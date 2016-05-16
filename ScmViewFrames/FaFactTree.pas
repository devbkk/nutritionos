unit FaFactTree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Provider, DB, DBClient, ImgList, ActnList, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, ComCtrls, ShareInterface, Grids, DBGrids, Menus;

type
  TfraFactTree = class(TFrame, IFraFactTree)
    tvwFact: TTreeView;
    grSearch: TGroupBox;
    edSearch: TEdit;
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    lbFactDataType: TLabel;
    chkSeqAdd: TCheckBox;
    acList: TActionList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    actNext: TAction;
    actPrev: TAction;
    imgList: TImageList;
    srcFactTree: TDataSource;
    cdsFactTree: TClientDataSet;
    dspFactTree: TDataSetProvider;
    spMain: TSplitter;
    pnlMain: TPanel;
    grFact: TGroupBox;
    lbCode: TLabel;
    lbDesc: TLabel;
    lbNote: TLabel;
    edCode: TDBEdit;
    edDesc: TDBEdit;
    edNote: TDBEdit;
    grdFact: TDBGrid;
    pmuFactTree: TPopupMenu;
    mnuChildAdd: TMenuItem;
    mnuChildDel: TMenuItem;
    actChildAdd: TAction;
    actChildDel: TAction;
    sepInput: TMenuItem;
    mnuFactDet: TMenuItem;
    actFactDet: TAction;
    mnuEditFact: TMenuItem;
    actFactEdit: TAction;
    imgNode: TImageList;
    lblSlipPrn: TLabel;
  private
    { Private declarations }
    FDM  :IFact;
  public
    { Public declarations }
    constructor Create(AOwner :TComponent); override;
    //
    procedure Contact;
    procedure DataInterface(AFact :IFact);
    function  DataManage :TClientDataSet;
    procedure FocusFirstCell;
    function IsSqeuenceAppend :Boolean;
    //
    procedure SetActionEvents(evt :TNotifyEvent);
    procedure SetAllowActions(enb :Boolean);
    procedure SetAllowPopupMenus(enb :Boolean);
    procedure SetTvwOnNodeActions(evt :TTVExpandedEvent);
    procedure SetTvwOnNodeGetImageIndex(evt: TTVExpandedEvent);
    procedure SetShowPrintSlip(v :Boolean);
    function Tree :TTreeView;
  end;

implementation

{$R *.dfm}

{ TfraFactTree }

constructor TfraFactTree.Create(AOwner: TComponent);
begin
  inherited;
  //
end;

procedure TfraFactTree.Contact;
begin
  dspFactTree.DataSet := FDM.FactDataSet;
  cdsFactTree.Close;
  cdsFactTree.SetProvider(dspFactTree);
  cdsFactTree.Open;
end;

procedure TfraFactTree.DataInterface(AFact: IFact);
begin
  FDM := AFact;
end;

function TfraFactTree.DataManage: TClientDataSet;
begin
  Result := cdsFactTree;
end;

procedure TfraFactTree.FocusFirstCell;
begin
  if edCode.CanFocus then
    edCode.SetFocus;
end;

function TfraFactTree.IsSqeuenceAppend: Boolean;
begin
  Result := chkSeqAdd.Checked;
end;

procedure TfraFactTree.SetActionEvents(evt: TNotifyEvent);
begin
  actAddWrite.OnExecute := evt;
  actDelCanc.OnExecute  := evt;
  actFactDet.OnExecute  := evt;
  actFactEdit.OnExecute := evt;
  //
  tvwFact.OnClick       := evt;
  actChildAdd.OnExecute := evt;
  actChildDel.OnExecute := evt;
  //
  pmuFactTree.OnPopup   := evt;
end;

procedure TfraFactTree.SetAllowActions(enb: Boolean);
begin
  chkSeqAdd.Enabled  := enb;
  sbAddWrite.Enabled := enb;
  sbDelCanc.Enabled  := enb;
  grFact.Enabled     := enb;
end;

procedure TfraFactTree.SetAllowPopupMenus(enb: Boolean);
begin
  mnuChildAdd.Enabled := enb;
  mnuChildDel.Enabled := enb;
end;

procedure TfraFactTree.SetShowPrintSlip(v: Boolean);
begin
  lblSlipPrn.Visible := v;
end;

procedure TfraFactTree.SetTvwOnNodeActions(evt: TTVExpandedEvent);
begin
  tvwFact.OnCollapsed := evt;
end;

procedure TfraFactTree.SetTvwOnNodeGetImageIndex(evt: TTVExpandedEvent);
begin
  tvwFact.OnGetImageIndex := evt;
end;

function TfraFactTree.Tree: TTreeView;
begin
  Result := tvwFact;
end;

end.
