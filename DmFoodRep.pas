unit DmFoodRep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  ShareInterface, frxClass, frxDBSet, DBClient, Provider;

type
  TDmoFoodRep = class(TDmoBase, IFoodRepDataX)
    qryFoodRep: TSQLQuery;
    dspFoodReq: TDataSetProvider;
    cdsRep: TClientDataSet;
    rep: TfrxReport;
    rds: TfrxDBDataset;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FSearchKey :TRecDataXSearch;    
    function GetSearchKey :TRecDataXSearch;
    procedure SetSearchKey(const Value :TRecDataXSearch);
  public
    { Public declarations }
    function GetReportData :TDataSet;
    procedure PrintReport(const idx :Integer);    
    //
    function XDataSet :TDataSet; overload;
    function XDataSet(const p :TRecDataXSearch):TDataSet; overload;
    //
    property SearchKey :TRecDataXSearch
      read GetSearchKey write SetSearchKey;
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

{$R *.dfm}

procedure TDmoFoodRep.DataModuleCreate(Sender: TObject);
begin
  inherited;
//
end;

procedure TDmoFoodRep.DataModuleDestroy(Sender: TObject);
begin
  inherited;
//
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

function TDmoFoodRep.GetSearchKey: TRecDataXSearch;
begin
  Result := FSearchKey;
end;

procedure TDmoFoodRep.PrintReport(const idx: Integer);
begin
  ShowMessage('Print Report '+IntToStr(idx));
end;

procedure TDmoFoodRep.SetSearchKey(const Value: TRecDataXSearch);
begin
  FSearchKey := Value;
end;

end.
