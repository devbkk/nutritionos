unit FaUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DBCGrids, Buttons, DB, DBClient,
  ActnList, ImgList, ShareInterface, Mask, DBCtrls, Provider, System.Actions;

type
  TEnumUserAct = (uaAddWrite,uaDelCan,uaPrev,uaNext);

  IfraUser = Interface(IInterface)
  ['{CB332A90-E677-4959-8487-DB0B8B215E1D}']
    procedure Contact;
    procedure DoFirstFocus;
    function  IsSqeuenceAppend :Boolean;
    function  IsUnUsed :Boolean;
    procedure SetActionEvents(evt :TNotifyEvent); overload;
    procedure SetActionEvents(evt :TNotifyEvent; atype :TEnumUserAct); overload;
    procedure SetEditExit(evt :TNotifyEvent);
    procedure SetIsAdmin(v :Boolean);
    procedure UserCorrectEmail;
    procedure UserDataInterface(const AUser :IUser);
    function  UserDataManage :TClientDataSet;
  end;

  //
  TfraUser = class(TFrame, IfraUser)
    grSearch: TGroupBox;
    edSearch: TEdit;
    grdFact: TDBGrid;
    grCmd: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    cdsUser: TClientDataSet;
    srcUser: TDataSource;
    lbFactDataType: TLabel;
    acList: TActionList;
    tmrSearch: TTimer;
    imgList: TImageList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    chkSeqAdd: TCheckBox;
    grSave: TGroupBox;
    edID: TDBEdit;
    edFName: TDBEdit;
    edLName: TDBEdit;
    edLogin: TDBEdit;
    edPassword: TDBEdit;
    lbID: TLabel;
    lbFName: TLabel;
    lbLName: TLabel;
    lbLogin: TLabel;
    lbPassword: TLabel;
    spbPrev: TSpeedButton;
    spbNext: TSpeedButton;
    actPrev: TAction;
    actNext: TAction;
    dspUser: TDataSetProvider;
    rdgGender: TDBRadioGroup;
    lbGender: TLabel;
    lbEmail: TLabel;
    edEmail: TDBEdit;
    chkUnUsed: TDBCheckBox;
  private
    { Private declarations }
    FFactDataType :TFactDataType;
    FUser         :IUser;
    function GetFactDataType :TFactDataType;
    procedure SetFactDataType(SetValue :TFactDataType);
    procedure SetFactDataTypeDesc(p :TFactDataType);
    //
    procedure OnEditKeyPress(Sender :TObject; var Key :Char);
    procedure SetEditKeyPress;
    //
  public
    { Public declarations }
    constructor Create(AOwner :TComponent); override;
    //IfraFactData
    procedure DoRequestFactInput(p :TFactDataType);
    property FactDataType :TFactDataType
      read GetFactDataType write SetFactDataType;
    //IfraUser
    procedure Contact;
    procedure DoFirstFocus;
    function  IsSqeuenceAppend :Boolean;
    function  IsUnUsed :Boolean;
    procedure SetActionEvents(evt :TNotifyEvent); overload;
    procedure SetActionEvents(evt :TNotifyEvent; atype :TEnumUserAct); overload;
    procedure SetEditExit(evt :TNotifyEvent);
    procedure SetIsAdmin(v :Boolean);
    procedure UserCorrectEmail;
    procedure UserDataInterface(const AUser :IUser);
    function  UserDataManage :TClientDataSet;
  end;

const
   c_title_init      = 'ข้อมูล :';
   c_title_user      = 'ผู้ใช้งาน';
   c_title_material  = 'ส่วนประกอบอาหาร';

implementation

{$R *.dfm}

{ TfraFactData }

{public}
procedure TfraUser.Contact;
begin
  dspUser.DataSet := FUser.UserDataSet;
  cdsUser.Close;
  cdsUser.SetProvider(dspUser);
  cdsUser.Open;
end;

constructor TfraUser.Create(AOwner :TComponent);
begin
  inherited Create(AOwner);
  SetEditKeyPress;
end;

procedure TfraUser.DoFirstFocus;
begin
  if edFName.CanFocus then
    edFName.SetFocus;
end;

procedure TfraUser.DoRequestFactInput(p: TFactDataType);
begin
  FFactDataType := p;
  SetFactDataTypeDesc(p);
  Self.Visible := True;
end;

procedure TfraUser.SetActionEvents(evt: TNotifyEvent);
begin
  actAddWrite.OnExecute := evt;
  actDelCanc.OnExecute  := evt;
  actPrev.OnExecute     := evt;
  actNext.OnExecute     := evt;
end;

procedure TfraUser.SetActionEvents(evt: TNotifyEvent; atype: TEnumUserAct);
begin
  case atype of
    uaAddWrite : actAddWrite.OnExecute := evt;
    uaDelCan   : actDelCanc.OnExecute  := evt;
    uaPrev     : actPrev.OnExecute     := evt;
    uaNext     : actNext.OnExecute     := evt;
  end;
end;

procedure TfraUser.SetEditExit(evt :TNotifyEvent);
begin
  edFName.OnExit := evt;
  edLName.OnExit := evt;
  edEmail.OnExit := evt;
end;

{private}
function TfraUser.GetFactDataType: TFactDataType;
begin
  Result := FFactDataType;
end;

function TfraUser.IsSqeuenceAppend: Boolean;
begin
  Result := chkSeqAdd.Checked;
end;

function TfraUser.IsUnUsed: Boolean;
begin
  Result := chkUnUsed.Checked;
end;

procedure TfraUser.OnEditKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin
    If HiWord(GetKeyState(VK_SHIFT)) <> 0 then
      SelectNext(Sender as TWinControl,False,True)
    else SelectNext(Sender as TWinControl,True,True) ;
    Key := #0
  end;
end;

procedure TfraUser.SetEditKeyPress;
var i :Integer; cmp :TComponent;
begin
  for i := 0 to Self.ComponentCount - 1 do begin
    cmp := Self.Components[i];
    if cmp Is TDBEdit then
      TDBEdit(cmp).OnKeyPress :=  OnEditKeyPress;
  end;
end;

procedure TfraUser.SetFactDataType(SetValue: TFactDataType);
begin
  FFactDataType := SetValue;
end;

procedure TfraUser.SetFactDataTypeDesc(p: TFactDataType);
var sDesc :String;
begin
   sDesc := c_title_init;
  case p of
    fdtMaterial : lbFactDataType.Caption := sDesc+c_title_material;
    fdtUser     : lbFactDataType.Caption := sDesc+c_title_user;
  end;
end;

procedure TfraUser.SetIsAdmin(v: Boolean);
begin
  chkUnUsed.Enabled := v;
end;

procedure TfraUser.UserCorrectEmail;
begin
  if edEmail.CanFocus then
    edEmail.SetFocus;
end;

procedure TfraUser.UserDataInterface(const AUser: IUser);
begin
  FUser := AUser;
end;

function TfraUser.UserDataManage: TClientDataSet;
begin
  Result := cdsUser;
end;

end.
