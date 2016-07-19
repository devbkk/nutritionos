unit FrFoodRep;

interface

uses
  StdCtrls, Buttons, Controls, ExtCtrls, Classes, Forms,
  frxClass, frxDBSet, DB,  DBClient,  Provider, Grids,
  ValEdit, ComCtrls,
  //
  DmFoodRep, ShareCommon, ShareInterface;
type
  IViewFoodRep = Interface(IInterface)
  ['{D18417EF-F378-4D50-B3B3-C762B3ACE29C}']
    procedure AuthorizeMenu(uType :String);
    procedure Contact;
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
    dtpSelect: TDateTimePicker;
    lbSelDate: TLabel;
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
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    //
    function  SelectedReportIndex :Integer;
    procedure DataInterface(const IDat :IDataSetX);
    procedure SetActionEvents(evt :TNotifyEvent);
    //
    function DataManFoodRep :TClientDataSet;
    function GetMeal :String;
    function GetDate :TDateTime;
    procedure DoSetHasParams(const b :Boolean); overload;
    procedure DoSetHasParams(const p :TRecSetReportParamInputter); overload;
  end;

var
  frmFoodRep: TfrmFoodRep;

implementation

{$R *.dfm}

procedure TfrmFoodRep.FormCreate(Sender: TObject);
begin
  //FDM := TDmoFoodRep.Create(Self);
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

function TfrmFoodRep.GetDate: TDateTime;
begin
  Result := dtpSelect.DateTime;
end;

function TfrmFoodRep.GetMeal: String;
begin
  if vlRepParams.Visible then
    Result :=  vlRepParams.Cells[1,0]
  else Result := '';
end;

function TfrmFoodRep.SelectedReportIndex: Integer;
begin
  Result := lstRep.ItemIndex;
end;

procedure TfrmFoodRep.SetActionEvents(evt: TNotifyEvent);
begin
  bbtPrint.OnClick := evt;
  lstRep.OnClick   := evt;
end;

procedure TfrmFoodRep.AuthorizeMenu(uType: String);
begin
//
end;

procedure TfrmFoodRep.Contact;
begin
  if assigned(FParent) then begin
    Self.Align := alClient;
    Self.ManualDock(FParent);
    Self.Show;
  end else ShowModal;
  //
end;

procedure TfrmFoodRep.DataInterface(const IDat: IDataSetX);
begin
  FDM := IDat;
end;

function TfrmFoodRep.DataManFoodRep: TClientDataSet;
begin
  Result := cdsRep;
end;

procedure TfrmFoodRep.DoSetHasParams(const b: Boolean);
begin
  gbSelDate.Visible := b;
end;

procedure TfrmFoodRep.DoSetHasParams(const p: TRecSetReportParamInputter);
begin
  gbSelDate.Visible := p.IsFrDate;
end;

procedure TfrmFoodRep.DoSetParent(AOwner: TWinControl; AFrame: TFrame);
begin
  FParent := AOwner;
end;

end.
