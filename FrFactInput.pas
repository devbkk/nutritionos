unit FrFactInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, Grids, ValEdit;

type
  TfrmFactInputter = class(TForm)
    pcMain: TPageControl;
    btnOK: TBitBtn;
    tsPlainText: TTabSheet;
    tsFoodFormula: TTabSheet;
    mmNotes: TMemo;
    vlToNotes: TValueListEditor;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FParent :TWinControl;
  public
    { Public declarations }
    procedure Contact;
  end;

var
  frmFactInputter: TfrmFactInputter;

implementation

{$R *.dfm}

procedure TfrmFactInputter.FormCreate(Sender: TObject);
begin
//
end;

procedure TfrmFactInputter.FormDestroy(Sender: TObject);
begin
  if frmFactInputter=Self then
    frmFactInputter := nil;
end;

procedure TfrmFactInputter.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFactInputter.FormShow(Sender: TObject);
begin
//
end;

end.
