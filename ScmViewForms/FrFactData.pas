unit FrFactData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, FaFactData, ComCtrls, Buttons, ImgList, ActnList;

type
  TEnumInputType = (itMaterial=Ord('M'),
                    itUser    =Ord('U'),
                    itDbCfg   =Ord('D'),
                    itSysLog  =Ord('L'),
                    iFactTyp  =Ord('T'),
                    iFactTree =Ord('E'));

  TRecSetInputParam = record
    InputType :TEnumInputType;
    Evt       :TNotifyEvent;
    AFrame    :TFrame;
  end;

  IViewInputFact = Interface(IInterface)
  ['{1259E224-7DFE-4528-98DE-7A2575F87443}']
    procedure AuthorizeMenu(uType :String);
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    //
    procedure SetRequestInputUser(const evt :TNotifyEvent);
    procedure SetRequestInputMaterial(const evt :TNotifyEvent);
    procedure SetInputMan(const AFrame :TFrame); overload;
    procedure SetInputMan(const AFrame :TFrame; ATab :TTabSheet); overload;
    //
    procedure UnContact;
  end;

  TfrmFactData = class(TForm, IViewInputFact)
    pcMain: TPageControl;
    tsFact: TTabSheet;
    acList: TActionList;
    imgList: TImageList;
    actFdMatType: TAction;
    actUser: TAction;
    tsUser: TTabSheet;
    tsConf: TTabSheet;
    tsSysLog: TTabSheet;
    tsFactType: TTabSheet;
    tsFoodTree: TTabSheet;
    //
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pcMainChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FParent :TWinControl;
    AInput  :TFrame;
  public
    { Public declarations }
    procedure AuthorizeMenu(uType :String);
    procedure ClearInput;
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    //
    procedure SetCallBackEvents(evt :TNotifyEvent);
    //
    procedure SetInputMan(const AFrame :TFrame); overload;
    procedure SetInputMan(const AFrame :TFrame; ATab :TTabSheet); overload;
    procedure SetRequestInputUser(const evt :TNotifyEvent);
    procedure SetRequestInputMaterial(const evt :TNotifyEvent);
    //
    procedure SetupInput(const p:TRecSetInputParam); overload;
    //
    procedure UnContact;
  end;

var
  frmFactData: TfrmFactData;

implementation

const UT_ADMIN  = 'A';
      UT_DEMO   = 'D';
{$R *.dfm}

{ TfrmFactData }

procedure TfrmFactData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFactData.FormCreate(Sender: TObject);
begin
  //pcMain.ActivePage := tsFact;
end;

procedure TfrmFactData.FormDestroy(Sender: TObject);
begin
  if frmFactData = Self then
    frmFactData := nil;
end;

procedure TfrmFactData.FormShow(Sender: TObject);
begin
  //pcMain.ActivePage := tsFact;
  pcMain.ActivePage := tsFoodTree;
  //
  tsFact.TabVisible     := False;
  tsFactType.TabVisible := False;
end;

procedure TfrmFactData.pcMainChange(Sender: TObject);
begin
//
end;

{public}
procedure TfrmFactData.AuthorizeMenu(uType: String);
var b :Boolean;
begin
  b := (uType=UT_ADMIN)or(uType=UT_DEMO);
  tsUser.TabVisible   := b;
  tsConf.TabVisible   := b;
  tsSysLog.TabVisible := b;
end;

procedure TfrmFactData.ClearInput;
begin

end;

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

procedure TfrmFactData.SetInputMan(const AFrame: TFrame);
begin
  AFrame.Parent  := tsFact;
  AFrame.Align   := alClient;
  AFrame.Visible := True;
  AFrame.Show;
end;

procedure TfrmFactData.SetCallBackEvents(evt: TNotifyEvent);
begin
  pcMain.OnChange := evt;
end;

procedure TfrmFactData.SetInputMan(const AFrame: TFrame; ATab: TTabSheet);
begin
  //
  AFrame.Parent  := ATab;
  AFrame.Align   := alClient;
  AFrame.Visible := True;
  AFrame.Show;
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
      SetInputMan(p.AFrame,tsFact);
    end;
    //
    itUser     : begin
      actUser.OnExecute := p.Evt;
      SetInputMan(p.AFrame,tsUser);
    end;
    //
    itDbCfg    : begin
      SetInputMan(p.AFrame,tsConf);
    end;
    //
    itSysLog   : begin
      SetInputMan(p.AFrame,tsSysLog);
    end;
    //
    iFactTyp : begin
      SetInputMan(p.AFrame,tsFactType);
    end;
    //
    iFactTree : begin
      SetInputMan(p.AFrame,tsFoodTree);
    end;
  end;

  pcMain.ActivePageIndex := 0;
end;

procedure TfrmFactData.UnContact;
begin
  Self.Close;
end;

end.
