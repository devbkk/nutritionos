unit FaFactData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DBCGrids, Buttons, DB, DBClient,
  ActnList, ImgList, ShareInterface, Provider, CheckLst, DBCtrls{, System.Actions, Vcl.CheckLst};

type
 //
  TfraFactData = class(TFrame, IfraFactData)
    grSearch: TGroupBox;
    edSearch: TEdit;
    grdFact: TDBGrid;
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    cdsFact: TClientDataSet;
    srcFact: TDataSource;
    lbFactDataType: TLabel;
    acList: TActionList;
    tmrSearch: TTimer;
    imgList: TImageList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    chkSeqAdd: TCheckBox;
    dspFact: TDataSetProvider;
    actFactGroup: TAction;
    lupFactGrps: TDBLookupComboBox;
    srcFactGrps: TDataSource;
    cdsFactGrps: TClientDataSet;
    dspFactGrps: TDataSetProvider;
    procedure grdFactKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FFact         :IFact;
    FFactDataType :TFactDataType;
    function GetFactDataType :TFactDataType;
    procedure SetFactDataType(SetValue :TFactDataType);
    //
    procedure SetFactDataTypeDesc(p :TFactDataType);
  public
    { Public declarations }
    constructor Create(AOwner :TComponent); override;
    procedure Contact;
    //IfraFactData
    procedure ContactFactGroup;
    procedure DoRequestFactInput(p :TFactDataType);
    property FactDataType :TFactDataType
      read GetFactDataType write SetFactDataType;
    procedure FactDataInterface(const AFact :IFact);
    function  FactDataManage :TClientDataSet;
    function  FactTypeDataManage :TClientDataSet;
    procedure FocusFirstCell;
    procedure SetTimerSearch(enb :Boolean);
    //
    function FactType :String;
    function IsSqeuenceAppend :Boolean;
    procedure SetActionEvents(evt :TNotifyEvent); overload;
    procedure SetFactDataChanged(evt :TDataChangeEvent);
    procedure SetFactTypeCloseUp(evt :TNotifyEvent);
    procedure SetFactTypeDblClick(evt :TNotifyEvent);
    procedure SetFactTypeKeyDown(evt :TEditKeyDown);
    procedure SetFactTypeList(pList :TStrings);
    procedure SetFactTypeTimerSearch(evt :TNotifyEvent);
    //
    procedure GetFactDataSet;
    procedure GetFactTypeDataSet;
    procedure SetFactDataSet;
    procedure SetFactTypeDataSet;
    procedure SetFactTypeFirstItem(const Value :String);
  end;

const
   c_title_init      = 'ข้อมูล :';
   c_title_user      = 'ผู้ใช้งาน';
   c_title_material  = 'ส่วนประกอบอาหาร';
   //
   c_width_factgrp_hide = 0;
   c_width_factgrp_show = 175;

implementation

{$R *.dfm}

{ TfraFactData }


{public}

constructor TfraFactData.Create(AOwner: TComponent);
begin
  inherited;
//
end;

procedure TfraFactData.Contact;
begin
  SetFactTypeDataSet;
  //
  SetFactDataSet;
  //
end;

procedure TfraFactData.ContactFactGroup;
begin
  {if pnlFactGroup.Height = c_width_factgrp_hide then
    pnlFactGroup.Height := c_width_factgrp_show
  else pnlFactGroup.Height := c_width_factgrp_hide;}
end;

procedure TfraFactData.DoRequestFactInput(p: TFactDataType);
begin
  FFactDataType := p;
  SetFactDataTypeDesc(p);
  Self.Visible := True;
end;

{private}
procedure TfraFactData.GetFactDataSet;
begin
  dspFact.DataSet := FFact.FactDataSet;
end;

function TfraFactData.GetFactDataType: TFactDataType;
begin
  Result := FFactDataType;
end;

procedure TfraFactData.GetFactTypeDataSet;
begin
  dspFactGrps.DataSet := FFact.FactTypeDataSet;
end;

procedure TfraFactData.grdFactKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then begin
    Perform(WM_NEXTDLGCTL,0,0);
    Key := 0;
  end
end;

function TfraFactData.IsSqeuenceAppend: Boolean;
begin
  Result := chkSeqAdd.Checked;
end;

procedure TfraFactData.SetActionEvents(evt: TNotifyEvent);
begin
  actAddWrite.OnExecute := evt;
  actDelCanc.OnExecute  := evt;
  //actFactGroup.OnExecute := evt;
  grdFact.OnDblClick    := evt;
end;

procedure TfraFactData.SetFactDataChanged(evt: TDataChangeEvent);
begin
  srcFact.OnDataChange := evt;
end;

procedure TfraFactData.SetFactDataSet;
begin
  GetFactDataSet;
  cdsFact.Close;
  cdsFact.SetProvider(dspFact);
  cdsFact.Open;
end;

procedure TfraFactData.SetFactDataType(SetValue: TFactDataType);
begin
  FFactDataType := SetValue;
end;

procedure TfraFactData.SetFactDataTypeDesc(p: TFactDataType);
var sDesc :String;
begin
   sDesc := c_title_init;
  case p of
    fdtMaterial : lbFactDataType.Caption := sDesc+c_title_material;
    fdtUser     : lbFactDataType.Caption := sDesc+c_title_user;
  end;
end;

procedure TfraFactData.SetFactTypeCloseUp(evt: TNotifyEvent);
begin
  //cboFactDataType.OnCloseUp := evt;
  lupFactGrps.OnCloseUp := evt;
end;

procedure TfraFactData.SetFactTypeDataSet;
begin
  GetFactTypeDataSet;
  cdsFactGrps.Close;
  cdsFactGrps.SetProvider(dspFactGrps);
  cdsFactGrps.Open;
end;

procedure TfraFactData.SetFactTypeDblClick(evt: TNotifyEvent);
begin
  //cboFactDataType.OnDblClick := evt;
end;

procedure TfraFactData.SetFactTypeFirstItem(const Value :String);
begin
  lupFactGrps.KeyValue := Value;
end;

procedure TfraFactData.SetFactTypeKeyDown(evt: TEditKeyDown);
begin
  //cboFactDataType.OnKeyDown := evt;
end;

procedure TfraFactData.SetFactTypeList(pList: TStrings);
begin
  //cboFactDataType.Items.Clear;
  //cboFactDataType.Items := pList;
end;

procedure TfraFactData.SetFactTypeTimerSearch(evt: TNotifyEvent);
begin
  tmrSearch.OnTimer := evt;
end;

procedure TfraFactData.SetTimerSearch(enb: Boolean);
begin
  tmrSearch.Enabled := enb;
end;

procedure TfraFactData.FactDataInterface(const AFact: IFact);
begin
  FFact := AFact;
end;

function TfraFactData.FactDataManage: TClientDataSet;
begin
  Result := cdsFact;
end;

function TfraFactData.FactType: String;
begin
  //Result := cboFactDataType.Text;
end;

function TfraFactData.FactTypeDataManage: TClientDataSet;
begin
  Result := cdsFactGrps;
end;

procedure TfraFactData.FocusFirstCell;
var fld :TField;
begin
  fld := cdsFact.FindField('CODE');
  if fld<>nil then begin
    grdFact.SetFocus;
    grdFact.SelectedField := fld;
  end;
end;

end.
