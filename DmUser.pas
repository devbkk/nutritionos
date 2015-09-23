unit DmUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc, StrUtils,
  DmBase, DmCnMain, ShareMethod, ShareInterface, SvEncrypt;

type
  IDModAuthen = interface(IInterface)
  ['{D280A8F6-D202-4B0C-B884-43296939E74A}']
    function GetAutohirzeUserType(login,pwd :String):String;
    function IsAuthentiCated(login,pwd :String):Boolean;
  end;

  TDmoUser = class(TDmoBase, IUser, IDModAuthen)
    schemaUser:    TXMLDocument;
    schemaUserLog: TXMLDocument;
    qryAuthen: TSQLQuery;
    qryUser: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FUserDat :TRecUser;
    FSearch  :TRecUserSearch;
    //
    function GetData :TRecUser;
    procedure SetData(const Value :TRecUser);
    //
    function GetSearchKey :TRecUserSearch;
    procedure SetSearchKey(const Value :TRecUserSearch);
    //
  protected
    function Schema :TXMLDocument; override;
  public
    { Public declarations }

    {IUser}
    function GetRunno(fld :TField;upd :Boolean=False):String;
    //
    property Data :TRecUser read GetData write SetData;
    property SearchKey :TRecUserSearch
      read GetSearchKey write SetSearchKey;
    //
    function UserDataSet :TDataSet; overload;
    function UserDataSet(p :TRecUserSearch) :TDataSet; overload;

    {IDModAuthen}
    function GetAutohirzeUserType(login,pwd :String):String;
    function IsAuthentiCated(login,pwd :String):Boolean;
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


QRY_SEL_AUSR = 'SELECT * FROM NUTR_USER';

QRY_SEL_PWD  = 'SELECT * FROM NUTR_USER '+
               'WHERE LOGIN =:LOGIN '+
               'AND PASSWORD =:PASSWORD';

{$R *.dfm}

procedure TDmoUser.DataModuleCreate(Sender: TObject);
begin
  inherited;
//
end;

procedure TDmoUser.DataModuleDestroy(Sender: TObject);
begin
  inherited;
//
end;

function TDmoUser.GetAutohirzeUserType(login, pwd: String): String;
var qry :TSqlQuery; sEncode :String;
begin
  if MainDB.IsDemoMode then begin
    Result := 'D';
    Exit;
  end;
  //
  if not MainDB.IsConnected then begin
    Result := 'Z';
    Exit;
  end;
  //
  qry := TSqlQuery.Create(nil);
  try
    //
    qry.SqlConnection := MainConnection;
    qry.SQL.Text      := QRY_SEL_AUSR;
    qry.Open;
    if qry.IsEmpty then begin
      Result := 'A';
      Exit;
    end;
    //
    sEncode := encodestring(pwd);
    //
    qry.Close;
    qry.SQL.Text := QRY_SEL_PWD;
    qry.ParamByName('LOGIN').AsString    := login;
    qry.ParamByName('PASSWORD').AsString := sEncode;
    qry.Open;
    //
    if qry.IsEmpty then
      Result := 'X'
    else Result := qry.FieldByName('UTYPE').AsString;
    qry.Close;
  finally
    FreeAndNil(qry)
  end;
end;

function TDmoUser.GetData: TRecUser;
begin
  Result := FUserDat;
end;

function TDmoUser.GetRunno(fld: TField; upd: Boolean): String;
var iRn :Integer;
    s   :String;
begin
  iRn := MainDB.NextRunno(runUser,upd);
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

function TDmoUser.IsAuthentiCated(login, pwd: String): Boolean;
begin
  qryAuthen.SqlConnection := MainConnection;
  qryAuthen.Open;
  Result := True;
end;

function TDmoUser.Schema: TXMLDocument;
begin
  Result := schemaUser;
end;

procedure TDmoUser.SetData(const Value: TRecUser);
begin
  FUserDat := Value;
end;

procedure TDmoUser.SetSearchKey(const Value: TRecUserSearch);
begin
  FSearch := Value;
end;

function TDmoUser.UserDataSet: TDataSet;
begin
  Result := UserDataSet(FSearch);
end;

function TDmoUser.UserDataSet(p: TRecUserSearch): TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qryUser;
    Exit;
  end;

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

end.
