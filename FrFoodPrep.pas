unit FrFoodPrep;

interface

uses
  Menus, DB, DBClient, Grids, DBGrids, Controls, StdCtrls, Buttons,
  Classes, ExtCtrls, Forms;

type
  IViewFoodPrep = Interface(IInterface)
  ['{22F3B982-8AC8-4736-B309-D15886AD999E}']
    procedure AuthorizeMenu(uType :String);
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
  end;

  TfrmFoodPrep = class(TForm, IViewFoodPrep)
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    lbFactDataType: TLabel;
    chkSeqAdd: TCheckBox;
    cboFactDataType: TComboBox;
    grdFdPrep: TDBGrid;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    grdFdPrepDet: TDBGrid;
    cdsFdPrep: TClientDataSet;
    srcFdPrep: TDataSource;
    srcFdPrepDet: TDataSource;
    cdsFdPrepDet: TClientDataSet;
    pmuFdPrepDet: TPopupMenu;
    mnuFdPrepDetDchg: TMenuItem;
    mnuSlipDiet: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FParent :TWinControl;
  public
    { Public declarations }
    procedure AuthorizeMenu(uType :String);
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
  end;

var
  frmFoodPrep: TfrmFoodPrep;

implementation

{$R *.dfm}

procedure TfrmFoodPrep.FormCreate(Sender: TObject);
begin
//
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
end;

procedure TfrmFoodPrep.DoSetParent(AOwner: TWinControl; AFrame: TFrame);
begin
  FParent := AOwner;
end;

end.
