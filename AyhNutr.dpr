program AyhNutr;

uses
  Forms,
  DmCnMain in 'DmCnMain.pas' {DmoCnMain: TDataModule},
  DmUser in 'DmUser.pas' {DmoUser: TDataModule},
  FrFactData in 'FrFactData.pas' {frmFactData},
  FrLogin in 'FrLogin.pas' {FrmLogin},
  FrMain in 'FrMain.pas' {FrmMain},
  SvAuth in 'SvAuth.pas',
  SvCnMain in 'SvCnMain.pas',
  ShareMethod in 'ShareMethod.pas',
  FaUser in 'FaUser.pas' {fraUser: TFrame},
  SvFactData in 'SvFactData.pas',
  SvUser in 'SvUser.pas',
  DmFactDat in 'DmFactDat.pas' {DmoFact: TDataModule},
  FaFactData in 'FaFactData.pas' {fraFactData: TFrame},
  ShareInterface in 'ShareInterface.pas',
  SvEncrypt in 'SvEncrypt.pas',
  FaDbConfig in 'FaDbConfig.pas' {fraDBConfig: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
