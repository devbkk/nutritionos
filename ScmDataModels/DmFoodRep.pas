unit DmFoodRep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  frxClass, frxDBSet, frxDesgn, frxDBXComponents, DBClient, Provider,
  ShareCommon, ShareConstant, ShareInterface, ShareMethod;

type
  TDmoFoodRep = class(TDmoBase, IFoodRepDataX)
    qryFoodRep: TSQLQuery;
    dspFoodReq: TDataSetProvider;
    cdsRep: TClientDataSet;
    rep: TfrxReport;
    rds: TfrxDBDataset;
    qryFeedCol: TSQLQuery;
    cdsC19_1: TClientDataSet;
    rdsC19_1: TfrxDBDataset;
    qryFeedRowHead: TSQLQuery;
    qryFeedTot: TSQLQuery;
    repC19: TfrxReport;
    rdsC19_2: TfrxDBDataset;
    cdsC19_2: TClientDataSet;
    repFoodReq: TfrxReport;
    rdsFoodReq: TfrxDBDataset;
    cdsFoodReq: TClientDataSet;
    cdsRep1: TClientDataSet;
    rdsRep1: TfrxDBDataset;
    rdgRep1: TfrxReport;
    cdsRep4: TClientDataSet;
    rdsRep4: TfrxDBDataset;
    rdgRep4: TfrxReport;
    rDsgnMain: TfrxDesigner;
    repDbx: TfrxDBXComponents;
    repMain: TfrxReport;
    cdsMain: TClientDataSet;
    dspMain: TDataSetProvider;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    function  rDsgnMainSaveReport(Report: TfrxReport; SaveAs: Boolean): Boolean;
  private
    { Private declarations }
    FSearchKey :TRecDataXSearch;
    FQueryList :TStrings;
    FMealDesc  :String;
    FRepName   :String;
    FSelDate   :String;
    FSelDateTo :String;
    FRepExist  :Boolean;
    procedure DoCollectQuerys;
    //procedure GenerateSample;
    function  FetchAllReports :TDataSet;
    function  GetSearchKey :TRecDataXSearch;
    procedure SetSearchKey(const Value :TRecDataXSearch);
  public
    { Public declarations }
    procedure FeedAppendClientDS(
      var cds :TClientDataSet; dsno :Integer);
    function GetFeedFormulaColumn(const grp,typ :String) :TDataset;
    function GetFeedFormulaRowHead(const code :String) :TDataSet;
    function GetFeedFormulaTotal(const grp,typ :String) :TDataSet;
    //
    function GetFoodReport(dt :TDateTime) :TDataSet; overload;
    function GetFoodReport(p :TRecGetReport):TDataSet; overload;
    function GetReportData :TDataSet;
    procedure PrintReport(const idx :Integer) overload;
    procedure PrintReport(const idx :Integer; ds:TDataSet); overload;
    procedure PrintReport(const idx :Integer; cds:TClientDataSet); overload;
    //
    function XDataSet :TDataSet; overload;
    function XDataSet(const p :TRecDataXSearch):TDataSet; overload;
    //
    property SearchKey :TRecDataXSearch
      read GetSearchKey write SetSearchKey;
    //
    procedure Start;
    procedure SetMealDesc(const Value :String);
    //
    procedure ReportCreate(const repName :String);
    procedure ReportEdit(const repCode :String);
    procedure ReportDelete(const repCode :String);
    procedure ReportCopy(const repCode :String);
    procedure ReportImport(const repName, fileLong :String);
    procedure ReportExport(const repCode, fileLong :String);
    procedure ReportPrint(const repCode :String);
  end;

var
  DmoFoodRep: TDmoFoodRep;

implementation

const

QRY_SEL_REP =
'SELECT P.TNAME+P.FNAME+'' ''+P.LNAME AS PATNAME,'+
'R.HTS ,R.WTS, R.DIAG, R.FOODTYPE, R.AMOUNTAM,'+
'R.AMOUNTPM '+
'FROM NUTR_FOOD_REQS R '+
'LEFT JOIN NUTR_PATN P ON P.HN = R.HN';

//REP1
QRY_FUNC_REP1 = 'SELECT * FROM dbo.FN_REPORT1(%S) ORDER BY FGRC';

QRY_SEL_REP1=
'SELECT RQ.REQID, RQ.HN, RQ.MEALORD, RQ.FOODREQDESC,'+
       'RQ.REQDATE, RQ.HTS, RQ.WTS,'+
       'PA.TNAME, PA.FNAME, PA.LNAME,'+
       'DATEDIFF(YYYY,PA.BIRTH,GETDATE()) AS AGE,'+
       'PA.WARDID, PA.WARDNAME, PA.ROOMNO, PA.BEDNO,'+
       'B.FGRC, B.FGRP,'+
       'D.[DES] AS DIAGDESC '+
'FROM NUTR_FOOD_REQS RQ '+
'LEFT JOIN NUTR_PADM PA ON PA.AN = RQ.AN '+
'LEFT JOIN (SELECT DISTINCT A.REQID, A.FGRC1 AS FGRC, G.FGRP '+
           'FROM (SELECT *,'+
                        'dbo.ParGrpLev(F.FGRC,1) AS FGRC1,'+
                        'dbo.ParGrpLev(F.FGRC,0) AS FGRC0 '+
                 'FROM NUTR_FOOD_REQD R '+
                 'LEFT JOIN NUTR_FACT F ON F.CODE = R.REQCODE '+
                 'WHERE REQCODE <> ''freetext'') A '+
           'LEFT JOIN NUTR_FACT_GRPS G ON G.FGRC = A.FGRC1 '+
           'WHERE A.FGRC0= ''0002'') B ON B.REQID = RQ.REQID '+
'LEFT JOIN NUTR_DIAG D ON D.CODE = RQ.DIAG '+
'WHERE ISNULL(RQ.REQEND,'''') = ''Y'' '+
'AND ISNULL(RQ.FOODREQDESC,'''') <> '''' '+
'AND RQ.REQDATE <=%S';

//REP4
QRY_FUNC_REP4='SELECT * FROM dbo.FN_REPORT4(%S,%S)';

QRY_SEL_REP4=
'SELECT C.WARDID, C.WARDNAME, C.REQCODE,'+
       'C.FDES, SUM(DAYSCOUNT) AS DAYSCOUNT'+
'FROM (SELECT *, DATEDIFF(DAY,REQFR,REQTO) AS DAYSCOUNT '+
      'FROM(SELECT WARDID, WARDNAME, REQCODE, FDES,'+
                  'REQDATE, REQENDDATE, REQEND,'+
                  'CASE WHEN %S > REQDATE '+
                       'THEN REQDATE ELSE @FRDATE END AS REQFR,'+
	                'CASE WHEN %S > ISNULL(REQENDDATE,@TODATE) '+
                       'THEN REQENDDATE ELSE %S END AS REQTO '+
           'FROM(SELECT R.AN, R.REQDATE, R.REQEND, R.REQENDDATE,'+
                       'R.REQID,P.WARDID, P.WARDNAME, D.REQCODE, F.FDES,'+
                       'MIN(R.REQDATE) AS REQFR,'+
                       'MAX(REQENDDATE) AS REQTO '+
                'FROM NUTR_FOOD_REQS R '+
                'JOIN NUTR_FOOD_REQD D ON D.REQID = R.REQID '+
                'JOIN NUTR_FACT F ON F.CODE = D.REQCODE '+
                'JOIN NUTR_PADM P ON P.AN = R.AN '+
                'WHERE F.FGRC = ''0001'' '+
                'GROUP BY R.AN, R.REQDATE, R.REQEND, R.REQENDDATE,'+
                         'R.REQID, P.WARDID, P.WARDNAME,'+
                         'D.REQCODE, F.FDES) A) B) C '+
'GROUP BY C.WARDID, C.WARDNAME, C.REQCODE, C.FDES';


QRY_FEED_COL =
'SELECT CODE, FDES ,NOTE '+
'FROM NUTR_FACT '+
'WHERE FGRC = %S '+
'AND FTYC = %S';

QRY_FEED_RHD =
'SELECT CODE, FDES, NOTE '+
'FROM NUTR_FACT '+
'WHERE CODE = %S';

QRY_FEED_TOT =
'SELECT RQ.FOODTYPC,'+
       'SUM(RQ.AMOUNTAM) TOTALAM,'+
	     'SUM(RQ.AMOUNTPM) TOTALPM,'+
       'COUNT(*) CNT '+
'FROM NUTR_FOOD_REQS RQ '+
'WHERE ISNULL(RQ.FOODTYPC ,'''') <> '''''+
'GROUP BY RQ.FOODTYPC '+
'ORDER BY RQ.FOODTYPC';

QRY_FEED_TOT2 =
'SELECT F.CODE,'+
       'ISNULL(C.TOTALAM,0) AS TOTALAM,'+
	     'ISNULL(C.TOTALPM,0) AS TOTALPM,'+
	     'ISNULL(C.CNT,0)     AS CNT '+
'FROM NUTR_FACT F '+
'LEFT JOIN (SELECT RQ.FOODTYPC,' +
           'SUM(RQ.AMOUNTAM) TOTALAM,'+
           'SUM(RQ.AMOUNTPM) TOTALPM,'+
           'COUNT(*) CNT '+
           'FROM NUTR_FOOD_REQS RQ '+
           'WHERE ISNULL(RQ.FOODTYPC ,'''') <> '''''+
           'GROUP BY RQ.FOODTYPC) C ON C.FOODTYPC = F.CODE '+
'WHERE FGRC = %S AND FTYC = %S';

QRY_SEL_REPORTS=
'SELECT * FROM NUTR_REPORTS WHERE RCOD LIKE %S AND RTYP=''R''';

QRY_UPD_REPDEL=
'UPDATE NUTR_REPORTS SET RDEL=''Y'' WHERE RCOD LIKE %S';

{$R *.dfm}

procedure TDmoFoodRep.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Start;
end;

procedure TDmoFoodRep.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FQueryList.Free;
end;

function TDmoFoodRep.rDsgnMainSaveReport(Report: TfrxReport;
  SaveAs: Boolean): Boolean;
var sRCode :String; memSave :TMemoryStream;
begin
  inherited;
  //get report code
  if not FRepExist then begin
    if cdsMain.IsEmpty then
      sRCode := PRNDOCS_REPORT_FCODE
    else begin
      cdsMain.First;
      sRCode := cdsMain.FieldByName('RCOD').AsString;
      sRCode := NextIpacc(sRCode);
    end;
  end;

  //
  memSave := TMemoryStream.Create;
  try
    memSave.Position := 0;
    repMain.SaveToStream(memSave);
    //
    if FRepExist then begin
      cdsMain.Edit;
    end else begin
      cdsMain.Append;
      cdsMain.FieldByName('RCOD').AsString := sRCode;
      cdsMain.FieldByName('RDES').AsString := FRepName;
      cdsMain.FieldByName('RQRY').AsString := 'NO QUERY';
      cdsMain.FieldByName('RTYP').AsString := PRNDOCS_REPORT_TYPE;
      cdsMain.FieldByName('RDEL').AsString := 'N';
    end;
    TBlobField(cdsMain.FieldByName('RDGN')).LoadFromStream(memSave);
    cdsMain.Post;
    cdsMain.ApplyUpdates(-1)
    //
  finally
    memSave.Free;
  end;

  Result := True;
end;

procedure TDmoFoodRep.FeedAppendClientDS(
  var cds: TClientDataSet; dsno :Integer);
begin
  if dsno=1 then begin
    cdsC19_1.EmptyDataSet;
    DataCdsCopy(cds,cdsC19_1);
    rdsC19_1.DataSet := cdsC19_1;
  end else if dsno=2 then begin
    cdsC19_2.EmptyDataSet;
    DataCdsCopy(cds,cdsC19_2);
    rdsC19_2.DataSet := cdsC19_2;
  end;
end;

function TDmoFoodRep.FetchAllReports: TDataSet;
var sQry :String;
begin
  sQry   := Format(QRY_SEL_REPORTS,[QuotedStr('%')]);
  Result := GenerateDataSet(sQry,PRNDOCS_REPORT_DESIGN);
end;

function TDmoFoodRep.GetFeedFormulaColumn(const grp, typ: String): TDataset;
var sQry :String;
begin
  if not MainDB.IsConnected then begin
    Result := qryFeedCol;
    Exit;
  end;
  //
  qryFeedCol.DisableControls;
  try
    sQry := Format(QRY_FEED_COL,[QuotedStr(grp),QuotedStr(typ)]);
    //
    qryFeedCol.Close;
    qryFeedCol.SQL.Text := sQry;
    qryFeedCol.Open;
  finally
    qryFeedCol.EnableControls;
  end;
  //
  Result := qryFeedCol;
end;

function TDmoFoodRep.GetFeedFormulaRowHead(const code: String): TDataSet;
var sQry :String;
begin
  if not MainDB.IsConnected then begin
    Result := qryFeedRowHead;
    Exit;
  end;
  //
  qryFeedRowHead.DisableControls;
  try
    sQry := Format(QRY_FEED_RHD,[QuotedStr(code)]);
    //
    qryFeedRowHead.Close;
    qryFeedRowHead.SQL.Text := sQry;
    qryFeedRowHead.Open;
  finally
    qryFeedRowHead.EnableControls;
  end;
  //
  Result := qryFeedRowHead;
end;

function TDmoFoodRep.GetFeedFormulaTotal(const grp,typ :String): TDataSet;
var sQry :String;
begin
  if not MainDB.IsConnected then begin
    Result := qryFeedTot;
    Exit;
  end;
  //
  qryFeedTot.DisableControls;
  try
    //
    sQry := Format(QRY_FEED_TOT2,[QuotedStr(grp),QuotedStr(typ)]);
    //
    qryFeedTot.Close;
    qryFeedTot.SQL.Text := sQry;
    qryFeedTot.Open;
  finally
    qryFeedTot.EnableControls;
  end;
  //
  Result := qryFeedTot;
end;

function TDmoFoodRep.GetFoodReport(p :TRecGetReport): TDataSet;
var sQry, sFrDate, sToDate :String;
begin
  if not MainDB.IsConnected then begin
    Result := nil;
    Exit;
  end;
  qryFoodRep.DisableControls;
  try
    //
    sFrDate := DateToYMD(p.FrDate);
    sToDate := DateToYMD(p.ToDate);

    case p.Index of
      0 :sQry  := Format(QRY_FUNC_REP1,[QuotedStr(sFrDate)]);
      3 :sQry  := Format(QRY_FUNC_REP4,[QuotedStr(sFrDate),QuotedStr(sToDate)]);
    end;

    FSelDate   := DateThai(p.FrDate,[]);
    FSelDateTo := DateThai(p.ToDate,[]);
    //
    qryFoodRep.Close;
    qryFoodRep.SQL.Text := sQry;
    qryFoodRep.Open;
  finally
    qryFoodRep.EnableControls;
  end;
  //
  Result := qryFoodRep;
end;

function TDmoFoodRep.GetFoodReport(dt :TDateTime): TDataSet;
var sQry, sDate :String;
begin
  if not MainDB.IsConnected then begin
    Result := nil;
    Exit;
  end;
  qryFoodRep.DisableControls;
  try
    //
    sDate := DateToYMD(dt);
    sQry  := Format(QRY_FUNC_REP1,[QuotedSTr(sDate)]);
    FSelDate := DateThai(dt,[]);
    //
    qryFoodRep.Close;
    qryFoodRep.SQL.Text := sQry;
    qryFoodRep.Open;
  finally
    qryFoodRep.EnableControls;
  end;
  //
  Result := qryFoodRep;
end;

function TDmoFoodRep.GetReportData: TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qryFoodRep;
    Exit;
  end;
  //
  qryFoodRep.DisableControls;
  try
    qryFoodRep.Close;
    qryFoodRep.SQL.Text := QRY_SEL_REP;
    qryFoodRep.Open;
  finally
    qryFoodRep.EnableControls;
  end;
  //
  Result := qryFoodRep;
end;

function TDmoFoodRep.XDataSet: TDataSet;
begin
   //Result := XDataSet(FSearchKey);
   Result := FetchAllReports;
end;

function TDmoFoodRep.XDataSet(const p: TRecDataXSearch): TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qryFoodRep;
    Exit;
  end;
  //
  qryFoodRep.DisableControls;
  try
    qryFoodRep.Close;
    qryFoodRep.SQL.Text := QRY_SEL_REP;
    qryFoodRep.Open;
  finally
    qryFoodRep.EnableControls;
  end;
  //
  Result := qryFoodRep;
end;

{procedure TDmoFoodRep.PrintReport(const idx: Integer);
begin
  case idx of
    0 : begin
      if cdsC19_1.IsEmpty and cdsC19_2.IsEmpty then
        Exit;
      //
      rdsC19_1.DataSet := cdsC19_1;
      rdsC19_2.DataSet := cdsC19_2;
      repC19.Variables['CurDate']  := QuotedStr(DateThaiFull(Now));
      repC19.Variables['Meal']     := FMealDesc;
      repC19.ShowReport;
    end;
  end;
end;}

procedure TDmoFoodRep.PrintReport(const idx: Integer);
begin
//
end;

procedure TDmoFoodRep.PrintReport(const idx: Integer; ds:TDataSet);
begin
  case idx of
    0 : begin

    end;
  end;
end;

{procedure TDmoFoodRep.PrintReport(const idx: Integer; cds: TClientDataSet);
var dt :TDatetime;
begin
  case idx of
    0 : begin
      cdsC19_1.EmptyDataSet;
      DataCdsCopy(cds,cdsC19_1);
      //
      dt := Now;
      //
      rdsC19_1.DataSet := cdsC19_1;
      repC19.Variables['CurDate']  := QuotedStr(DateThaiFull(dt));
      repC19.ShowReport;
    end;
    1 : begin
      GenerateSample;
      repFoodReq.ShowReport;
    end;
  end;
end;}

procedure TDmoFoodRep.PrintReport(const idx: Integer; cds: TClientDataSet);
begin
  case idx of
    0: begin
      rdsRep1.DataSet := cds;
      rdgRep1.Variables['DATESTR'] := QuotedStr(FSelDate);
      rdgRep1.ShowReport(True);
    end;
    3: begin
      rdsRep4.DataSet := cds;
      rdgRep4.Variables['DATEFR'] := QuotedStr(FSelDate);
      rdgRep4.Variables['DATETO'] := QuotedStr(FSelDateTo);
      rdgRep4.ShowReport(True);
    end;
  end;
end;

procedure TDmoFoodRep.ReportCopy(const repCode: String);
var sRepNewCode, sRepName :String;
    memLoad :TMemoryStream;
    dsgFld :TBlobField;
    //vStream :OleVariant; pStream :Pointer;
begin
  if TrimRight(repCode)='' then
    Exit;
  //
  cdsMain.Close;
  dspMain.DataSet := FetchAllReports;
  cdsMain.SetProvider(dspMain);
  cdsMain.Open;
  with cdsMain.IndexDefs.AddIndexDef do begin
    Name    := 'RCodLastIdx';
    Fields  := 'RCOD';
    Options := [ixDescending, ixCaseInsensitive];
  end;
  cdsMain.IndexName := 'RCodLastIdx';
  //
  cdsMain.First;
  sRepNewCode := cdsMain.FieldByName('RCOD').AsString;
  sRepNewCode := NextIpacc(sRepNewCode);
  //
  if cdsMain.Locate('RCOD',repCode,[]) then begin

    dsgFld   := TBlobField(cdsMain.FieldByName('RDGN'));
    sRepName := cdsMain.FieldByName('RDES').AsString;
    //
    memLoad := TMemoryStream.Create;
    try
      dsgFld.SaveToStream(memLoad);
      memLoad.Position := 0;

      {vStream := VarArrayCreate([0,memLoad.Size-1],varByte);
      pStream := VarArrayLock(vStream);
      try
        memLoad.ReadBuffer(pStream^,memLoad.Size);

        cdsMain.AppendRecord([sRepNewCode,
                              sRepName,
                              'NO QUERY',
                              vStream,
                              PRNDOCS_REPORT_TYPE,
                              'N']);
        cdsMain.ApplyUpdates(-1);
      finally
        VarArrayUnlock(vStream);
      end;}
      //
      cdsMain.Append;
      cdsMain.FieldByName('RCOD').AsString := sRepNewCode;
      cdsMain.FieldByName('RDES').AsString := sRepName;
      cdsMain.FieldByName('RQRY').AsString := 'NO QUERY';
      cdsMain.FieldByName('RTYP').AsString := PRNDOCS_REPORT_TYPE;
      cdsMain.FieldByName('RDEL').AsString := 'N';
      dsgFld.LoadFromStream(memLoad);
      cdsMain.Post;
      cdsMain.ApplyUpdates(-1);
      //
    finally
      memLoad.Free;
    end;
  end;
end;

procedure TDmoFoodRep.ReportCreate(const repName :String);
begin
  if TrimRight(repName)='' then
    Exit;
  //
  cdsMain.Close;
  dspMain.DataSet := FetchAllReports;
  cdsMain.SetProvider(dspMain);
  cdsMain.Open;
  with cdsMain.IndexDefs.AddIndexDef do begin
    Name    := 'RCodLastIdx';
    Fields  := 'RCOD';
    Options := [ixDescending, ixCaseInsensitive];
  end;
  cdsMain.IndexName := 'RCodLastIdx';
  //
  FRepName  := repName;
  FRepExist := cdsMain.Locate('RDES',repName,[]);
  //
  repDbx.DefaultDatabase := MainConnection;
  //
  repMain.Clear;
  repMain.DesignReport(True);
end;

procedure TDmoFoodRep.ReportDelete(const repCode: String);
var sQry :String;
begin
  sQry := Format(QRY_UPD_REPDEL,[QuotedStr(repCode)]);
  RunSQLCommand(sQry);
end;

procedure TDmoFoodRep.ReportEdit(const repCode :String);
var ds :TDataSet; dsgField :TField; memLoad :TMemoryStream;
begin
  //
  memLoad := TMemoryStream.Create;
  try
    ds := GetDataSet(PRNDOCS_REPORT_DESIGN);
    if not ds.IsEmpty then begin
      cdsMain.Close;
      dspMain.DataSet := ds;
      cdsMain.SetProvider(dspMain);
      cdsMain.Open;
      //
      FRepExist := cdsMain.Locate('RCOD',repcode,[]);
      if FRepExist then begin
        //
        dsgField := cdsMain.FieldByName('RDGN');
        TBlobField(dsgField).SaveToStream(memLoad);
        memLoad.Position := 0;
        //
        repDbx.DefaultDatabase := MainConnection;
        //
        repMain.Clear;
        repMain.LoadFromStream(memLoad);
        repMain.DesignReport(True);
      end;
    end;
  finally
    memLoad.Free;
  end;
end;

procedure TDmoFoodRep.ReportExport(const repCode, fileLong: String);
var memLoad :TMemoryStream; dsgField :TField; sFileLong :String;
const c_report_ext = '.fr3';
begin
  if (TrimRight(repCode)='')or(TrimRight(fileLong)='') then
    Exit;

  if Pos(c_report_ext,fileLong)>0 then
    sFileLong := fileLong
  else sFileLong := fileLong+c_report_ext;

  cdsMain.Close;
  dspMain.DataSet := FetchAllReports;
  cdsMain.SetProvider(dspMain);
  cdsMain.Open;
  if not cdsMain.Locate('RCOD',repCode,[]) then
    Exit;

  memLoad := TMemoryStream.Create;
  try
    dsgField := cdsMain.FieldByName('RDGN');
    TBlobField(dsgField).SaveToStream(memLoad);
    memLoad.Position := 0;
    memLoad.SaveToFile(sFileLong);
  finally
    memLoad.Free;
  end;
end;

procedure TDmoFoodRep.ReportImport(const repName, fileLong: String);
var memSave :TMemoryStream; dsgFld :TBlobField; sRepNewCode :String;
begin
  if(TrimRight(repName)='')or(TrimRight(fileLong)='')then
    Exit;

  memSave := TMemoryStream.Create;
  try
    memSave.LoadFromFile(fileLong);
    memSave.Position := 0;
    if memSave.Size=0 then
      Exit;

    cdsMain.Close;
    dspMain.DataSet := FetchAllReports;
    cdsMain.SetProvider(dspMain);
    cdsMain.Open;
    with cdsMain.IndexDefs.AddIndexDef do begin
      Name    := 'RCodLastIdx';
      Fields  := 'RCOD';
      Options := [ixDescending, ixCaseInsensitive];
    end;
    cdsMain.IndexName := 'RCodLastIdx';
    cdsMain.First;
    sRepNewCode := cdsMain.FieldByName('RCOD').AsString;
    sRepNewCode := NextIpacc(sRepNewCode);

    dsgFld   := TBlobField(cdsMain.FieldByName('RDGN'));

    cdsMain.Append;
    cdsMain.FieldByName('RCOD').AsString := sRepNewCode;
    cdsMain.FieldByName('RDES').AsString := repName;
    cdsMain.FieldByName('RQRY').AsString := 'NO QUERY';
    cdsMain.FieldByName('RTYP').AsString := PRNDOCS_REPORT_TYPE;
    cdsMain.FieldByName('RDEL').AsString := 'N';
    dsgFld.LoadFromStream(memSave);
    cdsMain.Post;
    cdsMain.ApplyUpdates(-1);
  finally
    memSave.Free;
  end;
end;

procedure TDmoFoodRep.ReportPrint(const repCode: String);
var ds :TDataSet; dsgField :TField; memLoad :TMemoryStream;
begin
  //
  memLoad := TMemoryStream.Create;
  try
    ds := GetDataSet(PRNDOCS_REPORT_DESIGN);
    if not ds.IsEmpty then begin
      cdsMain.Close;
      dspMain.DataSet := ds;
      cdsMain.SetProvider(dspMain);
      cdsMain.Open;
      //
      FRepExist := cdsMain.Locate('RCOD',repcode,[]);
      if FRepExist then begin
        //
        dsgField := cdsMain.FieldByName('RDGN');
        TBlobField(dsgField).SaveToStream(memLoad);
        memLoad.Position := 0;
        //
        repDbx.DefaultDatabase := MainConnection;
        //
        repMain.Clear;
        repMain.LoadFromStream(memLoad);
        repMain.ShowReport(False);
      end;
    end;
  finally
    memLoad.Free;
  end;
end;

procedure TDmoFoodRep.Start;
begin
  FQueryList := TStringList.Create;
  DoCollectQuerys;
end;

{private}
procedure TDmoFoodRep.DoCollectQuerys;
begin
  FQueryList.Append(QRY_SEL_REP);
end;

function TDmoFoodRep.GetSearchKey: TRecDataXSearch;
begin
  Result := FSearchKey;
end;

procedure TDmoFoodRep.SetMealDesc(const Value: String);
begin
  FMealDesc := Value;
end;

procedure TDmoFoodRep.SetSearchKey(const Value: TRecDataXSearch);
begin
  FSearchKey := Value;
end;

end.
