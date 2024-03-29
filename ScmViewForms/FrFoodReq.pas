unit FrFoodReq;

interface

uses
  SysUtils, DB, DBClient, ImgList, Controls, Classes, ActnList, Grids, DBGrids,
  StdCtrls, ExtCtrls, DBCtrls, Mask, Buttons, Forms, StrUtils, Dialogs,
  Provider, ComCtrls, Math, Windows, Graphics, ShareCommon, ShareInterface,
  FaSrchPatient, SMDBGrid, Menus;

type
  IViewFoodReq = Interface(IInterface)
  ['{7CCC0175-C79A-4997-BBE1-7A783BA6D61B}']
    procedure AuthorizeMenu(uType :String);
    procedure Contact(reqID :String='');
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
  end;

  TRecFoodReqCalcFields = record
    PatName, Age :String;
  end;

  TfrmFoodReq = class(TForm,
                      IViewFoodReq,
                      IFrmFoodReqDataX,
                      IViewPatient)
    pnlButtons: TPanel;
    lbPatient: TLabel;
    chkPatSeqAdd: TCheckBox;
    acList: TActionList;
    actPatAddWrite: TAction;
    actPatDelCanc: TAction;
    actFactGroup: TAction;
    imgList: TImageList;
    grPAdm: TGroupBox;
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
    cdsReqDet: TClientDataSet;
    dspReqDet: TDataSetProvider;
    srcReqDet: TDataSource;
    dspDiag: TDataSetProvider;
    srcDiag: TDataSource;
    cdsDiag: TClientDataSet;
    sbReqEnd: TSpeedButton;
    actReqEnd: TAction;
    actHcDiagHist: TAction;
    lbStopInfo: TLabel;
    fraSPat: TfraSrchPat;
    grdReqs: TSMDBGrid;
    pmuReqs: TPopupMenu;
    mnuDiagHist: TMenuItem;
    grdReqDet: TDBGrid;
    pnlReqDet: TPanel;
    sbFoodType: TSpeedButton;
    pnlReq: TPanel;
    sbPatAddWrite: TSpeedButton;
    sbPatDelCanc: TSpeedButton;
    actHcDiag: TAction;
    sbCancPat: TSpeedButton;
    sbReqEndReset: TSpeedButton;
    actReqEndReset: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure grdReqsEditButtonClick(Sender: TObject);
    procedure mnuDiagHistClick(Sender: TObject);
  private
    { Private declarations }
    FDM     :IFoodReqDataX;
    FParent :TWinControl;

    //IViewPatient
    procedure PatientEnableControls;
    procedure PatientDisableControls;
  public
    { Public declarations }
    procedure AuthorizeMenu(uType :String);
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    //
    procedure Contact;overload;
    procedure Contact(reqID :String);overload;
    procedure DataInterface(const IDat :IFoodReqDataX);
    //
    function  DataManDiag :TclientDataSet;
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
    procedure SetLabelDblClickEvents(evt :TNotifyEvent);
    //
    procedure SetReqFrTo(dtFr, dtTo :TDateTime);
    //
    procedure SetListFoodType(pList :TStrings);
    procedure SetListDiag(pList :TStrings);
    procedure ShowIsEndRequest(b :Boolean); overload;
    procedure ShowIsEndRequest(p :TRecEndRequest); overload;
    //
    procedure DoClearSearchPatient;
    procedure PatAdmDataContact(b :Boolean);
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

procedure TfrmFoodReq.grdReqsEditButtonClick(Sender: TObject);
begin
 case grdReqs.Col of
   2 : actReqDt.Execute;
   5 : actHcDiag.Execute;
 end;
end;

procedure TfrmFoodReq.AuthorizeMenu(uType: String);
begin
//
end;

procedure TfrmFoodReq.Contact(reqID :String);
begin
  Contact;
  //
  if(cdsFdReq.Active)and(not cdsFdReq.IsEmpty)and(reqID<>'')then
    cdsFdReq.Locate('REQID',reqID,[]);
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

function TfrmFoodReq.DataManDiag: TclientDataSet;
begin
  Result := cdsDiag;
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

procedure TfrmFoodReq.DoClearSearchPatient;
begin
  fraSPat.DoClearSearchText;
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
  Result := False
end;

function TfrmFoodReq.IsPatSequenceAppend: Boolean;
begin
  Result := chkPatSeqAdd.Checked;
end;

procedure TfrmFoodReq.mnuDiagHistClick(Sender: TObject);
begin
//
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
  actHcDiag.OnExecute      := evt;
  actHcDiagHist.OnExecute  := evt;
  //
  actReqAddWrite.OnExecute := evt;
  actReqDelCanc.OnExecute  := evt;
  actReqNext.OnExecute     := evt;
  actReqPrev.OnExecute     := evt;
  actReqNewPat.OnExecute   := evt;
  actReqFoodType.OnExecute := evt;
  actReqEnd.OnExecute      := evt;
  actReqEndReset.OnExecute := evt; //issue#007
  //
  actReqDt.OnExecute       := evt;
  actReqFr.OnExecute       := evt;
  actReqTo.OnExecute       := evt;
  //
  //Self.OnShow              := evt;
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
  //edSearch.OnKeyDown := evt;
end;

procedure TfrmFoodReq.SetLabelDblClickEvents(evt: TNotifyEvent);
begin
  lbStopInfo.OnDblClick := evt;
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

procedure TfrmFoodReq.ShowIsEndRequest(p: TRecEndRequest);
begin
  ShowIsEndRequest(p.IsEnd);
  lbStopInfo.Visible := (p.EndType<>'');
  if p.EndType = C_ReqEndType_NPO then
    lbStopInfo.Caption :='NPO'
  else if p.EndType = C_ReqEndType_GHM then
    lbStopInfo.Caption :='HOME'
  else lbStopInfo.Caption := '';
end;

procedure TfrmFoodReq.ShowIsEndRequest(b: Boolean);
var i :Integer; ctr :TControl;
begin

  //command button enable property
  sbCancPat.Enabled     := not b;
  sbReqEnd.Enabled      := not b;
  sbPatAddWrite.Enabled := not b;
  sbPatDelCanc.Enabled  := not b;
  sbFoodType.Enabled    := not b;
  sbReqEnd.Enabled      := not b;
  sbReqEndReset.Enabled := b;

  //
  for i:= 0 to grPAdm.ControlCount -1 do begin
    ctr := grPAdm.Controls[i];
    if not(ctr is TLabel) then
      ctr.Enabled := not b;
  end;

  //
  chkPatSeqAdd.Enabled := not b;

  //
  grdReqs.ReadOnly := b;
  grdReqs.Color    := ifthen(grdReqs.ReadOnly ,
                             TColor(clMoneyGreen),
                             TColor(clWindow));

  //
  grdReqDet.ReadOnly  := b;
  grdReqDet.Color     := ifthen(grdReqDet.ReadOnly,
                                TColor(clMoneyGreen),
                                TColor(clWindow));

  //
  lbPatient.Caption := ifthen(b,
                              '����¡�� : ��ش��������',
                              '����¡�� : ��������');
  //
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
  //
  fraSPat.DoSetDataSource(srcPatAdm.DataSet);
end;

{private}
procedure TfrmFoodReq.PatientEnableControls;
begin
  srcPatAdm.DataSet.EnableControls;
end;

procedure TfrmFoodReq.PatAdmDataContact(b: Boolean);
begin
  if b then
    cdsPatAdm.EnableControls
  else cdsPatAdm.DisableControls;
end;

procedure TfrmFoodReq.PatientDisableControls;
begin
  srcPatAdm.DataSet.DisableControls;
end;

end.
