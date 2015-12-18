unit FrHcSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, Provider, DB, DBClient, Grids, DBGrids, ImgList,
  Buttons, ExtCtrls;

type
  TfrmHcSearch = class(TForm)
    edSearch: TEdit;
    pnlButtons: TPanel;
    sbExcit: TSpeedButton;
    sbOK: TSpeedButton;
    lbFactDataType: TLabel;
    actList: TActionList;
    imgList: TImageList;
    grdHcDat: TDBGrid;
    cdsHcDat: TClientDataSet;
    srcHcDat: TDataSource;
    dspHcDat: TDataSetProvider;
    actSelect: TAction;
    actExit: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Contact;
    procedure DataInterface(const IDat :IDataSetX);
    //function DataManFoodReq :TClientDataSet;
  end;

var
  frmHcSearch: TfrmHcSearch;

implementation

{$R *.dfm}

procedure TfrmHcSearch.FormCreate(Sender: TObject);
begin
//
end;

procedure TfrmHcSearch.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfrmHcSearch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmHcSearch.FormShow(Sender: TObject);
begin
//
end;

procedure TfrmHcSearch.Contact;
begin

end;

procedure TfrmHcSearch.DataInterface(const IDat: IDataSetX);
begin

end;

end.
