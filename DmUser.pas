unit DmUser;

interface

uses
  SysUtils, Classes, xmldom, XMLIntf, msxmldom, XMLDoc, ClUser, FMTBcd, DB,
  SqlExpr, {InfInputData,} Dialogs, DmCnMain, SvAux;

type
  IDModAuthen = interface(IInterface)
  ['{D280A8F6-D202-4B0C-B884-43296939E74A}']
    function IsAuthentiCated(login,pwd :String):Boolean;
  end;

  TDmoUser = class(TDataModule, IUser, IDModAuthen{, IDataManage})
    schemaUser: TXMLDocument;
    qryAuthen: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
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
  end;

var
  DmoUser: TDmoUser;

implementation

{$R *.dfm}

procedure TDmoUser.DataModuleCreate(Sender: TObject);
begin
  CheckTables;
end;

procedure TDmoUser.DataModuleDestroy(Sender: TObject);
begin
//
end;

{public}
procedure TDmoUser.CheckTables;
var inf :IDmNutrCn;
    sTblName,sTblCrCmd :String;
begin
  inf := TDmoCnMain.Create(nil);
  sTblName := XmlGetTableName(schemaUser);
  if not inf.IsTableExist(sTblName) then begin
    sTblCrCmd := XmlToSqlCreateCommand(schemaUser);
    inf.ExecCmd(sTblCrCmd);
  end;
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
var inf :IDmNutrCn;
begin
  inf := TDmoCnMain.Create(nil);
  qryAuthen.SQLConnection := inf.Connection;
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

end.
