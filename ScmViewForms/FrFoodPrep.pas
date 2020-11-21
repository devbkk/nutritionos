unit FrFoodPrep;

interface

uses
  Menus, DB, DBClient, Grids, DBGrids, Controls, StdCtrls, Buttons,
  Classes, ExtCtrls, Forms, ShareCommon, ShareInterface, Provider, ActnList,
  ImgList, Dialogs, Mask, DBCtrls, SysUtils, FaSrchPatient;

type
  IViewFoodPrep = Interface(IInterface)
  ['{22F3B982-8AC8-4736-B309-D15886AD999E}']
    procedure AuthorizeMenu(uType :String);
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    procedure DoSetServiceCallBack(evt :TEventServiceCallBack);
    function  GetSelectedList :TBookmarkList;
  end;

  TfrmFoodPrep = class(TForm,
                       IViewFoodPrep,
                       IFrmFoodPrepDataX,
                       IViewPatient)
    pnlButtons: TPanel;
    sbPrintAll: TSpeedButton;
    sbSelPrint: TSpeedButton;
    lbFactDataType: TLabel;
    grdFdPrep: TDBGrid;
    cdsFoodPrep: TClientDataSet;
    srcFdPrep: TDataSource;
    dspFoodPrep: TDataSetProvider;
    imgList: TImageList;
    actList: TActionList;
    actSelPrint: TAction;
    actPrintAll: TAction;
    rdoPrnAm: TRadioButton;
    rdoPrnPm: TRadioButton;
    actPrnAm: TAction;
    actPrnPm: TAction;
    cdsSelPrn: TClientDataSet;
    cdsSlipDiet: TClientDataSet;
    fraSPat: TfraSrchPat;
    pmuFdPrep: TPopupMenu;
    mnuEditFoodReq: TMenuItem;
    actEditFoodReq: TAction;
    mnuDelFoodReq: TMenuItem;
    mnuDoNPO: TMenuItem;
    actDelFoodReq: TAction;
    actDoNPO: TAction;
    sbSlipEdit: TSpeedButton;
    actSlipEdit: TAction;
    mnuDelFoodReqById: TMenuItem;
    actDelFoodReqById: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FParent :TWinControl;
    FDM     :IDataSetX;
    FServiceCallBack :TEventServiceCallBack;
    //IViewPatient
    procedure PatientEnableControls;
    procedure PatientDisableControls;
  public
    { Public declarations }
    procedure AuthorizeMenu(uType :String);
    procedure CallBackServiceReq;
    procedure Contact;
    procedure ContactData;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    procedure DoSetServiceCallBack(evt :TEventServiceCallBack);
    function  GetSelectedList :TBookmarkList;
    //
    procedure DataInterface(const IDat :IDataSetX);
    function DataManFoodPrep :TClientDataSet;
    function SelectedData :TClientDataSet;
    //
    procedure SetActionEvents(evt :TNotifyEvent);
    procedure SetEditKeyDownEvents(evt :TEditKeyDown);
    procedure SetDrawColumnCellEvents(evt :TDrawColumnCellEvent);
  end;

var
  frmFoodPrep: TfrmFoodPrep;

implementation

{$R *.dfm}

procedure TfrmFoodPrep.FormCreate(Sender: TObject);
begin
  dspFoodPrep.Options := dspFoodPrep.Options +[poFetchDetailsOnDemand];
  cdsFoodPrep.FetchOnDemand := True;
  cdsFoodPrep.PacketRecords := 100;
  //
  fraSPat.DoSetDataSource(srcFdPrep.DataSet);
end;

procedure TfrmFoodPrep.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfrmFoodPrep.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFoodPrep.FormShow(Sender: TObject);
begin
//
end;

function TfrmFoodPrep.GetSelectedList: TBookmarkList;
begin
  Result := grdFdPrep.SelectedRows;
end;

procedure TfrmFoodPrep.AuthorizeMenu(uType: String);
begin
  sbSlipEdit.Visible := (uType='A');
end;

procedure TfrmFoodPrep.CallBackServiceReq;
var rec :TRecServiceCallBack;
begin
  if Assigned(FServiceCallBack) then begin
    if cdsFoodPrep.IsEmpty then
      Exit;
    //
    rec.CallBackID := scReq;
    rec.CallBackValue := cdsFoodPrep.FieldByName('AN').AsString;
    //
    FServiceCallBack(rec);
  end;
end;

procedure TfrmFoodPrep.Contact;
begin
  if assigned(FParent) then begin
    Self.Align := alClient;
    Self.ManualDock(FParent);
    Self.Show;
  end else ShowModal;
  ContactData;
end;

procedure TfrmFoodPrep.ContactData;
begin
  //
  dspFoodPrep.DataSet := FDM.XDataSet;
  cdsFoodPrep.Close;
  cdsFoodPrep.SetProvider(dspFoodPrep);
  cdsFoodPrep.Open;
end;

procedure TfrmFoodPrep.DataInterface(const IDat: IDataSetX);
begin
  FDM := IDat;
end;

function TfrmFoodPrep.DataManFoodPrep: TClientDataSet;
begin
  Result := cdsFoodPrep;
end;

procedure TfrmFoodPrep.DoSetParent(AOwner: TWinControl; AFrame: TFrame);
begin
  FParent := AOwner;
end;

procedure TfrmFoodPrep.DoSetServiceCallBack(evt: TEventServiceCallBack);
begin
  FServiceCallBack := evt;
end;

function TfrmFoodPrep.SelectedData: TClientDataSet;
begin
  Result := cdsSlipDiet;
end;

procedure TfrmFoodPrep.SetActionEvents(evt: TNotifyEvent);
begin
  actSelPrint.OnExecute := evt;
  actPrintAll.OnExecute := evt;
  //
  actPrnAm.OnExecute    := evt;
  actPrnPm.OnExecute    := evt;
  //
  actEditFoodReq.OnExecute := evt;
  actDelFoodReq.OnExecute  := evt;
  actDelFoodReqById.OnExecute := evt;
  actDoNPO.OnExecute       := evt;
  //
  actSlipEdit.OnExecute    := evt;
end;

procedure TfrmFoodPrep.SetDrawColumnCellEvents(evt: TDrawColumnCellEvent);
begin
  grdFdPrep.OnDrawColumnCell := evt;
end;

procedure TfrmFoodPrep.SetEditKeyDownEvents(evt: TEditKeyDown);
begin
  grdFdPrep.OnKeyDown := evt;

end;

//
procedure TfrmFoodPrep.PatientDisableControls;
begin
  srcFdPrep.DataSet.DisableControls;
end;

procedure TfrmFoodPrep.PatientEnableControls;
begin
  srcFdPrep.DataSet.EnableControls;
end;

end.
