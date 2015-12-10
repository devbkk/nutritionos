unit DmCnHomc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmCnMain, xmldom, XMLIntf, DBXpress, WideStrings, FMTBcd, DB,
  SqlExpr, msxmldom, XMLDoc;

type
  TDmoCnHomc = class(TDmoCnMain)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FCnParam :TRecConnectParams;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent; p:TRecConnectParams); reintroduce; overload;
    procedure ReadDbConfig(var p:TRecConnectParams); override;
  end;

var
  DmoCnHomc: TDmoCnHomc;

implementation

{$R *.dfm}

constructor TDmoCnHomc.Create(AOwner: TComponent; p: TRecConnectParams);
begin
  FCnParam := p;
end;

procedure TDmoCnHomc.DataModuleCreate(Sender: TObject);
begin
  inherited;
//
end;

procedure TDmoCnHomc.DataModuleDestroy(Sender: TObject);
begin
  inherited;
//
end;

procedure TDmoCnHomc.ReadDbConfig(var p: TRecConnectParams);
begin
  p := FCnParam;
end;

end.
