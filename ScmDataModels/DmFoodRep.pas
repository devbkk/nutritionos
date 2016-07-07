unit DmFoodRep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  frxClass, frxDBSet, DBClient, Provider,
  ShareInterface, ShareMethod;

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
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure repC19GetValue(const VarName: string; var Value: Variant);
  private
    { Private declarations }
    FSearchKey :TRecDataXSearch;
    FQueryList :TStrings;
    FMealDesc :String;
    FSelDate  :String;
    procedure DoCollectQuerys;
    //procedure GenerateSample;
    function GetSearchKey :TRecDataXSearch;
    procedure SetSearchKey(const Value :TRecDataXSearch);
  public
    { Public declarations }
    procedure FeedAppendClientDS(
      var cds :TClientDataSet; dsno :Integer);
    function GetFeedFormulaColumn(const grp,typ :String) :TDataset;
    function GetFeedFormulaRowHead(const code :String) :TDataSet;
    function GetFeedFormulaTotal(const grp,typ :String) :TDataSet;
    //
    function GetFoodReport(dt :TDateTime) :TDataSet;
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
'AND RQ.REQDATE =%S';

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

{procedure TDmoFoodRep.GenerateSample;
begin
  cdsFoodReq.AppendRecord([1,'AG07','π“ßÕ—≠™≈’ ∫ÿªº“Õ‘π∑√Ï','∏√√¡¥“',1,'','‡©æ“–‚√§','40','55','165','Diesease']);
  cdsFoodReq.AppendRecord([2,'AG03','π“¬®‘µ  ÿ¢ ¡π‘µ¬Ï','∏√√¡¥“',1,'','‡©æ“–‚√§','55','49','170','Diesease']);
  //
  cdsFoodReq.AppendRecord([3,'AG05','π“¬¥”√ß»—°¥‘Ï ‡∑◊Õ°‡∂“«Ï','∏√√¡¥“',1,'','∏√√¡¥“','55','49','170','Diesease']);
end;}

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
    sDate := DateTimeToSqlServerDateTimeString(dt);
    sQry  := Format(QRY_SEL_REP1,[QuotedStr(sDate)]);
    FSelDate := DateThaiFull(dt);
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
   Result := XDataSet(FSearchKey);
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
  end;
end;

procedure TDmoFoodRep.repC19GetValue(const VarName: string; var Value: Variant);
begin
  inherited;
  {if VarName='CurDay' then
    Value := QuotedStr('15');}
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
