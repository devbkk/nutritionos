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
    procedure DoConnectDB;
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
  inherited Create(AOwner);
  FCnParam := p;
  DoConnectDB; 
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

procedure TDmoCnHomc.DoConnectDB;
begin
  cnDB.DriverName    := 'DevartSQLServer';
  cnDB.LibraryName   := 'dbexpsda30.dll';
  cnDB.VendorLib     := 'sqlncli';
  cnDB.GetDriverFunc := 'getSQLDriverSQLServer';
  cnDB.LoginPrompt   := False;
  cnDB.KeepConnection:= True;
  //
  if(FCnParam.server='')or(FCnParam.database='')or
    (FCnParam.user='')or(FCnParam.password='')then
    Exit
  else begin
    cnDB.Params.Clear;
    cnDB.Params.Add('User_Name='+FCnParam.user);
    cnDB.Params.Add('Password='+FCnParam.password);
    cnDB.Params.Add('HostName='+FCnParam.server);
    cnDB.Params.Add('Database='+FCnParam.database);
    cnDB.Open;
  end;
end;

procedure TDmoCnHomc.ReadDbConfig(var p: TRecConnectParams);
begin
  p := FCnParam;
end;

end.
