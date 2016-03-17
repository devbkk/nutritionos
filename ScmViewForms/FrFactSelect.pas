unit FrFactSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, Buttons,
  ShareInterface;

type
  IViewFactSelect = Interface(IInterface)
  ['{B0FABA87-C4F4-4361-BF38-9C31C6A67D66}']
    procedure AuthorizeMenu(uType :String);
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
  End;

  TfrmFactselect = class(TForm, IViewFactSelect)
    btnOK: TBitBtn;
    vlFacts: TValueListEditor;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure vlFactsStringsChange(Sender: TObject);
  private
    { Private declarations }
    FParent :TWinControl;
    FDM     :IFact;
  public
    { Public declarations }
    procedure AuthorizeMenu(uType :String);
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    //
    procedure DataInterface(const AFact :IFact);
    procedure AppendSelectList(const kname :String; lst :TStrings);
  end;

var
  frmFactselect: TfrmFactselect;

implementation

{$R *.dfm}

procedure TfrmFactselect.FormCreate(Sender: TObject);
begin
//
end;

procedure TfrmFactselect.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfrmFactselect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//
end;

procedure TfrmFactselect.FormShow(Sender: TObject);
begin
//
end;

procedure TfrmFactselect.vlFactsStringsChange(Sender: TObject);
var valSel :TItemProp;
begin
  if Self.Showing then begin
    //ShowMessage(vlFacts.Cells[vlFacts.Col-1,vlFacts.Row]);
    //
    valSel := TItemProp.Create(vlFacts);
    valSel.EditStyle := esPickList;
    //
    valSel.PickList.Append('test');
    valSel.PickList.Append('test2');
    //
    vlFacts.InsertRow('test','',True);
    vlFacts.ItemProps[1] := valSel;
  end;

end;

procedure TfrmFactselect.AppendSelectList(
  const kname :String; lst: TStrings);
var valSel :TItemProp; idx :Integer;
begin
  if lst.Count=0 then
    Exit;
  valSel := TItemProp.Create(vlFacts);
  valSel.EditStyle := esPickList;
  valSel.PickList := lst;
  //
  idx := vlFacts.RowCount-2;
  //
  vlFacts.InsertRow(kname,lst[0],True);
  vlFacts.ItemProps[idx] := valSel;


end;

procedure TfrmFactselect.AuthorizeMenu(uType: String);
begin
//
end;

procedure TfrmFactselect.Contact;
begin
  ShowModal;
end;

procedure TfrmFactselect.DataInterface(const AFact: IFact);
begin
  FDM := AFact;
end;

procedure TfrmFactselect.DoSetParent(AOwner: TWinControl; AFrame: TFrame);
begin
  FParent := AOwner;
end;

end.
