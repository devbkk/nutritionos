unit FrFoodPrep;

interface

uses
  Menus, DB, DBClient, Grids, DBGrids, Controls, StdCtrls, Buttons,
  Classes, ExtCtrls, Forms, ShareInterface, Provider, ActnList, 
  ImgList, Dialogs, Mask, DBCtrls;

type
  IViewFoodPrep = Interface(IInterface)
  ['{22F3B982-8AC8-4736-B309-D15886AD999E}']
    procedure AuthorizeMenu(uType :String);
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    function  GetSelectedList :TBookmarkList;
  end;

  TfrmFoodPrep = class(TForm, IViewFoodPrep, IFrmFoodPrepDataX)
    pnlButtons: TPanel;
    sbPrintAll: TSpeedButton;
    sbSelPrint: TSpeedButton;
    lbFactDataType: TLabel;
    grdFdPrep: TDBGrid;
    cdsFoodPrep: TClientDataSet;
    srcFdPrep: TDataSource;
    dspFoodPrep: TDataSetProvider;
    grSearch: TGroupBox;
    edSearch: TEdit;
    imgList: TImageList;
    actList: TActionList;
    actSelPrint: TAction;
    actPrintAll: TAction;
    cdsSelPrn: TClientDataSet;
    rdoPrnAm: TRadioButton;
    rdoPrnPm: TRadioButton;
    actPrnAm: TAction;
    actPrnPm: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FParent :TWinControl;
    FDM     :IDataSetX;
  public
    { Public declarations }
    procedure AuthorizeMenu(uType :String);
    procedure Contact;    
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    function  GetSelectedList :TBookmarkList;
    //
    procedure DataInterface(const IDat :IDataSetX);
    function DataManFoodPrep :TClientDataSet;
    function SelectedData :TClientDataSet;
    //
    procedure SetActionEvents(evt :TNotifyEvent);
    procedure SetEditKeyDownEvents(evt :TEditKeyDown);    
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
//
end;

procedure TfrmFoodPrep.Contact;
begin
  if assigned(FParent) then begin
    Self.Align := alClient;
    Self.ManualDock(FParent);
    Self.Show;
  end else ShowModal;
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

function TfrmFoodPrep.SelectedData: TClientDataSet;
begin
  Result := cdsSelPrn;
end;

procedure TfrmFoodPrep.SetActionEvents(evt: TNotifyEvent);
begin
  actSelPrint.OnExecute := evt;
  actPrintAll.OnExecute := evt;
  //
  actPrnAm.OnExecute    := evt;
  actPrnPm.OnExecute    := evt;
end;

procedure TfrmFoodPrep.SetEditKeyDownEvents(evt: TEditKeyDown);
begin
  edSearch.OnKeyDown := evt;
end;

end.
