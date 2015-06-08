unit DmUser;

interface

uses
  SysUtils, Classes, xmldom, XMLIntf, msxmldom, XMLDoc, FMTBcd, DB,
  SqlExpr, Dialogs, DmCnMain, ShareMethod, ShareInterface;

type

  IDModAuthen = interface(IInterface)
  ['{D280A8F6-D202-4B0C-B884-43296939E74A}']
    function IsAuthentiCated(login,pwd :String):Boolean;
  end;

  IDmoUser = Interface
  ['{AF77C77F-08E1-4D51-975A-B66A24F087D8}']
    function UserDataSet(p :TUserRec) :TDataSet;
  end;

  TDmoUser = class(TDataModule, IUser, IDmoUser, IDModAuthen)
    schemaUser: TXMLDocument;
    qryAuthen: TSQLQuery;
    qryUser: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
     FMainDB :IDmNutrCn;
     function GetData :TUserRec;
     procedure SetData(const Value :TUserRec);
     //
     function GetKey :TUserSearchKey;
     procedure SetKey(const Value :TUserSearchKey);
  public
    { Public declarations }
     //IDModAuthen
     function IsAuthentiCated(login,pwd :String):Boolean;
     //IUser
     property Data :TUserRec read GetData write SetData;
     property Key :TUserSearchKey read GetKey write SetKey;
     //IDataManage
     procedure CheckTables;
     procedure Initialize;
     //
     function FetchAllUsers :TDataSet;
     //IDmoUser     
     function UserDataSet(p :TUserRec) :TDataSet;
  end;

var
  DmoUser: TDmoUser;

implementation

{$R *.dfm}

procedure TDmoUser.DataModuleCreate(Sender: TObject);
begin
  FMainDB :=  TDmoCnMain.Create(nil);
  CheckTables;
end;

procedure TDmoUser.DataModuleDestroy(Sender: TObject);
begin
//
end;

{public}
procedure TDmoUser.CheckTables;
var sTblName,sTblCrCmd :String;
begin
  sTblName := XmlGetTableName(schemaUser);
  if not FMainDB.IsTableExist(sTblName) then begin
    sTblCrCmd := XmlToSqlCreateCommand(schemaUser);
    FMainDB.ExecCmd(sTblCrCmd);
  end;
end;

function TDmoUser.FetchAllUsers: TDataSet;
begin
  Result := qryUser;
end;

function TDmoUser.GetData: TUserRec;
begin
//
end;

function TDmoUser.GetKey: TUserSearchKey;
begin
//
end;

procedure TDmoUser.Initialize;
begin

end;

function TDmoUser.IsAuthentiCated(login, pwd: String): Boolean;
begin
  qryAuthen.SQLConnection := FMainDB.Connection;
  //
  Result := True;
end;

procedure TDmoUser.SetData(const Value: TUserRec);
begin
//
end;

procedure TDmoUser.SetKey(const Value: TUserSearchKey);
begin
//
end;

function TDmoUser.UserDataSet(p: TUserRec): TDataSet;
begin
//
end;

end.
