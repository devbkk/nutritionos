unit FaFoodMenu;

interface

uses
  Classes, ActnList, ImgList, Controls, StdCtrls, Mask, DBCtrls, Buttons,
  ExtCtrls, Forms, DB, DBClient,
  ShareInterface, Provider;

type
  TfraFoodMenu = class(TFrame, IFraDataX)
    grSearch: TGroupBox;
    edSearch: TEdit;
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    lbFactDataType: TLabel;
    chkSeqAdd: TCheckBox;
    cboFactDataType: TComboBox;
    lstFood: TListBox;
    grSave: TGroupBox;
    lbID: TLabel;
    lbFName: TLabel;
    edID: TDBEdit;
    edFName: TDBEdit;
    pnlSelecct: TPanel;
    lstMenuItems: TListBox;
    imgList: TImageList;
    acList: TActionList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    actFactGroup: TAction;
    spbPrev: TSpeedButton;
    spbNext: TSpeedButton;
    dspFoodMenu: TDataSetProvider;
    cdsFoodMenu: TClientDataSet;
    srcFoodMenu: TDataSource;
    actMenuItemAdd: TAction;
    actMenuItemDel: TAction;
    lbDesc: TLabel;
    btnMenuItemAdd: TBitBtn;
    btnMenuItemDel: TBitBtn;
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
    //
    procedure FocusFirst;
    function IsSqeuenceAppend :Boolean;    
    procedure SetActionEvents(evt :TNotifyEvent);
    procedure SetFoodList(pList :TStrings);
    //
    procedure FoodToMenuItem;
    procedure MenuItemToFood;
  end;

implementation

{$R *.dfm}

{ TfraFoodMenu }

constructor TfraFoodMenu.Create(AOwner: TComponent);
begin
  inherited;
//
end;

destructor TfraFoodMenu.Destroy;
begin
//
  inherited;
end;

procedure TfraFoodMenu.FocusFirst;
begin
  if edID.CanFocus then
    edId.SetFocus;
end;

procedure TfraFoodMenu.FoodToMenuItem;
begin
  if lstFood.Count<=0 then
    Exit;
  lstMenuItems.Items.Append(lstFood.Items[lstFood.ItemIndex]);
end;

procedure TfraFoodMenu.Contact;
begin
  dspFoodMenu.DataSet := FDM.XDataSet;
  cdsFoodMenu.Close;
  cdsFoodMenu.SetProvider(dspFoodMenu);
  cdsFoodMenu.Open;
end;

procedure TfraFoodMenu.DataInterface(const IDat: IDataSetX);
begin
  FDM := IDat;
end;

function TfraFoodMenu.DataManage: TClientDataSet;
begin
  Result := cdsFoodMenu;
end;

function TfraFoodMenu.IsSqeuenceAppend: Boolean;
begin
  Result := chkSeqAdd.Checked;
end;

procedure TfraFoodMenu.MenuItemToFood;
begin
  if lstMenuItems.Count<=0 then
    Exit;
  lstFood.Items.Append(lstMenuItems.Items[lstMenuItems.ItemIndex]);

end;

procedure TfraFoodMenu.SetActionEvents(evt: TNotifyEvent);
begin
  actAddWrite.OnExecute := evt;
  actDelCanc.OnExecute  := evt;
  //
  actMenuItemAdd.OnExecute := evt;
  actMenuItemDel.OnExecute := evt;
end;

procedure TfraFoodMenu.SetFoodList(pList: TStrings);
begin
  lstFood.Clear;
  lstFood.Items := pList;
end;

end.
