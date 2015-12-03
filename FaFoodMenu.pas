unit FaFoodMenu;

interface

uses
  Classes, ActnList, ImgList, Controls, StdCtrls, Mask,
  Dialogs, DBCtrls, Buttons, ExtCtrls, Forms, DB, DBClient,
  Provider, SysUtils,
  ShareInterface;

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
    actMenuItemSel: TAction;
    actNext: TAction;
    actPrev: TAction;
    procedure lstFoodClick(Sender: TObject);
    procedure lstFoodMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    FDM :IDataSetX;
    procedure MergeActions;
  public
    { Public declarations }
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
    //
    procedure Contact;
    procedure DataInterface(const IDat :IDataSetX);
    function  DataManage :TClientDataSet;
    //
    function IsSqeuenceAppend :Boolean;
    procedure FocusFirst;
    procedure ClearFoodMenuItems;
    procedure SetActionEvents(evt :TNotifyEvent);
    procedure SetFoodMenuDataChanged(evt :TDataChangeEvent);
    procedure SetFoodList(pList :TStrings);
    procedure SetFoodMenuItems(pList :TStrings);
    //
    procedure FoodToMenuItem;
    procedure MenuItemToFood;
    //
    function FMnuItems :TStrings;
    function FoodItems :TStrings;
    procedure CheckEnableBeforeSelect;
    procedure EnableAddItem(const b :Boolean);
    //
    function CurrentMenuID :String;
  end;

implementation

{$R *.dfm}

{ TfraFoodMenu }

constructor TfraFoodMenu.Create(AOwner: TComponent);
begin
  inherited;
  MergeActions;
end;

destructor TfraFoodMenu.Destroy;
begin
//
  inherited;
end;

procedure TfraFoodMenu.lstFoodClick(Sender: TObject);
begin
  CheckEnableBeforeSelect;
end;

procedure TfraFoodMenu.lstFoodMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  CheckEnableBeforeSelect;
end;

function TfraFoodMenu.CurrentMenuID: String;
begin
  Result := cdsFoodMenu.FieldByName('MNUID').AsString;
end;

procedure TfraFoodMenu.EnableAddItem(const b: Boolean);
begin
  actMenuItemAdd.Enabled := b;
end;

function TfraFoodMenu.FMnuItems: TStrings;
begin
  Result := lstMenuItems.Items;
end;

procedure TfraFoodMenu.FocusFirst;
begin
  if edID.CanFocus then
    edId.SetFocus;
end;

function TfraFoodMenu.FoodItems: TStrings;
begin
  Result := lstFood.Items;
end;

procedure TfraFoodMenu.FoodToMenuItem;
begin
  if(lstFood.Count<=0)or(lstFood.ItemIndex=-1)then
    Exit;
  lstMenuItems.Items.Append(lstFood.Items[lstFood.ItemIndex]);
  CheckEnableBeforeSelect;
end;

procedure TfraFoodMenu.CheckEnableBeforeSelect;
var s :String;
begin
  if lstFood.ItemIndex=-1 then
    Exit;
  s := lstFood.Items[lstFood.ItemIndex];
  actMenuItemAdd.Enabled := (lstMenuItems.Items.Indexof(s)=-1);
end;

procedure TfraFoodMenu.ClearFoodMenuItems;
begin
  lstMenuItems.Clear;
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
  if(lstMenuItems.Count<=0)or(lstMenuItems.ItemIndex=-1)then
    Exit;
  //lstFood.Items.Append(lstMenuItems.Items[lstMenuItems.ItemIndex]);
  lstMenuItems.DeleteSelected;
  CheckEnableBeforeSelect;  
end;

procedure TfraFoodMenu.SetActionEvents(evt: TNotifyEvent);
begin
  actAddWrite.OnExecute := evt;
  actDelCanc.OnExecute  := evt;
  actNext.OnExecute := evt;
  actPrev.OnExecute := evt;
  //
  actMenuItemAdd.OnExecute := evt;
  actMenuItemDel.OnExecute := evt;
  actMenuItemSel.OnExecute := evt;
end;

procedure TfraFoodMenu.SetFoodList(pList: TStrings);
begin
  lstFood.Clear;
  lstFood.Items := pList;
end;

procedure TfraFoodMenu.SetFoodMenuDataChanged(evt: TDataChangeEvent);
begin
  srcFoodMenu.OnDataChange := evt;
end;

procedure TfraFoodMenu.SetFoodMenuItems(pList: TStrings);
begin
  lstMenuItems.Clear;
  lstMenuItems.Items := pList;
end;

procedure TfraFoodMenu.MergeActions;
begin
  lstFood.OnClick := actMenuItemSel.OnExecute;
end;

end.
