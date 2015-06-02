unit SvInutData;

interface

uses
  Classes, Controls, SysUtils, Dialogs, InfInputData, FrFactData;

type
  ICtrlInputFact = Interface(IInterface)
  ['{6CFC789C-0E36-43BD-9FB2-AA61E28A8DB9}']
    procedure DoInputData(OnWhat : TWinControl=nil);
  end;

  TCtrlInputData = class(TInterfacedObject, ICtrlInputFact, IViewInputFact)
  private
    FSvInpDat :TfrmFactData;
    function FactInputView :IViewInputFact;
  public
    constructor Create;  
    procedure DoInputData(OnWhat : TWinControl=nil);
    property View :IViewInputFact read FactInputView implements IViewInputFact;
  end;

function CtrInputFact :ICtrlInputFact;

implementation

var iCtrlInpFact :ICtrlInputFact;

function CtrInputFact :ICtrlInputFact;
begin
  if not assigned(iCtrlInpFact) then
    iCtrlInpFact := TCtrlInputData.Create;
  Result := iCtrlInpFact;
end;
{ TCtrlInputData }

constructor TCtrlInputData.Create;
begin
  inherited Create;
  //
end;

procedure TCtrlInputData.DoInputData(OnWhat :TWinControl=nil);
begin
  View.DoSetParent(OnWhat);
  View.Contact;
end;

function TCtrlInputData.FactInputView: IViewInputFact;
begin
  if not Assigned(FSvInpDat) then
    FSvInpDat := TfrmFactData.Create(nil);
  Result := FSvInpDat;
end;

end.
