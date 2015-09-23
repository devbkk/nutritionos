unit SvFactData;

interface

uses
  Forms, Classes, Controls, SysUtils, Dialogs, ActnList, DB, DBClient,
  xmldom, XMLIntf, msxmldom, XMLDoc, StdCtrls, 
  FrFactData, FaFactData, FaDbConfig, FaUser, FaSysLog,
  DmUser, DmFactDat, DmSysLog,
  ShareInterface, ShareMethod, SvEncrypt;


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
    FfraInpDat :TfraFactData;
    FFact      :IFact;
    FManFact   :TClientDataSet;
    FFtypList  :TStrings;
    //
    FfraUser   :TfraUser;
    FUser      :IUser;
    FManUser   :TClientDataSet;
    FIsAdmin   :Boolean;
    //
    FFraDbCfg  :TfraDBConfig;
    //
    FFraSysLog :TfraSysLog;
    FSysLog    :ISysLog;
    //
    FFactTypeSearch :String;
    function CreateModelUser :IUser;
    function CreateModelFact :IFact;
    function CreateModelSysLog :ISysLog;
    function FactInputView :IViewInputFact;
    //
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
    //Fact
    procedure DoFactAddWrite;
    procedure DoFactCancelDel;
    procedure DoGenerateFactTypeList;
    procedure OnFactCommandInput(Sender :TObject);
    procedure OnFactTypeCloseUp(Sender :TObject);
    procedure OnFactTypeKeyDown(Sender: TObject;
                                var Key:
                                Word; Shift: TShiftState);
    procedure OnFactTypeTimerSearch(Sender :TObject);
    //User
    procedure DoUserAddWrite;
    procedure DoUserCancelDel;
    procedure DoUserMoveNext;
    procedure DoUserMovePrev;
    procedure OnUserNameExit(Sender :TObject);
    procedure OnUserCommandInput(Sender :TObject);
    procedure OnUserPasswordGetText(Sender: TField;
                                    var Text: string;
                                    DisplayText: Boolean);
    procedure OnUserPasswordSetText(Sender: TField; const Text: string);
    //
    procedure OnDbConnectParamsSave(Sender :TObject);
    class function ReadConfig :TRecConnectParams;
    class procedure WriteConfig(p :TRecConnectParams);
    //
    procedure SetDemoMode;
    procedure SetNormalMode;
  end;

var
  FAuthorizeUserType :String;

function CtrInputFact(IsDemo:Boolean=False) :ICtrlInputFact;

implementation

var
  iCtrlInpFact :ICtrlInputFact;

const
  ERR_EMAIL = 'E-mail ไม่ถูกต้อง บันทึกหรือไม่';
  ERR_CFG   = 'ไม่พบไฟล์ที่ใช้ตั้งค่า';
  //
  MSG_XML_SAVED = 'ตั้งค่า ';
  //USER
  FLD_ID    = 'ID';
  FLD_FNM   = 'FNAME';
  FLD_LNM   = 'LNAME';
  FLD_ANM   = 'ANAME';
  FLD_EMAIL = 'EMAIL';
  FLD_PWD   = 'PASSWORD';
  FLD_UNU   = 'UNUSED';
  FLD_UTY   = 'UTYPE';
  //FACT TYPE
  FLD_FTY   = 'FTYP';
  FLD_NOT   = 'NOTE';
  //
  CMP_EDFNM = 'edFName';
  CMP_EDLNM = 'edLName';
  CMP_EDEMA = 'edEmail';
  //
  CMP_ACTAW = 'actAddWrite';
  CMP_ACTDC = 'actDelCanc';
  CMP_ACTNX = 'actNext';
  CMP_ACTPV = 'actPrev';
  CMP_ACTFG = 'actFactGroup';
  //
  C_ADMIN = 'A';
  C_USER  = '0';
  //
  C_UNUSED = 'Y';
  C_USED   = 'N';
  //
  FILE_CONFIG = 'config.xml';
  //
  element_db     = 'database';
  element_server = 'server';
  element_name   = 'name';
  element_user   = 'user';
  element_pwd    = 'password';

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

function TCtrlInputData.CreateModelFact: IFact;
var p :TRecFactSearch;
begin
  FFact := TDmoFactdat.Create(nil);
  FFact.SearchKey := p;
  Result := FFact;
end;

function TCtrlInputData.CreateModelSysLog: ISysLog;
var p :TRecSysLogSearch;
begin
  FSysLog := TDmoSysLog.Create(nil);
  FSysLog.SearchKey := p;
  Result := FSysLog;
end;

function TCtrlInputData.CreateModelUser: IUser;
var p :TRecUserSearch;
begin
  //
  FUser := TDmoUser.Create(nil);
  FUser.SearchKey := p;
  Result := FUser;
end;

destructor TCtrlInputData.Destroy;
begin
  FFtypList.Free;
  //
  inherited Destroy;
end;

procedure TCtrlInputData.DoClearInput;
begin
  //View.UnContact;
  if Assigned(FfrmInpDat)and(FfrmInpDat.Showing)then
    FfrmInpDat.Hide;
  FAuthorizeUserType := '';
end;

procedure TCtrlInputData.DoFactAddWrite;
begin
  if FManFact.State = dsBrowse then begin
    FManFact.Append;
    FfraInpDat.FocusFirstCell;
  end else if FManFact.State in [dsInsert,dsEdit] then begin
    if FManFact.State = dsInsert then begin
      FManFact.FieldByName(FLD_FTY).AsString := FfraInpDat.FactType;
      if FManFact.FieldByName(FLD_NOT).IsNull then
        FManFact.FieldByName(FLD_NOT).AsString := '';
    end;
    FManFact.Post;
    FManFact.ApplyUpdates(-1);
    //
    DoGenerateFactTypeList;
    if FfraInpDat.IsSqeuenceAppend then
      DoFactAddWrite;
  end;
end;

procedure TCtrlInputData.DoFactCancelDel;
begin
  if FManFact.State = dsBrowse then begin
    FManFact.Delete;
  end else if FManFact.State in [dsInsert,dsEdit] then begin
    FManFact.Cancel;
  end;
end;

procedure TCtrlInputData.DoGenerateFactTypeList;
var ds :TDataSet;
begin
  ds := FFact.FactTypeDataSet;
  if not ds.IsEmpty then begin
    FFtypList.Clear;
    ds.First;
    repeat
      FFtypList.Append(ds.Fields[0].AsString);
      ds.Next;
    until ds.Eof;
    FfraInpDat.SetFactTypeList(FFtypList);
  end;
end;

procedure TCtrlInputData.DoInputData(OnWhat :TWinControl=nil; uType :String='');
var snd :TRecSetInputParam;
begin

  if not assigned(FfrmInpDat) then begin
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
  //
    snd.InputType := itDbCfg;
    snd.AFrame    := FFraDbCfg;
    FfrmInpDat.SetupInput(snd);
  //
    snd.InputType := itSysLog;
    snd.AFrame    := FFraSysLog;
    FfrmInpDat.SetupInput(snd);
  end;
  View.AuthorizeMenu(uType);
  View.DoSetParent(OnWhat, nil);
  View.Contact;
  //
  FAuthorizeUserType := uType;
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
    //sEmail            :String;
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
    FManUser.Post;
    FManUser.ApplyUpdates(-1);
    //
    if FfraUser.IsSqeuenceAppend then
      DoUserAddWrite;
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

procedure TCtrlInputData.OnDbConnectParamsSave(Sender: TObject);
begin
  WriteConfig(TConnectParam(Sender).Params);
end;

procedure TCtrlInputData.OnFactCommandInput(Sender: TObject);
begin
  if TCustomAction(Sender).Name=CMP_ACTAW then
    DoFactAddWrite
  else if TCustomAction(Sender).Name=CMP_ACTDC then
    DoFactCancelDel
  else if TCustomAction(Sender).Name=CMP_ACTFG then
    FfraInpDat.ContactFactGroup;
  {else if TCustomAction(Sender).Name=CMP_ACTPV then
    DoUserMovePrev
  else if TCustomAction(Sender).Name=CMP_ACTNX then
    DoUserMoveNext;}
end;

procedure TCtrlInputData.OnFactTypeCloseUp(Sender: TObject);
var snd :TRecFactSearch;
begin
  if Sender is TComboBox then
    snd.ftyp := TComboBox(Sender).Items[TComboBox(Sender).ItemIndex];
    //snd.ftyp := TComboBox(Sender).Text;

  FFact.SearchKey := snd;
  //
  FfraInpDat.FactDataInterface(FFact);
  FfraInpDat.Contact;
end;

procedure TCtrlInputData.OnFactTypeKeyDown(
  Sender: TObject;
  var Key: Word;
  Shift: TShiftState);
begin
  FfraInpDat.SetTimerSearch(True);
  FFactTypeSearch := TComboBox(Sender).Text;
end;

procedure TCtrlInputData.OnFactTypeTimerSearch(Sender: TObject);
var snd :TRecFactSearch;
begin
  FfraInpDat.SetTimerSearch(False);
  //
  snd.ftyp := FFactTypeSearch;
  FFact.SearchKey := snd;
  //
  FfraInpDat.FactDataInterface(FFact);
  FfraInpDat.Contact;
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
var snd :TRecSetInputParam; //inf :IViewInputFact;
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
  //
  {try#
  if Supports(FfrmInpDat,IViewInputFact,inf) then
    Result := inf
  else Result := nil;}
  Result := FfrmInpDat;
end;

class function TCtrlInputData.ReadConfig: TRecConnectParams;
var xmlRead :TXMLDocument;
    dbNode  :IXMLNode;
    p       :TRecConnectParams;
    sFile   :String;
begin
  sFile := GetCurrentDir+'\'+FILE_CONFIG;
  if not FileExists(sFile) then
    MessageDlg(ERR_CFG,mtError,[mbOK],0)
  else begin
    xmlRead := TXMLDocument.Create(Application);
    try
      xmlRead.FileName := sFile;
      xmlRead.Active   := True;
      if xmlRead.Active then begin
        dbNode := xmlRead.DocumentElement;
        p.Server   := dbNode.ChildNodes[element_server].NodeValue;
        p.Database := dbNode.ChildNodes[element_name].NodeValue;
        p.User     := dbNode.ChildNodes[element_user].NodeValue;
        p.Password := dbNode.ChildNodes[element_pwd].NodeValue;
      end;
      Result := p;
    finally
      xmlRead.Active := False;
      xmlRead.Free;
    end;
  end;
end;

procedure TCtrlInputData.SetDemoMode;
begin
  FfraInpDat := TfraFactData.Create(nil);
  FfraUser := TfraUser.Create(nil);
  FFraDbCfg := TfraDBConfig.Create(nil);
  FFraSysLog := TfraSysLog.Create(nil);
end;

procedure TCtrlInputData.SetNormalMode;
begin
  FFtypList := TStringList.Create;
  //
  if not assigned(FfraInpDat) then begin
    FfraInpDat := TfraFactData.Create(nil);
    FfraInpDat.SetActionEvents(OnFactCommandInput);
    FfraInpDat.SetFactTypeCloseUp(OnFactTypeCloseUp);
    FfraInpDat.SetFactTypeKeyDown(OnFactTypeKeyDown);
    FfraInpDat.SetFactTypeTimerSearch(OnFactTypeTimerSearch);
    FfraInpDat.FactDataInterface(CreateModelFact);
    FfraInpDat.Contact;
    FfraInpDat.ContactFactGroup;
    DoGenerateFactTypeList;
    //
    FManFact := FfraInpDat.FactDataManage;
  end;
  //
  if not assigned(FfraUser) then begin
    FfraUser := TfraUser.Create(nil);
    FfraUser.SetEditExit(OnUserNameExit);
    FfraUser.SetActionEvents(OnUserCommandInput);
    FfraUser.UserDataInterface(CreateModelUser);
    FfraUser.Contact;
    //
    FManUser := FfraUser.UserDataManage;
    FManUser.FieldByName(FLD_PWD).OnGetText := OnUserPasswordGetText;
    FManUser.FieldByName(FLD_PWD).OnSetText := OnUserPasswordSetText;
  end;
  //
  if not assigned(FFraDbCfg) then begin
    FFraDbCfg := TfraDBConfig.Create(nil);
    FFraDbCfg.Params := ReadConfig;
    FFraDbCfg.OnSave := OnDbConnectParamsSave;
  end;
  //
  if not assigned(FFraSysLog) then begin
    FFraSysLog := TfraSysLog.Create(nil);
    FFraSysLog.SysLogDataInterface(CreateModelSysLog);
    FFraSysLog.Contact;
  end;
end;

class procedure TCtrlInputData.WriteConfig(p: TRecConnectParams);
var xmlSave :TXMLDocument;
    dbNode  :IXMLNode;
    sFile   :String;
begin
  sFile := GetCurrentDir+'\'+FILE_CONFIG;
  if not FileExists(sFile) then
    MessageDlg(ERR_CFG,mtError,[mbOK],0)
  else begin
    xmlSave := TXMLDocument.Create(Application);
    try
      xmlSave.FileName := sFile;
      xmlSave.Active   := True;
      if xmlSave.Active then begin
        dbNode := xmlSave.DocumentElement;
        dbNode.ChildNodes[element_server].NodeValue := p.Server;
        dbNode.ChildNodes[element_name].NodeValue   := p.Database;
        dbNode.ChildNodes[element_user].NodeValue   := p.User;
        dbNode.ChildNodes[element_pwd].NodeValue    := p.Password;
      end;
      xmlSave.SaveToFile(sFile);
    finally
      xmlSave.Active := False;
      xmlSave.Free;
    end;
  end;
end;

end.
