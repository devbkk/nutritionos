unit FrFoodReq;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ImgList, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask,
  Vcl.Grids, Vcl.DBGrids, Data.DB, Datasnap.DBClient;

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
    lbFName: TLabel;
    lbLName: TLabel;
    lbLogin: TLabel;
    lbGender: TLabel;
    lbEmail: TLabel;
    edID: TDBEdit;
    edFName: TDBEdit;
    edLName: TDBEdit;
    edLogin: TDBEdit;
    rdgGender: TDBRadioGroup;
    edEmail: TDBEdit;
    grdFact: TDBGrid;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    Label6: TLabel;
    DBEdit5: TDBEdit;
    cdsFdReqDet: TClientDataSet;
    srcReqDet: TDataSource;
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
