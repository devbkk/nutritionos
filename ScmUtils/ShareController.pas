unit ShareController;

interface

uses Classes, ShareCommon;

type
  ICtrlReqFoodDet = Interface
  ['{A60034C0-2F12-41DC-9B58-E94B96A8C35E}']
    function DiagDetLabel(const dCode :String) :String;
    function FoodDetLabel(const reqID :String) :String;
    procedure GetFeedLabel(var p:TRecFeedLabel);
  End;

implementation

end.
