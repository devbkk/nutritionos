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
    pnlMain: TPanel;
    sbtLogin: TSpeedButton;
    sbtFileMan: TSpeedButton;
    sbtFood: TSpeedButton;
    sbtMealReq: TSpeedButton;
    sbtMealPrep: TSpeedButton;
    sbtReport: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbtLoginClick(Sender: TObject);
    procedure sbtFileManClick(Sender: TObject);
  private
    { Private declarations }
    FIsLogined :Boolean;
    FDemoMode  :Boolean;
    procedure AuthorizeMenu(const utype :String);
    procedure InitialSetting;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses FrFactData;

const
  C_LOGIN  = '�����ҹ';
  C_LOGOUT = '��ԡ��ҹ';
  //
  UTYPE_LOGOUT = 'X';
  //
  MSG_NOAUTH = '��辺�����ҹ �������ʼ�ҹ���١��ͧ';

{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  InitialSetting;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmMain.InitialSetting;
begin
  FIsLogined := False;
  CtrlCnMain.CheckDataBase;
  //
  sbtFileMan.Enabled  := False;
  sbtFood.Enabled     := False;
  sbtMealReq.Enabled  := False;
  sbtMealPrep.Enabled := False;
  sbtReport.Enabled   := False;
end;

procedure TFrmMain.sbtFileManClick(Sender: TObject);
begin
  CtrInputFact.DoInputData(pnlMain,CtrAuthen.AutohirzeUserType);
end;

procedure TFrmMain.sbtLoginClick(Sender: TObject);
var fDbCfg :TfrmDbConfig;
begin
  FDemoMode := False;
  //
  if FIsLogined=False then begin
    CtrAuthen.DoLogin;
    if(CtrAuthen.IsAuthenticated = AUTH_OK) then begin
      //
      FIsLogined := True;
      sbtLogin.Caption := C_LOGOUT;
      //
      AuthorizeMenu(CtrAuthen.AutohirzeUserType);
    end else if CtrAuthen.IsAuthenticated = AUTH_FAIL_WRONGUSERPWD then begin
      MessageDlg(MSG_NOAUTH,mtInformation,[mbYes],0);
    end else if (CtrAuthen.IsAuthenticated = AUTH_FAIL_NODBCONNECT) then begin
      fDbCfg := TfrmDbConfig.Create(nil);
      fDbCfg.Contact;
    end else if (CtrAuthen.IsAuthenticated = AUTH_DEMO) then begin
      //
      FIsLogined := True;
      FDemoMode  := True;
      sbtLogin.Caption := C_LOGOUT;
      //
      AuthorizeMenu(CtrAuthen.AutohirzeUserType);
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
var b :Boolean;
begin
  b := (uType<>UTYPE_LOGOUT);
  sbtFileMan.Enabled  := b;
  sbtFood.Enabled     := b;
  sbtMealReq.Enabled  := b;
  sbtMealPrep.Enabled := b;
  sbtReport.Enabled   := b;
  //
end;

end.
