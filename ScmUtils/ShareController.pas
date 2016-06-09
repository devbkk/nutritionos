unit ShareController;

interface

uses Classes;

type
  ICtrlReqFoodDet = Interface
  ['{A60034C0-2F12-41DC-9B58-E94B96A8C35E}']
    function DiagDetLabel(const dCode :String) :String;
    function FoodDetLabel(const reqID :String) :String;
  End;

implementation

end.
