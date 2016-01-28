unit FrFoodRep;

interface

uses
  frxClass, StdCtrls, Buttons, Controls, ExtCtrls, Classes, Forms, frxDBSet, DB,
  DBClient, DmFoodRep, Provider, ShareInterface;

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
    procedure DataInterface(const IDat :IDataSetX);
    function  SelectedReportIndex :Integer;
    procedure SetActionEvents(evt :TNotifyEvent);
    //
    function DataManFoodRep :TClientDataSet;
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

function TfrmFoodRep.SelectedReportIndex: Integer;
begin
  Result := lstRep.ItemIndex;
end;

procedure TfrmFoodRep.SetActionEvents(evt: TNotifyEvent);
begin
  bbtPrint.OnClick := evt;
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

procedure TfrmFoodRep.DoSetParent(AOwner: TWinControl; AFrame: TFrame);
begin
  FParent := AOwner;
end;

end.
