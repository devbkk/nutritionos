unit SvFoodReq;

interface

uses SysUtils, Classes, Controls, Forms,
     ShareInterface, CtrFoodReq, FrFoodReq;

type
  IServFoodReq = Interface(IInterface)
  ['{4FC33EE0-D83A-4426-8A97-17C6BD031DB6}']
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String='');
  End;

  TServFoodReq = Class(TInterfacedObject, IServFoodReq, IViewFoodReq)
  private
    FCtrFoodReq :TControllerFoodReq;
    function FoodReqInputView :IViewFoodReq;
  public
    constructor Create;
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String='');
    procedure Start;
    property View :IViewFoodReq read FoodReqInputView implements IViewFoodReq;
  End;

function ServFoodReq :IServFoodReq;

implementation

var
  iSvFoodReq :IServFoodReq;

{ TServFood }

function ServFoodReq :IServFoodReq;
begin
  if not Assigned(iSvFoodReq) then
    iSvFoodReq := TServFoodReq.Create;
  Result := iSvFoodReq;
end;

constructor TServFoodReq.Create;
begin
  inherited Create;
  Start;
end;

procedure TServFoodReq.DoClearInput;
var frm :TForm;
begin
  frm := FCtrFoodReq.View;
  if Assigned(frm)and(frm.Showing)then
    frm.Hide;
end;

procedure TServFoodReq.DoInputData(OnWhat :TWinControl=nil; uType :String='');
begin
  View.AuthorizeMenu(uType);
  View.DoSetParent(OnWhat, nil);
  View.Contact;
end;

function TServFoodReq.FoodReqInputView: IViewFoodReq;
begin
  Result := TfrmFoodReq(FCtrFoodReq.View);
end;

procedure TServFoodReq.Start;
begin
  if not Assigned(FCtrFoodReq) then
    FCtrFoodReq := TControllerFoodReq.Create;
end;

end.
