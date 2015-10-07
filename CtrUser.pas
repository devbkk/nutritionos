unit CtrUser;

interface

uses Classes, Controls, DB, DBClient, ActnList, StdCtrls, Forms,
     ShareInterface, SvEncrypt, FaUser, DmUser;

type
  TControllerUser = class
  private
    FfraUser   :TfraUser;
    FUser      :IUser;
    FManUser   :TClientDataSet;
    FIsAdmin   :Boolean;
    function CreateModelUser :IUser;    
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
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
    function View :TFrame;
  end;

implementation

const
  //USER
  FLD_ID    = 'ID';
  FLD_FNM   = 'FNAME';
  FLD_LNM   = 'LNAME';
  FLD_ANM   = 'ANAME';
  FLD_EMAIL = 'EMAIL';
  FLD_PWD   = 'PASSWORD';
  FLD_UNU   = 'UNUSED';
  FLD_UTY   = 'UTYPE';
  //
  C_ADMIN = 'A';
  C_USER  = '0';  
  //
  C_UNUSED = 'Y';
  C_USED   = 'N';
  //
  CMP_ACTAW = 'actAddWrite';
  CMP_ACTDC = 'actDelCanc';
  CMP_ACTNX = 'actNext';
  CMP_ACTPV = 'actPrev';
  //
  CMP_EDFNM = 'edFName';
  CMP_EDLNM = 'edLName';
  CMP_EDEMA = 'edEmail';
  //
  ERR_EMAIL = 'E-mail ไม่ถูกต้อง บันทึกหรือไม่';

{ TControllerUser }
constructor TControllerUser.Create;
begin
  Start;
end;

destructor TControllerUser.Destroy;
begin
  FFraUser.Free;
  inherited;
end;

{public}
procedure TControllerUser.DoUserAddWrite;
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

procedure TControllerUser.DoUserCancelDel;
begin
  if FManUser.State = dsBrowse then begin
    FManUser.Delete;
  end else if FManUser.State in [dsInsert,dsEdit] then begin
    FManUser.Cancel;
  end;
end;

procedure TControllerUser.DoUserMoveNext;
begin
  if FManUser.Eof then
    FManUser.Last
  else FManUser.Next;
end;

procedure TControllerUser.DoUserMovePrev;
begin
  if FManUser.Bof then
    FManUser.First
  else FManUser.Prior;
end;

procedure TControllerUser.OnUserCommandInput(Sender: TObject);
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

procedure TControllerUser.OnUserNameExit(Sender: TObject);
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

procedure TControllerUser.OnUserPasswordGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  try
    Text := decodestring(Sender.AsString);
  except
    Text := Sender.AsString;
  end;
end;

procedure TControllerUser.OnUserPasswordSetText(Sender: TField;
  const Text: string);
begin
  try
    Sender.AsString := encodestring(Text);
  except
    Sender.AsString := Text;
  end;
end;

procedure TControllerUser.Start;
begin
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

function TControllerUser.View: TFrame;
begin
  Result := FfraUser;
end;

{private}
function TControllerUser.CreateModelUser: IUser;
var p :TRecUserSearch;
begin
  //
  FUser := TDmoUser.Create(nil);
  FUser.SearchKey := p;
  Result := FUser;
end;

end.
