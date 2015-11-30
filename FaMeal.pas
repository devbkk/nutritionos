unit FaMeal;

interface

uses
  {Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions,
  Vcl.ActnList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Classes, ActnList, ImgList, Controls, StdCtrls, Mask, DBCtrls,
  Buttons, ExtCtrls,} Classes, ActnList, ImgList, Controls, StdCtrls, Mask, DBCtrls,
  Buttons, ExtCtrls, Forms;

type
  TfraMeal = class(TFrame)
    grSearch: TGroupBox;
    edSearch: TEdit;
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    lbFactDataType: TLabel;
    chkSeqAdd: TCheckBox;
    cboFactDataType: TComboBox;
    ListBox1: TListBox;
    grSave: TGroupBox;
    lbID: TLabel;
    lbFName: TLabel;
    edID: TDBEdit;
    edFName: TDBEdit;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    ListBox2: TListBox;
    imgList: TImageList;
    acList: TActionList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    actFactGroup: TAction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
