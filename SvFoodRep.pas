unit SvFoodRep;

interface

uses SysUtils, Classes, Controls, Forms,
     ShareInterface, CtrFoodRep, FrFoodRep;

type
  IServFoodRep = Interface(IInterface)
  ['{BFE9B1F2-03F2-449F-8949-DA0A37A87824}']
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String='');
  End;

  TServFoodRep = Class(TInterfacedObject, IServFoodRep, IViewFoodRep)
  private
    FCtrFoodRep :TControllerFoodRep;
    function FoodRepInputView :IViewFoodRep;
  public
    constructor Create;
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String='');
    procedure Start;
    //
    property View : IViewFoodRep
      read FoodRepInputView implements IViewFoodRep;
  End;

function ServFoodRep :IServFoodRep;

implementation

var
  iSvFoodRep :IServFoodRep;

{ TServFoodRep }

function ServFoodRep :IServFoodRep;
begin
  if not Assigned(iSvFoodRep) then
    iSvFoodRep := TServFoodRep.Create;
  Result := iSvFoodRep;
end;

constructor TServFoodRep.Create;
begin
  Start;
end;

procedure TServFoodRep.DoClearInput;
var frm :TForm;
begin
  frm := FCtrFoodRep.View;
  if Assigned(frm)and(frm.Showing)then
    frm.Hide;
end;

procedure TServFoodRep.DoInputData(OnWhat: TWinControl; uType: String);
begin
  View.AuthorizeMenu(uType);
  View.DoSetParent(OnWhat, nil);
  View.Contact;
end;

procedure TServFoodRep.Start;
begin
  if not Assigned(FCtrFoodRep) then
    FCtrFoodRep := TControllerFoodRep.Create;
end;

function TServFoodRep.FoodRepInputView: IViewFoodRep;
begin
  Result := TfrmFoodRep(FCtrFoodRep.View);
end;

end.
