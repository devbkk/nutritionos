unit DmFoodPrep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  frxClass, frxDBSet, frxDesgn, DBClient, Provider,
  ShareCommon, ShareConstant, ShareInterface, ShareQueryConst;

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
    qrySlipFeed: TSQLQuery;
    cdsRep: TClientDataSet;
    dspRep: TDataSetProvider;
    rdgSlipFeed: TfrxDesigner;
    dspSlipAll: TDataSetProvider;
    //
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    //
    function DoSaveReport(Report :TfrxReport; SaveAs:Boolean) :Boolean;
  private
    { Private declarations }
    FSearchKey  :TRecDataXSearch;
    FPrnAmPm    :Integer;
    function GetCopyAmt(const ds :TDataSet):Integer;
    function GetSearchKey :TRecDataXSearch;
    procedure SetSearchKey(const Value :TRecDataXSearch);

    //slip diet manage
    function  GetPrintDocs(const code :String):TDataSet;
    procedure CreateSlipFeedToDB;
    procedure EditSlipFeedFrDB;
    procedure LoadReportFrDB(rep :TfrxReport; code :String);

    //
    procedure InitDataModel;
  public
    { Public declarations }
    procedure PrintAll; overload;
    procedure PrintAll(const ds :TDataSet); overload;    
    procedure PrintSelected(const ds :TDataset);
    procedure SetPrintAmPm(const idx :Integer);
    //
    function GetSlipFeed :TDataSet;
    function XDataSet :TDataSet; overload;
    function XDataSet(const p :TRecDataXSearch):TDataSet; overload;
    //
   procedure DoRequestEditSlipFeed;
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

QRY_SEL_REPORTS=
'SELECT * FROM NUTR_REPORTS WHERE RCOD =%S';

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
  InitDataModel;
end;

procedure TDmoFoodPrep.DataModuleDestroy(Sender: TObject);
begin
  inherited;
//
end;

function TDmoFoodPrep.DoSaveReport(
  Report: TfrxReport; SaveAs: Boolean): Boolean;
var memSave :TMemoryStream; dsgnFld :TField;
begin
  inherited;
  //
  memSave := TMemoryStream.Create;
  try
    memSave.Position := 0;
    Report.SaveToStream(memSave);
    //
    cdsRep.Edit;
    dsgnFld := cdsRep.FieldByName('RDGN');
    TBlobField(dsgnFld).LoadFromStream(memSave);
    cdsRep.Post;
    cdsRep.ApplyUpdates(-1);
    //
  finally
    memSave.Free;
  end;
  //
  Result := True;
end;

function TDmoFoodPrep.GetPrintDocs(const code: String): TDataSet;
var sQry,sRep :String;
begin
  sRep   := QuotedStr(code);
  sQry   := Format(QRY_SEL_REPORTS,[sRep]);
  Result := GenerateDataSet(sQry,code);
end;

procedure TDmoFoodPrep.CreateSlipFeedToDB;
var memSave :TMemoryStream; dsgnFld :TField;
begin
  memSave := TMemoryStream.Create;
  try
    memSave.Position := 0;
    repSlipFeed.SaveToStream(memSave);
    //
    cdsRep.Append;
    cdsRep.FieldByName('RCOD').AsString := PRNDOCS_SLIPFEED_CODE;
    cdsRep.FieldByName('RDES').AsString := PRNDOCS_SLIPFEED_DESC;
    cdsRep.FieldByName('RQRY').AsString := 'NO QUERY';
    cdsRep.FieldByName('RTYP').AsString := PRNDOCS_SLIPFEED_TYPE;
    //
    dsgnFld := cdsRep.FieldByName('RDGN');
    TBlobField(dsgnFld).LoadFromStream(memSave);
    //
    cdsRep.Post;
    cdsRep.ApplyUpdates(-1)
  finally
    memSave.Free;
  end;
end;

procedure TDmoFoodPrep.EditSlipFeedFrDB;
var memLoad :TMemoryStream; dsgnFld :TField;
begin
  memLoad := TMemoryStream.Create;
  try
    memLoad.Position := 0;
    //
    dsgnFld := cdsRep.FieldByName('RDGN');
    TBlobField(dsgnFld).SaveToStream(memLoad);
    //
    {work temp file logic
    memLoad.SaveToFile('temp.fr3');
    repSlipFeed.LoadFromFile('temp.fr3');}
    //
    memLoad.Position := 0;
    repSlipFeed.LoadFromStream(memLoad);
    repSlipFeed.DesignReport(True);

  finally
    memLoad.Free;
  end;
end;

procedure TDmoFoodPrep.LoadReportFrDB(rep: TfrxReport; code: String);
var memLoad :TMemoryStream; dsgnFld :TField;
begin
  cdsRep.Close;
  dspRep.DataSet := GetPrintDocs(code);
  cdsRep.SetProvider(dspRep);
  cdsRep.Open;
  //
  if cdsRep.IsEmpty then
    Exit;
  //
  memLoad := TMemoryStream.Create;
  try
    dsgnFld := cdsRep.FieldByName('RDGN');
    TBlobField(dsgnFld).SaveToStream(memLoad);
    //
    memLoad.Position := 0;
    rep.LoadFromStream(memLoad);
  finally
    memLoad.Free;
  end;
end;

procedure TDmoFoodPrep.DoRequestEditSlipFeed;
begin
  cdsRep.Close;
  dspRep.DataSet := GetSlipFeed;
  cdsRep.SetProvider(dspRep);
  cdsRep.Open;
  //
  if cdsRep.IsEmpty then
    CreateSlipFeedToDB;
  //
  EditSlipFeedFrDB;
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

function TDmoFoodPrep.GetSlipFeed: TDataSet;
var sQry,sRep :String;
begin
  sRep   := QuotedStr(PRNDOCS_SLIPFEED_CODE);
  sQry   := Format(QRY_SEL_REPORTS,[sRep]);
  Result := GenerateDataSet(sQry,'slipfeed');
end;

procedure TDmoFoodPrep.InitDataModel;
begin
  LoadReportFrDB(repSlipFeed,PRNDOCS_SLIPFEED_CODE);
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

procedure TDmoFoodPrep.PrintAll(const ds: TDataSet);
var cdsFeed, cdsNorm :TClientDataSet;
begin
  dspSlipAll.DataSet := ds;
  //
  cdsFeed := TClientDataSet.Create(nil);
  cdsNorm := TClientDataSet.Create(nil);
  try
    cdsFeed.Close;
    cdsFeed.SetProvider(dspSlipAll);
    cdsFeed.Open;
    cdsFeed.Refresh;

    cdsNorm.Close;
    cdsNorm.SetProvider(dspSlipAll);
    cdsNorm.Open;
    cdsNorm.Refresh;

    cdsFeed.Filter :='FEED_TYPE<>'+QuotedStr('');
    cdsNorm.Filter :='FEED_TYPE='+QuotedStr('');

    cdsFeed.Filtered := True;
    cdsNorm.Filtered := True;

    if not cdsFeed.IsEmpty then begin
      rdsSlipFeed.DataSet := cdsFeed;
      repSlipFeed.ShowReport(True);
    end;

    if not cdsNorm.IsEmpty then begin
      rdsSlipDiet.DataSet := ds;
      repSlipDiet.ShowReport(True);
    end;

  finally
    cdsFeed.Free;
    cdsNorm.Free;
  end;
end;

procedure TDmoFoodPrep.PrintSelected(const ds: TDataset);
begin
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
