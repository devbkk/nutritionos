unit FrFood;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ComCtrls,
  ShareInterface, FaFood, FaFoodMenu, FaMeal;


type
  IViewFood = Interface(IInterface)
  ['{7AADD575-7FEC-4561-BB54-1942ADA035C8}']
    procedure AuthorizeMenu(uType :String);
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
  end;

  TfrmFood = class(TForm, IViewFood)
    pcMain: TPageControl;
    tsFood: TTabSheet;
    tsFdMnu: TTabSheet;
    tsFdMeal: TTabSheet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FParent :TWinControl;
    //AInput  :TFrame;
  public
    { Public declarations }
    procedure AuthorizeMenu(uType :String);
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    procedure SetupInputItem(p :TRecSetInputItem);
  end;

var
  frmFood: TfrmFood;

implementation

{$R *.dfm}

{ TfrmFood }

procedure TfrmFood.AuthorizeMenu(uType: String);
begin
//
end;

procedure TfrmFood.Contact;
begin
  if assigned(FParent) then begin
    Self.Align := alClient;
    Self.ManualDock(FParent);
    Self.Show;
  end else ShowModal;
end;

procedure TfrmFood.DoSetParent(AOwner: TWinControl; AFrame: TFrame);
begin
  FParent := AOwner;
  {if assigned(AFrame) then begin
    AInput := AFrame;
    SetInputMan(AInput);
  end;}
end;

procedure TfrmFood.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFood.FormCreate(Sender: TObject);
begin
//
end;

procedure TfrmFood.FormDestroy(Sender: TObject);
begin
  if frmFood = Self then
    frmFood := nil;
end;

procedure TfrmFood.FormShow(Sender: TObject);
begin
  pcMain.ActivePage := tsFood;
end;

procedure TfrmFood.SetupInputItem(p: TRecSetInputItem);
var ATab :TTabSheet; AFrame :TFrame;
begin
  ATab := pcMain.Pages[p.PageIndex];
  //
  AFrame := p.AFrame;
  AFrame.Parent  := ATab;
  AFrame.Align   := alClient;
  AFrame.Visible := True;
  AFrame.Show;
end;

end.
