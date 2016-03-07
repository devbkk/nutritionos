unit DmCnMain;

interface

uses
  SysUtils, Classes, DB, WideStrings, SqlExpr, xmldom, XMLIntf,
  msxmldom, XMLDoc, FMTBcd, DBXpress, ShareMethod, ShareIntfModel;

type


  TDmoCnMain = class(TDataModule, IDbConnect, IDmoCheckDB)
    cnParams: TXMLDocument;
    schemaCtrl: TXMLDocument;
    cnDB: TSQLConnection;
    qryCmd: TSQLQuery;
    schemaMisc: TXMLDocument;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FServer  :String;
    FDbName  :String;
    FIsDemo  :Boolean;
    FCmdList :TStrings;
    procedure DoConnectDB;
    function  IsConnected :Boolean;
    function IsDemoMode :Boolean;
  public
    { Public declarations }
    //IDbConnect
    procedure CheckTables; virtual;
    function  Connection :TSQLConnection;
    procedure ExecCmd(const sql :String);
    function  IsTableExist(const tb :String):Integer;
    function NextRunno(typ :TEnumRunno;upd :Boolean=false):Integer;
    procedure ReadDbConfig(var p:TWideStrings); overload;
    procedure ReadDbConfig(var p:TRecConnectParams); overload; virtual;
    //
    procedure AddTransCmd(const s :String);
    procedure DoTransCmd;
    //
    function GetHcCnParams :TRecConnectParams;
    function GetMisc(const code :String) :String;
    //IDmoCheckDB
    function RequestConfig :TStrings;
  end;

var
  DmoCnMain: TDmoCnMain;

//public const
const
MISC_HC_CN  = 'CNHC';

implementation

//private const
const
QRY_TBL_EXIST = 'SELECT TABLE_NAME,TABLE_TYPE,TABLE_CATALOG '+
                'FROM INFORMATION_SCHEMA.TABLES '+
                'WHERE TABLE_TYPE =:TT '+
                'AND TABLE_CATALOG=:DB '+
                'AND TABLE_NAME=:TB ';

QRY_SEL_RUNNO = 'SELECT RUNNO FROM NUTR_CTRL WHERE ID=:ID ';

QRY_UPD_RUNNO = 'UPDATE NUTR_CTRL SET RUNNO=:RUNNO WHERE ID=:ID';

QRY_SEL_MISC  = 'SELECT VAL FROM NUTR_MISC WHERE COD=:COD';

C_USER_RUNNO  = '100';

FILE_CONFIG = 'config.xml';
  element_db     = 'database';
  element_server = 'server';
  element_name   = 'name';
  element_user   = 'user';
  element_pwd    = 'password';
  element_demo   = 'demo';

{$R *.dfm}
procedure TDmoCnMain.DataModuleCreate(Sender: TObject);
begin
  FServer := 'STYLEME-SPB\SQLX2';
  FDbName := 'DEVNUT';
  //
  DoConnectDB;
  CheckTables;
  //
  FCmdList := TStringList.Create;
end;

procedure TDmoCnMain.DataModuleDestroy(Sender: TObject);
begin
  FCmdList.Free;
end;

{public}
procedure TDmoCnMain.AddTransCmd(const s: String);
begin
  FCmdList.Append(s);
end;

procedure TDmoCnMain.CheckTables;
var sTblName, sTblCrCmd :String;
begin
  if Self is TDmoCnMain then begin
    sTblName := XmlGetTableName(schemaCtrl);
    if (IsTableExist(sTblName)=0) then begin
      sTblCrCmd := XmlToSqlCreateCommand(schemaCtrl);
      ExecCmd(sTblCrCmd);
    end;
    //
    sTblName := XmlGetTableName(schemaMisc);
    if (IsTableExist(sTblName)=0) then begin
      sTblCrCmd := XmlToSqlCreateCommand(schemaMisc);
      ExecCmd(sTblCrCmd);
    end;
  end;
end;

function TDmoCnMain.Connection: TSqlConnection;
begin
  if not IsConnected then
    DoConnectDB;
  Result := cnDB;
end;

procedure TDmoCnMain.DoTransCmd;
var tr :TTransactionDesc;
    i  :Integer;
begin
  if FCmdList.Count > 0 then begin
    tr.TransactionID  := 1;
    tr.IsolationLevel := xilREADCOMMITTED;
    //
    cnDB.StartTransaction(tr);
    try
      for i := 0 to FCmdList.Count - 1 do begin
        qryCmd.CommandText := FCmdList[i];
        qryCmd.ExecSQL
      end;
      cnDB.Commit(tr);
      FCmdList.Clear;
    except
      cnDB.Rollback(tr);
    end;
  end;
end;

{private}
procedure TDmoCnMain.DoConnectDB;
var s :TRecConnectParams;
begin
  cnDB.DriverName    := 'DevartSQLServer';
  cnDB.LibraryName   := 'dbexpsda30.dll';
  cnDB.VendorLib     := 'sqlncli';
  cnDB.GetDriverFunc := 'getSQLDriverSQLServer';
  cnDB.LoginPrompt   := False;
  cnDB.KeepConnection:= True;
  //
  ReadDbConfig(s);
  FIsDemo := s.demo;
  if(s.server='')or(s.database='')or(s.user='')or(s.password='')then
    Exit
  else begin
    cnDB.Params.Clear;
    cnDB.Params.Add('User_Name='+s.user);
    cnDB.Params.Add('Password='+s.password);
    cnDB.Params.Add('HostName='+s.server);
    cnDB.Params.Add('Database='+s.database);
    cnDB.Open;
    //
    FDbName := s.database;
    FServer := s.server;
  end;
end;

procedure TDmoCnMain.ExecCmd(const sql: String);
var qry :TSQLQuery;
begin
  qry := TSQLQuery.Create(nil);
  try
    qry.SQLConnection := Connection;
    qry.SQL.Text      := sql;
    qry.ExecSQL;
  finally
    FreeAndNil(qry);
  end;
end;

function TDmoCnMain.GetHcCnParams: TRecConnectParams;
var lst :TStrings; ret :TRecConnectParams;
begin
  lst := TStringList.Create;
  try
    lst.Delimiter := ';';
    lst.DelimitedText := GetMisc(MISC_HC_CN);
    //
    ret.server   := lst[0];
    ret.database := lst[1];
    ret.user     := lst[2];
    ret.password := lst[3];
    //
    Result := ret;
  finally
    lst.Free;
  end;
end;

function TDmoCnMain.GetMisc(const code: String): String;
var qry: TSQLQuery;
begin
  qry := TSQLQuery.Create(nil);
  try
    qry.SQLConnection := Connection;
    qry.SQL.Text      := QRY_SEL_MISC;
    qry.ParamByName('COD').AsString := code;
    qry.Open;
    if not qry.IsEmpty then
      Result := qry.Fields[0].AsString
    else Result := '';
  finally
    FreeAndNil(qry);
  end;
end;

function TDmoCnMain.IsConnected: Boolean;
begin
  Result := cnDB.Connected;
end;

function TDmoCnMain.IsDemoMode: Boolean;
begin
  Result := FIsDemo;
end;

function TDmoCnMain.IsTableExist(const tb: String): Integer;
var qry :TSqlQuery;
begin
  //
  if not IsConnected then begin
    Result := -1;
    Exit;
  end;
  //
  qry := TSqlQuery.Create(nil);
  try
    qry.SQLConnection  := Connection;
    qry.SQL.Text       := QRY_TBL_EXIST;
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
var qry :TSqlQuery; sRunType :String;
begin
  qry := TSqlQuery.Create(nil);
  try
    case typ of
      runUser : sRunType := C_USER_RUNNO;
    end;
    //
    qry.SQLConnection              := Connection;
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

procedure TDmoCnMain.ReadDbConfig(var p: TWideStrings);
//
var xmlRead :TXMLDocument;
    dbNode  :IXMLNode;
    sFile,sHost,sDB,sUser,sPwd,sDemo   :String;
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
        sDemo  := dbNode.ChildNodes[element_demo].NodeValue;
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

procedure TDmoCnMain.ReadDbConfig(var p: TRecConnectParams);
//
var xmlRead :TXMLDocument;
    dbNode  :IXMLNode;
    sFile,sHost,sDB,sUser,sPwd,sDemo   :String;
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
        sDemo  := dbNode.ChildNodes[element_demo].NodeValue;
        //
        bChk := (sHost<>'X');
        bChk := bChk and (sDB<>'X');
        bChk := bChk and (sUser<>'X');
        bChk := bChk and (sPwd<>'X');
        //
        if bChk then begin
          p.server   := sHost;
          p.database := sDB;
          p.user     := sUser;
          p.password := sPwd;
        end;
        p.demo := (sDemo='Y');
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
