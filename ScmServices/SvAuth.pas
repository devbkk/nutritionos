unit SvAuth;

interface

uses
  Classes, SysUtils, Dialogs, FrLogin, DmUser, DmSysLog, ShareInterface;

type
  ICtrlAuthen = Interface(IInterface)
  ['{930E3989-CC09-4AE4-857A-6D1C5ABB15B0}']
    procedure DoLogin; //overload;
    function IsAuthenticated :Integer;
    function GetAuthorizeUserType :String;
    procedure SetAuthenticated(p :Integer);
    property AutohirzeUserType :String read GetAuthorizeUserType;
  end;

  TCtrlAuthen = Class(TInterfacedObject, ICtrlAuthen, IViewAuthen, IDModAuthen,
                      IDmoSysLog)
  private
    FSvAuthLogin  :TFrmLogin;
    FSvAuthData   :TDmoUser;
    FSvAuthSysLog :TDmoSysLog;
    function GetAuthorizeUserType :String;
    function LoginView :IViewAuthen;
    function LoginData :IDModAuthen;
    function SysLogData :IDMoSysLog;
  public
    constructor Create;
    destructor Destroy; override;
    procedure DoCheckAuthen(p :TRecUser);
    procedure DoLogin;
    function IsAuthenticated :Integer;
    procedure SetAuthenticated(p :Integer);
    property AutohirzeUserType :String read GetAuthorizeUserType;
    property DatM :IDModAuthen read LoginData implements IDModAuthen;
    property DatL :IDmoSysLog  read SysLogData implements IDMoSysLog;
    property View :IViewAuthen read LoginView implements IViewAuthen;
  end;

var
  FAuthorizeUserType :String;
  FAuthenticated     :Integer;

const AUTH_OK = 1;
      AUTH_DEMO = 2;
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
end;

destructor TCtrlAuthen.Destroy;
begin
  {comment because invalid pointer
  if Assigned(FSvAuthLogin) then
    FSvAuthLogin.Free;
  if Assigned(FSvAuthData) then
    FSvAuthData.Free;
  if Assigned(FSvAuthSysLog) then
    FSvAuthSysLog.Free;}
  inherited;
end;

procedure TCtrlAuthen.DoCheckAuthen(p: TRecUser);
var snd :TRecSysLog;
begin
  if(p.login='')and(p.password='')then
    FAuthenticated := AUTH_FAIL_NOUSER
  else begin
    FAuthorizeUserType := DatM.GetAutohirzeUserType(p.login,p.password);
    //
    if FAuthorizeUserType='D' then
      FAuthentiCated := AUTH_DEMO
    else if FAuthorizeUserType='X' then
      FAuthenticated := AUTH_FAIL_WRONGUSERPWD
    else if FAuthorizeUserType='Z'  then
      FAuthenticated := AUTH_FAIL_NODBCONNECT
    else FAuthenticated := AUTH_OK;
    //
    if FAuthenticated = AUTH_OK then begin
      snd.id := 0;
      snd.desc := 'user='+p.login;
      snd.typ  := 'login';
      snd.dt   := now;
      //
      snd.desc := QuotedStr(snd.desc);
      snd.typ  := QuotedStr(snd.typ);
      DatL.WriteSysLog(snd);
    end;
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

function TCtrlAuthen.SysLogData: IDMoSysLog;
begin
  if not Assigned(FSvAuthSysLog) then
    FSvAuthSysLog := TDmoSysLog.Create(nil);
  Result := FSvAuthSysLog;
end;

end.
