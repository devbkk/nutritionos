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
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure repC19GetValue(const VarName: string; var Value: Variant);
  private
    { Private declarations }
    FSearchKey :TRecDataXSearch;
    FQueryList :TStrings;
    procedure DoCollectQuerys;
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
  end;

var
  DmoFoodRep: TDmoFoodRep;

implementation

const

QRY_SEL_REP = 'SELECT P.TNAME+P.FNAME+'' ''+P.LNAME AS PATNAME,'+
                     'R.HTS ,R.WTS, R.DIAG, R.FOODTYPE, R.AMOUNTAM,'+
                     'R.AMOUNTPM '+
                     'FROM NUTR_FOOD_REQS R '+
                     'LEFT JOIN NUTR_PATN P ON P.HN = R.HN';

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

procedure TDmoFoodRep.PrintReport(const idx: Integer);
begin
  case idx of
    0 : begin
      if cdsC19_1.IsEmpty and cdsC19_2.IsEmpty then
        Exit;
      //
      rdsC19_1.DataSet := cdsC19_1;
      rdsC19_2.DataSet := cdsC19_2;
      repC19.Variables['CurDate']  := QuotedStr(DateThaiFull(Now));
      repC19.ShowReport;
    end;
  end;
end;

procedure TDmoFoodRep.PrintReport(const idx: Integer; ds:TDataSet);
begin
  case idx of
    0 : begin

    end;
  end;
end;

procedure TDmoFoodRep.PrintReport(const idx: Integer; cds: TClientDataSet);
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

procedure TDmoFoodRep.SetSearchKey(const Value: TRecDataXSearch);
begin
  FSearchKey := Value;
end;

end.
