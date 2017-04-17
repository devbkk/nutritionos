unit FrFoodRep;

interface

uses
  StdCtrls, Buttons, Controls, ExtCtrls, Classes, Forms,
  frxClass, frxDBSet, DB,  DBClient,  Provider, Grids,
  ValEdit, ComCtrls, SysUtils,
  //
  DmFoodRep, ShareCommon, ShareInterface, ActnList, ImgList, DBGrids, SMDBGrid,
  Menus, ToolWin;
type
  IViewFoodRep = Interface(IInterface)
  ['{D18417EF-F378-4D50-B3B3-C762B3ACE29C}']
    procedure AuthorizeMenu(uType :String);
    procedure Contact(code :String='');
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
  End;

  TfrmFoodRep = class(TForm, IViewFoodRep)
    grSearch: TGroupBox;
    edSearch: TEdit;
    pnlButtons: TPanel;
    lbFactDataType: TLabel;
    lstRep: TListBox;
    bbtPrint: TBitBtn;
    cdsRep: TClientDataSet;
    vlRepParams: TValueListEditor;
    gbSelDate: TGroupBox;
    dtpFrDate: TDateTimePicker;
    lbFrDate: TLabel;
    dtpToDate: TDateTimePicker;
    lbToDate: TLabel;
    cdsRep4: TClientDataSet;
    sbRepCr: TSpeedButton;
    imgList: TImageList;
    actList: TActionList;
    actRepCr: TAction;
    edReportName: TEdit;
    srcRep: TDataSource;
    dspRep: TDataSetProvider;
    actRepEdt: TAction;
    sbRepEdt: TSpeedButton;
    sbRepDel: TSpeedButton;
    actRepDel: TAction;
    sbtRepCopy: TSpeedButton;
    actRepCopy: TAction;
    sbtRepPrn: TSpeedButton;
    actRepPrn: TAction;
    grdRep: TDBGrid;
    sbRepImp: TSpeedButton;
    spRepExp: TSpeedButton;
    actRepImp: TAction;
    actRepExp: TAction;
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
    procedure Contact(code :String='');
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    //
    function  SelectedReportIndex :Integer;
    procedure DataInterface(const IDat :IDataSetX);
    procedure SetActionEvents(evt :TNotifyEvent);
    //
    function DataManFoodRep :TClientDataSet;
    function DataManFoodRep4 :TClientDataSet;
    function GetMeal :String;
    function GetFrDate :TDateTime;
    function GetToDate :TDateTime;
    function GetReportCode :String;
    function GetReportName :String;
    //
    procedure DoClearInput;
    procedure DoSetDateInputters;
    procedure DoSetHasParams(const b :Boolean); overload;
    procedure DoSetHasParams(const p :TRecSetReportParamInputter); overload;
    //
    procedure Start;
  end;

var
  frmFoodRep: TfrmFoodRep;

implementation

{$R *.dfm}

procedure TfrmFoodRep.FormCreate(Sender: TObject);
begin
  Start;
end;

procedure TfrmFoodRep.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfrmFoodRep.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//
end;

procedure TfrmFoodRep.FormShow(Sender: TObject);
begin
//
end;

function TfrmFoodRep.GetFrDate: TDateTime;
begin
  Result := dtpFrDate.DateTime;
end;

function TfrmFoodRep.GetMeal: String;
begin
  if vlRepParams.Visible then
    Result :=  vlRepParams.Cells[1,0]
  else Result := '';
end;

function TfrmFoodRep.GetReportCode: String;
begin
  Result := cdsRep.FieldByName('RCOD').AsString;
end;

function TfrmFoodRep.GetReportName: String;
begin
  Result := edReportName.Text;
end;

function TfrmFoodRep.GetToDate: TDateTime;
begin
  Result := dtpToDate.DateTime;
end;

function TfrmFoodRep.SelectedReportIndex: Integer;
begin
  Result := lstRep.ItemIndex;
end;

procedure TfrmFoodRep.SetActionEvents(evt: TNotifyEvent);
begin
  actRepCr.OnExecute   := evt;
  actRepEdt.OnExecute  := evt;
  actRepDel.OnExecute  := evt;
  actRepCopy.OnExecute := evt;
  actRepPrn.OnExecute  := evt;
  actRepExp.OnExecute  := evt;
  actRepImp.OnExecute  := evt;
  //
  bbtPrint.OnClick   := evt;
  lstRep.OnClick     := evt;
end;

procedure TfrmFoodRep.AuthorizeMenu(uType: String);
begin
  pnlButtons.Visible := (uType='A');
end;

procedure TfrmFoodRep.Contact(code :String);
begin
  if assigned(FParent) then begin
    Self.Align := alClient;
    Self.ManualDock(FParent);
    Self.Show;
  end else ShowModal;
  //
  dspRep.DataSet := FDM.XDataSet;
  cdsRep.Close;
  cdsRep.SetProvider(dspRep);
  cdsRep.Open;
  //
  if code<>'' then
    cdsRep.Locate('RCOD',code,[]);

  cdsRep.Filter   := 'RDEL<>''Y''';
  cdsRep.Filtered := True;
end;

procedure TfrmFoodRep.DataInterface(const IDat: IDataSetX);
begin
  FDM := IDat;
end;

function TfrmFoodRep.DataManFoodRep: TClientDataSet;
begin
  Result := cdsRep;
end;

function TfrmFoodRep.DataManFoodRep4: TClientDataSet;
begin
  Result := cdsRep4;
end;

procedure TfrmFoodRep.DoSetHasParams(const b: Boolean);
begin
  gbSelDate.Visible := b;
end;

procedure TfrmFoodRep.DoClearInput;
begin
  edReportName.Text := '';
end;

procedure TfrmFoodRep.DoSetDateInputters;
begin
  if dtpFrDate.Visible then
    dtpFrDate.DateTime := Date;
  if dtpToDate.Visible then
    dtpToDate.DateTime := Date;
end;

procedure TfrmFoodRep.DoSetHasParams(const p: TRecSetReportParamInputter);
begin
  gbSelDate.Visible := p.IsGrDate;
  lbFrDate.Visible  := p.IsFrDate;
  dtpFrDate.Visible := p.IsFrDate;
  lbToDate.Visible  := p.IsToDate;
  dtpToDate.Visible := p.IsToDate;
end;

procedure TfrmFoodRep.DoSetParent(AOwner: TWinControl; AFrame: TFrame);
begin
  FParent := AOwner;
end;

procedure TfrmFoodRep.Start;
begin
  dspRep.Options := dspRep.Options+[poFetchDetailsOnDemand];
  cdsRep.FetchOnDemand := True;
  cdsRep.PacketRecords := 100;
end;

end.
