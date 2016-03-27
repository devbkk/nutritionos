unit FrFactSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, Buttons, Math,
  ShareInterface, DBCtrls, DB;

type
  IViewFactSelect = Interface(IInterface)
  ['{B0FABA87-C4F4-4361-BF38-9C31C6A67D66}']
    procedure AuthorizeMenu(uType :String);
    procedure Contact;overload;
    procedure Contact(p :String);overload;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    function  IsSelected :Boolean;
  End;

  TfrmFactselect = class(TForm, IViewFactSelect)
    btnOK: TBitBtn;
    gbPatType: TGroupBox;
    gbFoodType: TGroupBox;
    gbFoodRestrict: TGroupBox;
    cboPatType: TComboBox;
    cboFoodTypeL1: TComboBox;
    cboRestrict: TComboBox;
    cboFoodTypeL2: TComboBox;
    cboFoodTypeL3: TComboBox;
    cboFoodTypeL4: TComboBox;
    cboFoodTypeL5: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FParent :TWinControl;
    FDM     :IFact;
    procedure ClearAllSelect;
    procedure SetFactSelectList(p :String);
  public
    { Public declarations }
    procedure AuthorizeMenu(uType :String);
    procedure Contact; overload;
    procedure Contact(p :String);overload;
    procedure DoSetParent(AOwner : TWinControl; AFrame :TFrame=nil);
    function  IsSelected :Boolean;
    //
    procedure DataInterface(const AFact :IFact);
    procedure AppendSelectList(const kname :String; lst :TStrings);
    //
    function PatTypeSelect :TComboBox;
    procedure FactTypeClear(lv :Integer=1);
    function FactTypeSelect(lv :Integer=1) :TComboBox;
    function RestrictSeelect :TComboBox;
    //
    procedure GetReqDesc(var s :String);
    function GetSelectedData :TRecFactSelect;
    procedure SetButtonEvents(evt :TNotifyEvent);
    procedure SetSelectCloseUp(evt :TNotifyEvent);
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

procedure TfrmFactselect.GetReqDesc(var s: String);
//
  function ifselect(const b :Boolean; sTrue, sFalse: String):String;
  begin
    if b then
      Result := sTrue
    else Result := sFalse;
  end;

begin
  s := cboPatType.Text+'>'+
       cboFoodTypeL1.Text+'>'+
       ifselect((cboFoodTypeL2.Text>''),cboFoodTypeL2.Text+'>','')+
       ifselect((cboFoodTypeL3.Text>''),cboFoodTypeL3.Text+'>','')+
       ifselect((cboFoodTypeL4.Text>''),cboFoodTypeL4.Text+'>','');
  //
  s := Copy(s,1,Length(s)-1);
end;

function TfrmFactselect.GetSelectedData: TRecFactSelect;
begin
//
end;

function TfrmFactselect.IsSelected: Boolean;
begin
  Result := (ModalResult=mrOK);
end;

procedure TfrmFactselect.AppendSelectList(
  const kname :String; lst: TStrings);
begin
//
end;

procedure TfrmFactselect.AuthorizeMenu(uType: String);
begin
//
end;

procedure TfrmFactselect.Contact(p: String);
begin
  SetFactSelectList(p);
  Contact;
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

procedure TfrmFactselect.FactTypeClear(lv: Integer);
begin
  //
  if (lv=1) then begin
    cboFoodTypeL2.Items.Clear;
    cboFoodTypeL3.Items.Clear;
    cboFoodTypeL4.Items.Clear;
    //
    cboFoodTypeL2.Text := '';
    cboFoodTypeL3.Text := '';
    cboFoodTypeL4.Text := '';
  end else if (lv=2) then begin
    cboFoodTypeL3.Items.Clear;
    cboFoodTypeL4.Items.Clear;
    //
    cboFoodTypeL3.Text := '';
    cboFoodTypeL4.Text := '';
  end else if (lv=3) then begin
    cboFoodTypeL4.Items.Clear;
    //
    cboFoodTypeL4.Text := '';
  end;
end;

function TfrmFactselect.FactTypeSelect(lv :Integer): TComboBox;
begin
  if lv=1 then
    Result := cboFoodTypeL1
  else if lv=2 then
    Result := cboFoodTypeL2
  else if lv=3 then
    Result := cboFoodTypeL3
  else if lv=4 then
    Result := cboFoodTypeL4
  else if lv=5 then
    Result := cboFoodTypeL5    
  else Result := nil;
end;

function TfrmFactselect.PatTypeSelect: TComboBox;
begin
  Result := cboPatType;
end;

function TfrmFactselect.RestrictSeelect: TComboBox;
begin
  Result := cboRestrict;
end;

procedure TfrmFactselect.SetButtonEvents(evt: TNotifyEvent);
begin
  btnOK.OnClick := evt;
end;

{private}
procedure TfrmFactselect.ClearAllSelect;
begin
  cboPatType.Text := '';
  cboFoodTypeL1.Text := '';
  cboFoodTypeL2.Text := '';
  cboFoodTypeL3.Text := '';
  cboFoodTypeL4.Text := '';
  cboRestrict.Text   := '';
end;

procedure TfrmFactselect.SetFactSelectList(p :String);
var lst :TStrings; i, cnt8, cnt4 :Integer; s :String;

{procedure LoadDatas(
  ds: TDataSet; cb: TComboBox; bFirst: Boolean);
begin
  cb.Items.Clear;
  repeat
    s := TrimRight(ds.FieldByName('CODE').AsString)+':'+
         ds.FieldByName('FDES').AsString;
    s := TrimLeft(TrimRight(s));
    if not(s=':')then
      cb.Items.Append(s);
    ds.Next;
  until(ds.Eof);
  //
  if bFirst then
    cb.ItemIndex := 0;
end;}

begin
//
  if p='' then begin
    ClearAllSelect;
    Exit;
  end;
  //
  lst := TStringList.Create;
  try
    lst.Delimiter := '>';
    lst.StrictDelimiter := True;
    lst.DelimitedText := p;
    //
    cnt4 := 0; cnt8 := 0;
    for i := 0 to lst.Count - 1 do begin
      s := Copy(lst[i],1,Pos(':',lst[i])-1);
      if length(s)=8 then begin
        case cnt8 of
          0 : cboPatType.Text := lst[i];
          1 : begin
            case cnt4 of
              1 : cboFoodTypeL2.Text := lst[i];
              2 : cboFoodTypeL3.Text := lst[i];
              3 : cboFoodTypeL4.Text := lst[i];
              4 : cboFoodTypeL5.Text := lst[i];
            end;
          end;
          //2 : cboRestrict.Text := lst[i];
        end;
        Inc(cnt8);
      end else if length(s)=4 then begin
        case cnt4 of
          0 : cboFoodTypeL1.Text := lst[i];
          1 : cboFoodTypeL2.Text := lst[i];
          2 : cboFoodTypeL3.Text := lst[i];
          3 : cboFoodTypeL4.Text := lst[i];
          4 : cboFoodTypeL5.Text := lst[i];          
        end;
        Inc(cnt4);
      end;
    end;

  finally
    lst.Free;
  end;
end;

procedure TfrmFactselect.SetSelectCloseUp(evt: TNotifyEvent);
begin
  cboPatType.OnCloseUp    := evt;
  //
  cboFoodTypeL1.OnCloseUp := evt;
  cboFoodTypeL2.OnCloseUp := evt;
  cboFoodTypeL3.OnCloseUp := evt;
  cboFoodTypeL4.OnCloseUp := evt;
  cboFoodTypeL5.OnCloseUp := evt;
  //
  cboRestrict.OnCloseUp   := evt;
end;

end.
