unit FrFoodRep;

interface

uses
  frxClass, StdCtrls, Buttons, Controls, ExtCtrls, Classes, Forms, frxDBSet, DB,
  DBClient, DmFoodRep, Provider;

type
  TfrmFoodRep = class(TForm)
    grSearch: TGroupBox;
    edSearch: TEdit;
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    lbFactDataType: TLabel;
    chkSeqAdd: TCheckBox;
    cboFactDataType: TComboBox;
    ListBox1: TListBox;
    bbtPrint: TBitBtn;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    cdsRep: TClientDataSet;
    dspFoodReq: TDataSetProvider;
    procedure bbtPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FDM : TDmoFoodRep;
  public
    { Public declarations }
  end;

var
  frmFoodRep: TfrmFoodRep;

implementation

{$R *.dfm}

procedure TfrmFoodRep.FormCreate(Sender: TObject);
begin
  FDM := TDmoFoodRep.Create(Self);
end;

procedure TfrmFoodRep.bbtPrintClick(Sender: TObject);
begin
  dspFoodReq.DataSet := FDM.GetReportData;
  cdsRep.Close;
  cdsRep.SetProvider(dspFoodReq);
  cdsRep.Open;
  //
  frxReport1.ShowReport();
end;

end.
