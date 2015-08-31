unit FrFoodPrep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Data.DB, Datasnap.DBClient, Vcl.Menus;

type
  TfrmFoodPrep = class(TForm)
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    lbFactDataType: TLabel;
    chkSeqAdd: TCheckBox;
    cboFactDataType: TComboBox;
    grdFdPrep: TDBGrid;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    grdFdPrepDet: TDBGrid;
    cdsFdPrep: TClientDataSet;
    srcFdPrep: TDataSource;
    srcFdPrepDet: TDataSource;
    cdsFdPrepDet: TClientDataSet;
    pmuFdPrepDet: TPopupMenu;
    mnuFdPrepDetDchg: TMenuItem;
    mnuSlipDiet: TMenuItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFoodPrep: TfrmFoodPrep;

implementation

{$R *.dfm}

end.
