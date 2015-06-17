unit FrMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls,Forms, Dialogs, Menus, StdCtrls, Buttons, ExtCtrls,
  SvCnMain, SvAuth, SvFactData;

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
begin
  if FIsLogined=False then begin
    CtrAuthen.DoLogin;
    if CtrAuthen.IsAuthenticated then begin
      AuthorizeMenu(CtrAuthen.AutohirzeUserType);
      //
      FIsLogined := True;
      sbtLogin.Caption := C_LOGOUT;
    end else begin
      MessageDlg(MSG_NOAUTH,mtInformation,[mbYes],0);
    end;
  end else begin
    AuthorizeMenu(UTYPE_LOGOUT);
    //
    FIsLogined := False;
    sbtLogin.Caption := C_LOGIN;
    //
    CtrAuthen.SetAuthenticated(False);
    CtrInputFact.DoClearInput;
  end;
end;

{private}
procedure TFrmMain.AuthorizeMenu(const utype: String);
begin
  sbtFileMan.Enabled := (uType<>UTYPE_LOGOUT);
end;

end.
