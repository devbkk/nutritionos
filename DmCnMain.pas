unit DmCnMain;

interface

uses
  SysUtils, Classes, DB, DBXpress, WideStrings, SqlExpr, xmldom, XMLIntf,
  msxmldom, XMLDoc, FMTBcd;

type
  TDBServerParamsRec = record
    Server,Database,User,Password :String;
  end;

  IDmNutrCn = Interface
  ['{B406FD48-3D65-40F1-83E7-0F0F7B7D0C48}']
    function  Connection :TSQLConnection;
    procedure DoConnectDB;
    procedure ExecCmd(const sql :String);
    function  IsConnected :Boolean;
    function  IsTableExist(const tb :String):Boolean;
  End;

  TDmoCnMain = class(TDataModule, IDmNutrCn)
    cnDB: TSQLConnection;
    cnParams: TXMLDocument;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FServer :String;
    FDbName :String;
    procedure DoConnectDB;
    function  IsConnected :Boolean;
  public
    { Public declarations }
    function  Connection :TSQLConnection;
    procedure ExecCmd(const sql :String);
    function  IsTableExist(const tb :String):Boolean;
  end;

var
  DmoCnMain: TDmoCnMain;

implementation

const

SQL_TBL_EXIST = 'SELECT TABLE_NAME,TABLE_TYPE,TABLE_CATALOG '+
                'FROM INFORMATION_SCHEMA.TABLES '+
                'WHERE TABLE_TYPE =:TT '+
                'AND TABLE_CATALOG=:DB '+
                'AND TABLE_NAME=:TB ';

{$R *.dfm}

procedure TDmoCnMain.DataModuleCreate(Sender: TObject);
begin
  FServer := 'SPB-MYNB\SQL2012';
  FDbName := 'DEVNUT';
end;

procedure TDmoCnMain.DataModuleDestroy(Sender: TObject);
begin
//
end;

{public}
function TDmoCnMain.Connection: TSQLConnection;
begin
  if not IsConnected then
    DoConnectDB;
  Result := cnDB;
end;

{private}
procedure TDmoCnMain.DoConnectDB;
begin
  cnDB.DriverName    := 'DevartSQLServer';
  cnDB.LibraryName   := 'dbexpsda30.dll';
  cnDB.VendorLib     :=  'sqlncli';
  cnDB.GetDriverFunc := 'getSQLDriverSQLServer';
  cnDB.LoginPrompt   := False;
  //
  cnDB.Params.Clear;
  cnDB.Params.Add('User_Name=homc');
  cnDB.Params.Add('Password=homc');
  cnDB.Params.Add('HostName='+FServer);
  cnDB.Params.Add('Database='+FDbName);
  cnDB.Open;
end;

procedure TDmoCnMain.ExecCmd(const sql: String);
var qry :TSQLQuery;
begin
  qry := TSQLQuery.Create(nil);
  try
    qry.SQLConnection := Connection;
    qry.CommandText   := sql;
    qry.ExecSQL(True);
  finally
    freeandnil(qry);
  end;
end;

function TDmoCnMain.IsConnected: Boolean;
begin
  Result := cnDB.Connected;
end;

function TDmoCnMain.IsTableExist(const tb: String): Boolean;
var qry :TSQLQuery;
begin
  qry := TSQLQuery.Create(nil);
  try
    qry.SQLConnection := Connection;
    qry.CommandText := SQL_TBL_EXIST;
    qry.ParamByName('TT').AsString := 'BASE TABLE';
    qry.ParamByName('DB').AsString := FDbName;
    qry.ParamByName('TB').AsString := tb;
    qry.Open;
    Result := not qry.IsEmpty;
  finally
    freeandnil(qry);
  end;
end;

end.
