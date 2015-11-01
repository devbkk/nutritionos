unit FaFood;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs,
  ActnList, ImgList, ExtCtrls, StdCtrls, Buttons,
  DBCtrls, Mask, Grids, DBGrids, DB, DBClient,
  ShareInterface, Provider;

type
  TfraFood = class(TFrame, IFraDataX)
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
    edFdID: TDBEdit;
    edFdName: TDBEdit;
    chkUnUsed: TDBCheckBox;
    grdFood: TDBGrid;
    cdsFood: TClientDataSet;
    srcFood: TDataSource;
    grSearch: TGroupBox;
    edSearch: TEdit;
    dspFood: TDataSetProvider;
    lupFdTyp: TDBLookupComboBox;
  private
    { Private declarations }
    FDM :IDataSetX;
  public
    { Public declarations }
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
    //
    procedure Contact;
    procedure DataInterface(const IDat :IDataSetX);    
    function  DataManage :TClientDataSet;
    procedure FocusFirst;
    procedure SetActionEvents(evt :TNotifyEvent);     
  end;

implementation

{$R *.dfm}

{ TfraFood }

constructor TfraFood.Create(AOwner: TComponent);
begin
  inherited;
  //
end;

destructor TfraFood.Destroy;
begin
   //
  inherited;
end;

procedure TfraFood.FocusFirst;
//var fld :TField;
begin
  {fld := cdsFood.FindField('FDID');
  if fld<>nil then begin
    grdFood.SetFocus;
    grdFood.SelectedField := fld;
  end;}

  if edFdID.CanFocus then
    edFdID.SetFocus;
end;

procedure TfraFood.DataInterface(const IDat: IDataSetX);
begin
  FDM := IDat;
end;

procedure TfraFood.Contact;
begin
  dspFood.DataSet := FDM.XDataSet;
  cdsFood.Close;
  cdsFood.SetProvider(dspFood);
  cdsFood.Open;
end;

function TfraFood.DataManage: TClientDataSet;
begin
  Result := cdsFood;
end;

procedure TfraFood.SetActionEvents(evt: TNotifyEvent);
begin
  actAddWrite.OnExecute := evt;
  actDelCanc.OnExecute  := evt;
  actFactGroup.OnExecute := evt;
end;

end.
