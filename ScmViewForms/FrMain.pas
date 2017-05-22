unit FrMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls,Forms, Dialogs, Menus, StdCtrls, Buttons, ExtCtrls,
  ComCtrls, ShareCommon, ShareMethod, SvCnMain, SvAuth, SvFactData,
  SvFood, SvFoodReq, SvFoodPrep, SvFoodRep, SvChecker, FrDbConfig;

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
    stbMain: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbtLoginClick(Sender: TObject);
    procedure sbtFileManClick(Sender: TObject);
    procedure sbtFoodClick(Sender: TObject);
    procedure sbtMealReqClick(Sender: TObject);
    procedure sbtMealPrepClick(Sender: TObject);
    procedure sbtReportClick(Sender: TObject);
  private
    { Private declarations }
    FIsLogined :Boolean;
    FDemoMode  :Boolean;
    procedure AuthorizeMenu(const utype :String);
    procedure ClearAllServices;
    procedure InitialSetting;
    procedure StartAllServices;
  public
    { Public declarations }
    procedure ServiceCallBack(pCall :TRecServiceCallBack);
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
  InitialSetting;
  StartAllServices;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  ServFood.DoFinishInput;

  if FrmMain=Self then
    FrmMain := nil;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
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
  //
  stbMain.Panels[0].Text := GetAppVersion;
end;

procedure TFrmMain.sbtFileManClick(Sender: TObject);
begin
  CtrInputFact(FDemoMode).DoInputData(pnlMain,CtrAuthen.AutohirzeUserType);
end;

procedure TFrmMain.sbtFoodClick(Sender: TObject);
begin
  ServFood.DoInputData(pnlMain,CtrAuthen.AutohirzeUserType);
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
    //
    ClearAllServices;
  end;
end;

procedure TFrmMain.sbtMealPrepClick(Sender: TObject);
begin
  ServFoodPrep.DoSetServiceCallBack(ServiceCallBack);
  ServFoodPrep.DoInputData(pnlMain,CtrAuthen.AutohirzeUserType);
end;

procedure TFrmMain.sbtMealReqClick(Sender: TObject);
begin
  ServFoodReq.DoInputData(pnlMain,CtrAuthen.AutohirzeUserType);
end;

procedure TFrmMain.sbtReportClick(Sender: TObject);
begin
  ServFoodRep.DoInputData(pnlMain,CtrAuthen.AutohirzeUserType);
end;

procedure TFrmMain.ServiceCallBack(pCall: TRecServiceCallBack);
var snd :TRecServFoodReq;
begin
  snd.OnWhat        := pnlMain;
  snd.UserType      := CtrAuthen.AutohirzeUserType;
  snd.CallBackValue := pCall.CallBackValue;
  //
  ServFoodReq.DoInputData(snd);
end;

procedure TFrmMain.StartAllServices;
begin
  ServFood.Start;
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

procedure TFrmMain.ClearAllServices;
begin
  CtrInputFact.DoClearInput;
  ServFood.DoClearInput;
  ServFoodReq.DoClearInput;
  ServFoodPrep.DoClearInput;
  ServFoodRep.DoClearInput;
end;

end.
