unit FrFactSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, Buttons, Math, DBCtrls, DB, StrUtils,
  ShareInterface;

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
    gbNote: TGroupBox;
    edNote: TEdit;
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
    procedure GetNote(var s :String);
    procedure GetReqDesc(var s :String);
    procedure GetReqDet(var p :TRecFactSelect);
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

procedure TfrmFactselect.GetNote(var s: String);
begin
  s := edNote.Text;
end;

procedure TfrmFactselect.GetReqDesc(var s: String);
begin
  s := cboPatType.Text+W_DELIM+
       cboFoodTypeL1.Text+W_DELIM+
       ifthen((cboFoodTypeL2.Text>''),cboFoodTypeL2.Text+W_DELIM)+
       ifthen((cboFoodTypeL3.Text>''),cboFoodTypeL3.Text+W_DELIM)+
       ifthen((cboFoodTypeL4.Text>''),cboFoodTypeL4.Text+W_DELIM)+
       ifthen((cboFoodTypeL5.Text>''),cboFoodTypeL5.Text+W_DELIM)+
       ifthen((cboRestrict.Text>''),cboRestrict.Text+W_DELIM)+
       ifthen(edNote.Text>'','freetext='+edNote.Text+W_DELIM);
  //
  s := Copy(s,1,Length(s)-1);
end;

procedure TfrmFactselect.GetReqDet(var p: TRecFactSelect);
begin
  GetReqDesc(p.reqdesc);
  p.note := edNote.Text;
end;

function TfrmFactselect.GetSelectedData: TRecFactSelect;
var snd :TRecFactSelect;
//
function ExtractCode(s :String):String;
begin
  Result := Copy(s,1,Pos('=',s)-1);
end;
//
begin
  snd.pattype   := ExtractCode(cboPatType.Text);
  snd.foodprop1 := ExtractCode(cboFoodTypeL1.Text);
  snd.foodprop2 := ExtractCode(cboFoodTypeL2.Text);
  snd.foodprop3 := ExtractCode(cboFoodTypeL3.Text);
  snd.foodprop4 := ExtractCode(cboFoodTypeL4.Text);
  snd.foodprop5 := ExtractCode(cboFoodTypeL5.Text);
  snd.restrict  := ExtractCode(cboRestrict.Text);
  snd.note      := edNote.Text;
  GetReqDesc(snd.reqdesc);
  //
  Result := snd;
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
  ClearAllSelect;
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
    cboFoodTypeL5.Items.Clear;
    //
    cboFoodTypeL2.Text := '';
    cboFoodTypeL3.Text := '';
    cboFoodTypeL4.Text := '';
    cboFoodTypeL5.Text := '';
  end else if (lv=2) then begin
    cboFoodTypeL3.Items.Clear;
    cboFoodTypeL4.Items.Clear;
    cboFoodTypeL5.Items.Clear;
    //
    cboFoodTypeL3.Text := '';
    cboFoodTypeL4.Text := '';
    cboFoodTypeL5.Text := '';
  end else if (lv=3) then begin
    cboFoodTypeL4.Items.Clear;
    cboFoodTypeL5.Items.Clear;
    //
    cboFoodTypeL4.Text := '';
    cboFoodTypeL5.Text := '';
  end else if (lv=4) then begin
    cboFoodTypeL5.Items.Clear;
    //
    cboFoodTypeL5.Text := '';
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
  cboPatType.Text    := '';
  cboFoodTypeL1.Text := '';
  cboFoodTypeL2.Text := '';
  cboFoodTypeL3.Text := '';
  cboFoodTypeL4.Text := '';
  cboFoodTypeL5.Text := '';
  cboRestrict.Text   := '';
  edNote.Text        := '';
end;

procedure TfrmFactselect.SetFactSelectList(p :String);
var lst :TStrings; i, cnt :Integer; s :String;
begin
  //
  if p='' then begin
    ClearAllSelect;
    Exit;
  end;
  //
  lst := TStringList.Create;
  try
    try
      lst.Delimiter := W_DELIM;
      lst.StrictDelimiter := True;
      lst.DelimitedText := p;
    except
      on E : Exception do
        ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
    end;
    //
    cnt := 0; 
    for i := 0 to lst.Count - 1 do begin
      s := Copy(lst[i],1,Pos(C_DELIM,lst[i])-1);
      //
      if s='freetext' then begin
        edNote.Text := Copy(lst[i],Pos(C_DELIM,lst[i])+1,Length(lst[i]));
      end else begin
        //
        if Copy(s,1,4)='0001' then
          cboPatType.Text := lst[i]
        else if Copy(s,1,4)='0003' then
          cboRestrict.Text := lst[i]
        else begin
          Inc(cnt);
          case cnt of
          1 : cboFoodTypeL1.Text := lst[i];
          2 : cboFoodTypeL2.Text := lst[i];
          3 : cboFoodTypeL3.Text := lst[i];
          4 : cboFoodTypeL4.Text := lst[i];
          5 : cboFoodTypeL5.Text := lst[i];
          end;
        end;
      end;
    end;
  //
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
