unit FrFoodReq;

interface

uses
  DB, DBClient, ImgList, Controls, Classes, ActnList, Grids, DBGrids,
  StdCtrls, ExtCtrls, DBCtrls, Mask, Buttons, Forms;

type
  TfrmFoodReq = class(TForm)
    grSearch: TGroupBox;
    edSearch: TEdit;
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    lbFactDataType: TLabel;
    chkSeqAdd: TCheckBox;
    cboFactDataType: TComboBox;
    acList: TActionList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    actFactGroup: TAction;
    imgList: TImageList;
    grSave: TGroupBox;
    lbID: TLabel;
    lbName: TLabel;
    lbAN: TLabel;
    lbAge: TLabel;
    lbGender: TLabel;
    lbDiag: TLabel;
    edHN: TDBEdit;
    edName: TDBEdit;
    edAN: TDBEdit;
    edAge: TDBEdit;
    rdgGender: TDBRadioGroup;
    edDiag: TDBEdit;
    grdFact: TDBGrid;
    btnSearch: TButton;
    lbYr: TLabel;
    lbHeight: TLabel;
    edHeight: TDBEdit;
    lbWeight: TLabel;
    edWeight: TDBEdit;
    Label4: TLabel;
    edFoodType: TDBEdit;
    lbAmtAM: TLabel;
    edAmtAM: TDBEdit;
    lbAmtPM: TLabel;
    edAmtPM: TDBEdit;
    cdsFdReqDet: TClientDataSet;
    srcReqDet: TDataSource;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFoodReq: TfrmFoodReq;

implementation

{$R *.dfm}

end.
