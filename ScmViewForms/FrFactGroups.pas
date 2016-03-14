unit FrFactGroups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, ImgList,
  ActnList, DB, Provider, DBClient;

type
  TfrmFoodGroups = class(TForm)
    pcMain: TPageControl;
    tsInput: TTabSheet;
    tsSelect: TTabSheet;
    grSearch: TGroupBox;
    edSearch: TEdit;
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbtAddWrite: TSpeedButton;
    lbPatient: TLabel;
    sbtNext: TSpeedButton;
    sbtPrev: TSpeedButton;
    chkPatSeqAdd: TCheckBox;
    acList: TActionList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    actNext: TAction;
    actPrev: TAction;
    imgList: TImageList;
    grdFactGrps: TDBGrid;
    cdsFactGrps: TClientDataSet;
    dspFactGrps: TDataSetProvider;
    srcFactGrps: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFoodGroups: TfrmFoodGroups;

implementation

{$R *.dfm}

end.
