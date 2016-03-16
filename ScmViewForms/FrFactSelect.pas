unit FrFactGroupsInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, Buttons,
  ShareInterface;

type
  IViewFactGroupsInput = Interface(IInterface)
  ['{B0FABA87-C4F4-4361-BF38-9C31C6A67D66}']
    procedure AuthorizeMenu(uType :String);
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
  End;

  TfrmFactGroupsInput = class(TForm, IViewFactGroupsInput)
    btnOK: TBitBtn;
    vlToNotes: TValueListEditor;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FParent :TWinControl;
    FDM     :IFoodGroupsDataX;
  public
    { Public declarations }
    procedure AuthorizeMenu(uType :String);
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    //
    procedure DataInterface(const AFact :IFoodGroupsDataX);
  end;

var
  frmFactGroupsInput: TfrmFactGroupsInput;

implementation

{$R *.dfm}

procedure TfrmFactGroupsInput.FormCreate(Sender: TObject);
begin
//
end;

procedure TfrmFactGroupsInput.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfrmFactGroupsInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//
end;

procedure TfrmFactGroupsInput.FormShow(Sender: TObject);
begin
//
end;

procedure TfrmFactGroupsInput.AuthorizeMenu(uType: String);
begin
//
end;

procedure TfrmFactGroupsInput.Contact;
begin
//
end;

procedure TfrmFactGroupsInput.DataInterface(const AFact: IFoodGroupsDataX);
begin
  FDM := AFact;
end;

procedure TfrmFactGroupsInput.DoSetParent(AOwner: TWinControl; AFrame: TFrame);
begin
  FParent := AOwner;
end;

end.
