program AyhNutr;

uses
  Forms,
  ClUser in 'ClUser.pas',
  DmCnMain in 'DmCnMain.pas' {DmoCnMain: TDataModule},
  DmUser in 'DmUser.pas' {DmoUser: TDataModule},
  FrFactData in 'FrFactData.pas' {frmFactData},
  FrLogin in 'FrLogin.pas' {FrmLogin},
  FrMain in 'FrMain.pas' {FrmMain},
  SvAuth in 'SvAuth.pas',
  SvCnMain in 'SvCnMain.pas',
  SvAux in 'SvAux.pas',
  FaFactData in 'FaFactData.pas' {fraFactData: TFrame},
  SvInutData in 'SvInutData.pas',
  InfInputData in 'InfInputData.pas',
  SvUser in 'SvUser.pas',
  DmFactDat in 'DmFactDat.pas' {DmoFact: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDmoFact, DmoFact);
  Application.Run;
end.
