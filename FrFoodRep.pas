unit FrFoodRep;

interface

uses
  frxClass, StdCtrls, Buttons, Controls, ExtCtrls, Classes, Forms;

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
    procedure bbtPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFoodRep: TfrmFoodRep;

implementation

{$R *.dfm}

procedure TfrmFoodRep.bbtPrintClick(Sender: TObject);
begin
  frxReport1.ShowReport();
end;

end.
