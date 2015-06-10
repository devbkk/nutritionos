unit SvAuth;

interface

uses
  Classes, SysUtils, Dialogs, FrLogin, DmUser, ShareInterface;

type
  ICtrlAuthen = Interface(IInterface)
  ['{930E3989-CC09-4AE4-857A-6D1C5ABB15B0}']
    procedure DoLogin;
    function IsAuthenticated :Boolean;
  end;

  TCtrlAuthen = Class(TInterfacedObject, ICtrlAuthen, IViewAuthen, IDModAuthen)
  private
    FSvAuthLogin :TFrmLogin;
    FSvAuthData  :TDmoUser;
    FSvAuthenticated : Boolean;
    function LoginView :IViewAuthen;
    function LoginData :IDModAuthen;
  public
    constructor Create;
    procedure DoCheckAuthen(p :TRecUser);
    procedure DoLogin;
    function IsAuthenticated :Boolean;    
    property View :IViewAuthen read LoginView implements IViewAuthen;
    property DatM :IDModAuthen read LoginData implements IDModAuthen;
  end;

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
end;

procedure TCtrlAuthen.DoCheckAuthen(p: TRecUser);
begin
  FSvAuthenticated := DatM.IsAuthentiCated(p.login,p.password);
end;

procedure TCtrlAuthen.DoLogin;
begin
  if not FSvAuthenticated then
    View.Contact;
end;

function TCtrlAuthen.IsAuthenticated: Boolean;
begin
  Result := FSvAuthenticated;
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

end.
