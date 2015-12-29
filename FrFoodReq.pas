unit FrFoodReq;

interface

uses
  DB, DBClient, ImgList, Controls, Classes, ActnList, Grids, DBGrids,
  StdCtrls, ExtCtrls, DBCtrls, Mask, Buttons, Forms,
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
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    lbFactDataType: TLabel;
    chkSeqAdd: TCheckBox;
    cboFactDataType: TComboBox;
    acList: TActionList;
    actAddWrite: TAction;
    actDelCanc: TAction;
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
    spbNext: TSpeedButton;
    spbPrev: TSpeedButton;
    actNext: TAction;
    actPrev: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FDM     :IDataSetX;
    FParent :TWinControl;
  public
    { Public declarations }
    procedure AuthorizeMenu(uType :String);
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    //
    procedure Contact;
    procedure DataInterface(const IDat :IDataSetX);
    function DataManFoodReq :TClientDataSet;
    function  DataManHcData :TClientDataSet;
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
  end;

var
  frmFoodReq: TfrmFoodReq;

implementation

{$R *.dfm}

{ TfrmFoodReq }

procedure TfrmFoodReq.FormCreate(Sender: TObject);
begin
//
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
  dspReqDet.DataSet := FDM.XDataSet;
  cdsFdReqDet.Close;
  cdsFdReqDet.SetProvider(dspReqDet);
  cdsFdReqDet.Open;
end;

procedure TfrmFoodReq.DataInterface(const IDat: IDataSetX);
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
  Result := chkSeqAdd.Checked;
end;

procedure TfrmFoodReq.SetActionEvents(evt: TNotifyEvent);
begin
  actAddWrite.OnExecute := evt;
  actDelCanc.OnExecute  := evt;
  actNext.OnExecute     := evt;
  actPrev.OnExecute     := evt;
  actHcSearch.OnExecute := evt;
  //
  dpkReqFr.OnExit    := evt;
  dpkReqTo.OnExit    := evt;
end;

procedure TfrmFoodReq.SetDataChangedEvents(evt: TDataChangeEvent);
begin
  srcReqDet.OnDataChange := evt;
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

end.
