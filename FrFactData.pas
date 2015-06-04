unit FrFactData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, FaFactData, ComCtrls, Buttons, ImgList, ActnList;

type
  TEnumInputType = (itMaterial=Ord('M'),itUser=Ord('U'));

  TRecSetInputParam = record
    InputType :TEnumInputType;
    Evt       :TNotifyEvent;
    AFrame    :TFrame;
  end;

  IViewInputFact = Interface(IInterface)
  ['{1259E224-7DFE-4528-98DE-7A2575F87443}']
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    //
    procedure SetRequestInputUser(const evt :TNotifyEvent);
    procedure SetRequestInputMaterial(const evt :TNotifyEvent);
    procedure SetInputMan(const AFrame :TFrame);
    //
  end;

  TfrmFactData = class(TForm, IViewInputFact)
    pcMain: TPageControl;
    tsFact: TTabSheet;
    pnlMenu: TPanel;
    sbFdMatType: TSpeedButton;
    acList: TActionList;
    imgList: TImageList;
    actFdMatType: TAction;
    sbUsers: TSpeedButton;
    actUser: TAction;
    //
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FParent :TWinControl;
    AInput  :TFrame;
  public
    { Public declarations }
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    //
    procedure SetInputMan(const AFrame :TFrame);
    procedure SetRequestInputUser(const evt :TNotifyEvent);
    procedure SetRequestInputMaterial(const evt :TNotifyEvent);

    procedure SetupInput(const p:TRecSetInputParam);
  end;

var
  frmFactData: TfrmFactData;

implementation

{$R *.dfm}

{ TfrmFactData }

procedure TfrmFactData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFactData.FormCreate(Sender: TObject);
begin
//
end;

procedure TfrmFactData.FormDestroy(Sender: TObject);
begin
  if frmFactData = Self then
    frmFactData := nil;
end;

{public}
procedure TfrmFactData.Contact;
begin
  if assigned(FParent) then begin
    Self.Align := alClient;
    Self.ManualDock(FParent);
    Self.Show;
  end else ShowModal;
end;

procedure TfrmFactData.DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
begin
  FParent := AOwner;
  if assigned(AFrame) then begin
    AInput := AFrame;
    SetInputMan(AInput);
  end;
end;

{public}
procedure TfrmFactData.SetInputMan(const AFrame: TFrame);
begin
  AFrame.Parent  := tsFact;
  AFrame.Align   := alClient;
  AFrame.Visible := False;
  //AFrame.Show;
end;

procedure TfrmFactData.SetRequestInputMaterial(const evt: TNotifyEvent);
begin
  actFdMatType.OnExecute := evt;
end;

procedure TfrmFactData.SetRequestInputUser(const evt: TNotifyEvent);
begin
  actUser.OnExecute := evt;
end;

procedure TfrmFactData.SetupInput(const p:TRecSetInputParam);
begin
  case p.InputType of
    itMaterial : begin
      actFdMatType.OnExecute := p.Evt;
      SetInputMan(p.AFrame);
    end;

    itUser     : begin
      actUser.OnExecute := p.Evt;
      SetInputMan(p.AFrame);
    end;
  end;
end;

end.
