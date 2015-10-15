unit SvFood;

interface

uses SysUtils, Classes, Controls,
     ShareInterface, FrFood, CtrFood;

type
  TEnumServiceFood = (esfFood, esfMenu, esfMeal);

  ICtrlFood = Interface(IInterface)
    ['{9522DC22-9B03-4D64-BC67-F1D6AA44BD2F}']
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String='');
  end;

  TCtrlFood = class(TInterfacedObject, ICtrlFood, IViewFood)
    //
  private
    FCtrFood :TControllerFood;
    FfrmFood :TfrmFood;
    function FoodInputView :IViewFood;
  public
    constructor Create;
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String='');
    procedure Start;
    property View :IViewFood read FoodInputView implements IViewFood;
  end;

function CtrFood :ICtrlFood;

implementation

var
  iCtrFood :ICtrlFood;

function CtrFood :ICtrlFood;
begin
  if not Assigned(iCtrFood) then
    iCtrFood := TCtrlFood.Create;
  Result := iCtrFood;
end;

{ TCtrlFood }

constructor TCtrlFood.Create;
begin
  inherited Create;
  Start;
end;

procedure TCtrlFood.DoClearInput;
begin
  if Assigned(FfrmFood)and(FfrmFood.Showing)then
    FfrmFood.Hide; 
end;

procedure TCtrlFood.DoInputData(OnWhat: TWinControl; uType: String);
begin
  View.AuthorizeMenu(uType);
  View.DoSetParent(OnWhat, nil);
  View.Contact;
end;

function TCtrlFood.FoodInputView: IViewFood;
begin
  Result := FfrmFood;
end;

procedure TCtrlFood.Start;
var snd :TRecSetInputItem;
begin
  if not Assigned(FCtrFood) then
    FCtrFood := TControllerFood.Create;

  if not Assigned(FfrmFood) then begin
    FfrmFood := TfrmFood.Create(nil);

    snd.PageIndex := Ord(esfFood);
    snd.AFrame    := FCtrFood.View;
    FfrmFood.SetupInputItem(snd);
  end;
end;

end.
