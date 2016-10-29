unit FrFactTreeInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ShareCommon, ShareInterface;

type
  TfrmFactTreeInput = class(TForm)
    gbMain: TGroupBox;
    lbCode: TLabel;
    edCode: TEdit;
    lbDesc: TLabel;
    edDesc: TEdit;
    sbOK: TSpeedButton;
    sbCancel: TSpeedButton;
    lbNote: TLabel;
    edNote: TEdit;
    chkUserDef: TCheckBox;
    radIsSubLevel: TRadioButton;
    radIsProperty: TRadioButton;
    chkIsSlipPrn: TCheckBox;
    //
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    //
    procedure chkUserDefClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure sbOKClick(Sender: TObject);

  private
    { Private declarations }
    FCodeList :TStrings;
    FEditMode :Boolean;
    function GetCode :String;
    procedure SetCode(const Val :String);
    //
    function GetDesc :String;
    procedure SetDesc(const Val :String);
    //
    function GetIsSubLevel :Boolean;
    procedure SetIsSubLevel(const Val :Boolean);
    //
    function GetNote :String;
    procedure SetNote(const Val :String);
    //
    function GetIsSlipPrn :Boolean;
    procedure SetIsSlipPrn(const Val :Boolean);
    //
    procedure SetEditMode(const Val :Boolean);
  public
    { Public declarations }
    function Answer :TRecFactTreeInput;
    procedure SetCodeLlist(lst :TStrings);
    procedure SetDatas(p :TRecFactTreeInput);
    //
    property Code :String read GetCode write SetCode;
    property Desc :String read GetDesc write SetDesc;
    property EditMode :Boolean read FEditMode write SetEditMode;
    property IsSubLevel :Boolean
      read GetIsSubLevel write SetIsSubLevel;
    property Note :String read GetNote write SetNote;
    property IsSlipPrn :Boolean
      read GetIsSlipPrn write SetIsSlipPrn;
  end;

var
  frmFactTreeInput: TfrmFactTreeInput;

implementation

const WRN_CREP =  'รหัสนี้ถูกใช้งานแล้ว';

{$R *.dfm}

procedure TfrmFactTreeInput.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFactTreeInput.FormDestroy(Sender: TObject);
begin
  if frmFactTreeInput=Self then
    frmFactTreeInput := nil;
end;

procedure TfrmFactTreeInput.FormShow(Sender: TObject);
begin
  edCode.ReadOnly := FEditMode;
  //
  if edDesc.CanFocus then
    edDesc.SetFocus;
end;

procedure TfrmFactTreeInput.chkUserDefClick(Sender: TObject);
begin
  edCode.ReadOnly := not chkUserDef.Checked;
  //
  if chkUserDef.Checked then begin
    if edCode.CanFocus then begin
      edCode.SetFocus;
      edCode.SelStart  := Length(edCode.Text);
      edCode.SelLength := Length(edCode.Text);
    end;
  end;
end;

procedure TfrmFactTreeInput.sbCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmFactTreeInput.sbOKClick(Sender: TObject);
var sCode :String;
begin
  sCode := edCode.Text;
  if not FEditMode then begin
    //
    if (FCodeList<>nil) then
      if (FCodeList.IndexOf(sCode)=-1) then
        ModalResult := mrOk
      else begin
        MessageDlg(WRN_CREP,mtWarning,[mbOK],0);
        Abort;
      end;
  end else ModalResult := mrOK;
end;

function TfrmFactTreeInput.Answer: TRecFactTreeInput;
begin
  if ShowModal=mrOk then begin
    Result.Code := edCode.Text;
    Result.Desc := edDesc.Text;
    Result.Note := edNote.Text;
    Result.IsSubLevel := radIsSubLevel.Checked;
    Result.IsSlipPrn  := chkIsSlipPrn.Checked;
  end else begin
    Result.Code := '';
    Result.Desc := '';
    Result.Note := '';
    Result.IsSubLevel := False;
    Result.IsSlipPrn  := False;
  end;
end;

{private}
function TfrmFactTreeInput.GetCode: String;
begin
  Result := edCode.Text;
end;

function TfrmFactTreeInput.GetDesc: String;
begin
  Result := edDesc.Text;
end;

function TfrmFactTreeInput.GetIsSlipPrn: Boolean;
begin
  Result := chkIsSlipPrn.Checked;
end;

function TfrmFactTreeInput.GetIsSubLevel: Boolean;
begin
  Result := radIsSubLevel.Checked;
end;

function TfrmFactTreeInput.GetNote: String;
begin
  Result := edNote.Text;
end;

procedure TfrmFactTreeInput.SetCode(const Val: String);
begin
  edCode.Text := Val;
end;

procedure TfrmFactTreeInput.SetCodeLlist(lst: TStrings);
begin
  FCodeList := lst;
end;

procedure TfrmFactTreeInput.SetDatas(p: TRecFactTreeInput);
begin
  edCode.Text := p.Code;
  edDesc.Text := p.Desc;
  edNote.Text := p.Note;
  radIsSubLevel.Checked := p.IsSubLevel;
  radIsProperty.Checked := not p.IsSubLevel;
  chkIsSlipPrn.Checked  := p.IsSlipPrn;
end;

procedure TfrmFactTreeInput.SetDesc(const Val: String);
begin
  edDesc.Text := Val;
end;

procedure TfrmFactTreeInput.SetEditMode(const Val: Boolean);
begin
  FEditMode := Val;
end;

procedure TfrmFactTreeInput.SetIsSlipPrn(const Val: Boolean);
begin
  chkIsSlipPrn.Checked := Val;
end;

procedure TfrmFactTreeInput.SetIsSubLevel(const Val: Boolean);
begin
  radIsSubLevel.Checked := Val;
end;

procedure TfrmFactTreeInput.SetNote(const Val: String);
begin
  edNote.Text := Val;
end;

end.
