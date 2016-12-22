unit ShareIntfService;

interface

uses SysUtils, Classes;

type
  IServiceCallBack = Interface
  ['{35DBAB97-1F69-4E55-B3C4-0E24584AF1B1}']

  //
  End;

  IServiceSelector = Interface
  ['{0FECF316-95A4-4A43-AE53-67C826BC67A4}']
    function ServiceId :Integer;
    procedure Execute;
    procedure RegistService(iList :IInterfaceList);
  End;

implementation

end.
