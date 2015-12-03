unit FaMeal;

interface

uses
  Classes, ActnList, ImgList, Controls, StdCtrls, Mask, DBCtrls,
  Buttons, ExtCtrls, Forms, Provider, DB, DBClient,
  ShareInterface;

type
  TfraMeal = class(TFrame, IFraDataX)
    grSearch: TGroupBox;
    edSearch: TEdit;
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    lbFactDataType: TLabel;
    chkSeqAdd: TCheckBox;
    cboFactDataType: TComboBox;
    lstMenu: TListBox;
    grSave: TGroupBox;
    lbID: TLabel;
    lbFName: TLabel;
    edID: TDBEdit;
    edName: TDBEdit;
    pnlSelect: TPanel;
    lstMealItems: TListBox;
    cdsMeal: TClientDataSet;
    srcMeal: TDataSource;
    dspMeal: TDataSetProvider;
    acList: TActionList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    actFactGroup: TAction;
    actMealItemAdd: TAction;
    actMealItemDel: TAction;
    actMealItemSel: TAction;
    actNext: TAction;
    actPrev: TAction;
    imgList: TImageList;
    btnMenuItemAdd: TBitBtn;
    btnMenuItemDel: TBitBtn;
    lbDesc: TLabel;
    spbPrev: TSpeedButton;
    spbNext: TSpeedButton;
    procedure lstMenuMouseDown(Sender: TObject; Button: TMouseButton;
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
    procedure ClearMealItems;
    procedure SetActionEvents(evt :TNotifyEvent);
    //
    procedure SetMealDataChanged(evt :TDataChangeEvent);
    procedure SetMealList(pList :TStrings);
    procedure SetMealItems(pList :TStrings);
    //
    procedure MenuToMealItem;
    procedure MealItemToMenu;
    //
    function FoodMenuList :TStrings;
    function MealItems :TStrings;
    //
    procedure CheckEnableBeforeSelect;
    procedure EnableAddItem(const b :Boolean);
    //
    function CurrentMealID :String;
  end;

implementation

{$R *.dfm}

{ TfraMeal }

constructor TfraMeal.Create(AOwner: TComponent);
begin
  inherited;
  MergeActions;
end;

destructor TfraMeal.Destroy;
begin
//
  inherited;
end;

procedure TfraMeal.lstMenuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  CheckEnableBeforeSelect;
end;

{public}
function TfraMeal.CurrentMealID: String;
begin
  Result := cdsMeal.FieldByName('MLID').AsString;
end;

procedure TfraMeal.CheckEnableBeforeSelect;
var s :String;
begin
  if lstMenu.ItemIndex=-1 then
    Exit;
  s := lstMenu.Items[lstMenu.ItemIndex];
  actMealItemAdd.Enabled := (lstMealItems.Items.Indexof(s)=-1);
end;

procedure TfraMeal.ClearMealItems;
begin
  lstMealItems.Clear;
end;

procedure TfraMeal.Contact;
begin
  dspMeal.DataSet := FDM.XDataSet;
  cdsMeal.Close;
  cdsMeal.SetProvider(dspMeal);
  cdsMeal.Open;
end;

procedure TfraMeal.DataInterface(const IDat: IDataSetX);
begin
  FDM := IDat;
end;

function TfraMeal.DataManage: TClientDataSet;
begin
  Result := cdsMeal;
end;

procedure TfraMeal.EnableAddItem(const b: Boolean);
begin
  actMealItemAdd.Enabled := b;
end;

procedure TfraMeal.FocusFirst;
begin
  if edID.CanFocus then
    edId.SetFocus;
end;

function TfraMeal.FoodMenuList: TStrings;
begin
  Result := lstMenu.Items;
end;

function TfraMeal.IsSqeuenceAppend: Boolean;
begin
  Result := chkSeqAdd.Checked;
end;

function TfraMeal.MealItems: TStrings;
begin
  Result := lstMealItems.Items;
end;

procedure TfraMeal.MealItemToMenu;
begin
  if(lstMealItems.Count<=0)or(lstMealItems.ItemIndex=-1)then
    Exit;
  lstMealItems.DeleteSelected;
  CheckEnableBeforeSelect;
end;

procedure TfraMeal.MenuToMealItem;
begin
  if(lstMenu.Count<=0)or(lstMenu.ItemIndex=-1)then
    Exit;
  lstMealItems.Items.Append(lstMenu.Items[lstMenu.ItemIndex]);
  CheckEnableBeforeSelect;
end;

procedure TfraMeal.SetActionEvents(evt: TNotifyEvent);
begin
  actAddWrite.OnExecute := evt;
  actDelCanc.OnExecute  := evt;
  actNext.OnExecute := evt;
  actPrev.OnExecute := evt;
  //
  actMealItemAdd.OnExecute := evt;
  actMealItemDel.OnExecute := evt;
  actMealItemSel.OnExecute := evt;
end;

procedure TfraMeal.SetMealDataChanged(evt: TDataChangeEvent);
begin
  srcMeal.OnDataChange := evt;
end;

procedure TfraMeal.SetMealItems(pList: TStrings);
begin
  lstMealItems.Clear;
  lstMealItems.Items := pList;
end;

procedure TfraMeal.SetMealList(pList: TStrings);
begin
  lstMenu.Clear;
  lstMenu.Items := pList;
end;

procedure TfraMeal.MergeActions;
begin
  lstMenu.OnClick := actMealItemSel.OnExecute;
end;

end.
