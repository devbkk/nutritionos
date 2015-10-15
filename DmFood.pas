unit DmFood;

interface

uses
  xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, Classes,
  XMLDoc, ShareInterface, DmBase;

type
  TDmoFood = class(TDmoBase, IDataSetX)
    schemaFood: TXMLDocument;
    qryFood: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FSearchKey :TRecDataXSearch;
    function GetSearchKey :TRecDataXSearch;
    procedure SetSearchKey(const Value :TRecDataXSearch);
  protected
    { Protected declarations }
    function Schema :TXMLDocument; override;    
  public
    { Public declarations }
    function XDataSet :TDataSet; overload;
    function XDataSet(const p :TRecDataXSearch):TDataSet; overload;
    property SearchKey :TRecDataXSearch
      read GetSearchKey write SetSearchKey;
  end;

var
  DmoFood: TDmoFood;

implementation

const
QRY_SEL_FOOD='SELECT * FROM NUTR_FOOD '+
             'WHERE ISNULL(FDID,'''') LIKE :ID '+
             'AND ISNULL(FDNAME,'''') LIKE :NAME '+
             'AND ISNULL(FDTYPE,'''') LIKE :TYP';

{$R *.dfm}

procedure TDmoFood.DataModuleCreate(Sender: TObject);
begin
  inherited;
//
end;

procedure TDmoFood.DataModuleDestroy(Sender: TObject);
begin
  inherited;
//
end;

{public}
function TDmoFood.XDataSet: TDataSet;
begin
  Result := XDataSet(FSearchKey);
end;

function TDmoFood.XDataSet(const p: TRecDataXSearch): TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qryFood;
    Exit;
  end;
  //
  qryFood.DisableControls;
  try
    qryFood.Close;
    //
    qryFood.SQL.Text   := QRY_SEL_FOOD;
    //
    if p.ID='' then
      qryFood.ParamByName('ID').AsString := '%'
    else qryFood.ParamByName('ID').AsString := p.ID;

    if p.NAME='' then
      qryFood.ParamByName('NAME').AsString  := '%'
    else qryFood.ParamByName('NAME').AsString  := p.NAME;

    qryFood.ParamByName('TYP').AsString  := p.TYP;
    //
    qryFood.Open;
  finally
    qryFood.EnableControls;
  end;

  Result := qryFood;
end;

function TDmoFood.GetSearchKey: TRecDataXSearch;
begin
  Result := FSearchKey
end;

function TDmoFood.Schema: TXMLDocument;
begin
  Result := schemaFood;
end;

procedure TDmoFood.SetSearchKey(const Value: TRecDataXSearch);
begin
  FSearchKey := Value;
end;

end.
