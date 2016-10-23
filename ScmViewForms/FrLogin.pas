unit FrLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, frxpngimage, ExtCtrls,
  ShareCommon, ShareInterface;

type
  IViewAuthen = interface(IInterface)
  ['{1F6F2C28-3CC6-4F16-BBA3-A870D469AC1E}']
    //
    procedure Contact;
    function GetUserRecEvent :TSendUserRecEvent;
    procedure SetUserRecEvent(evt :TSendUserRecEvent);
    property UserRecEvent :TSendUserRecEvent
      read GetUserRecEvent write SetUserRecEvent;
  end;

  TFrmLogin = class(TForm, IViewAuthen)
    lbHeader: TLabel;
    grpLogin: TGroupBox;
    edLogin: TEdit;
    edPassword: TEdit;
    lbLogin: TLabel;
    lbPassword: TLabel;
    sbtOK: TSpeedButton;
    sbtCancel: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbtCancelClick(Sender: TObject);
    procedure sbtOKClick(Sender: TObject);
  private
    { Private declarations }
    FUserRecEvent :TSendUserRecEvent;
    //
    procedure DoFinishLogin(res :TModalResult);
    function GetLoginData(var p:TRecUser):Boolean;
    //
    function GetUserRecEvent :TSendUserRecEvent;
    procedure SetUserRecEvent(evt :TSendUserRecEvent);
    //
    procedure OnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SetKeyDownEvents;
  public
    { Public declarations }
    procedure Contact;
    property UserRecEvent :TSendUserRecEvent
      read GetUserRecEvent write SetUserRecEvent;
  end;

var
  FrmLogin: TFrmLogin;


implementation

{$R *.dfm}

procedure TFrmLogin.Contact;
begin
  ShowModal;
end;

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  SetKeyDownEvents;
end;

procedure TFrmLogin.FormDestroy(Sender: TObject);
begin
  if FrmLogin=Self then
    FrmLogin := nil;
end;

procedure TFrmLogin.sbtCancelClick(Sender: TObject);
begin
  DoFinishLogin(mrCancel);
  Self.Close;
end;

procedure TFrmLogin.sbtOKClick(Sender: TObject);
begin
  DoFinishLogin(mrOK);
  Self.Close;
end;

{private}
procedure TFrmLogin.DoFinishLogin(res :TModalResult);
var fUser :TRecUser;
begin
  if res=mrOK then begin
    if not GetLoginData(fUser) then
      Exit;
  end else if res=mrCancel then begin
    Exit;
  end;
  //
  if assigned(FUserRecEvent) then
     FUserRecEvent(fUser);
end;

function TFrmLogin.GetLoginData(var p:TRecUser):Boolean;
begin
  Result := False;
  if edLogin.Text='' then begin
    if edLogin.CanFocus then
      edLogin.SetFocus;
    Exit;
  end;
  //
  if edPassword.Text='' then begin
    if edPassword.CanFocus then
      edPassword.SetFocus;
    Exit;
  end;
  //
  p.login    := edLogin.Text;
  p.password := edPassword.Text;
  Result := True;
end;

function TFrmLogin.GetUserRecEvent: TSendUserRecEvent;
begin
  Result := FUserRecEvent;
end;

procedure TFrmLogin.OnKeyDown(Sender: TObject;
  var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_RETURN then begin
    if Sender = edLogin then begin
      if edPassword.CanFocus then
        edPassword.SetFocus;
    end;
    if Sender = edPassword then begin
      DoFinishLogin(mrOK);
      Self.Close;
    end;
  end;
end;

procedure TFrmLogin.SetKeyDownEvents;
begin
  edLogin.OnKeyDown    := OnKeyDown;
  edPassword.OnKeyDown := OnKeyDown;
end;

procedure TFrmLogin.SetUserRecEvent(evt: TSendUserRecEvent);
begin
  FUserRecEvent := evt;
end;

end.

