unit SvInutData;

interface

uses
  Forms, Classes, Controls, SysUtils, Dialogs, ActnList, DB, DBClient,
  FrFactData, FaFactData, FaUser, DmUser, ShareInterface;

type
  ICtrlInputFact = Interface(IInterface)
  ['{6CFC789C-0E36-43BD-9FB2-AA61E28A8DB9}']
    procedure DoInputData(OnWhat : TWinControl=nil);
  end;

  TCtrlInputData = class(TInterfacedObject,
                         ICtrlInputFact,
                         IViewInputFact)
  private
    FfrmInpDat :TfrmFactData;
    FfraInpDat :TfraFactData;
    FfraUser   :TfraUser;
    FUser      :IUser;
    FManUser   :TClientDataSet;
    function FactInputView :IViewInputFact;
    procedure SetUserModel;
  public
    constructor Create;
    destructor Destroy; override;
    procedure DoInputData(OnWhat : TWinControl=nil);
    //
    procedure DoRequestInputMaterial(Sender :TObject);
    procedure DoRequestInputUser(Sender :TObject);
    property View :IViewInputFact read FactInputView implements IViewInputFact;
    //User
    procedure DoUserAddWrite;
    procedure DoUserCancelDel;
    procedure DoUserMoveNext;
    procedure DoUserMovePrev;
    procedure OnUserNameExit(Sender :TObject);
    procedure OnUserCommandInput(Sender :TObject);
  end;

function CtrInputFact :ICtrlInputFact;

implementation

var iCtrlInpFact :ICtrlInputFact;

function CtrInputFact :ICtrlInputFact;
begin
  if not assigned(iCtrlInpFact) then
    iCtrlInpFact := TCtrlInputData.Create;
  Result := iCtrlInpFact;
end;
{ TCtrlInputData }

constructor TCtrlInputData.Create;
begin
  inherited Create;
  //
  if not assigned(FfraInpDat) then
    FfraInpDat := TfraFactData.Create(nil);

  if not assigned(FfraUser) then begin
    FfraUser := TfraUser.Create(nil);
    FfraUser.SetEditExit(OnUserNameExit);
    FfraUser.SetActionEvents(OnUserCommandInput);
  end;

  SetUserModel;
  FfraUser.UserDataInterface(FUser);
  FfraUser.Contact;
  FManUser := FfraUser.UserDataManage;
end;

destructor TCtrlInputData.Destroy;
begin
  //
  inherited Destroy;
end;

procedure TCtrlInputData.DoInputData(OnWhat :TWinControl=nil);
begin
  View.DoSetParent(OnWhat, nil);
  View.Contact;
end;

procedure TCtrlInputData.DoRequestInputMaterial(Sender: TObject);
var inf :IfraFactData;
begin
  if supports(FfraInpDat,IfraFactData,inf) then
    inf.DoRequestFactInput(fdtMaterial);
end;

procedure TCtrlInputData.DoRequestInputUser(Sender: TObject);
var inf :IfraFactData;
begin
  if supports(FfraUser,IfraFactData,inf) then
    inf.DoRequestFactInput(fdtUser);
end;

procedure TCtrlInputData.DoUserAddWrite;
begin
  if FManUser.State = dsBrowse then begin
    FManUser.Append;
  end else if FManUser.State in [dsInsert,dsEdit] then begin
    FManUser.Post;
    FManUser.ApplyUpdates(-1);
  end;
end;

procedure TCtrlInputData.DoUserCancelDel;
begin
  if FManUser.State = dsBrowse then begin
    FManUser.Delete;
  end else if FManUser.State in [dsInsert,dsEdit] then begin
    FManUser.Cancel;
  end;
end;

procedure TCtrlInputData.DoUserMoveNext;
begin
//
end;

procedure TCtrlInputData.DoUserMovePrev;
begin
//
end;

procedure TCtrlInputData.OnUserCommandInput(Sender: TObject);
begin
  if TCustomAction(Sender).Name='actAddWrite' then
    DoUserAddWrite
  else if TCustomAction(Sender).Name='actDelCanc' then
    DoUserCancelDel;     
  //
end;

procedure TCtrlInputData.OnUserNameExit(Sender: TObject);
var sFName, sLName :String;
begin
  if FManUser.State in [dsInsert,dsEdit] then begin
    sFName := FManUser.FieldByName('FNAME').AsString;
    sLName := FManUser.FieldByName('LNAME').AsString;
    FManUser.FieldByName('ANAME').AsString := sFName+' '+sLName;
  end;
end;

{private}
function TCtrlInputData.FactInputView: IViewInputFact;
var snd :TRecSetInputParam;
begin
  if not Assigned(FfrmInpDat) then begin
    FfrmInpDat := TfrmFactData.Create(nil);
    //
    snd.InputType := itMaterial;
    snd.Evt       := DoRequestInputMaterial;
    snd.AFrame    := FfraInpDat;
    FfrmInpDat.SetupInput(snd);
    //
    snd.InputType := itUser;
    snd.Evt       := DoRequestInputUser;
    snd.AFrame    := FfraUser;
    FfrmInpDat.SetupInput(snd);
  end;
  Result := FfrmInpDat;
end;

procedure TCtrlInputData.SetUserModel;
var p :TRecUserSearch;
begin
  //
  FUser := TDmoUser.Create(nil);
  FUser.SearchKey := p;
end;

end.
