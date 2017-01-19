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
    radByFName: TRadioButton;
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
  private
    { Private declarations }
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
//
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

function TfrmFoodReqInputter.Answer(var p: TRecSearch): Boolean;
begin
   //
   Result := False;
   if(p.Ds=nil)or(p.Ds.IsEmpty)then
     Exit;

   //
   dsp.DataSet := p.DS;
   if ShowModal=mrOK then begin
     p.ACode := cds.FieldByName('ACODE').AsString;
     p.ADesc := cds.FieldByName('ADESC').AsString;
   end;
   Result := (ModalResult=mrOK);
end;

end.
