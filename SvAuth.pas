unit SvAuth;

interface

uses
  Classes, SysUtils, Dialogs, FrLogin, DmUser, ShareInterface;

type
  ICtrlAuthen = Interface(IInterface)
  ['{930E3989-CC09-4AE4-857A-6D1C5ABB15B0}']
    procedure DoLogin; //overload;
    function IsAuthenticated :Integer;
    function GetAuthorizeUserType :String;
    procedure SetAuthenticated(p :Integer);
    property AutohirzeUserType :String read GetAuthorizeUserType;
  end;

  TCtrlAuthen = Class(TInterfacedObject, ICtrlAuthen, IViewAuthen, IDModAuthen)
  private
    FSvAuthLogin :TFrmLogin;
    FSvAuthData  :TDmoUser;
    function GetAuthorizeUserType :String;
    function LoginView :IViewAuthen;
    function LoginData :IDModAuthen;
  public
    constructor Create;
    procedure DoCheckAuthen(p :TRecUser);
    procedure DoLogin;
    function IsAuthenticated :Integer;
    procedure SetAuthenticated(p :Integer);
    property AutohirzeUserType :String read GetAuthorizeUserType;    
    property DatM :IDModAuthen read LoginData implements IDModAuthen;
    property View :IViewAuthen read LoginView implements IViewAuthen;
  end;

var
  FAuthorizeUserType :String;
  FAuthenticated     :Integer;

const AUTH_OK = 1;
      AUTH_FAIL_NOUSER       = 0;
      AUTH_FAIL_WRONGUSERPWD = -1;
      AUTH_FAIL_NODBCONNECT  = -2;

function CtrAuthen :ICtrlAuthen;

implementation

var iAuth :ICtrlAuthen;

function CtrAuthen :ICtrlAuthen;
begin
  iAuth := TCtrlAuthen.Create;
  Result := iAuth;
end;

{ TCtrlAuthen }

constructor TCtrlAuthen.Create;
begin
  inherited Create;
  View.UserRecEvent := DoCheckAuthen;
  //FAuthenticated := -1;
end;

procedure TCtrlAuthen.DoCheckAuthen(p: TRecUser);
begin
  if(p.login='')and(p.password='')then
    FAuthenticated := AUTH_FAIL_NOUSER
  else begin
    FAuthorizeUserType := DatM.GetAutohirzeUserType(p.login,p.password);
    {if FAuthorizeUserType<>'X' then
      FAuthenticated := AUTH_OK
    else FAuthenticated := AUTH_FAIL_WRONGUSERPWD;}
    if FAuthorizeUserType='X' then
      FAuthenticated := AUTH_FAIL_WRONGUSERPWD
    else if FAuthorizeUserType='Z'  then
      FAuthenticated := AUTH_FAIL_NODBCONNECT
    else FAuthenticated := AUTH_OK;
  end;
end;

procedure TCtrlAuthen.DoLogin;
begin
  if FAuthenticated<>AUTH_OK then
    View.Contact;
end;

function TCtrlAuthen.GetAuthorizeUserType: String;
begin
  Result := FAuthorizeUserType;
end;

function TCtrlAuthen.IsAuthenticated: Integer;
begin
  Result := FAuthenticated;
end;

function TCtrlAuthen.LoginData: IDModAuthen;
begin
  if not Assigned(FSvAuthData) then
    FSvAuthData := TDmoUser.Create(nil);
  Result := FSvAuthData;
end;

function TCtrlAuthen.LoginView: IViewAuthen;
begin
  if not Assigned(FSvAuthLogin) then
    FSvAuthLogin := TFrmLogin.Create(nil);
  Result := FSvAuthLogin;
end;

procedure TCtrlAuthen.SetAuthenticated(p: Integer);
begin
  FAuthenticated := p;
end;

end.
