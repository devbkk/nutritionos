unit SvFactData;

interface

uses
  Forms, Classes, Controls, SysUtils, Dialogs, ActnList, DB, DBClient,
  FrFactData, FaFactData, FaUser, DmUser, ShareInterface, ShareMethod,
  SvEncrypt;

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
    //
    FfraUser   :TfraUser;
    FUser      :IUser;
    FManUser   :TClientDataSet;
    FIsAdmin   :Boolean;
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
    procedure DoUserBeforePost(DataSet :TDataSet);
    procedure DoUserCancelDel;
    procedure DoUserMoveNext;
    procedure DoUserMovePrev;
    procedure OnUserNameExit(Sender :TObject);
    procedure OnUserCommandInput(Sender :TObject);
    procedure OnUserPasswordGetText(Sender: TField;
                                    var Text: string;
                                    DisplayText: Boolean);
    procedure OnUserPasswordSetText(Sender: TField; const Text: string);
  end;

function CtrInputFact :ICtrlInputFact;

implementation

var
  iCtrlInpFact :ICtrlInputFact;

const
  ERR_EMAIL = 'E-mail ���١��ͧ �ѹ�֡�������';
  //
  FLD_ID    = 'ID';
  FLD_FNM   = 'FNAME';
  FLD_LNM   = 'LNAME';
  FLD_ANM   = 'ANAME';
  FLD_EMAIL = 'EMAIL';
  FLD_PWD   = 'PASSWORD';
  FLD_UNU   = 'UNUSED';
  FLD_UTY   = 'UTYPE';
  //
  CMP_EDFNM = 'edFName';
  CMP_EDLNM = 'edLName';
  CMP_EDEMA = 'edEmail';
  //
  CMP_ACTAW = 'actAddWrite';
  CMP_ACTDC = 'actDelCanc';
  CMP_ACTNX = 'actNext';
  CMP_ACTPV = 'actPrev';
  //
  C_ADMIN = 'A';
  C_USER  = '0';
  //
  C_UNUSED = 'Y';
  C_USED   = 'N';

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
  //
  FManUser := FfraUser.UserDataManage;
  FManUser.BeforePost := DoUserBeforePost;
  //
  FManUser.FieldByName(FLD_PWD).OnGetText := OnUserPasswordGetText;
  FManUser.FieldByName(FLD_PWD).OnSetText := OnUserPasswordSetText;
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
var fldID,fldUT,fldUU :TField;
    sEmail            :String;
begin
  if FManUser.State = dsBrowse then begin
    //
    FIsAdmin := FManUser.IsEmpty;
    //
    FManUser.Append;
      fldID := FManUser.FieldByName(FLD_ID);
      fldID.AsString := FUser.GetRunno(fldID);
    //
    FfraUser.DoFirstFocus;
  end else if FManUser.State in [dsInsert,dsEdit] then begin
    //
    if FManUser.State = dsInsert then begin
      fldID := FManUser.FieldByName(FLD_ID);
      fldID.AsString := FUser.GetRunno(fldID,True);
      //
      fldUT := FManUser.FieldByName(FLD_UTY);
      If FIsAdmin then
        fldUT.AsString := C_ADMIN
      else fldUT.AsString := C_USER;
      //
      fldUU := FManUser.FieldByName(FLD_UNU);
      if FfraUser.IsUnUsed then
        fldUU.AsString := C_UNUSED
      else fldUU.AsString := C_USED;
    end;
    //
    sEmail := FManUser.FieldByName(FLD_EMAIL).AsString;
    if not ValidEmail(sEmail) then begin
      if MessageDlg(ERR_EMAIL,mtWarning,mbYesNo,0)=mrNo then begin
        FfraUser.UserCorrectEmail;
        Abort;
      end;
    end;
    //
    FManUser.Post;
    FManUser.ApplyUpdates(-1);
    //
    if FfraUser.IsSqeuenceAppend then
      DoUserAddWrite;
  end;
end;

procedure TCtrlInputData.DoUserBeforePost(DataSet: TDataSet);
{var sEmail,sPassword :String;}
begin
  //
  {sEmail := DataSet.FieldByName(FLD_EMAIL).AsString;
  if not ValidEmail(sEmail) then begin
    if MessageDlg(ERR_EMAIL,mtWarning,mbYesNo,0)=mrNo then begin
      FfraUser.UserCorrectEmail;
      Abort;
    end;
  end;}
  //
  {sPassword := DataSet.FieldByName(FLD_PWD).AsString;
  sPassword := encodestring(sPassword);
  DataSet.FieldByName(FLD_PWD).AsString:=sPassword;}
  //
  {If FIsAdmin then
    DataSet.FieldByName(FLD_UTY).AsString := C_ADMIN
  else DataSet.FieldByName(FLD_UTY).AsString := C_USER;}
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
  if FManUser.Eof then
    FManUser.Last
  else FManUser.Next;
end;

procedure TCtrlInputData.DoUserMovePrev;
begin
  if FManUser.Bof then
    FManUser.First
  else FManUser.Prior;
end;

procedure TCtrlInputData.OnUserCommandInput(Sender: TObject);
begin
  if TCustomAction(Sender).Name=CMP_ACTAW then
    DoUserAddWrite
  else if TCustomAction(Sender).Name=CMP_ACTDC then
    DoUserCancelDel
  else if TCustomAction(Sender).Name=CMP_ACTPV then
    DoUserMovePrev
  else if TCustomAction(Sender).Name=CMP_ACTNX then
    DoUserMoveNext;
end;

procedure TCtrlInputData.OnUserNameExit(Sender: TObject);
var sFName, sLName{, sEmail} :String;
begin
  if FManUser.State in [dsInsert,dsEdit] then begin
    if (TControl(Sender).Name=CMP_EDFNM)or
       (TControl(Sender).Name=CMP_EDLNM) then begin
      sFName := FManUser.FieldByName(FLD_FNM).AsString;
      sLName := FManUser.FieldByName(FLD_LNM).AsString;
      FManUser.FieldByName(FLD_ANM).AsString := sFName+' '+sLName;
    end else if TControl(Sender).Name=CMP_EDEMA then begin
      {sEmail := FManUser.FieldByName(FLD_EMAIL).AsString;
      if not ValidEmail(sEmail) then begin
        if MessageDlg(ERR_EMAIL,mtWarning,mbYesNo,0)=mrNo then begin
          FfraUser.UserCorrectEmail;
          Abort;
        end;
      end;}
    end;
  end;
end;

procedure TCtrlInputData.OnUserPasswordGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  try
    Text := decodestring(Sender.AsString);
  except
    Text := Sender.AsString;
  end;
end;

procedure TCtrlInputData.OnUserPasswordSetText(Sender: TField;
  const Text: string);
begin
  try
    Sender.AsString := encodestring(Text);
  except
    Sender.AsString := Text;
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
