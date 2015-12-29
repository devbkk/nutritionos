unit SvFoodPrep;

interface

uses SysUtils, Classes, Controls, Forms,
     ShareInterface, CtrFoodPrep, FrFoodPrep;

type
  IServFoodPrep = Interface(IInterface)
  ['{8B4A1C20-A7BF-4171-AA72-8BB78CF4F94C}']
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String='');
  End;

  TServFoodPrep = Class(TInterfacedObject, IServFoodPrep, IViewFoodPrep)
  private
    FCtrFoodPrep :TControllerFoodPrep;
    function FoodPrepInputView :IViewFoodPrep;
  public
    constructor Create;
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String='');
    procedure Start;
    //
    property View : IViewFoodPrep
      read FoodPrepInputView implements IViewFoodPrep;
  End;

function ServFoodPrep :IServFoodPrep;

implementation

var
  iSvFoodPrep :IServFoodPrep;

{ TServFoodPrep }

function ServFoodPrep :IServFoodPrep;
begin
  if not Assigned(iSvFoodPrep) then
    iSvFoodPrep := TServFoodPrep.Create;
  Result := iSvFoodPrep;
end;

constructor TServFoodPrep.Create;
begin
  inherited Create;
  Start;
end;

procedure TServFoodPrep.DoClearInput;
var frm :TForm;
begin
  frm := FCtrFoodPrep.View;
  if Assigned(frm)and(frm.Showing)then
    frm.Hide;
end;

procedure TServFoodPrep.DoInputData(OnWhat: TWinControl; uType: String);
begin
  View.AuthorizeMenu(uType);
  View.DoSetParent(OnWhat, nil);
  View.Contact;
end;

procedure TServFoodPrep.Start;
begin
  if not Assigned(FCtrFoodPrep) then
    FCtrFoodPrep := TControllerFoodPrep.Create;
end;

function TServFoodPrep.FoodPrepInputView: IViewFoodPrep;
begin
  Result := TfrmFoodPrep(FCtrFoodPrep.View);
end;

end.
