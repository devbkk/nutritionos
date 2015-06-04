unit ShareInterface;

interface

uses Classes;

type
  TFactDataType = (fdtUser=Ord('U'),fdtMaterial=Ord('M'));

  IfraFactData = Interface
  ['{76F6FDA7-55D4-4547-95EF-59741A194E32}']

    procedure DoRequestFactInput(p :TFactDataType);
    //
    function GetFactDataType :TFactDataType;
    procedure SetFactDataType(SetValue :TFactDataType);
    property FactDataType :TFactDataType
      read GetFactDataType write SetFactDataType;
    //
  End;

implementation

end.
