unit SvAuth;

interface

uses
  Classes, SysUtils, Dialogs, FrLogin, DmUser, ShareInterface;

type
  ICtrlAuthen = Interface(IInterface)
  ['{930E3989-CC09-4AE4-857A-6D1C5ABB15B0}']
    procedure DoLogin; //overload;
    //function DoLogin :String;// overload;
    function IsAuthenticated :Boolean;
    function GetAuthorizeUserType :String;
    property AutohirzeUserType :String read GetAuthorizeUserType;
  end;

  TCtrlAuthen = Class(TInterfacedObject, ICtrlAuthen, IViewAuthen, IDModAuthen)
  private
    FSvAuthLogin :TFrmLogin;
    FSvAuthData  :TDmoUser;
    FSvAuthenticated : Boolean;
    function GetAuthorizeUserType :String;
    function LoginView :IViewAuthen;
    function LoginData :IDModAuthen;
  public
    constructor Create;
    procedure DoCheckAuthen(p :TRecUser);
    procedure DoLogin; //overload;
    //function DoLogin :String; //overload;
    function IsAuthenticated :Boolean;
    property DatM :IDModAuthen read LoginData implements IDModAuthen;
    property AutohirzeUserType :String read GetAuthorizeUserType;
    property View :IViewAuthen read LoginView implements IViewAuthen;
  end;

var
  FAutohirzeUserType :String;

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
  //FSvAuthenticated := DatM.IsAuthentiCated(p.login,p.password);
  FAutohirzeUserType := DatM.GetAutohirzeUserType(p.login,p.password);
  ShowMessage(FAutohirzeUserType+'1');
end;

{function TCtrlAuthen.DoLogin: String;
begin
  Result := DatM.GetAutohirzeUserType(p.login,p.password);
end;}

procedure TCtrlAuthen.DoLogin;
begin
  if not FSvAuthenticated then
    View.Contact;
end;

function TCtrlAuthen.GetAuthorizeUserType: String;
begin
  ShowMessage(FAutohirzeUserType+'2');
  Result := FAutohirzeUserType;
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
