unit DmFoodPrep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  ShareInterface, frxClass, frxDBSet, DBClient;

type
  TDmoFoodPrep = class(TDmoBase, IFoodPrepDataX)
    qryFoodPrep: TSQLQuery;
    repSlipDietAm: TfrxReport;
    rdsSlipDiet: TfrxDBDataset;
    cdsFoodPrep: TClientDataSet;
    repSlipDietPm: TfrxReport;
    repSlipDiet: TfrxReport;
    cdsSlipDiet: TClientDataSet;
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
  'P.HN,'+
  'P.TNAME+P.FNAME+'' ''+P.LNAME AS PATNAME,'+
  'GETDATE() AS PRNDATE,'+
  'RQ.REQID, RQ.FOODREQDESC, RQ.REQDATE, RQ.DIAG, RQ.MEALORD '+
'FROM NUTR_PADM P '+
'JOIN NUTR_FOOD_REQS RQ ON RQ.HN = P.HN '+
                      'AND RQ.AN = RQ.AN '+
'JOIN (SELECT TOP 1 D.* '+
      'FROM NUTR_FOOD_REQD D '+
      'WHERE EXISTS (SELECT 1 '+
                    'FROM NUTR_FACT F '+
                    'JOIN NUTR_FACT_GRPS G ON G.FGRC = F.FGRC '+
                    'WHERE ISNULL(G.SLIPPRN,'''') = ''Y'' '+
                    'AND CODE=D.REQCODE)) A ON A.REQID = RQ.REQID';
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
//var iCopy :Integer;
begin
  //rdsSlipDiet.DataSet := ds;
  //iCopy := GetCopyAmt(ds);
  {case FPrnAmPm of
    0 : begin
      repSlipDietAm.PrintOptions.Copies := 1;//iCopy;
      repSlipDietAm.ShowReport(True);
    end;
    1 : begin
      repSlipDietPm.PrintOptions.Copies := 1;//iCopy;
      repSlipDietPm.ShowReport(True);
    end;
  end;}
  //
  if Assigned(ds)or not ds.IsEmpty then begin
    rdsSlipDiet.DataSet := ds;
  end;
  repSlipDiet.ShowReport(True);
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
