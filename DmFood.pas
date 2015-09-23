unit DmFood;

interface

uses
  xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, Classes,
  XMLDoc, DmBase;

type
  TDmoFood = class(TDmoBase)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmoFood: TDmoFood;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

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

end.
