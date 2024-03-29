unit ShareCommon;

interface

uses Classes, SysUtils, DB, DBClient, Forms;

type

  TEnumLup = (eluFoodType);

  TEnumUserType = (utAdmin,utUser);

  TEnumReqEndType = (retNPO=Ord('N'),retGHM=Ord('H'));

  TEnumServiceCallBack = (scReq=Ord('R'),scNone=Ord('N'));

  TFactDataType = (fdtUser=Ord('U'),fdtMaterial=Ord('M'));

  TRecCaptionTmpl = record
    CurrentText, Caption, GroupCode :String;
    Dt :TDateTime;
    IsSetDateTime :Boolean;
    IsSetDiagHist :Boolean;
    procedure Initial;
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
    foodprop4, foodprop5, foodprop6 :String;
    //foodselect : Array of String;
    //
    restrict, reqdesc, note :String;
    countprop :Integer;
    //
    function HaveNeededRecs :Boolean;    
    function IsEmptyRecord :Boolean;
  end;

  TRecFactTreeInput = record
    Code, Desc, Note, Prop :String;
    IsSubLevel, IsSlipPrn :Boolean;
    function IsEmptyRec :Boolean;
  end;

  TRecFeedLabel = record
    FeedType, FeedMeal, FeedText :String;
    procedure Reset;
  end;

  TRecHcDat = record
    Hn, An, PID, TName, FName, LName: String;
    PatName, Gender, Ht, Wt :String;
    Birth, AdmitDt, DiscDt :TDateTime;
    Age :Integer;
    WardID, WardName, RoomNo, BedNo :String;
    RelgCode, RelgDesc :String;
    function IsHaveBedNo :Boolean;
    procedure InitRec;
  end;

  TRecHcSearch = record
    SearchTxt, ListAn, ListHn :String;
    Selector : Integer;
  end;

  TRecSetInputItem = record
    PageIndex : Integer;
    AFrame    : TFrame;
  end;

  TRecGenCode = record
    FGrc, FTyc :String;
  end;

  TRecSearch = record
    ACode, ADesc :String;
    Ds :TDataSet;
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

  TRecFactGroup = record
    FGRC,FGRP :String;
    FLEV : Integer;
    NOTE, FPRP, PCOD, SLIPPRN :String;
  end;

  TRecConnectParams = record
    Server,Database,User,Password :String;
  end;
  //
  TRecGetReport = record
    FrDate, ToDate :TDateTime;
    Index :Integer;
  end;
  //
  TRecSetReportParamInputter = record
    IsFrDate, IsGrDate, IsToDate :Boolean;
    function ResetDate :TRecSetReportParamInputter;
    function SetFrDate :TRecSetReportParamInputter;
    function SetRangeDate :TRecSetReportParamInputter;
  end;

  //
  TRecEndRequest = record
    IsEnd :Boolean;
    EndType :String;
    procedure InitRec;
  end;

  //
  TRecPrintData = record
    DateBirth, DatePrint :TDateTime;
    Hn,  PatLoc, PatName, Diag, Food, Meal, ReqID :String;
    Age, ComDis, MealFmt, PrnDateStr, Relg :String;
    FeedType, FeedMeal, FeedText :String;
    function IsFeed :Boolean;
  end;

  //
  TRecServiceCallBack = record
    CallBackID :TEnumServiceCallBack;
    CallBackValue :String;
  end;

  //
  TEditKeyDown = procedure(Sender: TObject;
                           var Key: Word;
                           Shift: TShiftState) of object;

  //
  TSendUserRecEvent = procedure(pUsr :TRecUser) of Object;

  //
  TEventServiceCallBack = procedure(pCall :TRecServiceCallBack) of Object;


// �����������ش�Ӣ������
const C_ReqEndType_NPO = 'N'; //����ӧ������
      C_ReqEndType_GHM = 'H'; //��Ѻ��ҹ����Ǥ���
      C_ReqEndType_PER = ' '; //��ش����ö���
      C_ReqEndType_XXX = 'X'; //�����ش�����

      C_Misc_Concat = 'CCAT';

implementation

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

{ TRecCaptionTmpl }

procedure TRecCaptionTmpl.Initial;
begin
  Self.CurrentText := '';
  Self.Caption     := '';
  Self.GroupCode   := '';
  Self.Dt          := 0;
  Self.IsSetDateTime := False;
  Self.IsSetDiagHist := False;
end;

{ TRecSetReportParamInputter }

function TRecSetReportParamInputter.ResetDate: TRecSetReportParamInputter;
begin
  IsFrDate := False;
  IsGrDate := False;
  IsToDate := False;
  Result   := Self;
end;

function TRecSetReportParamInputter.SetFrDate: TRecSetReportParamInputter;
begin
  IsFrDate := True;
  IsGrDate := True;
  IsToDate := False;
  Result   := Self;
end;

function TRecSetReportParamInputter.SetRangeDate: TRecSetReportParamInputter;
begin
  IsFrDate := True;
  IsGrDate := True;
  IsToDate := True;
  Result   := Self;
end;

{ TRecHcDat }

procedure TRecHcDat.InitRec;
begin
    Hn    := '';
    An    := '';
    PID   := '';
    TName := '';
    FName := '';
    LName :='';
    PatName := '';
    Gender  := '';
    Ht      := '';
    Wt      := '';
    Birth   := 0;
    AdmitDt := 0;
    DiscDt  := 0;
    Age     := 0;
    WardID  := '';
    WardName := '';
    RoomNo   := '';
    BedNo    := '';
    RelgCode := '';
    RelgDesc := '';
end;

function TRecHcDat.IsHaveBedNo: Boolean;
begin
  Result := (Trim(Self.BedNo)<>'')
end;

{ TRecEndRequest }

procedure TRecEndRequest.InitRec;
begin
  Self.IsEnd   := False;
  Self.EndType := '';
end;

{ TRecPrintData }

function TRecPrintData.IsFeed: Boolean;
begin
  Result := (FeedType<>'')and(FeedMeal<>'');
end;

{ TRecFeedLabel }

procedure TRecFeedLabel.Reset;
begin
  FeedType := '';
  FeedMeal := '';
  FeedText := '';
end;

end.
