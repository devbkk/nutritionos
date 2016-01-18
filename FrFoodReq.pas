unit FrFoodReq;

interface

uses
  DB, DBClient, ImgList, Controls, Classes, ActnList, Grids, DBGrids,
  StdCtrls, ExtCtrls, DBCtrls, Mask, Buttons, Forms, StrUtils,
  ShareInterface, Provider, ComCtrls;

type
  IViewFoodReq = Interface(IInterface)
  ['{7CCC0175-C79A-4997-BBE1-7A783BA6D61B}']
    procedure AuthorizeMenu(uType :String);
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
  end;

  TfrmFoodReq = class(TForm, IViewFoodReq, IFrmFoodReqDataX)
    grSearch: TGroupBox;
    edSearch: TEdit;
    pnlButtons: TPanel;
    sbPatDelCanc: TSpeedButton;
    sbPatAddWrite: TSpeedButton;
    lbPatient: TLabel;
    chkPatSeqAdd: TCheckBox;
    acList: TActionList;
    actPatAddWrite: TAction;
    actPatDelCanc: TAction;
    actFactGroup: TAction;
    imgList: TImageList;
    grSave: TGroupBox;
    lbID: TLabel;
    lbName: TLabel;
    lbAN: TLabel;
    lbAge: TLabel;
    lbGender: TLabel;
    edHN: TDBEdit;
    edName: TDBEdit;
    edAN: TDBEdit;
    edAge: TDBEdit;
    rdgGender: TDBRadioGroup;
    grdReqDet: TDBGrid;
    btnSearch: TButton;
    lbYr: TLabel;
    cdsFdReqDet: TClientDataSet;
    srcReqDet: TDataSource;
    cdsHcDat: TClientDataSet;
    srcHcDat: TDataSource;
    actHcSearch: TAction;
    dspReqDet: TDataSetProvider;
    grFoodReq: TGroupBox;
    cboFoodType: TDBComboBox;
    lbFoodType: TLabel;
    lbDiag: TLabel;
    cboDiag: TDBComboBox;
    dpkReqFr: TDateTimePicker;
    lbRqFr: TLabel;
    lbRqTo: TLabel;
    dpkReqTo: TDateTimePicker;
    lbWardID: TLabel;
    edWardID: TDBEdit;
    lbWardName: TLabel;
    edWardName: TDBEdit;
    spbPatNext: TSpeedButton;
    spbPatPrev: TSpeedButton;
    actPatNext: TAction;
    actPatPrev: TAction;
    lbRoomNo: TLabel;
    edRoomNo: TDBEdit;
    lbBedNo: TLabel;
    edBedNo: TDBEdit;
    dspHcDat: TDataSetProvider;
    cdsReqDet: TClientDataSet;
    Panel1: TPanel;
    sbReqDelCanc: TSpeedButton;
    sbReqAddWrite: TSpeedButton;
    lbFoodReq: TLabel;
    spbReqNext: TSpeedButton;
    spbReqPrev: TSpeedButton;
    chkReqSeqAdd: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FDM     :IFoodReqDataX;
    FParent :TWinControl;
  public
    { Public declarations }
    procedure AuthorizeMenu(uType :String);
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    //
    procedure Contact;
    procedure DataInterface(const IDat :IFoodReqDataX);
    function  DataManFoodReq :TClientDataSet;
    function  DataManHcData :TClientDataSet;
    procedure DoSetFoodReqAn(const s :String);
    //
    procedure FocusFirst;
    function IsSqeuenceAppend :Boolean;
    procedure SetActionEvents(evt :TNotifyEvent);
    procedure SetDataChangedEvents(evt :TDataChangeEvent);
    procedure SetEditKeyDownEvents(evt :TEditKeyDown);
    //
    procedure SetReqFrTo(dtFr, dtTo :TDateTime);
    //
    procedure SetListFoodType(pList :TStrings);
    procedure SetListDiag(pList :TStrings);
    //
    procedure Start;
  end;

var
  frmFoodReq: TfrmFoodReq;

implementation

{$R *.dfm}

{ TfrmFoodReq }

procedure TfrmFoodReq.FormCreate(Sender: TObject);
begin
  Start;
end;

procedure TfrmFoodReq.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfrmFoodReq.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//
end;

procedure TfrmFoodReq.FormShow(Sender: TObject);
begin
//
end;

procedure TfrmFoodReq.AuthorizeMenu(uType: String);
begin
//
end;

procedure TfrmFoodReq.Contact;
begin
  if assigned(FParent) then begin
    Self.Align := alClient;
    Self.ManualDock(FParent);
    Self.Show;
  end else ShowModal;
  //
  dspHcDat.DataSet := FDM.XDataSet;
  cdsHcDat.Close;
  cdsHcDat.SetProvider(dspHcDat);
  cdsHcDat.Open;
  //
  dspReqDet.DataSet := FDM.FoodReqSet('');
  cdsFdReqDet.Close;
  cdsFdReqDet.SetProvider(dspReqDet);
  cdsFdReqDet.Open;
end;

procedure TfrmFoodReq.DataInterface(const IDat: IFoodReqDataX);
begin
  FDM := IDat;
end;

function TfrmFoodReq.DataManFoodReq: TClientDataSet;
begin
  Result := cdsFdReqDet;
end;

function TfrmFoodReq.DataManHcData: TClientDataSet;
begin
  Result := cdsHcDat;
end;

procedure TfrmFoodReq.DoSetFoodReqAn(const s: String);
begin
  cdsFdReqDet.Filter := 'AN='''+s+'''';
  cdsFdReqDet.Filtered := True;
end;

procedure TfrmFoodReq.DoSetParent(AOwner: TWinControl; AFrame: TFrame);
begin
  FParent := AOwner;
end;

procedure TfrmFoodReq.FocusFirst;
begin
  if edHn.CanFocus then
    edHn.SetFocus;
end;

function TfrmFoodReq.IsSqeuenceAppend: Boolean;
begin
  Result := chkPatSeqAdd.Checked;
end;

procedure TfrmFoodReq.SetActionEvents(evt: TNotifyEvent);
begin
  actPatAddWrite.OnExecute := evt;
  actPatDelCanc.OnExecute  := evt;
  actPatNext.OnExecute     := evt;
  actPatPrev.OnExecute     := evt;
  //
  actHcSearch.OnExecute := evt;
  //
  dpkReqFr.OnExit    := evt;
  dpkReqTo.OnExit    := evt;
end;

procedure TfrmFoodReq.SetDataChangedEvents(evt: TDataChangeEvent);
begin
  //srcReqDet.OnDataChange := evt;
  srcHcDat.OnDataChange := evt;
end;

procedure TfrmFoodReq.SetEditKeyDownEvents(evt: TEditKeyDown);
begin
  edSearch.OnKeyDown := evt;
end;

procedure TfrmFoodReq.SetListDiag(pList: TStrings);
begin
  cboDiag.Items.Clear;
  cboDiag.Items := pList;
end;

procedure TfrmFoodReq.SetListFoodType(pList: TStrings);
begin
  cboFoodType.Items.Clear;
  cboFoodType.Items := pList;
end;

procedure TfrmFoodReq.SetReqFrTo(dtFr, dtTo: TDateTime);
begin
  dpkReqFr.DateTime := dtFr;
  dpkReqTo.DateTime := dtTo;
end;

procedure TfrmFoodReq.Start;
begin
  dspHcDat.Options  := dspHcDat.Options+[poFetchDetailsOnDemand];
  cdsHcDat.FetchOnDemand := True;
  cdsHcDat.PacketRecords := 100;
  //
  dspReqDet.Options := dspReqDet.Options+[poFetchDetailsOnDemand];
  cdsFdReqDet.FetchOnDemand := True;
  cdsFdReqDet.PacketRecords := 100;
end;

end.
