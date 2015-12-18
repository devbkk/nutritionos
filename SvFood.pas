unit SvFood;

interface

uses SysUtils, Classes, Controls,
     ShareInterface, FrFood, CtrFood;

type
  TEnumServiceFood = (esfFood, esfMenu, esfMeal);

  IServFood = Interface(IInterface)
    ['{9522DC22-9B03-4D64-BC67-F1D6AA44BD2F}']
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String='');
    procedure DoFinishInput;
  end;

  TServFood = class(TInterfacedObject, IServFood, IViewFood)
    //
  private
    FCtrFood     :TControllerFood;
    FCtrFoodMenu :TControllerFoodMenu;
    FCtrMeal     :TControllerMeal;
    FfrmFood     :TfrmFood;
    function FoodInputView :IViewFood;
  public
    constructor Create;
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String='');
    procedure DoFinishInput;
    procedure Start;
    procedure Finish;
    property View :IViewFood read FoodInputView implements IViewFood;
  end;

function ServFood :IServFood;

implementation

var
  iSvFood :IServFood;

function ServFood :IServFood;
begin
  if not Assigned(iSvFood) then
    iSvFood := TServFood.Create;
  Result := iSvFood;
end;

{ TServFood }

constructor TServFood.Create;
begin
  inherited Create;
  Start;
end;

procedure TServFood.DoClearInput;
begin
  if Assigned(FfrmFood)and(FfrmFood.Showing)then
    FfrmFood.Hide;
end;

procedure TServFood.DoFinishInput;
begin
  Finish;
end;

procedure TServFood.DoInputData(OnWhat: TWinControl; uType: String);
begin
  View.AuthorizeMenu(uType);
  View.DoSetParent(OnWhat, nil);
  View.Contact;
end;

procedure TServFood.Finish;
begin
  if Assigned(FCtrFood) then
    FCtrFood.Free;

  if Assigned(FCtrFoodMenu) then
    FCtrFoodMenu.Free;

  if Assigned(FCtrMeal) then
    FCtrMeal.Free;

  if Assigned(FfrmFood) then
    FfrmFood.Free;
end;

function TServFood.FoodInputView: IViewFood;
begin
  Result := FfrmFood;
end;

procedure TServFood.Start;
var snd :TRecSetInputItem;
begin
  if not Assigned(FCtrFood) then
    FCtrFood := TControllerFood.Create;

  if not Assigned(FCtrFoodMenu) then
    FCtrFoodMenu := TControllerFoodMenu.Create;

  if not Assigned(FCtrMeal) then
    FCtrMeal := TControllerMeal.Create;

  if not Assigned(FfrmFood) then begin
    FfrmFood := TfrmFood.Create(nil);
    //
    snd.PageIndex := Ord(esfFood);
    snd.AFrame    := FCtrFood.View;
    FfrmFood.SetupInputItem(snd);
    //
    snd.PageIndex := Ord(esfMenu);
    snd.AFrame    := FCtrFoodMenu.View;
    FfrmFood.SetupInputItem(snd);
    //
    snd.PageIndex := Ord(esfMeal);
    snd.AFrame    := FCtrMeal.View;
    FfrmFood.SetupInputItem(snd);
  end;

end;

end.
