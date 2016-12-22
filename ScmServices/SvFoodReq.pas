unit SvFoodReq;

interface

uses SysUtils, Classes, Controls, Forms, Dialogs,
     ShareCommon, ShareInterface, ShareIntfService,
     CtrFoodReq, FrFoodReq, CtrFact, FrFactSelect;

type
  TRecServFoodReq = record
    OnWhat :TWinControl;
    CallBackValue :String;
    UserType  :String;
    procedure InitRec;
  end;

  IServFoodReq = Interface(IInterface)
  ['{4FC33EE0-D83A-4426-8A97-17C6BD031DB6}']
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String=''); overload;
    procedure DoInputData(p :TRecServFoodReq); overload;
    procedure DoSetServiceCallBack(evt :TEventServiceCallBack);
  End;

  TServFoodReq = Class(TInterfacedObject,
                       IServFoodReq,
                       IViewFoodReq,
                       IViewFactSelect)
  private
    FCtrFactSelect :TControllerFactSelect;
    FCtrFoodReq :TControllerFoodReq;
    FEvtServiceCallBack :TEventServiceCallBack;
    function FoodReqInputView :IViewFoodReq;
    function FactSelectPop : IViewFactSelect;
  public
    constructor Create;

    //IServFoodReq
    procedure DoClearInput;
    procedure DoInputData(OnWhat :TWinControl=nil; uType :String=''); overload;
    procedure DoInputData(p :TRecServFoodReq); overload;    
    procedure DoSetServiceCallBack(evt :TEventServiceCallBack);
    //
    procedure Start;
    //
    procedure DoFactSelect(Sender :TObject);
    property View :IViewFoodReq
      read FoodReqInputView implements IViewFoodReq;
    property PopSelect :IViewFactSelect
      read FactSelectPop implements IViewFactSelect;

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

procedure TServFoodReq.DoFactSelect(Sender: TObject);
var snd :TRecFactSelect;
begin
  snd := FCtrFoodReq.FactSelect;
  PopSelect.Contact(snd.reqdesc);
  if PopSelect.IsSelected then begin
    snd := FCtrFactSelect.FactSelect;
    if snd.HaveNeededRecs then
      FCtrFoodReq.FactSelect := snd;
  end;
end;

procedure TServFoodReq.DoInputData(p: TRecServFoodReq);
begin
  View.AuthorizeMenu(p.UserType);
  View.DoSetParent(p.OnWhat, nil);
  View.Contact;
  //
  FCtrFoodReq.DoPointToAN(p.CallBackValue);
end;

procedure TServFoodReq.DoInputData(OnWhat :TWinControl=nil; uType :String='');
begin
  View.AuthorizeMenu(uType);
  View.DoSetParent(OnWhat, nil);
  View.Contact;
end;

procedure TServFoodReq.DoSetServiceCallBack(evt: TEventServiceCallBack);
begin
  FEvtServiceCallBack := evt;
end;

function TServFoodReq.FactSelectPop: IViewFactSelect;
begin
  Result := TfrmFactselect(FCtrFactSelect.View);
end;

function TServFoodReq.FoodReqInputView: IViewFoodReq;
begin
  Result := TfrmFoodReq(FCtrFoodReq.View);
end;

procedure TServFoodReq.Start;
begin
  if not Assigned(FCtrFoodReq) then begin
    FCtrFoodReq := TControllerFoodReq.Create;
    FCtrFoodReq.CallBackFactSelect := DoFactSelect;
  end;
  //
  if not Assigned(FCtrFactSelect) then begin
    FCtrFactSelect := TControllerFactSelect.Create;
  end;
end;

{ TRecServFoodReq }

procedure TRecServFoodReq.InitRec;
begin
  Self.OnWhat        := nil;
  Self.CallBackValue := '';
  Self.UserType      := '';
end;

end.
