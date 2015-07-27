unit FaSysLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Provider, ImgList, ExtCtrls, ActnList, DB, DBClient, StdCtrls,
  Buttons, Grids, DBGrids;

type
  TfraSysLog = class(TFrame)
    grSearch: TGroupBox;
    edSearch: TEdit;
    grdSysLog: TDBGrid;
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    lbFactDataType: TLabel;
    chkSeqAdd: TCheckBox;
    cdsSysLog: TClientDataSet;
    srcSysLog: TDataSource;
    acList: TActionList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    tmrSearch: TTimer;
    imgList: TImageList;
    dspSysLog: TDataSetProvider;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
