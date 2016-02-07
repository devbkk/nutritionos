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
    cdsC19: TClientDataSet;
    rdsC19: TfrxDBDataset;
    qryFeedRowHead: TSQLQuery;
    qryFeedTot: TSQLQuery;
    repC19: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FSearchKey :TRecDataXSearch;
    FQueryList :TStrings;
    procedure DoCollectQuerys;
    function GetSearchKey :TRecDataXSearch;
    procedure SetSearchKey(const Value :TRecDataXSearch);
  public
    { Public declarations }
    function GetFeedFormulaColumn(const grp,typ :String) :TDataset;
    function GetFeedFormulaRowHead(const code :String) :TDataSet;
    function GetFeedFormulaTotal :TDataSet;
    //
    function GetReportData :TDataSet;
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
	     'SUM(RQ.AMOUNTPM) TOTALPM '+
'FROM NUTR_FOOD_REQS RQ '+
'WHERE ISNULL(RQ.FOODTYPC ,'''') <> '''''+
'GROUP BY RQ.FOODTYPC '+
'ORDER BY RQ.FOODTYPC';

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

function TDmoFoodRep.GetFeedFormulaTotal: TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qryFeedTot;
    Exit;
  end;
  //
  qryFeedTot.DisableControls;
  try
    //
    qryFeedTot.Close;
    qryFeedTot.SQL.Text := QRY_FEED_TOT;
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

procedure TDmoFoodRep.PrintReport(const idx: Integer; ds:TDataSet);
begin
  //ShowMessage('Print Report '+IntToStr(idx));
  case idx of
    0 : begin

    end;
  end;
end;

procedure TDmoFoodRep.PrintReport(const idx: Integer; cds: TClientDataSet);
begin
  case idx of
    0 : begin
      cdsC19.EmptyDataSet;
      DataCdsCopy(cds,cdsC19);
      //
      rdsC19.DataSet := cdsC19;
      repC19.ShowReport(True);
    end;  
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

procedure TDmoFoodRep.SetSearchKey(const Value: TRecDataXSearch);
begin
  FSearchKey := Value;
end;

end.
