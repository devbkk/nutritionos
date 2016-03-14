unit SvFactData;

interface

uses
  //system unit
  Forms, Classes, Controls, SysUtils, Dialogs, ActnList, DB, DBClient,
  xmldom, XMLIntf, msxmldom, XMLDoc, StdCtrls, 
  //user unit
  ShareCommon, ShareInterface, ShareMethod, SvEncrypt,
  FrFactData, CtrFact, CtrUser, CtrSysLog, CtrDbCfg, CtrFactGrps;

type
  ICtrlInputFact = Interface(IInterface)
  ['{6CFC789C-0E36-43BD-9FB2-AA61E28A8DB9}']
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String='');
  end;

  TCtrlInputData = class(TInterfacedObject,
                         ICtrlInputFact,
                         IViewInputFact)
  private
    FfrmInpDat :TfrmFactData;
    //
    FCtrFact   :TControllerFact;
    FCtrUser   :TControllerUser;
    FCtrDbCfg  :TControllerDbConfig;
    FCtrSysLog :TControllerSysLog;
    FCtrFaGrps :TControllerFactGroups;
    //
    function FactInputView :IViewInputFact;

  public
    constructor Create;overload;
    constructor Create(IsDemo :Boolean);overload;
    destructor Destroy; override;
    procedure DoClearInput;
    procedure DoInputData(OnWhat : TWinControl=nil; uType :String='');
    //
    procedure DoRequestInputMaterial(Sender :TObject);
    procedure DoRequestInputUser(Sender :TObject);
    property View :IViewInputFact read FactInputView implements IViewInputFact;
    //
    //
    procedure SetDemoMode;
    procedure SetNormalMode;
    procedure Start;
  end;

var
  FAuthorizeUserType :String;

function CtrInputFact(IsDemo:Boolean=False) :ICtrlInputFact;

implementation

var
  iCtrlInpFact :ICtrlInputFact;

function CtrInputFact(IsDemo:Boolean) :ICtrlInputFact;
begin
  if not assigned(iCtrlInpFact) then
    iCtrlInpFact := TCtrlInputData.Create(IsDemo);
  Result := iCtrlInpFact;
end;
{ TCtrlInputData }

constructor TCtrlInputData.Create;
begin
  inherited Create;
  SetNormalMode;
end;

constructor TCtrlInputData.Create(IsDemo: Boolean);
begin
  if IsDemo then
    SetDemoMode
  else SetNormalMode;
end;

destructor TCtrlInputData.Destroy;
begin
  //comment cause invalid pointer operation
  //FCtrFact.Free;
  //FCtrUser.Free;
  //FCtrDbCfg.Free;
  //FCtrSysLog.Free;
  inherited Destroy;
end;

procedure TCtrlInputData.DoClearInput;
begin
  if Assigned(FfrmInpDat)and(FfrmInpDat.Showing)then
    FfrmInpDat.Hide;
  FAuthorizeUserType := '';
end;

procedure TCtrlInputData.DoInputData(OnWhat :TWinControl=nil; uType :String='');
begin
  Start;
  //
  View.AuthorizeMenu(uType);
  View.DoSetParent(OnWhat, nil);
  View.Contact;
  //
  FAuthorizeUserType := uType;
end;

procedure TCtrlInputData.DoRequestInputMaterial(Sender: TObject);
var inf :IfraFactData;
begin
  if supports(FCtrFact.View,IfraFactData,inf) then
    inf.DoRequestFactInput(fdtMaterial);
end;

procedure TCtrlInputData.DoRequestInputUser(Sender: TObject);
var inf :IfraFactData;
begin
  if supports(FCtrUser.View,IfraFactData,inf) then
    inf.DoRequestFactInput(fdtUser);
end;


{private}
function TCtrlInputData.FactInputView: IViewInputFact;
begin
  Start;
  //
  Result := FfrmInpDat;
end;

procedure TCtrlInputData.SetDemoMode;
begin
  //FfraInpDat := TfraFactData.Create(nil);
  //FfraUser := TfraUser.Create(nil);
  //FFraDbCfg := TfraDBConfig.Create(nil);
  //FFraSysLog := TfraSysLog.Create(nil);
end;

procedure TCtrlInputData.SetNormalMode;
begin
  //
  FCtrFact   := TControllerFact.Create;
  //
  FCtrUser   := TControllerUser.Create;
  //
  FCtrDbCfg  := TControllerDbConfig.Create;
  //
  FCtrSysLog := TControllerSysLog.Create;
  //
  FCtrFaGrps := TControllerFactGroups.Create;
end;

procedure TCtrlInputData.Start;
var snd :TRecSetInputParam;
begin
  if not assigned(FfrmInpDat) then begin
    FfrmInpDat := TfrmFactData.Create(nil);
  //
    snd.InputType := itMaterial;
    snd.Evt       := DoRequestInputMaterial;
    snd.AFrame    := FCtrFact.View;
    FfrmInpDat.SetupInput(snd);
  //
    snd.InputType := itUser;
    snd.Evt       := DoRequestInputUser;
    snd.AFrame    := FCtrUser.View;
    FfrmInpDat.SetupInput(snd);
  //
    snd.InputType := itDbCfg;
    snd.AFrame    := FCtrDbCfg.View;
    FfrmInpDat.SetupInput(snd);
  //
    snd.InputType := itSysLog;
    snd.AFrame    := FCtrSysLog.View;
    FfrmInpDat.SetupInput(snd);
  //
    snd.InputType := iFactTyp;
    snd.AFrame    := FCtrFaGrps.View;
    FfrmInpDat.SetupInput(snd);
  end;
end;

end.
