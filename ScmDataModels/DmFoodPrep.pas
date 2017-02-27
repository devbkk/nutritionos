unit DmFoodPrep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  frxClass, frxDBSet, DBClient,
  ShareCommon, ShareInterface, ShareQueryConst;

type
  TDmoFoodPrep = class(TDmoBase, IFoodPrepDataX)
    qryFoodPrep: TSQLQuery;
    repSlipDietAm: TfrxReport;
    //
    cdsFoodPrep: TClientDataSet;
    repSlipDietPm: TfrxReport;
    //
    repSlipDiet: TfrxReport;
    rdsSlipDiet: TfrxDBDataset;
    cdsSlipDiet: TClientDataSet;
    //
    repSlipFeed: TfrxReport;
    rdsSlipFeed: TfrxDBDataset;
    cdsSlipFeed: TClientDataSet;
    qryPrnCond: TSQLQuery;
    //
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FSearchKey :TRecDataXSearch;
    FPrnAmPm   :Integer;
    function GetCopyAmt(const ds :TDataSet):Integer;
    function GetSearchKey :TRecDataXSearch;
    procedure SetSearchKey(const Value :TRecDataXSearch);
  public
    { Public declarations }
    procedure PrintAll;
    procedure PrintSelected(const ds :TDataset);
    procedure SetPrintAmPm(const idx :Integer);
    //
    function XDataSet :TDataSet; overload;
    function XDataSet(const p :TRecDataXSearch):TDataSet; overload;
    //
    procedure DoStopFoodRequest(const an, rtyp :String);
    //
    property SearchKey :TRecDataXSearch
      read GetSearchKey write SetSearchKey;
  end;

var
  DmoFoodPrep: TDmoFoodPrep;

implementation

const

QRY_SEL_FREQ=
'SELECT '+
  'P.WARDID, P.WARDNAME,'+
  'ISNULL(P.ROOMNO,'''') AS ROOMNO,'+
  'ISNULL(P.BEDNO,'''')  AS BEDNO,'+
  'P.HN,P.BIRTH,'+
  'P.TNAME+P.FNAME+'' ''+P.LNAME AS PATNAME,'+
  'P.RELGCODE, P.RELGDESC,'+
  'GETDATE() AS PRNDATE,'+
  'RQ.REQID, RQ.FOODREQDESC, RQ.REQDATE, RQ.DIAG, RQ.MEALORD,'+
  'RQ.COMDIS, RQ.MEALORD ,'+
  'ISNULL(RQ.USEHALAL,'''') AS HALAL,'+
  'P.FNAME,'+
  'CASE WHEN ISNULL(RQ.REQENDTYPE,'''')='''' THEN ''ปกติ'' ELSE ''NPO'' END AS REQSTAT,'+
  'P.AN '+
'FROM NUTR_PADM P '+
'JOIN NUTR_FOOD_REQS RQ ON RQ.HN = P.HN '+
                      'AND RQ.AN = RQ.AN '+
'JOIN '+
'(SELECT DISTINCT REQID '+
 'FROM NUTR_FOOD_REQD '+
 'WHERE EXISTS (SELECT * '+
               'FROM NUTR_FACT_GRPS G '+
               'JOIN NUTR_FACT F ON F.FGRC = G.FGRC '+
               'WHERE SLIPPRN = ''Y'')) B ON B.REQID = RQ.REQID '+
'JOIN '+
'(SELECT AN, MAX(REQDATE) AS REQDATE '+
 'FROM NUTR_FOOD_REQS '+
 'GROUP BY AN) C ON C.AN = RQ.AN '+
               'AND C.REQDATE = RQ.REQDATE '+
'WHERE NOT(ISNULL(RQ.REQEND,'''') = ''Y'' '+
'AND ISNULL(RQ.REQENDTYPE,'''') = '''') '+
'ORDER BY WARDID, HN';

QRY_SEL_FACTS=
'SELECT * FROM NUTR_FACT WHERE FGRC IN (%S)';

QRY_UPD_RQEND=
'UPDATE NUTR_FOOD_REQS '+
'SET REQEND=''Y'',' +
'REQENDTYPE=%S,'+
'REQENDDATE=GETDATE() '+
'WHERE AN=%S';

{$R *.dfm}

procedure TDmoFoodPrep.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FPrnAmPm := 0;
end;

procedure TDmoFoodPrep.DataModuleDestroy(Sender: TObject);
begin
  inherited;
//
end;

procedure TDmoFoodPrep.DoStopFoodRequest(const an, rtyp: String);
var sQry,sNPO :String;
begin
  if an='' then
    Exit;
  sNPO := QuotedStr(rtyp);
  sQry := Format(QRY_UPD_RQEND,[sNPO,QuotedStr(an)]);
  MainDB.ExecCmd(sQry);
end;

function TDmoFoodPrep.XDataSet: TDataSet;
begin
  Result := XDataSet(FSearchKey);
end;

function TDmoFoodPrep.XDataSet(const p: TRecDataXSearch): TDataSet;
const cWhere = ' WHERE %S BETWEEN RQ.REQFR AND RQ.REQTO';
var   sQry :String;
begin
  if not MainDB.IsConnected then begin
    Result := qryFoodPrep;
    Exit;
  end;
  //
  qryFoodPrep.DisableControls;
  try
    qryFoodPrep.Close;
    //
    sQry := QRY_SEL_FREQ;

    qryFoodPrep.SQL.Text   := sQry;
    //
    //
    qryFoodPrep.Open;
  finally
    qryFoodPrep.EnableControls;
  end;

  Result := qryFoodPrep;
end;

function TDmoFoodPrep.GetCopyAmt(const ds :TDataSet): Integer;
var sFeed :String; iFeed, iFeedAmt, iCopy :Integer;
begin
  sFeed := ds.FieldByName('FEED').AsString;

  if Pos('x',sFeed)=0 then begin
    Result := 1;
    Exit;
  end;

  iFeed := StrToIntDef(Copy(sFeed,1,Pos('x',sFeed)-1),0);
  case FPrnAmPm of
    0 : iFeedAmt := StrToIntDef(ds.FieldByName('AMOUNTAM').AsString,0);
    1 : iFeedAmt := StrToIntDef(ds.FieldByName('AMOUNTPM').AsString,0);
  else
    iFeedAmt := 0;  
  end;
  //
  if (iFeed=0)or(iFeedAmt=0)then begin
    Result := 1;
    Exit;
  end;
  iCopy := Round(iFeedAmt/iFeed);

  Result := iCopy
end;

function TDmoFoodPrep.GetSearchKey: TRecDataXSearch;
begin
  Result := FSearchKey;
end;

procedure TDmoFoodPrep.PrintAll;
var iCopy :Integer;
begin
  if qryFoodPrep.IsEmpty then
    Exit;
  //
  rdsSlipDiet.DataSet := qryFoodPrep;
  iCopy := GetCopyAmt(qryFoodPrep);
  case FPrnAmPm of
    0 : begin
      repSlipDietAm.PrintOptions.Copies := iCopy;
      repSlipDietAm.ShowReport(True);
    end;
    1 : begin
      repSlipDietPm.PrintOptions.Copies := iCopy;
      repSlipDietPm.ShowReport(True);
    end;
  end;
  //
end;

procedure TDmoFoodPrep.PrintSelected(const ds: TDataset);
begin
  //
  if ds.FieldByName('FEED_TYPE').AsString<>'' then begin
    if Assigned(ds)or not ds.IsEmpty then begin
      rdsSlipFeed.DataSet := ds;
    end;
    repSlipFeed.ShowReport(True);
  end else begin
    //
    if Assigned(ds)or not ds.IsEmpty then begin
      rdsSlipDiet.DataSet := ds;
    end;
    repSlipDiet.ShowReport(True);
  end;
end;

procedure TDmoFoodPrep.SetPrintAmPm(const idx: Integer);
begin
  FPrnAmPm := idx;
end;

procedure TDmoFoodPrep.SetSearchKey(const Value: TRecDataXSearch);
begin
  FSearchKey := Value;
end;

end.
