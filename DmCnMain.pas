unit DmCnMain;

interface

uses
  SysUtils, Classes, DB, {DBXpress,} WideStrings, SqlExpr, xmldom, XMLIntf,
  msxmldom, XMLDoc, FMTBcd, ShareMethod, DBAccess, Uni, UniProvider,
  SQLServerUniProvider;

type
  TEnumRunno = (runUser);

  IDmNutrCn = Interface
  ['{B406FD48-3D65-40F1-83E7-0F0F7B7D0C48}']
    function  Connection :TUniConnection;
    procedure DoConnectDB;
    procedure ExecCmd(const sql :String);
    function  IsConnected :Boolean;
    function  IsTableExist(const tb :String):Integer;
    function NextRunno(typ :TEnumRunno;upd :Boolean=false):Integer;
    procedure ReadDbConfig(p:TWideStrings);
  End;

  IDmoCheckDB = Interface
  ['{354F348F-2312-49D4-9540-9ED3F928A4F4}']
    function RequestConfig :TStrings;
  end;

  TDmoCnMain = class(TDataModule, IDmNutrCn, IDmoCheckDB)
    cnParams: TXMLDocument;
    schemaCtrl: TXMLDocument;
    pdSQL: TSQLServerUniProvider;
    cnDB: TUniConnection;
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
    //IDmNutrCn
    procedure CheckTables;
    function  Connection :TUniConnection;
    procedure ExecCmd(const sql :String);
    function  IsTableExist(const tb :String):Integer;
    function NextRunno(typ :TEnumRunno;upd :Boolean=false):Integer;
    procedure ReadDbConfig(p:TWideStrings);
    //IDmoCheckDB
    function RequestConfig :TStrings;
  end;

var
  DmoCnMain: TDmoCnMain;

implementation

const
QRY_TBL_EXIST = 'SELECT TABLE_NAME,TABLE_TYPE,TABLE_CATALOG '+
                'FROM INFORMATION_SCHEMA.TABLES '+
                'WHERE TABLE_TYPE =:TT '+
                'AND TABLE_CATALOG=:DB '+
                'AND TABLE_NAME=:TB ';

QRY_SEL_RUNNO = 'SELECT RUNNO FROM NUTR_CTRL WHERE ID=:ID ';

QRY_UPD_RUNNO = 'UPDATE NUTR_CTRL SET RUNNO=:RUNNO WHERE ID=:ID';

C_USER_RUNNO  = '100';

FILE_CONFIG = 'config.xml';
  element_db     = 'database';
  element_server = 'server';
  element_name   = 'name';
  element_user   = 'user';
  element_pwd    = 'password';

{$R *.dfm}
procedure TDmoCnMain.DataModuleCreate(Sender: TObject);
begin
  FServer := 'SPB-MYNB\SQL2012';
  FDbName := 'DEVNUT';
  //
  DoConnectDB;
  CheckTables;
end;

procedure TDmoCnMain.DataModuleDestroy(Sender: TObject);
begin
//
end;

{public}
procedure TDmoCnMain.CheckTables;
var sTblName,sTblCrCmd :String;
begin
  sTblName := XmlGetTableName(schemaCtrl);
  if (IsTableExist(sTblName)=0) then begin
    sTblCrCmd := XmlToSqlCreateCommand(schemaCtrl);
    ExecCmd(sTblCrCmd);
  end;
end;

function TDmoCnMain.Connection: TUniConnection;
begin
  if not IsConnected then
    DoConnectDB;
  Result := cnDB;
end;

{private}
procedure TDmoCnMain.DoConnectDB;
begin
  {cnDB.DriverName    := 'DevartSQLServer';
  cnDB.LibraryName   := 'dbexpsda30.dll';
  cnDB.VendorLib     :=  'sqlncli';
  cnDB.GetDriverFunc := 'getSQLDriverSQLServer';
  cnDB.LoginPrompt   := False;
  cnDB.KeepConnection:= True;}
  //
  {cnDB.Params.Clear;
  cnDB.Params.Add('User_Name=homc');
  cnDB.Params.Add('Password=homc');
  cnDB.Params.Add('HostName='+FServer);
  cnDB.Params.Add('Database='+FDbName);
  cnDB.Open;}
  //
  {cnDB.Params.Clear;
  ReadDbConfig(cnDB.Params);
  if cnDB.Params.Text='' then
    Exit
  else cnDB.Open;}

  cnDB.Server   := FServer;
  cnDB.Database := FDbName;
  cnDB.Username := 'homc';
  cnDB.Password := 'homc';
  cndb.Open;
end;

procedure TDmoCnMain.ExecCmd(const sql: String);
var qry :TUniQuery;
begin
  qry := TUniQuery.Create(nil);
  try
    qry.Connection := Connection;
    qry.SQL.Text   := sql;
    qry.ExecSQL;
  finally
    FreeAndNil(qry);
  end;
end;

function TDmoCnMain.IsConnected: Boolean;
begin
  Result := cnDB.Connected;
end;

function TDmoCnMain.IsTableExist(const tb: String): Integer;
var qry :TUniQuery;
begin
  //
  if not IsConnected then begin
    Result := -1;
    Exit;
  end;
  //
  qry := TUniQuery.Create(nil);
  try
    qry.Connection  := Connection;
    qry.SQL.Text    := QRY_TBL_EXIST;
    qry.ParamByName('TT').AsString := 'BASE TABLE';
    qry.ParamByName('DB').AsString := FDbName;
    qry.ParamByName('TB').AsString := tb;
    qry.Open;
    //
    if not qry.IsEmpty then
      Result := 1
    else Result := 0;
  finally
    FreeAndNil(qry);
  end;
end;

function TDmoCnMain.NextRunno(typ: TEnumRunno;upd :Boolean): Integer;
var qry :TUniQuery; sRunType :String;
begin
  qry := TUniQuery.Create(nil);
  try
    case typ of
      runUser : sRunType := C_USER_RUNNO;
    end;
    //
    qry.Connection                 := Connection;
    qry.SQL.Text                   := QRY_SEL_RUNNO;
    qry.ParamByName('ID').AsString := sRunType;
    qry.Open;
    //
    Result := StrToIntDef(qry.Fields[0].AsString,0)+1;
    //
    if upd then begin
      qry.Close;
      qry.SQL.Text                       := QRY_UPD_RUNNO;
      qry.ParamByName('ID').AsString     := sRunType;
      qry.ParamByName('RUNNO').AsInteger := Result;
      qry.ExecSQL;
    end;
    //
  finally
    FreeAndNil(qry);
  end;
end;

procedure TDmoCnMain.ReadDbConfig(p: TWideStrings);
//
var xmlRead :TXMLDocument;
    dbNode  :IXMLNode;
    sFile,sHost,sDB,sUser,sPwd   :String;
    bChk    :Boolean;
//
const param_user = 'User_Name=%S';
      param_pwd  = 'Password=%S';
      param_host = 'HostName=%S';
      param_db   = 'Database=%S';
//
begin
  sFile := GetCurrentDir+'\'+FILE_CONFIG;
  if not FileExists(sFile) then
    Exit
  else begin
    xmlRead := TXMLDocument.Create(Self);
    try
      xmlRead.FileName := sFile;
      xmlRead.Active   := True;
      if xmlRead.Active then begin
        dbNode := xmlRead.DocumentElement;
        sHost  := dbNode.ChildNodes[element_server].NodeValue;
        sDB    := dbNode.ChildNodes[element_name].NodeValue;
        sUser  := dbNode.ChildNodes[element_user].NodeValue;
        sPwd   := dbNode.ChildNodes[element_pwd].NodeValue;
        //
        bChk := (sHost<>'X');
        bChk := bChk and (sDB<>'X');
        bChk := bChk and (sUser<>'X');
        bChk := bChk and (sPwd<>'X');
        //
        if bChk then begin
          p.Add(Format(param_user,[sUser]));
          p.Add(Format(param_pwd,[sPwd]));
          p.Add(Format(param_host,[sHost]));
          p.Add(Format(param_db,[sDB]));
        end;
      end;
      //
    finally
      xmlRead.Active := False;
      xmlRead.Free;
    end;
  end;
end;

function TDmoCnMain.RequestConfig: TStrings;
begin
  Result := cnParams.XML;
end;

end.
