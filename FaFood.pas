unit FaFood;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions,
  Vcl.ActnList, Vcl.ImgList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.DBCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Data.DB, Datasnap.DBClient;

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
