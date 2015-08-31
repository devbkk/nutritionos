unit SvFood;

interface

uses SysUtils, Classes, Controls,
     FrFood;

type
  ICtrlFood = Interface(IInterface)
    ['{9522DC22-9B03-4D64-BC67-F1D6AA44BD2F}']
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String='');
  end;

  TCtrlFood = class(TInterfacedObject, ICtrlFood, IViewFood)
    //
  private
    FfrmFood :TfrmFood;
    function FoodInputView :IViewFood;
  public
    constructor Create;
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String='');
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
end;

procedure TCtrlFood.DoClearInput;
begin
//
end;

procedure TCtrlFood.DoInputData(OnWhat: TWinControl; uType: String);
begin
  View.AuthorizeMenu(uType);
  View.DoSetParent(OnWhat, nil);
  View.Contact;
end;

function TCtrlFood.FoodInputView: IViewFood;
begin
  if not Assigned(FfrmFood) then begin
    FfrmFood := TfrmFood.Create(nil);
  end;
  Result := FfrmFood;
end;

end.
