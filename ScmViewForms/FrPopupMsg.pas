unit FrPopupMsg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShareCommon, ShareMethod;

type
  TfrmPopupMessage = class(TForm)
    lbTitle: TLabel;
    rdgSelect: TRadioGroup;
    btnOK: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Answer :String;
    procedure SetTitle(const t :String);
    procedure SetSelects(sl :TStrings);
  end;

var
  frmPopupMessage: TfrmPopupMessage;

function PopMessage(const Title :String; Choose :Variant) :String;


implementation


{$R *.dfm}

function PopMessage(const Title :String; Choose :Variant) :String;
begin
  frmPopupMessage := TfrmPopupMessage.Create(nil);
  frmPopupMessage.SetTitle(Title);
  frmPopupMessage.SetSelects(ArrayVariantToStringList(Choose));
  Result := frmPopupMessage.Answer;
end;

procedure TfrmPopupMessage.FormCreate(Sender: TObject);
begin
//
end;

procedure TfrmPopupMessage.FormDestroy(Sender: TObject);
begin
  if frmPopupMessage=Self then
    frmPopupMessage := nil;
end;

procedure TfrmPopupMessage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmPopupMessage.FormShow(Sender: TObject);
begin
//
end;

{public}

function TfrmPopupMessage.Answer: String;
begin
  if (ShowModal=mrOK) then begin
    case rdgSelect.ItemIndex of
      0 : Result := C_ReqEndType_NPO;
      1 : Result := C_ReqEndType_GHM;
      2 : Result := '';
    end;
  end;
end;

procedure TfrmPopupMessage.SetSelects(sl: TStrings);
begin
  if sl.Count=0 then
    Exit;
  //
  rdgSelect.Items     := sl;
  rdgSelect.Columns   := sl.Count;
  rdgSelect.ItemIndex := 0;
end;

procedure TfrmPopupMessage.SetTitle(const t: String);
begin
  lbTitle.Caption := t;
end;

end.
