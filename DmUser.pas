unit DmUser;

interface

uses
  SysUtils, Classes, xmldom, XMLIntf, msxmldom, XMLDoc, FMTBcd, DB,
  SqlExpr, Dialogs, StrUtils, DmCnMain, ShareMethod, ShareInterface;

type

  IDModAuthen = interface(IInterface)
  ['{D280A8F6-D202-4B0C-B884-43296939E74A}']
    function IsAuthentiCated(login,pwd :String):Boolean;
  end;

  TDmoUser = class(TDataModule, IUser, IDModAuthen)
    schemaUser: TXMLDocument;
    qryAuthen: TSQLQuery;
    qryUser: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
     FMainDB  :IDmNutrCn;
     FUserDat :TRecUser;
     FSearch  :TRecUserSearch;
     function GetData :TRecUser;
     procedure SetData(const Value :TRecUser);
     //
     function GetSearchKey :TRecUserSearch;
     procedure SetSearchKey(const Value :TRecUserSearch);
     //
     procedure SetConnection;
  public
    { Public declarations }
     //IDModAuthen
     function IsAuthentiCated(login,pwd :String):Boolean;

     //IUser
     property Data :TRecUser
       read GetData write SetData;
     property SearchKey :TRecUserSearch
       read GetSearchKey write SetSearchKey;
    //
     function GetRunno(fld :TField; upd :Boolean=False):String;
     function UserDataSet :TDataSet; overload;
     function UserDataSet(p :TRecUserSearch) :TDataSet; overload;

     //IDataManage
     procedure CheckTables;
     procedure Initialize;

     //
     function FetchAllUsers :TDataSet;
  end;

var
  DmoUser: TDmoUser;

implementation

const
QRY_SEL_USER = 'SELECT * FROM NUTR_USER '+
               'WHERE ISNULL(ID,'''') LIKE :ID '+
               'AND ISNULL(FNAME,'''') LIKE :FNAME '+
               'AND ISNULL(LNAME,'''') LIKE :LNAME '+
               'AND ISNULL(GENDER,'''') LIKE :GENDER '+
               'AND ISNULL(EMAIL,'''') LIKE :EMAIL '+
               'AND ISNULL([LOGIN],'''') LIKE :LOGIN';

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
  qryUser.SQL.Text      := QRY_SEL_USER;
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
  Result := UserDataSet(FSearch);
end;

function TDmoUser.UserDataSet(p: TRecUserSearch): TDataSet;
begin
  qryUser.DisableControls;
  try
    qryUser.Close;
    //
    qryUser.SQL.Text   := QRY_SEL_USER;
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
    qryUser.Open;
  finally
    qryUser.EnableControls;
  end;

  Result := qryUser;
end;

{private}
function TDmoUser.GetData: TRecUser;
begin
  Result := FUserDat;
end;

function TDmoUser.GetRunno(fld :TField; upd :Boolean): String;
var iRn :Integer;
    s   :String;
begin
  iRn := FMainDB.NextRunno(runUser,upd);
  //
  if fld<>nil then begin
    s := DupeString('0', fld.Size);
    Result := RightStr(s+IntToStr(iRn),fld.Size);
  end else begin
    Result := IntToStr(iRn);
  end;
end;

function TDmoUser.GetSearchKey: TRecUserSearch;
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

procedure TDmoUser.SetData(const Value: TRecUser);
begin
  FUserDat := Value;
end;

procedure TDmoUser.SetSearchKey(const Value: TRecUserSearch);
begin
  FSearch := Value;
end;

end.
