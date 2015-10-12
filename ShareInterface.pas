unit ShareInterface;

interface

uses Classes, DB, DBClient, ShareCommon;

type
  //food
  TRecFood = record
    id, name, typ, recipe, cal :String;
  end;

  TRecFoodSearch = record
    name :String;
  end;

  //user
  TEnumUserType = (utAdmin,utUser);

  TRecUserSearch = record
    id,fname,lname,gender,email,login :String;
  end;

  TRecUser = record
    id,fname,lname,aname,gender,email,login,password :String;
  end;

  TRecDatas = record
    User :TRecUser;
    Food :TRecFood;
  end;
  
  TSendUserRecEvent = procedure(pUsr :TRecUser) of Object;

  IDataModel = Interface(IInterface)
  ['{08D5B19F-2CDF-424F-9B70-9C01BDFBD1E6}']
    function GetData :String;
    procedure SetData(const Value :String);
  End;

  IUser = Interface(IInterface)
  ['{DFCD226E-6AD6-4B16-AC16-74FE88B1B5C2}']
    //
    function GetData :TRecUser;
    procedure SetData(const Value :TRecUser);
    property Data :TRecUser read GetData write SetData;
    //
    function GetRunno(fld :TField;upd :Boolean=False):String;
    //
    function GetSearchKey :TRecUserSearch;
    procedure SetSearchKey(const Value :TRecUserSearch);
    property SearchKey :TRecUserSearch
      read GetSearchKey write SetSearchKey;
    //
    function UserDataSet :TDataSet; overload;
    function UserDataSet(p :TRecUserSearch) :TDataSet; overload;
  end;

  //fact data
  TFactDataKeyDown = procedure(Sender: TObject;
                               var Key:
                               Word; Shift: TShiftState) of object;

  TFactDataType = (fdtUser=Ord('U'),fdtMaterial=Ord('M'));

  TRecFactSearch = record
    code, fdes ,ftyp :String;
  end;

  TRecFactData = record
    code, fdes, ftyp, note :String;
  end;

  IFact = Interface(IInterface)
  ['{71E0F280-F14B-46FF-B1BA-8111BE5F72D0}']
    function GetData :TRecFactData;
    procedure SetData(const Value :TRecFactData);
    property Data :TRecFactData read GetData write SetData;
    //
    function GetSearchKey :TRecFactSearch;
    procedure SetSearchKey(const Value :TRecFactSearch);
    property SearchKey :TRecFactSearch
      read GetSearchKey write SetSearchKey;
    //
    function FactDataSet :TDataSet; overload;
    function FactDataSet(p :TRecFactSearch) :TDataSet; overload;
    function FactTypeDataSet :TDataSet;
  end;

  IfraFactData = Interface(IInterface)
  ['{76F6FDA7-55D4-4547-95EF-59741A194E32}']
    procedure Contact;
    procedure DoRequestFactInput(p :TFactDataType);
    //
    function GetFactDataType :TFactDataType;
    procedure SetFactDataType(SetValue :TFactDataType);
    property FactDataType :TFactDataType
      read GetFactDataType write SetFactDataType;
    //
    procedure FactDataInterface(const AFact :IFact);
    function  FactDataManage :TClientDataSet;
    function IsSqeuenceAppend :Boolean;
    //
    procedure FocusFirstCell;
    procedure SetTimerSearch(enb :Boolean);
    //
    procedure ContactFactGroup;
  end;

  //syslog
  TRecSysLog = record
    id :Integer;
    desc,typ :String;
    dt :TDatetime;
  end;

  TRecSysLogSearch = record
    //id :Integer;
    desc, typ :String;
    //dt :TDatetime;
  end;

  ISysLog = Interface(IInterface)
  ['{8DD672A7-158B-471B-8CCA-5BB795533946}']
    function GetData :TRecSysLog;
    procedure SetData(const Value :TRecSysLog);
    property Data :TRecSysLog read GetData write SetData;
    //
    function GetSearchKey :TRecSysLogSearch;
    procedure SetSearchKey(const Value :TRecSysLogSearch);
    property SearchKey :TRecSysLogSearch
      read GetSearchKey write SetSearchKey;
    //
    function SysLogDataSet :TDataSet; overload;
    function SysLogDataSet(p :TRecSysLogSearch) :TDataSet; overload;
    function SysLogTypeDataSet :TDataSet;
  end;

  TRecDataXSearch = record
   ID, CODE, NAME, TYP :String;
  end;

  IDataSetX = Interface(IInterface)
  ['{65B2A441-5600-49E9-B252-6B6F4B090FA6}']
    function XDataSet :TDataSet; overload;
    function XDataSet(const pSearch :TRecDataXSearch):TDataSet; overload;
  end;

  TConnectParam = Class
  private
    FParams :TRecConnectParams;
    procedure SetParams(const Value: TRecConnectParams);
  public
    constructor Create(p :TRecConnectParams);
    property Params :TRecConnectParams read FParams write SetParams;
  end;

implementation

{ TConnectParam }

constructor TConnectParam.Create(p: TRecConnectParams);
begin
  FParams :=p;
end;

procedure TConnectParam.SetParams(const Value: TRecConnectParams);
begin
  FParams := Value;
end;

end.
