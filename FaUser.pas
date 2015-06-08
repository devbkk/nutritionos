unit FaUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DBCGrids, Buttons, DB, DBClient,
  ActnList, ImgList, ShareInterface, Mask, DBCtrls;

type
  TEnumUserAct = (uaAddWrite,uaDelCan,uaPrev,uaNext);

  IfraUser = Interface(IfraFactData)
  ['{CB332A90-E677-4959-8487-DB0B8B215E1D}']
    procedure SetActionEvents(evt :TNotifyEvent; atype :TEnumUserAct);
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
    chkEdit: TCheckBox;
    grSave: TGroupBox;
    edID: TDBEdit;
    edFName: TDBEdit;
    edLName: TDBEdit;
    edAName: TDBEdit;
    edLogin: TDBEdit;
    edPassword: TDBEdit;
    lbID: TLabel;
    lbFName: TLabel;
    lbLName: TLabel;
    lbAName: TLabel;
    lbLogin: TLabel;
    lbPassword: TLabel;
    spbPrev: TSpeedButton;
    spbNext: TSpeedButton;
    actPrev: TAction;
    actNext: TAction;
    procedure navUserClick(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
    FFactDataType :TFactDataType;
    function GetFactDataType :TFactDataType;
    procedure SetFactDataType(SetValue :TFactDataType);
    procedure SetFactDataTypeDesc(p :TFactDataType);
    //
    procedure OnEditKeyPress(Sender :TObject; var Key :Char);
    procedure SetEditKeyPress;
    //
    //procedure OnEditExit(Sender :TObject);

  public
    { Public declarations }
    constructor Create(AOwner :TComponent); override;
    procedure Contact;
    //IfraFactData
    procedure DoRequestFactInput(p :TFactDataType);
    property FactDataType :TFactDataType
      read GetFactDataType write SetFactDataType;
    //IfraUser
    procedure SetActionEvents(evt :TNotifyEvent; atype :TEnumUserAct);
    //
    procedure SetEditExit(evt :TNotifyEvent);
  end;

const
   c_title_init      = 'ข้อมูล :';
   c_title_user      = 'ผู้ใช้งาน';
   c_title_material  = 'ส่วนประกอบอาหาร';
implementation

{$R *.dfm}

{ TfraFactData }

procedure TfraUser.navUserClick(Sender: TObject; Button: TNavigateBtn);
begin
  case Button of
    nbInsert : begin
      cdsUser.Append;
      if edID.CanFocus then
        edID.SetFocus;
    end;
  end;

end;

{public}
procedure TfraUser.Contact;
begin
//
end;

constructor TfraUser.Create(AOwner :TComponent);
begin
  inherited Create(AOwner);
  //SetEditExit;
  SetEditKeyPress;
end;

procedure TfraUser.DoRequestFactInput(p: TFactDataType);
begin
  FFactDataType := p;
  SetFactDataTypeDesc(p);
  Self.Visible := True;
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
end;

{private}
function TfraUser.GetFactDataType: TFactDataType;
begin
  Result := FFactDataType;
end;

{procedure TfraUser.OnEditExit(Sender: TObject);
begin
  edAName.Text := edFName.Text+' '+edLName.Text;
end;}

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

end.
