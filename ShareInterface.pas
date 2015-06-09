unit ShareInterface;

interface

uses Classes;

type
  //user
  TUserSearchKey = record
    id,fname,lname,gender,email,login :String;
  end;

  TUserRec = record
    id,fname,lname,aname,gender,email,login,password :String;
  end;

  TSendUserRecEvent = procedure(pUsr :TUserRec) of Object;

  IUser = Interface(IInterface)
  ['{DFCD226E-6AD6-4B16-AC16-74FE88B1B5C2}']
    //
    function GetData :TUserRec;
    procedure SetData(const Value :TUserRec);
    property Data :TUserRec read GetData write SetData;
    //
    function GetSearchKey :TUserSearchKey;
    procedure SetSearchKey(const Value :TUserSearchKey);
    property SearchKey :TUserSearchKey
      read GetSearchKey write SetSearchKey;
  End;

   TUser = Class(TInterfacedObject, IUser)
   private

   protected
     //
     function GetData :TUserRec; virtual; abstract;
     procedure SetData(const Value :TUserRec); virtual; abstract;
     //
     function GetSearchKey :TUserSearchKey; virtual; abstract;
     procedure SetSearchKey(const Value :TUserSearchKey); virtual; abstract;
   public
     property Data :TUserRec read GetData write SetData;
     property SearchKey :TUserSearchKey read GetSearchKey write SetSearchKey;
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
