unit FrFoodReq;

interface

uses
  DB, DBClient, ImgList, Controls, Classes, ActnList, Grids, DBGrids,
  StdCtrls, ExtCtrls, DBCtrls, Mask, Buttons, Forms, StrUtils,
  ShareInterface, Provider, ComCtrls, Math, Windows, Graphics;

type
  IViewFoodReq = Interface(IInterface)
  ['{7CCC0175-C79A-4997-BBE1-7A783BA6D61B}']
    procedure AuthorizeMenu(uType :String);
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
  end;

  TRecFoodReqCalcFields = record
    PatName, Age :String;
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
    edAN: TDBEdit;
    rdgGender: TDBRadioGroup;
    btnSearch: TButton;
    lbYr: TLabel;
    cdsFdReq: TClientDataSet;
    srcReq: TDataSource;
    cdsPatAdm: TClientDataSet;
    srcPatAdm: TDataSource;
    actHcSearch: TAction;
    dspReq: TDataSetProvider;
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
    dspPatAdm: TDataSetProvider;
    actReqAddWrite: TAction;
    actReqDelCanc: TAction;
    actReqNext: TAction;
    actReqPrev: TAction;
    edName: TEdit;
    edAge: TEdit;
    actReqFr: TAction;
    actReqTo: TAction;
    lbReligion: TLabel;
    edReligion: TDBEdit;
    sbNewPat: TSpeedButton;
    actPatNew: TAction;
    actReqNewPat: TAction;
    actReqDt: TAction;
    actReqFoodType: TAction;
    pnlReqDate: TPanel;
    grReqDate: TGroupBox;
    lbRqFr: TLabel;
    sbReqFr: TSpeedButton;
    edReqDt: TDBEdit;
    grdReqDate: TDBGrid;
    pnlReqDet: TPanel;
    grFoodReq: TGroupBox;
    lbDiag: TLabel;
    grdReqDet: TDBGrid;
    edReqID: TDBEdit;
    lbReqID: TLabel;
    lbWts: TLabel;
    edWts: TDBEdit;
    Label2: TLabel;
    edHts: TDBEdit;
    sbFoodType: TSpeedButton;
    cdsReqDet: TClientDataSet;
    dspReqDet: TDataSetProvider;
    srcReqDet: TDataSource;
    lupDiag: TDBLookupComboBox;
    dspDiag: TDataSetProvider;
    srcDiag: TDataSource;
    cdsDiag: TClientDataSet;
    chkCOMDIS: TDBCheckBox;
    cboMealOrd: TDBComboBox;
    lbMealOrd: TLabel;
    sbReqEnd: TSpeedButton;
    actReqEnd: TAction;
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
    function  DataManFoodReqDet :TClientDataSet;
    function  DataManPatAdm :TClientDataSet;
    //
    procedure DoProvidePatAdm;
    procedure DoProvideFoodReq;
    procedure DoProvideFoodReqDet;
    procedure DoProvideHcDiag;
    //
    procedure DoSetFoodReqAn(const s :String);
    //
    procedure FocusFirst;
    function IsDiabete :Boolean;
    function IsPatSequenceAppend :Boolean;
    procedure SetActionEvents(evt :TNotifyEvent);
    procedure SetCalcFields(const p :TRecFoodReqCalcFields);
    procedure SetDataChangedEvents(evt :TDataChangeEvent);
    procedure SetEditKeyDownEvents(evt :TEditKeyDown);
    //
    procedure SetReqFrTo(dtFr, dtTo :TDateTime);
    //
    procedure SetListFoodType(pList :TStrings);
    procedure SetListDiag(pList :TStrings);
    procedure ShowIsEndRequest(b :Boolean);
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
  DoProvidePatAdm;
  //
  DoProvideFoodReq;
  //
  DoProvideFoodReqDet;
  //
  DoProvideHcDiag;
end;

procedure TfrmFoodReq.DataInterface(const IDat: IFoodReqDataX);
begin
  FDM := IDat;
end;

function TfrmFoodReq.DataManFoodReq: TClientDataSet;
begin
  Result := cdsFdReq;
end;

function TfrmFoodReq.DataManFoodReqDet: TClientDataSet;
begin
  Result := cdsReqDet;
end;

function TfrmFoodReq.DataManPatAdm: TClientDataSet;
begin
  Result := cdsPatAdm;
end;

procedure TfrmFoodReq.DoProvideFoodReq;
begin
  dspReq.DataSet := FDM.FoodReqSet('');
  cdsFdReq.Close;
  cdsFdReq.SetProvider(dspReq);
  cdsFdReq.Open;
end;

procedure TfrmFoodReq.DoProvideFoodReqDet;
begin
  dspReqDet.DataSet := FDM.FoodReqDet;
  cdsReqDet.Close;
  cdsReqDet.SetProvider(dspReqDet);
  cdsReqDet.Open;
end;

procedure TfrmFoodReq.DoProvideHcDiag;
begin
  dspDiag.DataSet := FDM.HcDiagDataSet;
  cdsDiag.Close;
  cdsDiag.SetProvider(dspDiag);
  cdsDiag.Open;
end;

procedure TfrmFoodReq.DoProvidePatAdm;
begin
  dspPatAdm.DataSet := FDM.XDataSet;
  cdsPatAdm.Close;
  cdsPatAdm.SetProvider(dspPatAdm);
  cdsPatAdm.Open;
end;

procedure TfrmFoodReq.DoSetFoodReqAn(const s: String);
begin
  cdsFdReq.Filter := 'AN='''+s+'''';
  cdsFdReq.Filtered := True;
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

function TfrmFoodReq.IsDiabete: Boolean;
begin
  //Result := chkDiab.Checked;
  Result := False
end;

function TfrmFoodReq.IsPatSequenceAppend: Boolean;
begin
  Result := chkPatSeqAdd.Checked;
end;

procedure TfrmFoodReq.SetActionEvents(evt: TNotifyEvent);
begin
  actPatAddWrite.OnExecute := evt;
  actPatDelCanc.OnExecute  := evt;
  actPatNext.OnExecute     := evt;
  actPatPrev.OnExecute     := evt;
  actPatNew.OnExecute      := evt;
  //
  actHcSearch.OnExecute    := evt;
  //
  actReqAddWrite.OnExecute := evt;
  actReqDelCanc.OnExecute  := evt;
  actReqNext.OnExecute     := evt;
  actReqPrev.OnExecute     := evt;
  actReqNewPat.OnExecute   := evt;
  actReqFoodType.OnExecute := evt;
  actReqEnd.OnExecute      := evt;
  //
  actReqDt.OnExecute       := evt;
  actReqFr.OnExecute       := evt;
  actReqTo.OnExecute       := evt;
  //
end;

procedure TfrmFoodReq.SetCalcFields(const p: TRecFoodReqCalcFields);
begin
  edName.Text := p.PatName;
  edAge.Text  := p.Age;
end;

procedure TfrmFoodReq.SetDataChangedEvents(evt: TDataChangeEvent);
begin
  srcPatAdm.OnDataChange := evt;
  srcReq.OnDataChange    := evt;
end;

procedure TfrmFoodReq.SetEditKeyDownEvents(evt: TEditKeyDown);
begin
  edSearch.OnKeyDown := evt;
end;

procedure TfrmFoodReq.SetListDiag(pList: TStrings);
begin
  //cboDiag.Items.Clear;
  //cboDiag.Items := pList;
end;

procedure TfrmFoodReq.SetListFoodType(pList: TStrings);
begin
  //cboFoodType.Items.Clear;
  //cboFoodType.Items := pList;
end;

procedure TfrmFoodReq.SetReqFrTo(dtFr, dtTo: TDateTime);
begin
  //dpkReqFr.DateTime := dtFr;
  //dpkReqTo.DateTime := dtTo;
end;

procedure TfrmFoodReq.ShowIsEndRequest(b: Boolean);
begin
  sbReqEnd.Enabled := not b;
  sbNewPat.Enabled := not b;
  sbPatAddWrite.Enabled := not b;
  sbPatDelCanc.Enabled  := not b;
  sbReqFr.Enabled  := not b;
  sbReqEnd.Enabled := not b;
  //
  grFoodReq.Enabled := not b;
  grReqDate.Enabled := not b;
  grSave.Enabled    := not b;
  grSearch.Enabled  := not b;
  //
  chkPatSeqAdd.Enabled := not b;
  //
  grdReqDate.ReadOnly := b;
  grdReqDet.ReadOnly  := b;
  //
  grdReqDate.Color := ifthen(grdReqDate.ReadOnly,
                             TColor(clMoneyGreen),
                             TColor(clWindow));

  grdReqDet.Color := ifthen(grdReqDate.ReadOnly,
                            TColor(clMoneyGreen),
                            TColor(clWindow));

  lbPatient.Caption := ifthen(b,
                              'ทำรายการ : หยุดสั่งอาหาร',
                              'ทำรายการ : สั่งอาหาร');

  lbPatient.Font.Color := ifthen(b,TColor(clGreen),TColor(clBlack));

end;

procedure TfrmFoodReq.Start;
begin
  dspPatAdm.Options  := dspPatAdm.Options+[poFetchDetailsOnDemand];
  cdsPatAdm.FetchOnDemand := True;
  cdsPatAdm.PacketRecords := 100;
  //
  dspReq.Options := dspReq.Options+[poFetchDetailsOnDemand];
  cdsFdReq.FetchOnDemand := True;
  cdsFdReq.PacketRecords := 100;
  //
  dspReqDet.Options := dspReqDet.Options+[poFetchDetailsOnDemand];
  cdsReqDet.FetchOnDemand := True;
  cdsReqDet.PacketRecords := 100;
end;

end.
