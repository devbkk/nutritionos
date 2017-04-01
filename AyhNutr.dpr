program AyhNutr;

uses
  FastMM4,
  Forms,
  ShareCommon in 'ScmUtils\ShareCommon.pas',
  ShareInterface in 'ScmUtils\ShareInterface.pas',
  ShareMethod in 'ScmUtils\ShareMethod.pas',
  SvAuth in 'ScmServices\SvAuth.pas',
  SvCnMain in 'ScmServices\SvCnMain.pas',
  SvEncrypt in 'ScmServices\SvEncrypt.pas',
  SvFactData in 'ScmServices\SvFactData.pas',
  SvFood in 'ScmServices\SvFood.pas',
  SvFoodPrep in 'ScmServices\SvFoodPrep.pas',
  SvFoodRep in 'ScmServices\SvFoodRep.pas',
  SvFoodReq in 'ScmServices\SvFoodReq.pas',
  SvUser in 'ScmServices\SvUser.pas',
  CtrDbCfg in 'ScmControllers\CtrDbCfg.pas',
  CtrFact in 'ScmControllers\CtrFact.pas',
  CtrFood in 'ScmControllers\CtrFood.pas',
  CtrFoodPrep in 'ScmControllers\CtrFoodPrep.pas',
  CtrFoodRep in 'ScmControllers\CtrFoodRep.pas',
  CtrFoodReq in 'ScmControllers\CtrFoodReq.pas',
  CtrLookUp in 'ScmControllers\CtrLookUp.pas',
  CtrSysLog in 'ScmControllers\CtrSysLog.pas',
  CtrUser in 'ScmControllers\CtrUser.pas',
  DmBase in 'ScmDataModels\DmBase.pas' {DmoBase: TDataModule},
  DmCnHomc in 'ScmDataModels\DmCnHomc.pas',
  DmCnMain in 'ScmDataModels\DmCnMain.pas' {DmoCnMain: TDataModule},
  DmFactDat in 'ScmDataModels\DmFactDat.pas' {DmoFactdat: TDataModule},
  DmFood in 'ScmDataModels\DmFood.pas' {DmoFood: TDataModule},
  DmFoodMenu in 'ScmDataModels\DmFoodMenu.pas' {DmoFoodMenu: TDataModule},
  DmFoodPrep in 'ScmDataModels\DmFoodPrep.pas' {DmoFoodPrep: TDataModule},
  DmFoodRep in 'ScmDataModels\DmFoodRep.pas' {DmoFoodRep: TDataModule},
  DmFoodReq in 'ScmDataModels\DmFoodReq.pas' {DmoFoodReq: TDataModule},
  DmLookUp in 'ScmDataModels\DmLookUp.pas' {DmoLup: TDataModule},
  DmMeal in 'ScmDataModels\DmMeal.pas' {DmoMeal: TDataModule},
  DmSysLog in 'ScmDataModels\DmSysLog.pas' {DmoSysLog: TDataModule},
  DmUser in 'ScmDataModels\DmUser.pas' {DmoUser: TDataModule},
  FaDbConfig in 'ScmViewFrames\FaDbConfig.pas' {fraDBConfig: TFrame},
  FaFactData in 'ScmViewFrames\FaFactData.pas' {fraFactData: TFrame},
  FaFactGroup in 'ScmViewFrames\FaFactGroup.pas' {fraFactGroup: TFrame},
  FaFood in 'ScmViewFrames\FaFood.pas' {fraFood: TFrame},
  FaFoodMenu in 'ScmViewFrames\FaFoodMenu.pas' {fraFoodMenu: TFrame},
  FaMeal in 'ScmViewFrames\FaMeal.pas' {fraMeal: TFrame},
  FaSysLog in 'ScmViewFrames\FaSysLog.pas' {fraSysLog: TFrame},
  FaUser in 'ScmViewFrames\FaUser.pas' {fraUser: TFrame},
  FrDbConfig in 'ScmViewForms\FrDbConfig.pas' {frmDbConfig},
  FrFactData in 'ScmViewForms\FrFactData.pas' {frmFactData},
  FrFactInput in 'ScmViewForms\FrFactInput.pas' {frmFactInputter},
  FrFood in 'ScmViewForms\FrFood.pas' {frmFood},
  FrFoodPrep in 'ScmViewForms\FrFoodPrep.pas' {frmFoodPrep},
  FrFoodRep in 'ScmViewForms\FrFoodRep.pas' {frmFoodRep},
  FrFoodReq in 'ScmViewForms\FrFoodReq.pas' {frmFoodReq},
  FrHcSearch in 'ScmViewForms\FrHcSearch.pas' {frmHcSearch},
  FrLogin in 'ScmViewForms\FrLogin.pas' {FrmLogin},
  FrMain in 'ScmViewForms\FrMain.pas' {FrmMain},
  CtrHcSearch in 'ScmControllers\CtrHcSearch.pas',
  ShareIntfModel in 'ScmUtils\ShareIntfModel.pas',
  CtrFactGrps in 'ScmControllers\CtrFactGrps.pas',
  DmFactGroups in 'ScmDataModels\DmFactGroups.pas' {DmoFactGroups: TDataModule},
  FrFactGroups in 'ScmViewForms\FrFactGroups.pas' {frmFoodGroups},
  FrFactSelect in 'ScmViewForms\FrFactSelect.pas' {frmFactselect},
  FaFactTree in 'ScmViewFrames\FaFactTree.pas' {fraFactTree: TFrame},
  FrFactTreeInput in 'ScmViewForms\FrFactTreeInput.pas' {frmFactTreeInput},
  ArrayList in 'ScmUtils\ArrayList.pas',
  ShareController in 'ScmUtils\ShareController.pas',
  FrPopupMsg in 'ScmViewForms\FrPopupMsg.pas' {frmPopupMessage},
  FaSrchPatient in 'ScmViewFrames\FaSrchPatient.pas' {fraSrchPat: TFrame},
  ShareIntfService in 'ScmUtils\ShareIntfService.pas',
  ShareQueryConst in 'ScmUtils\ShareQueryConst.pas',
  FrFoodReqInput in 'ScmViewForms\FrFoodReqInput.pas' {frmFoodReqInputter};

{$R *.res}

begin
{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);
{$WARN SYMBOL_PLATFORM ON}
  //
  Application.Initialize;
  Application.Title := 'Nutritional Data Management';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
