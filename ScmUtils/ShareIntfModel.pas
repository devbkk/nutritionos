unit ShareIntfModel;

interface

uses SysUtils, Classes, DB, SqlExpr, WideStrings;

type
  TEnumRunno = (runUser);

  TRecConnectParams = record
    server,database,user,password :String;
    demo :Boolean;
  end;

  IDmoCheckDB = Interface
  ['{354F348F-2312-49D4-9540-9ED3F928A4F4}']
    function RequestConfig :TStrings;
  end;

  IDbConnect = Interface
  ['{B406FD48-3D65-40F1-83E7-0F0F7B7D0C48}']
    function  Connection :TSQLConnection;
    procedure DoConnectDB;
    procedure ExecCmd(const sql :String);
    function  IsConnected :Boolean;
    function  IsDemoMode :Boolean;
    function  IsTableExist(const tb :String):Integer;
    function  IsViewExist(const vw :String):Integer;
    function NextRunno(typ :TEnumRunno;upd :Boolean=false):Integer;
    procedure ReadDbConfig(var p:TWideStrings); overload;
    procedure ReadDbConfig(var p:TRecConnectParams); overload;
    //
    procedure AddTransCmd(const s :String);
    procedure ClearTransCmd;    
    procedure DoTransCmd;
    //
    function GetHcCnParams :TRecConnectParams;
    function GetMisc(const code :String) :String;
  End;

implementation

end.
