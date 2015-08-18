program AyhNutr;

uses
  Forms,
  DmCnMain in 'DmCnMain.pas' {DmoCnMain: TDataModule},
  FrFactData in 'FrFactData.pas' {frmFactData},
  FrLogin in 'FrLogin.pas' {FrmLogin},
  FrMain in 'FrMain.pas' {FrmMain},
  SvAuth in 'SvAuth.pas',
  SvCnMain in 'SvCnMain.pas',
  ShareMethod in 'ShareMethod.pas',
  FaUser in 'FaUser.pas' {fraUser: TFrame},
  SvFactData in 'SvFactData.pas',
  SvUser in 'SvUser.pas',
  FaFactData in 'FaFactData.pas' {fraFactData: TFrame},
  ShareInterface in 'ShareInterface.pas',
  SvEncrypt in 'SvEncrypt.pas',
  FaDbConfig in 'FaDbConfig.pas' {fraDBConfig: TFrame},
  FrDbConfig in 'FrDbConfig.pas' {frmDbConfig},
  DmBase in 'DmBase.pas' {DmoBase: TDataModule},
  DmUser in 'DmUser.pas' {DmoUser: TDataModule},
  DmFactDat in 'DmFactDat.pas' {DmoFactdat: TDataModule},
  FaSysLog in 'FaSysLog.pas' {fraSysLog: TFrame},
  DmSysLog in 'DmSysLog.pas' {DmoSysLog: TDataModule},
  frxpngimage in 'Corr\frxpngimage.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
