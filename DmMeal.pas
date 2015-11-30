unit DmMeal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  ShareInterface;

type
  TDmoMeal = class(TDmoBase, IMealDataX)
    schemaMeal: TXMLDocument;
    schemaMealItems: TXMLDocument;
    qryMeal: TSQLQuery;
    qryMealList: TSQLQuery;
    qryMealItems: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FSearchKey :TRecDataXSearch;
    function GetSearchKey: TRecDataXSearch;
    procedure SetSearchKey(const Value: TRecDataXSearch);
    { Private declarations }
  public
    { Public declarations }
    function XDataSet :TDataSet; overload;
    function XDataSet(const p :TRecDataXSearch):TDataSet; overload;
    property SearchKey :TRecDataXSearch
      read GetSearchKey write SetSearchKey;
  end;

var
  DmoMeal: TDmoMeal;

implementation

const
QRY_SEL_MEAL='SELECT * FROM NUTR_FMNU '+
             'WHERE ISNULL(MLID,'''') LIKE :ID '+
             'AND ISNULL(MLNAME,'''') LIKE :NAME';

{$R *.dfm}

procedure TDmoMeal.DataModuleCreate(Sender: TObject);
begin
  inherited;
//
end;

procedure TDmoMeal.DataModuleDestroy(Sender: TObject);
begin
  inherited;
//
end;

function TDmoMeal.XDataSet: TDataSet;
begin
  Result := XDataSet(FSearchKey);
end;

function TDmoMeal.XDataSet(const p: TRecDataXSearch): TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qryMeal;
    Exit;
  end;
  //
  qryMeal.DisableControls;
  try
    qryMeal.Close;
    //
    qryMeal.SQL.Text   := QRY_SEL_MEAL;
    //
    if p.ID='' then
      qryMeal.ParamByName('ID').AsString := '%'
    else qryMeal.ParamByName('ID').AsString := p.ID;

    if p.NAME='' then
      qryMeal.ParamByName('NAME').AsString  := '%'
    else qryMeal.ParamByName('NAME').AsString  := p.NAME;

    //
    qryMeal.Open;
  finally
    qryMeal.EnableControls;
  end;

  Result := qryMeal;
end;

{private}
function TDmoMeal.GetSearchKey: TRecDataXSearch;
begin
  Result := FSearchKey;
end;

procedure TDmoMeal.SetSearchKey(const Value: TRecDataXSearch);
begin
  FSearchKey := Value;
end;

end.
