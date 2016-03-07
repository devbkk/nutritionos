unit DmCnHomc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmCnMain, xmldom, XMLIntf, DBXpress, WideStrings, FMTBcd, DB,
  SqlExpr, msxmldom, XMLDoc, ShareIntfModel;

type
  TDmoCnHomc = class(TDmoCnMain)
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FCnParam :TRecConnectParams;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent; p:TRecConnectParams); reintroduce; overload;
    procedure CheckTables; override;    
    procedure ReadDbConfig(var p:TRecConnectParams); override;
  end;

var
  DmoCnHomc: TDmoCnHomc;

implementation

{$R *.dfm}

constructor TDmoCnHomc.Create(AOwner: TComponent; p: TRecConnectParams);
begin
  FCnParam := p;
  inherited Create(AOwner);
end;

procedure TDmoCnHomc.DataModuleDestroy(Sender: TObject);
begin
  inherited;
//
end;

{putlic}
procedure TDmoCnHomc.CheckTables;
begin
//
end;

procedure TDmoCnHomc.ReadDbConfig(var p: TRecConnectParams);
begin
  p := FCnParam;
end;

end.
