unit FrFoodReqInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, Provider, DB, DBClient, ExtCtrls,
  ShareCommon;

type
  TfrmFoodReqInputter = class(TForm)
    grSearch: TGroupBox;
    radByCode: TRadioButton;
    radByDesc: TRadioButton;
    edSearch: TEdit;
    grd: TDBGrid;
    btnOK: TBitBtn;
    src: TDataSource;
    cds: TClientDataSet;
    dsp: TDataSetProvider;
    tmr: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmrTimer(Sender: TObject);
  private
    { Private declarations }
    procedure InitForm;
    procedure OnSearchFilter(DataSet: TDataSet; var Accept: Boolean);
  public
    { Public declarations }
    //
    function Answer(var p :TRecSearch) :Boolean;
  end;

var
  frmFoodReqInputter: TfrmFoodReqInputter;

implementation

{$R *.dfm}


procedure TfrmFoodReqInputter.FormCreate(Sender: TObject);
begin
  InitForm;
end;

procedure TfrmFoodReqInputter.FormDestroy(Sender: TObject);
begin
  if frmFoodReqInputter = Self then
    frmFoodReqInputter := nil;
end;

procedure TfrmFoodReqInputter.FormClose(
  Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFoodReqInputter.FormShow(Sender: TObject);
begin
//
end;

procedure TfrmFoodReqInputter.edSearchKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  tmr.Enabled := True;
end;

procedure TfrmFoodReqInputter.tmrTimer(Sender: TObject);
begin
  tmr.Enabled := False;
  //
  cds.Filtered := False;
  if edSearch.Text<>'' then
    cds.Filtered := True;
end;

function TfrmFoodReqInputter.Answer(var p: TRecSearch): Boolean;
begin
   //
   Result := False;
   if(p.Ds=nil)or(p.Ds.IsEmpty)then
     Exit;

   //
   {dsp.DataSet := p.DS;
   cds.Close;
   cds.SetProvider(dsp);
   cds.Open;}

   //
   cds.EmptyDataSet;
   p.Ds.First;
   repeat
     cds.Append;
     cds.FieldByName('ACODE').AsString := p.Ds.FieldByName('ACODE').AsString;
     cds.FieldByName('ADESC').AsString := p.Ds.FieldByName('ADESC').AsString;
     cds.Post;
     p.Ds.Next;
   until p.Ds.Eof;
   cds.First;

   //
   if ShowModal=mrOK then begin
     p.ACode := cds.FieldByName('ACODE').AsString;
     p.ADesc := cds.FieldByName('ADESC').AsString;
   end;
   Result := (ModalResult=mrOK);
end;

procedure TfrmFoodReqInputter.InitForm;
begin
  cds.OnFilterRecord := OnSearchFilter;
end;

procedure TfrmFoodReqInputter.OnSearchFilter(
  DataSet: TDataSet; var Accept: Boolean);
var sData,sSrch :String;
begin

  //
  if radByCode.Checked then
    sData := DataSet.FieldByName('ACODE').AsString
  else if radByDesc.Checked then
    sData := DataSet.FieldByName('ADESC').AsString;

  //
  sSrch := edSearch.Text;

  //
  Accept := (Pos(sSrch,sData)=1);

end;

end.
