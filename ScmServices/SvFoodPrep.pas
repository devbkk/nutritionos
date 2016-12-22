unit SvFoodPrep;

interface

uses SysUtils, Classes, Controls, Forms,
     ShareCommon, ShareInterface,
     CtrFoodPrep, FrFoodPrep, CtrFoodReq;

type
  TRecServFoodPrep = record
    OnWhat :TWinControl;
    CallBackValue :String;
    UserType  :String;
    procedure InitRec;
  end;

  IServFoodPrep = Interface(IInterface)
  ['{8B4A1C20-A7BF-4171-AA72-8BB78CF4F94C}']
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String=''); overload;
    procedure DoInputData(p :TRecServFoodPrep); overload;
    procedure DoSetServiceCallBack(evt :TEventServiceCallBack);
  End;

  TServFoodPrep = Class(TInterfacedObject, IServFoodPrep, IViewFoodPrep)
  private
    FCtrFoodReq  :TControllerFoodReq;
    FCtrFoodPrep :TControllerFoodPrep;
    FEvtServiceCallBack :TEventServiceCallBack;
    function FoodPrepInputView :IViewFoodPrep;
  public
    constructor Create;
    //
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String=''); overload;
    procedure DoInputData(p :TRecServFoodPrep); overload;
    procedure DoSetServiceCallBack(evt :TEventServiceCallBack);
    //
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

procedure TServFoodPrep.DoInputData(p: TRecServFoodPrep);
begin
  View.AuthorizeMenu(p.UserType);
  View.DoSetParent(p.OnWhat, nil);
  View.DoSetServiceCallBack(FEvtServiceCallBack);
  View.Contact;
  //
  FCtrFoodPrep.DoPointToAN(p.CallBackValue);
end;

procedure TServFoodPrep.DoInputData(OnWhat: TWinControl; uType: String);
begin
  View.AuthorizeMenu(uType);
  View.DoSetParent(OnWhat, nil);
  View.DoSetServiceCallBack(FEvtServiceCallBack);
  View.Contact;
end;

procedure TServFoodPrep.DoSetServiceCallBack(evt: TEventServiceCallBack);
begin
  FEvtServiceCallBack := evt;
end;

procedure TServFoodPrep.Start;
begin
  FCtrFoodReq  := TControllerFoodReq.Create;
  //
  FCtrFoodPrep := TControllerFoodPrep.Create;
  FCtrFoodPrep.SetInfCtrlFoodDet(FCtrFoodReq);
end;

function TServFoodPrep.FoodPrepInputView: IViewFoodPrep;
begin
  Result := TfrmFoodPrep(FCtrFoodPrep.View);
end;

{ TRecServFoodPrep }

procedure TRecServFoodPrep.InitRec;
begin
  Self.OnWhat        := nil;
  Self.CallBackValue := '';
  Self.UserType      := '';
end;

end.
