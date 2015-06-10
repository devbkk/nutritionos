unit ShareInterface;

interface

uses Classes, DB, DBClient;

type
  //user
  TRecUserSearch = record
    id,fname,lname,gender,email,login :String;
  end;

  TRecUser = record
    id,fname,lname,aname,gender,email,login,password :String;
  end;

  TSendUserRecEvent = procedure(pUsr :TRecUser) of Object;

  IUser = Interface(IInterface)
  ['{DFCD226E-6AD6-4B16-AC16-74FE88B1B5C2}']
    procedure DoAppendWrite;
    //
    function GetData :TRecUser;
    procedure SetData(const Value :TRecUser);
    property Data :TRecUser read GetData write SetData;
    //
    function GetSearchKey :TRecUserSearch;
    procedure SetSearchKey(const Value :TRecUserSearch);
    property SearchKey :TRecUserSearch
      read GetSearchKey write SetSearchKey;
    //
    function UserDataSet :TDataSet; overload;
    function UserDataSet(p :TRecUserSearch) :TDataSet; overload; 
  End;

  //fact data
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
