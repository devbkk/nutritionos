unit FrFactInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, Grids, ValEdit, UxTheme,
  ShareInterface;

type
  TfrmFactInputter = class(TForm)
    pcMain: TPageControl;
    btnOK: TBitBtn;
    //
    tsPlainText: TTabSheet;
    mmNotes: TMemo;    
    //
    tsFoodFormula: TTabSheet;
    vlToNotes: TValueListEditor;
    //
    tsDateTime: TTabSheet;
    mcSelDate: TMonthCalendar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    FParent :TWinControl;
    function  ConCatValueList :String;
    procedure SetMonthCalendar;
    procedure ShowInputter(const p :TRecCaptionTmpl);
    procedure ShowInputterMemo(curText:String);
    procedure ShowInputterValList(curText, caption :String);
  public
    { Public declarations }
    function Answer(var p:TRecCaptionTmpl):Boolean;
    procedure Contact;
    procedure Start;
  end;

var
  frmFactInputter: TfrmFactInputter;

implementation

{$R *.dfm}

procedure TfrmFactInputter.FormCreate(Sender: TObject);
begin
  Start;
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

procedure TfrmFactInputter.btnOKClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

{public}
function TfrmFactInputter.Answer(var p:TRecCaptionTmpl):Boolean;
begin
   ShowInputter(p);
   if ShowModal=mrOK then begin
     //
     if tsPlainText.TabVisible then
       p.CurrentText := mmNotes.Lines.Text;
     //
     if tsFoodFormula.TabVisible then
       p.CurrentText := ConCatValueList;
     //
     if tsDateTime.TabVisible then
       p.Dt := mcSelDate.Date;
   end;
   Result := (ModalResult=mrOK);
end;

procedure TfrmFactInputter.Contact;
begin
  if assigned(FParent) then begin
    Self.Align := alClient;
    Self.ManualDock(FParent);
    Self.Show;
  end else ShowModal;
end;

procedure TfrmFactInputter.Start;
begin
  mmNotes.Lines.Text := '';
  //
  SetMonthCalendar;
end;

{private}
function TfrmFactInputter.ConCatValueList: String;
var s :String; i :Integer;
begin
  for i := 1 to vlToNotes.RowCount - 1 do begin
    s := s+vlToNotes.Cells[1,i]+'|';
  end;
  s := Copy(s,1,Length(s)-1);
  Result := s;
end;

procedure TfrmFactInputter.SetMonthCalendar;
begin
  {exmple to set scale by
   SetWindowTheme(MonthCalendar1.Handle, '', '');
   MonthCalendar1.ScaleBy(190, 100);
   MonthCalendar1.Width := MonthCalendar1.Width + 1;
   MonthCalendar1.Width := MonthCalendar1.Width - 1;}
   
  //SetwindowTheme
  mcSelDate.Date  := Now;
  SetWindowTheme(mcSelDate.Handle, '', '');
  mcSelDate.ScaleBy(120,100);
end;

procedure TfrmFactInputter.ShowInputter(const p: TRecCaptionTmpl);
begin
  tsPlainText.TabVisible   := (p.GroupCode<>'01')and not p.IsSetDateTime;
  tsFoodFormula.TabVisible := (p.GroupCode='01')and not p.IsSetDateTime;
  tsDateTime.TabVisible    := (p.IsSetDateTime);
  //
  if tsPlainText.TabVisible then
    ShowInputterMemo(p.CurrentText);
  //
  if tsFoodFormula.TabVisible then
    ShowInputterValList(p.CurrentText,p.Caption);
end;

procedure TfrmFactInputter.ShowInputterMemo(curText: String);
begin
  //
  if tsPlainText.TabVisible then
    mmNotes.Lines.Text := curText;
end;

procedure TfrmFactInputter.ShowInputterValList(curText, caption: String);
var slCap, slVal :TStrings; i :Integer;

//internal procedure
procedure GetList(s:TStrings; Txt :String);
begin
  s.Delimiter     := '|';
  s.DelimitedText := Txt;
end;

const ERR_INVALID_FORMULA = 'ตั้งค่าตำรับสูตรไม่ถูกต้อง';

begin
  slCap := TStringList.Create;
  slVal := TStringList.Create;
  try
    GetList(slCap,caption);
    GetList(slVal,curText);
    //
    if slCap.Count<>slVal.Count then
      Exception.Create(ERR_INVALID_FORMULA);

    for i := 0 to slCap.Count - 1 do begin
      vlToNotes.InsertRow(slCap[i],slVal[i],True);
    end;
    vlToNotes.Invalidate;
  finally
    slCap.Free;
    slVal.Free;
  end;
end;

end.
