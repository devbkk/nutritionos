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
    srcLupType: TDataSource;
    cdsFoodTyp: TClientDataSet;
    dspFoodTyp: TDataSetProvider;
  private
    { Private declarations }
    FDM :IDataSetX;
    //FLU :IDataLookupX;
  public
    { Public declarations }
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
    //
    //IFraDataX
    procedure Contact;
    procedure DataInterface(const IDat :IDataSetX);    
    function  DataManage :TClientDataSet;
    //
    procedure FocusFirst;
    function IsSqeuenceAppend :Boolean;    
    procedure SetActionEvents(evt :TNotifyEvent);
    procedure SetFoodTypeLookup(var iLup :IDataLookupX); overload;
    procedure SetFoodTypeLookup(const lupDS :TDataSet); overload;
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

function TfraFood.IsSqeuenceAppend: Boolean;
begin
  Result := chkSeqAdd.Checked;
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

procedure TfraFood.SetFoodTypeLookup(const lupDS: TDataSet);
begin
  {srcLupType.DataSet := lupDS;
  lupFdTyp.KeyField  := 'CODE';
  lupFdTyp.ListField := 'LIST'; }

  dspFoodTyp.DataSet := lupDS;
  cdsFoodTyp.Close;
  cdsFoodTyp.SetProvider(dspFoodTyp);
  cdsFoodTyp.Open;
end;

procedure TfraFood.SetFoodTypeLookup(var iLup: IDataLookupX);
begin
  {FLU := iLup;
  if Assigned(FLU) then begin
    srcLupType.DataSet := FLU.LDataSet(eluFoodType);
    lupFdTyp.KeyField  := FLU.KeyField;
    lupFdTyp.ListField := FLU.ListField;
  end;}
  if Assigned(iLup) then begin
    srcLupType.DataSet := iLup.LDataSet(eluFoodType);
    lupFdTyp.KeyField  := iLup.KeyField;
    lupFdTyp.ListField := iLup.ListField;
  end;
end;

end.
