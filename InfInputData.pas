unit InfInputData;

interface

uses
  Classes, Controls;

type
  ICtrlInputFact = Interface(IInterface)
  ['{6CFC789C-0E36-43BD-9FB2-AA61E28A8DB9}']
    procedure DoInputData(OnWhat : TWinControl=nil);
  end;

  IViewInputFact = Interface(IInterface)
  ['{1259E224-7DFE-4528-98DE-7A2575F87443}']
    procedure Contact;
    procedure DoSetParent(AOwner : TWinControl);
  end;

  IDataManage = Interface(IInterface)
  ['{8AFF9FF9-A756-4FED-BB28-CCFAA1968B39}']
    procedure CheckTables;
    procedure Initialize;
  end;

implementation

end.
