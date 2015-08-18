unit FrMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls,Forms, Dialogs, Menus, StdCtrls, Buttons, ExtCtrls,
  System.UITypes,
  SvCnMain, SvAuth, SvFactData, FrDbConfig;

type
  TFrmMain = class(TForm)
    pnlMenuButtons: TPanel;
    sbtLogin: TSpeedButton;
    sbtFileMan: TSpeedButton;
    pnlMain: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbtLoginClick(Sender: TObject);
    procedure sbtFileManClick(Sender: TObject);
  private
    { Private declarations }
    FIsLogined :Boolean;
    procedure AuthorizeMenu(const utype :String);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses FrFactData;

const
  C_LOGIN  = 'เข้าใช้งาน';
  C_LOGOUT = 'เลิกใช้งาน';
  //
  UTYPE_LOGOUT = 'X';
  //
  MSG_NOAUTH = 'ไม่พบผู้ใช้งาน หรือรหัสผ่านไม่ถูกต้อง';

{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FIsLogined := False;
  CtrlCnMain.CheckDataBase;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmMain.sbtFileManClick(Sender: TObject);
begin
  CtrInputFact.DoInputData(pnlMain,CtrAuthen.AutohirzeUserType);
end;

procedure TFrmMain.sbtLoginClick(Sender: TObject);
var fDbCfg :TfrmDbConfig;
begin
  if FIsLogined=False then begin
    CtrAuthen.DoLogin;
    if(CtrAuthen.IsAuthenticated = AUTH_OK) then begin
      AuthorizeMenu(CtrAuthen.AutohirzeUserType);
      //
      FIsLogined := True;
      sbtLogin.Caption := C_LOGOUT;
    end else if CtrAuthen.IsAuthenticated = AUTH_FAIL_WRONGUSERPWD then begin
      MessageDlg(MSG_NOAUTH,mtInformation,[mbYes],0);
    end else if (CtrAuthen.IsAuthenticated = AUTH_FAIL_NODBCONNECT) then begin
      fDbCfg := TfrmDbConfig.Create(nil);
      fDbCfg.Contact;
    end;
  end else begin
    AuthorizeMenu(UTYPE_LOGOUT);
    //
    FIsLogined := False;
    sbtLogin.Caption := C_LOGIN;
    //
    CtrAuthen.SetAuthenticated(-1);
    CtrInputFact.DoClearInput;
  end;
end;

{private}
procedure TFrmMain.AuthorizeMenu(const utype: String);
begin
  sbtFileMan.Enabled := (uType<>UTYPE_LOGOUT);
end;

end.
