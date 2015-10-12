unit DmFood;

interface

uses
  xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, Classes,
  XMLDoc, ShareInterface, DmBase;

type
  TDmoFood = class(TDmoBase, IDataSetX)
    schemaFood: TXMLDocument;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function XDataSet :TDataSet; overload;
    function XDataSet(const pSearch :TRecDataXSearch):TDataSet; overload;
  end;

var
  DmoFood: TDmoFood;

implementation

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

function TDmoFood.XDataSet: TDataSet;
begin
//
end;

function TDmoFood.XDataSet(const pSearch: TRecDataXSearch): TDataSet;
begin
//
end;

end.
