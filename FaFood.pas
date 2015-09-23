unit FaFood;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs,
  ActnList, ImgList, ExtCtrls, StdCtrls, Buttons,
  DBCtrls, Mask, Grids, DBGrids, DB, DBClient;

type
  TfraFood = class(TFrame)
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    lbFactDataType: TLabel;
    chkSeqAdd: TCheckBox;
    cboFactDataType: TComboBox;
    tmrSearch: TTimer;
    imgList: TImageList;
    acList: TActionList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    actFactGroup: TAction;
    grSave: TGroupBox;
    lbID: TLabel;
    lbFName: TLabel;
    lbLogin: TLabel;
    edID: TDBEdit;
    edFName: TDBEdit;
    chkUnUsed: TDBCheckBox;
    grdFact: TDBGrid;
    cdsFood: TClientDataSet;
    cdFdTyp: TDBComboBox;
    srcFood: TDataSource;
    grSearch: TGroupBox;
    edSearch: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
