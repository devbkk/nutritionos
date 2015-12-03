unit CtrFood;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, StrUtils, SysUtils,
     //
     ShareInterface, FaFood, DmFood, DmLookUp,
     FaFoodMenu, DmFoodMenu,
     FaMeal, DmMeal;

type
  TControllerFood = class
  private
    FfraFood :TfraFood;
    FFood    :IDataSetX;
    FManFood :TClientDataSet;
    //
    FDmLup   :TDmoLup;
    function CreateModelFood :IDataSetX;
    procedure CreateLookup;
    procedure DoAddWrite;
    procedure DoCancelDel;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
    procedure OnCommandInput(Sender :TObject);
    function View :TFrame;
  end;

  TControllerFoodMenu = class
  private
    FFoodList      :TStrings;
    FFoodMenuItems :TStrings;
    //
    FFoodMenu    :IFoodDataX;
    FfraFoodMenu :TfraFoodMenu;
    FManFoodMenu :TClientDataSet;
    //
    function  CreateModelFoodMenu :IDataSetX;
    procedure DoFoodItemAdd;
    procedure DoFoodItemDel;
    procedure DoFoodItemSel;
    //
    procedure DoAddWrite;
    procedure DoCancelDel;
    procedure DoMoveNext;
    procedure DoMovePrev;
    procedure DoGenerateFoodList;
    //
    procedure DoGetMenuItems;
    procedure DoSaveMenuItems;
    //
    procedure DoWhenFoodMenuDataChange(
      Sender :TObject;
      Field :TField);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
    procedure OnCommandInput(Sender :TObject);
    function View :TFrame;
  end;

  TControllerMeal = class
  private
    FFMnuList  :TStrings;
    FMealItems :TStrings;
    //
    FMeal    :IMealDataX;
    FfraMeal :TfraMeal;
    FManMeal :TClientDataSet;
    //
    function  CreateModelMeal :IDataSetX;
    procedure DoWhenMealDataChange(
      Sender :TObject;
      Field :TField);
    //
    procedure DoMealItemAdd;
    procedure DoMealItemDel;
    procedure DoMealItemSel;
    //
    procedure DoAddWrite;
    procedure DoCancelDel;
    procedure DoMoveNext;
    procedure DoMovePrev;
    procedure DoGenerateMenuList;
    //
    procedure DoGetMealItems;
    procedure DoSaveMealItems;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
    procedure OnCommandInput(Sender :TObject);
    function View :TFrame;
  end;

implementation

const
  CMP_ACTAW = 'actAddWrite';
  CMP_ACTDC = 'actDelCanc';
  CMP_ACTNX = 'actNext';
  CMP_ACTPV = 'actPrev';
  //
  ACT_MNUITMADD = 'actMenuItemAdd';
  ACT_MNUITMDEL = 'actMenuItemDel';
  ACT_MNUITMSEL = 'actMenuItemSel';
  //
  ACT_MELITMADD = 'actMealItemAdd';
  ACT_MELITMDEL = 'actMealItemDel';
  ACT_MELITMSEL = 'actMealItemSel';
  //
  CFM_DEL   = 'ลบข้อมูลนี้?';

{ TControllerFood }
constructor TControllerFood.Create;
begin
  Start;
end;

destructor TControllerFood.Destroy;
begin
  FfraFood.Free;
  FDmLup.Free;
  inherited;
end;

procedure TControllerFood.OnCommandInput(Sender: TObject);
begin
  if TCustomAction(Sender).Name=CMP_ACTAW then
    DoAddWrite
  else if TCustomAction(Sender).Name=CMP_ACTDC then
    DoCancelDel;
end;

procedure TControllerFood.Start;
begin
  //
  FfraFood := TfraFood.Create(nil);
  FFraFood.DataInterFace(CreateModelFood);
  FFraFood.SetActionEvents(OnCommandInput);
  FfraFood.Contact;
  //
  FManFood := FFraFood.DataManage;
  //
  FDmLup   := TDmoLup.Create(nil);
  CreateLookup;
end;

function TControllerFood.View: TFrame;
begin
  Result := FfraFood;
end;

procedure TControllerFood.CreateLookup;
begin
  FfraFood.SetFoodTypeLookup(FDmLup.LDataSet(eluFoodType));
end;

function TControllerFood.CreateModelFood: IDataSetX;
var p :TRecDataXSearch;
begin
  FFood := TDmoFood.Create(nil);
  FFood.SearchKey := p;
  Result := FFood;
end;

procedure TControllerFood.DoAddWrite;
begin
  if FManFood.State = dsBrowse then begin
    FManFood.Append;
    FfraFood.FocusFirst;
  end else if FManFood.State in [dsInsert,dsEdit] then begin
    FManFood.Post;
    FManFood.ApplyUpdates(-1);
    //
    if  FfraFood.IsSqeuenceAppend then
      DoAddWrite;
  end;
end;

procedure TControllerFood.DoCancelDel;
begin
  if FManFood.State = dsBrowse then begin
    if MessageDlg(CFM_DEL,mtWarning,[mbYes,mbNo],0) = mrYes then begin
      FManFood.Delete;
      FManFood.ApplyUpdates(-1);
    end;
  end else if FManFood.State in [dsInsert,dsEdit] then begin
    FManFood.Cancel;
  end;
end;

{ TControllerFoodMenu }

constructor TControllerFoodMenu.Create;
begin
  Start;
end;

destructor TControllerFoodMenu.Destroy;
begin
  FFoodList.Free;
  FFoodMenuItems.Free;
  inherited;
end;

procedure TControllerFoodMenu.OnCommandInput(Sender: TObject);
begin
  if TCustomAction(Sender).Name=CMP_ACTAW then
    DoAddWrite
  else if TCustomAction(Sender).Name=CMP_ACTDC then
    DoCancelDel
  else if TCustomAction(Sender).Name=CMP_ACTPV then
    DoMovePrev
  else if TCustomAction(Sender).Name=CMP_ACTNX then
    DoMoveNext
  else if TCustomAction(Sender).Name=ACT_MNUITMADD then
    DoFoodItemAdd
  else if TCustomAction(Sender).Name=ACT_MNUITMDEL then
    DoFoodItemDel
  else if TCustomAction(Sender).Name=ACT_MNUITMSEL then
    DoFoodItemSel;        
end;

procedure TControllerFoodMenu.Start;
begin
  FFoodList      := TStringList.Create;
  FFoodMenuItems := TStringList.Create;
  //
  FfraFoodMenu := TfraFoodMenu.Create(nil);
  FfraFoodMenu.DataInterFace(CreateModelFoodMenu);
  FfraFoodMenu.SetActionEvents(OnCommandInput);
  FfraFoodMenu.SetFoodMenuDataChanged(DoWhenFoodMenuDataChange);
  FfraFoodMenu.Contact;
  //
  FManFoodMenu := FFraFoodMenu.DataManage;
  //
  DoGenerateFoodList;
end;

function TControllerFoodMenu.View: TFrame;
begin
  Result := FfraFoodMenu;
end;

{private}
function TControllerFoodMenu.CreateModelFoodMenu: IDataSetX;
var p :TRecDataXSearch;
begin
  FFoodMenu := TDmoFoodMenu.Create(nil);
  FFoodMenu.SearchKey := p;
  Result := FFoodMenu;
end;

procedure TControllerFoodMenu.DoAddWrite;
const I_MSG = 'บันทึกข้อมูลแล้ว';
begin
  if FManFoodMenu.State = dsBrowse then begin
    FManFoodMenu.Append;
    FfraFoodMenu.FocusFirst;
  end else if FManFoodMenu.State in [dsInsert,dsEdit] then begin
    //
    DoSaveMenuItems;
    //
    FManFoodMenu.Post;
    FManFoodMenu.ApplyUpdates(-1);
    MessageDlg(I_MSG,mtInformation,[mbOK],0);
    //
    if  FfraFoodMenu.IsSqeuenceAppend then
      DoAddWrite;
  end;
end;

procedure TControllerFoodMenu.DoCancelDel;
begin
  if FManFoodMenu.State = dsBrowse then begin
    if MessageDlg(CFM_DEL,mtWarning,[mbYes,mbNo],0) = mrYes then begin
      FManFoodMenu.Delete;
      FManFoodMenu.ApplyUpdates(-1);
    end;
  end else if FManFoodMenu.State in [dsInsert,dsEdit] then begin
    FManFoodMenu.Cancel;
  end;
end;

procedure TControllerFoodMenu.DoFoodItemAdd;
begin
  FfraFoodMenu.FoodToMenuItem;
end;

procedure TControllerFoodMenu.DoFoodItemDel;
begin
  FfraFoodMenu.MenuItemToFood;
end;

procedure TControllerFoodMenu.DoFoodItemSel;
begin
  FfraFoodMenu.CheckEnableBeforeSelect;
end;

procedure TControllerFoodMenu.DoGenerateFoodList;
var ds :TDataSet;
begin
  ds :=  FFoodMenu.FoodList;
  if not ds.IsEmpty then begin
    FFoodList.Clear;
    ds.First;
    repeat
      FFoodList.Append(ds.Fields[2].AsString);
      ds.Next;
    until ds.Eof;
    FfraFoodMenu.SetFoodList(FFoodList);
  end;
end;

procedure TControllerFoodMenu.DoGetMenuItems;
var sMenuId :String; ds :TDataSet;
begin
  sMenuId := FfraFoodMenu.CurrentMenuID;
  ds := FFoodMenu.FoodMenuItemsList(sMenuId);
  if not ds.IsEmpty then begin
    FFoodMenuItems.Clear;
    repeat
      FFoodMenuItems.Append(ds.Fields[0].AsString);
      ds.Next;
    until ds.Eof;
    FfraFoodMenu.SetFoodMenuItems(FFoodMenuItems);
  end else FfraFoodMenu.ClearFoodMenuItems;
end;

procedure TControllerFoodMenu.DoMoveNext;
begin
  if FManFoodMenu.Eof then
    FManFoodMenu.Last
  else FManFoodMenu.Next;
end;

procedure TControllerFoodMenu.DoMovePrev;
begin
  if FManFoodMenu.Bof then
    FManFoodMenu.First
  else FManFoodMenu.Prior;
end;

procedure TControllerFoodMenu.DoSaveMenuItems;
var lstMenuItems,lstItemsSend :TStrings;
    i,idx :Integer;
    s,sMenuId :String;
begin
  //
  sMenuId := FfraFoodMenu.CurrentMenuID;
  if sMenuID='' then
    Exit;
  //
  lstMenuItems := FfraFoodMenu.FMnuItems;
  if lstMenuItems.Count>0 then begin
    lstItemsSend := TStringList.Create;
    try
      for i := 0 to lstMenuItems.Count - 1 do begin
        s := lstMenuItems[i];
        idx := Pos(' ',s);
        s := Copy(s,1,idx);
        s := TrimRight(s);
        //
        lstItemsSend.Append(s);
      end;
      //
      FFoodMenu.SaveMenuItems(sMenuID, lstItemsSend);
    finally
      lstItemsSend.Free;
    end;
  end;
end;

procedure TControllerFoodMenu.DoWhenFoodMenuDataChange(
  Sender: TObject;
  Field: TField);
begin
  DoGetMenuItems;
end;

{ TControllerMeal }

constructor TControllerMeal.Create;
begin
  Start;
end;

destructor TControllerMeal.Destroy;
begin
//
  inherited;
end;

{public}
procedure TControllerMeal.OnCommandInput(Sender: TObject);
begin
  if TCustomAction(Sender).Name=CMP_ACTAW then
    DoAddWrite
  else if TCustomAction(Sender).Name=CMP_ACTDC then
    DoCancelDel
  else if TCustomAction(Sender).Name=CMP_ACTPV then
    DoMovePrev
  else if TCustomAction(Sender).Name=CMP_ACTNX then
    DoMoveNext
  else if TCustomAction(Sender).Name=ACT_MELITMADD then
    DoMealItemAdd
  else if TCustomAction(Sender).Name=ACT_MELITMDEL then
    DoMealItemDel
  else if TCustomAction(Sender).Name=ACT_MELITMSEL then
    DoMealItemSel;
end;

procedure TControllerMeal.Start;
begin
  FFMnuList  := TStringList.Create;
  FMealItems := TStringList.Create;
  //
  FfraMeal := TfraMeal.Create(nil);
  FfraMeal.DataInterFace(CreateModelMeal);
  FfraMeal.SetActionEvents(OnCommandInput);
  FfraMeal.SetMealDataChanged(DoWhenMealDataChange);
  FfraMeal.Contact;
  //
  FManMeal := FfraMeal.DataManage;
  //
  DoGenerateMenuList;
end;

function TControllerMeal.View: TFrame;
begin
  Result := FfraMeal;
end;

{private}
function TControllerMeal.CreateModelMeal: IDataSetX;
var p :TRecDataXSearch;
begin
  FMeal := TDmoMeal.Create(nil);
  FMeal.SearchKey := p;
  Result := FMeal;
end;

procedure TControllerMeal.DoAddWrite;
const I_MSG = 'บันทึกข้อมูลแล้ว';
begin
  if FManMeal.State = dsBrowse then begin
    FManMeal.Append;
    FfraMeal.FocusFirst;
  end else if FManMeal.State in [dsInsert,dsEdit] then begin
    //
    DoSaveMealItems;
    //
    FManMeal.Post;
    FManMeal.ApplyUpdates(-1);
    MessageDlg(I_MSG,mtInformation,[mbOK],0);
    //
    if  FfraMeal.IsSqeuenceAppend then
      DoAddWrite;
  end;
end;

procedure TControllerMeal.DoCancelDel;
begin
  if FManMeal.State = dsBrowse then begin
    if MessageDlg(CFM_DEL,mtWarning,[mbYes,mbNo],0) = mrYes then begin
      FManMeal.Delete;
      FManMeal.ApplyUpdates(-1);
    end;
  end else if FManMeal.State in [dsInsert,dsEdit] then begin
    FManMeal.Cancel;
  end;
end;

procedure TControllerMeal.DoGenerateMenuList;
var ds :TDataSet;
begin
  ds :=  FMeal.MealList;
  if not ds.IsEmpty then begin
    FFMnuList.Clear;
    ds.First;
    repeat
      FFMnuList.Append(ds.Fields[2].AsString);
      ds.Next;
    until ds.Eof;
    FfraMeal.SetMealList(FFMnuList);
  end;
end;

procedure TControllerMeal.DoGetMealItems;
var sMealId :String; ds :TDataSet;
begin
  sMealId :=  FfraMeal.CurrentMealID;
  ds := FMeal.MealItemsList (sMealId);
  if not ds.IsEmpty then begin
    FMealItems.Clear;
    repeat
      FMealItems.Append(ds.Fields[0].AsString);
      ds.Next;
    until ds.Eof;
     FfraMeal.SetMealItems(FMealItems);
  end else FfraMeal.ClearMealItems;
end;

procedure TControllerMeal.DoMealItemAdd;
begin
  FfraMeal.MenuToMealItem;
end;

procedure TControllerMeal.DoMealItemDel;
begin
  FfraMeal.MealItemToMenu;
end;

procedure TControllerMeal.DoMealItemSel;
begin
  FfraMeal.CheckEnableBeforeSelect;
end;

procedure TControllerMeal.DoMoveNext;
begin
  if FManMeal.Eof then
    FManMeal.Last
  else FManMeal.Next;
end;

procedure TControllerMeal.DoMovePrev;
begin
  if FManMeal.Bof then
    FManMeal.First
  else FManMeal.Prior;
end;

procedure TControllerMeal.DoSaveMealItems;
var lstMealItems,lstItemsSend :TStrings;
    i,idx :Integer;
    s,sMealId :String;
begin
  //
  sMealId := FfraMeal.CurrentMealID;
  if sMealId='' then
    Exit;
  //
  lstMealItems := FfraMeal.MealItems;
  if lstMealItems.Count>0 then begin
    lstItemsSend := TStringList.Create;
    try
      for i := 0 to lstMealItems.Count - 1 do begin
        s := lstMealItems[i];
        idx := Pos(' ',s);
        s := Copy(s,1,idx);
        s := TrimRight(s);
        //
        lstItemsSend.Append(s);
      end;
      //
      FMeal.SaveMealItems(sMealID, lstItemsSend);
    finally
      lstItemsSend.Free;
    end;
  end;
end;

procedure TControllerMeal.DoWhenMealDataChange(
 Sender: TObject;
 Field: TField);
begin
  DoGetMealItems;
end;

end.
