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
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FSearchKey :TRecDataXSearch;
    FPrnAmPm   :Integer;
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

QRY_SEL_FREQ='SELECT DISTINCT '+
               'A.WARDID, A.WARDNAME,'+
               'A.ROOMNO, A.BEDNO,'+
               'P.TNAME+P.FNAME+'' ''+P.LNAME AS PATNAME,'+
               'RQ.AMOUNTAM, RQ.AMOUNTPM, RQ.SALTWT,'+
               'GETDATE() AS PRNDATE '+
               'FROM NUTR_FOOD_REQS RQ '+
             'LEFT JOIN NUTR_PATN_ADMT A ON A.AN = RQ.AN '+
             'LEFT JOIN NUTR_PATN P ON P.HN = A.HN';

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
    qryFoodPrep.SQL.Text   := QRY_SEL_FREQ;
    //
    //
    qryFoodPrep.Open;
  finally
    qryFoodPrep.EnableControls;
  end;

  Result := qryFoodPrep;
end;

function TDmoFoodPrep.GetSearchKey: TRecDataXSearch;
begin
  Result := FSearchKey;
end;

procedure TDmoFoodPrep.PrintAll;
begin
  if qryFoodPrep.IsEmpty then
    Exit;
  //
  rdsSlipDiet.DataSet := qryFoodPrep;
  case FPrnAmPm of
    0 : repSlipDietAm.ShowReport(True);
    1 : repSlipDietPm.ShowReport(True);
  end;
  //
end;

procedure TDmoFoodPrep.PrintSelected(const ds: TDataset);
begin
  rdsSlipDiet.DataSet := ds;
  case FPrnAmPm of
    0 : repSlipDietAm.ShowReport(True);
    1 : repSlipDietPm.ShowReport(True);
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
