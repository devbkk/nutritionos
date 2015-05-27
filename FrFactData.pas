unit FrFactData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, FaFactData, ComCtrls, Buttons, ImgList, ActnList,
  InfInputData;

type
  TfrmFactData = class(TForm, IViewInputFact)
    pcMain: TPageControl;
    tsFact: TTabSheet;
    pnlMenu: TPanel;
    fraFactDat: TfraFactData;
    sbFdMatType: TSpeedButton;
    acList: TActionList;
    imgList: TImageList;
    actFdMatType: TAction;
    sbUsers: TSpeedButton;
    actUser: TAction;
    procedure actFdMatTypeExecute(Sender: TObject);
    procedure actUserExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FParent :TWinControl;
  public
    { Public declarations }
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl);
  end;

var
  frmFactData: TfrmFactData;

implementation

{$R *.dfm}

{ TfrmFactData }

procedure TfrmFactData.actFdMatTypeExecute(Sender: TObject);
var inf :IfraFactData;
begin
  supports(fraFactDat,IfraFactData,inf);
  inf.DoRequestFactInput(fdtMaterial);
end;

procedure TfrmFactData.actUserExecute(Sender: TObject);
var inf :IfraFactData;
begin
  supports(fraFactDat,IfraFactData,inf);
  inf.DoRequestFactInput(fdtUser);
end;

procedure TfrmFactData.Contact;
begin
  if assigned(FParent) then begin
    Self.Align := alClient;
    Self.ManualDock(FParent);
    Self.Show;
  end else ShowModal;
end;

procedure TfrmFactData.DoSetParent(AOwner : TWinControl);
begin
  FParent := AOwner;
end;

procedure TfrmFactData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFactData.FormCreate(Sender: TObject);
begin
  fraFactDat.Visible := False;
end;

procedure TfrmFactData.FormDestroy(Sender: TObject);
begin
  if frmFactData = Self then
    frmFactData := nil;
end;

end.
