unit ShareInterface;

interface

uses Classes, DB, DBClient, Forms, ShareCommon;

type
  TEnumLup = (eluFoodType);

  TEnumUserType = (utAdmin,utUser);

  TFactDataType = (fdtUser=Ord('U'),fdtMaterial=Ord('M'));

  TRecCaptionTmpl = record
    CurrentText, Caption, GroupCode :String;
    Dt :TDateTime;
    IsSetDateTime :Boolean;
  end;

  TRecDataXSearch = record
   ID, CODE, NAME, TYP :String;
   AN :String;
   DT :TDateTime;
  end;

  TRecFood = record
    id, name, typ, recipe, cal :String;
  end;

  TRecFoodSearch = record
    name :String;
  end;

  TRecFactData = record
    code, fdes, ftyp, note :String;
  end;

  TRecFactSearch = record
    code, fdes ,ftyp :String;
  end;

  TRecFactSelect = record
    pattype :String;
    //
    foodprop1, foodprop2, foodprop3 :String;
    foodprop4, foodprop5 :String;
    //foodselect : Array of String;
    //
    restrict, reqdesc, note :String;
    countprop :Integer;
    //
    function HaveNeededRecs :Boolean;    
    function IsEmptyRecord :Boolean;
  end;

  TRecFactTreeInput = record
    Code, Desc, Note :String;
    IsSubLevel, IsSlipPrn :Boolean;
    function IsEmptyRec :Boolean;
  end;

  TRecHcDat = record
    Hn, An, PID, TName, FName, LName: String;
    PatName, Gender, Ht, Wt :String;
    Birth, AdmitDt, DiscDt :TDateTime;
    Age :Integer;
    WardID, WardName, RoomNo, BedNo :String;
    RelgCode, RelgDesc :String;
  end;

  TRecHcSearch = record
    SearchTxt, ListHn :String;
    Selector : Integer;
  end;

  TRecSetInputItem = record
    PageIndex : Integer;
    AFrame    : TFrame;
  end;

  TRecGenCode = record
    FGrc, FTyc :String;
  end;

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

  TRecUser = record
    id,fname,lname,aname,gender,email,login,password :String;
  end;

  TRecUserSearch = record
    id,fname,lname,gender,email,login :String;
  end;

  TEditKeyDown = procedure(Sender: TObject;
                           var Key: Word;
                           Shift: TShiftState) of object;

  TSendUserRecEvent = procedure(pUsr :TRecUser) of Object;

  //
  IDataModel = Interface(IInterface)
  ['{08D5B19F-2CDF-424F-9B70-9C01BDFBD1E6}']
    function GetData :String;
    procedure SetData(const Value :String);
  End;

  IDataLookupX = interface(IInterface)
  ['{07AC3CCA-00A9-4AF7-90F3-C2A41C16A662}']
    function GetKeyField :String;
    procedure SetKeyField(const Value :String);
    property KeyField :String read GetKeyField write SetKeyField;
    //
    function GetListField :String;
    procedure SetListField(const Value :String);
    property ListField :String read GetListField write SetListField;
    //
    function LDataSet(const typ:TEnumLup):TDataSet;
  end;

  IDataSetX = Interface(IInterface)
  ['{65B2A441-5600-49E9-B252-6B6F4B090FA6}']
    function GetSearchKey :TRecDataXSearch;
    procedure SetSearchKey(const Value :TRecDataXSearch);
    property SearchKey :TRecDataXSearch
      read GetSearchKey write SetSearchKey;
    //
    function XDataSet :TDataSet; overload;
    function XDataSet(const p :TRecDataXSearch):TDataSet; overload;
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
    function FactNextCode(p :TRecGenCode) :String;
    function FactTypeDataSet :TDataSet;
    //
    function GetCaptionTemplate(code :String):String;
    //
    function LookupPatientType :TDataSet;
    function LookupFacts(code :String) :TDataSet;
    //
    procedure DelFactGroup(code :String);
    procedure UpdateFactGroup(p :TRecFactTreeInput);    
  end;

  IFoodDataX = Interface(IDataSetX)
  ['{CB13CF0B-83FA-400F-BE22-D881D788D963}']
    function FoodList :TDataSet;
    function FoodMenuItemsList(const mnuId:String) :TDataSet;
    procedure SaveMenuItems(const mnuId:String; items :TStrings);
  end;

  IFoodGroupsDataX = Interface(IDataSetX)
  ['{AC86B41A-412C-455D-9DC0-6AA9E73D89B5}']
  End;

  IFoodPrepDataX = Interface(IDataSetX)
  ['{8E09EC06-2F1F-40F8-AB22-CCB2EF95945F}']
    procedure PrintAll;
    procedure PrintSelected(const ds :TDataset);
    procedure SetPrintAmPm(const idx :Integer);
  End;

  IFoodRepDataX = Interface(IDataSetX)
  ['{B0EE8B37-0C75-44A4-800C-EE5FAD331B88}']
    procedure FeedAppendClientDS(var cds :TClientDataSet; dsno:Integer);  
    function GetFeedFormulaColumn(const grp,typ :String) :TDataset;
    function GetFeedFormulaRowHead(const code :String) :TDataSet;
    function GetFeedFormulaTotal(const grp,typ :String) :TDataSet;
    function GetFoodReport :TDataSet;
    procedure PrintReport(const idx :Integer) overload;    
    procedure PrintReport(const idx :Integer; ds :TDataSet);overload;
    procedure PrintReport(const ids :Integer; cds:TClientDataSet); overload;
    procedure SetMealDesc(const Value :String);    
  End;

  IFoodReqDataX = Interface(IDataSetX)
  ['{2144CC70-98D0-414C-8D1C-82DE77DBD8DF}']
    function DiagList :TdataSet;
    function FoodReqDet :TDataSet; overload;
    function FoodReqDet(reqID :String) :TDataSet; overload;
    function FoodReqSet(const s :String):TDataSet;
    function FoodReqProp(const reqid :String) :TDataSet;
    function FoodTypeList(const grp,typ :String) :TDataSet;
    function HcDataSet(const p :TRecHcSearch):TDataSet;
    function HcDiagDataSet :TDataSet;
    function IsPatExist(const hn :String):Boolean;
    function IsAdmExist(const an, ward, room, bed :String):Boolean;
    function MaxReqID :String;
    function PatientAdmitDataSet(const an :String):TDataSet;
    //
    procedure DoExecCmd(s :String);
    procedure DoExecFoodReq(reqid :String; p :TRecFactSelect);
    procedure DoStopFoodRequest(const an :String);
    //procedure SavePatientAdmit(p :TRecHcDat);
  end;

  IFraDataX = Interface(IInterface)
  ['{01775B16-9A15-4C42-A412-E7471504BFD8}']
    procedure Contact;
    procedure DataInterface(const IDat :IDataSetX);
    function  DataManage :TClientDataSet;
  end;

  IFraFactData = Interface(IInterface)
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
  End;

  IFraFactTree = Interface(IInterFace)
  ['{94D6AA9B-5BB1-434D-BA85-62E2749D2686}']
    procedure Contact;
    procedure DataInterface(AFact :IFact);
    function  DataManage :TClientDataSet;
  End;

  IFrmFoodReqDataX = Interface(IInterface)
  ['{DBA181A5-F5EE-46E6-B08F-B9EE2A3CD196}']
    procedure Contact;
    procedure DataInterface(const IDat :IFoodReqDataX);
    function  DataManFoodReq :TClientDataSet;
    function  DataManPatAdm :TClientDataSet;
  End;

  IFrmFoodPrepDataX = Interface(IInterface)
  ['{3648FA38-376F-4EB6-B9BA-BC19C1944657}']
    procedure Contact;
    procedure DataInterface(const IDat :IDataSetX);
    function DataManFoodPrep :TClientDataSet;
    function SelectedData :TClientDataSet;
  End;

  IHcSearchDataX = Interface(IDataSetX)
  ['{86F8C282-1F0A-47DA-B3AF-F1B5F28A1B1E}']

  End;

  IMealDataX = Interface(IDataSetX)
  ['{6D516F05-00C3-4E8E-B8D6-46D0023FD183}']
    function MealList :TDataSet;
    function MealItemsList(const mlId:String) :TDataSet;
    procedure SaveMealItems(const mlId:String; items :TStrings);
  End;

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

  TConnectParam = Class
  private
    FParams :TRecConnectParams;
    procedure SetParams(const Value: TRecConnectParams);
  public
    constructor Create(p :TRecConnectParams);
    property Params :TRecConnectParams read FParams write SetParams;
  end;

const C_DELIM    = '=';
      W_DELIM    = '>';

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

{ TRecFactSelect }

function TRecFactSelect.HaveNeededRecs: Boolean;
var bRet : Boolean;
begin
  bRet := (Self.pattype <> '');
  bRet := bRet AND (Self.foodprop1 <> '');

  Result := bRet;
end;

function TRecFactSelect.IsEmptyRecord: Boolean;
var bRet : Boolean;
begin
  //
  bRet := (Self.pattype = '');
  bRet := bRet AND (Self.foodprop1 = '');
  bRet := bRet AND (Self.foodprop2 = '');
  bRet := bRet AND (Self.foodprop3 = '');
  bRet := bRet AND (Self.foodprop4 = '');
  bRet := bRet AND (Self.foodprop5 = '');
  //
  bRet := bRet AND (Self.restrict = '');
  bRet := bRet AND (Self.note = '');
  bRet := bRet AND (Self.countprop = 0);
  //
  Result := bRet;
end;

{ TRecFactTreeInput }

function TRecFactTreeInput.IsEmptyRec: Boolean;
var b :Boolean;
begin
  b := (Self.Code='');
  b := b AND (Self.Desc='');
  b := b AND (Self.Note='');
  Result := b;
end;

end.
