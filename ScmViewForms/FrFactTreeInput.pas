unit FrFactTreeInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ShareInterface;

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
    //
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure sbOKClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure chkUserDefClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    FCodeList :TStrings;
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

  public
    { Public declarations }
    function Answer :TRecFactTreeInput;
    procedure SetCodeLlist(lst :TStrings);
    property Code :String read GetCode write SetCode;
    property Desc :String read GetDesc write SetDesc;
    property IsSubLevel :Boolean read GetIsSubLevel write SetIsSubLevel;
    property Note :String read GetNote write SetNote;
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
  if (FCodeList<>nil) then
    if (FCodeList.IndexOf(sCode)=-1) then
      ModalResult := mrOk
    else MessageDlg(WRN_CREP,mtWarning,[mbOK],0);
end;

function TfrmFactTreeInput.Answer: TRecFactTreeInput;
begin
  if ShowModal=mrOk then begin
    Result.Code := edCode.Text;
    Result.Desc := edDesc.Text;
    Result.Note := edNote.Text;
    Result.IsSubLevel := radIsSubLevel.Checked;
  end else begin
    Result.Code := '';
    Result.Desc := '';
    Result.Note := '';
    Result.IsSubLevel := False;
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

procedure TfrmFactTreeInput.SetDesc(const Val: String);
begin
  edDesc.Text := Val;
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
