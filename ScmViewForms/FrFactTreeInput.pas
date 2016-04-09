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
    //
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure sbOKClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);

  private
    { Private declarations }
    function GetCode :String;
    procedure SetCode(const Val :String);
    //
    function GetDesc :String;
    procedure SetDesc(const Val :String);
  public
    { Public declarations }
    function Answer :TRecFactTreeInput;
    property Code :String read GetCode write SetCode;
    property Desc :String read GetDesc write SetDesc;
  end;

var
  frmFactTreeInput: TfrmFactTreeInput;

implementation

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

procedure TfrmFactTreeInput.sbCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmFactTreeInput.sbOKClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

function TfrmFactTreeInput.Answer: TRecFactTreeInput;
begin
  if ShowModal=mrOk then begin
    Result.Code := edCode.Text;
    Result.Desc := edDesc.Text;
  end else begin
    Result.Code := '';
    Result.Desc := '';
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

procedure TfrmFactTreeInput.SetCode(const Val: String);
begin
  edCode.Text := Val;
end;

procedure TfrmFactTreeInput.SetDesc(const Val: String);
begin
  edDesc.Text := Val;
end;

end.
