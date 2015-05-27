unit InfSvAuth;

interface

uses
  ClUser, ComObj, ActiveX;

type
  ICtrlAuthen = Interface(IInterface)
  ['{930E3989-CC09-4AE4-857A-6D1C5ABB15B0}']
    procedure DoLogin;
    function IsAuthenticated :Boolean;
  end;

  IViewAuthen = interface(IInterface)
  ['{1F6F2C28-3CC6-4F16-BBA3-A870D469AC1E}']
    //
    procedure Contact;
    function GetUserRecEvent :TSendUserRecEvent;
    procedure SetUserRecEvent(evt :TSendUserRecEvent);
    property UserRecEvent :TSendUserRecEvent
      read GetUserRecEvent write SetUserRecEvent;
  end;

  IDModAuthen = interface(IInterface)
  ['{D280A8F6-D202-4B0C-B884-43296939E74A}']
    function IsAuthentiCated(login,pwd :String):Boolean;
  end;
implementation


end.
