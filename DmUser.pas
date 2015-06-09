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
    function UserDataSet :TDataSet; overload;
    function UserDataSet(p :TUserRec) :TDataSet; overload;
  end;

  TDmoUser = class(TDataModule, IUser, IDmoUser, IDModAuthen)
    schemaUser: TXMLDocument;
    qryAuthen: TSQLQuery;
    qryUser: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
     FMainDB  :IDmNutrCn;
     FUserDat :TUserRec;
     FSearch  :TUserSearchKey;
     function GetData :TUserRec;
     procedure SetData(const Value :TUserRec);
     //
     function GetSearchKey :TUserSearchKey;
     procedure SetSearchKey(const Value :TUserSearchKey);
     //
     procedure SetConnection;
  public
    { Public declarations }
     //IDModAuthen
     function IsAuthentiCated(login,pwd :String):Boolean;
     //IUser
     property Data :TUserRec
       read GetData write SetData;
     property SearchKey :TUserSearchKey
       read GetSearchKey write SetSearchKey;
     //IDataManage
     procedure CheckTables;
     procedure Initialize;
     //
     function FetchAllUsers :TDataSet;
     //IDmoUser
     function UserDataSet :TDataSet; overload;
     function UserDataSet(p :TUserRec) :TDataSet; overload;
  end;

var
  DmoUser: TDmoUser;

implementation

const
QRY_SEL_USER = 'SELECT * FROM NUTR_USER '+
               'WHERE ID LIKE :ID '+
               'AND FNAME LIKE :FNAME '+
               'AND LNAME LIKE :LNAME '+
               'AND GENDER LIKE :GENDER '+
               'AND EMAIL LIKE :EMAIL '+
               'AND [LOGIN] LIKE :LOGIN';

{$R *.dfm}

procedure TDmoUser.DataModuleCreate(Sender: TObject);
begin
  FMainDB :=  TDmoCnMain.Create(nil);
  CheckTables;
  Initialize;
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
  qryUser.SQLConnection := FMainDB.Connection;
  qryUser.CommandText   := QRY_SEL_USER;
  //qryUser.ParamByName() :=
  Result := qryUser;
end;

procedure TDmoUser.Initialize;
begin
  SetConnection;
end;

function TDmoUser.IsAuthentiCated(login, pwd: String): Boolean;
begin
  qryAuthen.SQLConnection := FMainDB.Connection;
  //
  Result := True;
end;

function TDmoUser.UserDataSet: TDataSet;
begin
  qryUser.DisableControls;
  try
    qryUser.Close;
    //
    qryUser.CommandText   := QRY_SEL_USER;
    //
    if FSearch.id='' then
      qryUser.ParamByName('ID').AsString := '%'
    else qryUser.ParamByName('ID').AsString := FSearch.id;

    if FSearch.fname='' then
      qryUser.ParamByName('FNAME').AsString  := '%'
    else qryUser.ParamByName('FNAME').AsString  := FSearch.fname;

    if FSearch.lname='' then
      qryUser.ParamByName('LNAME').AsString  := '%'
    else qryUser.ParamByName('LNAME').AsString  := FSearch.lname;

    if FSearch.gender='' then
      qryUser.ParamByName('GENDER').AsString := '%'
    else qryUser.ParamByName('GENDER').AsString := FSearch.gender;

    if FSearch.email='' then
      qryUser.ParamByName('EMAIL').AsString  := '%'
    else qryUser.ParamByName('EMAIL').AsString  := FSearch.email;

    if FSearch.login='' then
      qryUser.ParamByName('LOGIN').AsString  := '%'
    else qryUser.ParamByName('LOGIN').AsString  := FSearch.login;
    //
  finally
    qryUser.EnableControls;
  end;

  Result := qryUser;
end;

function TDmoUser.UserDataSet(p: TUserRec): TDataSet;
begin
  qryUser.DisableControls;
  try
    qryUser.Close;
    //
    qryUser.CommandText   := QRY_SEL_USER;
    //
    if p.id='' then
      qryUser.ParamByName('ID').AsString := '%'
    else qryUser.ParamByName('ID').AsString := p.id;

    if p.fname='' then
      qryUser.ParamByName('FNAME').AsString  := '%'
    else qryUser.ParamByName('FNAME').AsString  := p.fname;

    if p.lname='' then
      qryUser.ParamByName('LNAME').AsString  := '%'
    else qryUser.ParamByName('LNAME').AsString  := p.lname;

    if p.gender='' then
      qryUser.ParamByName('GENDER').AsString := '%'
    else qryUser.ParamByName('GENDER').AsString := p.gender;

    if p.email='' then
      qryUser.ParamByName('EMAIL').AsString  := '%'
    else qryUser.ParamByName('EMAIL').AsString  := p.email;

    if p.login='' then
      qryUser.ParamByName('LOGIN').AsString  := '%'
    else qryUser.ParamByName('LOGIN').AsString  := p.login;
    //
  finally
    qryUser.EnableControls;
  end;

  Result := qryUser;
end;

{private}
function TDmoUser.GetData: TUserRec;
begin
  Result := FUserDat;
end;

function TDmoUser.GetSearchKey: TUserSearchKey;
begin
  Result := FSearch;
end;

procedure TDmoUser.SetConnection;
var cmp :TComponent; i :Integer;
begin
  for i := 0 to Self.ComponentCount - 1 do begin
    cmp := Self.Components[i];
    if cmp is TSQLQuery then
      TSQLQuery(cmp).SQLConnection := FMainDB.Connection;
  end;
end;

procedure TDmoUser.SetData(const Value: TUserRec);
begin
  FUserDat := Value;
end;

procedure TDmoUser.SetSearchKey(const Value: TUserSearchKey);
begin
  FSearch := Value;
end;

end.
