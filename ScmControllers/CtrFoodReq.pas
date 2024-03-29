unit CtrFoodReq;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, StrUtils, SysUtils, ComCtrls,
     //
     ShareCommon, ShareController, ShareInterface, ShareMethod,
     DmFoodReq, FrFoodReq, FrHcSearch, FrPopupMsg;

type
  //
  TRecFoodReq = record
    ReqID, Hn, An, Diag, FoodType :String;
    ReqFr, ReqTo :TDateTime;
    MlFr, MlTo :String;
    AmountAM, AmountPM :Integer;
    Wts, Hts :Extended;
  end;
  //
  TRecKeepReqDat = record
    Diag :String;
    Wts, Hts :Extended;
    function IsEmpty :Boolean;
    procedure Initial;
  end;
  //
  TControllerFoodReq = class(TInterfacedObject, ICtrlReqFoodDet)
  private
    FFoodTypeList     :TStrings;
    FFoodTypeListView :TStrings;
    FDiagList         :TStrings;
    FWardList         :TStrings;
    FFactList         :TStrings;
    //
    FDbDirectMode :Boolean;
    FMode         :Integer;
    FViewReq      :IViewFoodReq;
    //
    FFrFoodReq  :TfrmFoodReq;
    DFoodReq    :IFoodReqDataX;
    FManFoodReq :TClientDataSet;
    FManFoodReqDet :TClientDataSet;
    FManPatAdm  :TClientDataSet;
    FManHcDiag  :TClientDataSet;
    //
    FRecKeep    :TRecKeepReqDat;
    //
    FFrHcSrc    :TfrmHcSearch;
    FBrowseMode :Boolean;
    FlgMsgSaved :Boolean;
    //FListAn     :String;
    //FListHn     :String;
    //
    FCallBackFactSelect :TNotifyEvent;

    //
    FFeedLabel :TRecFeedLabel;
    function CreateModelFoodReq :IFoodReqDataX;
    function CurrentReqID :String;
    //
    procedure DoAddWrite;
    procedure DoDelCancel;
    procedure DoMoveNext;
    procedure DoMovePrev;
    procedure DoNewData;
    procedure DoNewDataCancel;
    //
    procedure DoFoodReqBeforePost(DataSet :TDataSet);
    procedure DoFoodReqAfterInsert(DataSet :TDataSet);
    procedure DoHcSearch;
    procedure DoMakeRequestEndReset;
    procedure DoMakeRequestToEnd;
    function IsEndRequest :Boolean;
    function EndRequestType :String;
    //
    procedure DoAfterFoodReqChanged(src :TDataSource);
    procedure DoAfterHcDataChanged(src :TDataSource);
    procedure DoAfterOpenPatAdm(DataSet :TDataset);
    procedure DoSearchByCond(const s :String);
    procedure DoSetHcData(const ds :TDataSet);overload;
    //function GetFoodRequestingAn :String;
    //function GetFoodRequestingHn :String;
    //
    procedure KeepDiagCode;
    //
    procedure ClearWardList;
    procedure GenerateWardList;
    procedure SetHcDat(const p :TRecHcDat);
    //
    procedure DoSetReqDate;
    //
    procedure DoSelectFoodType;
    function GetFactSelect :TRecFactSelect;
    procedure SetFactSelect(p :TRecFactSelect);
    //
    procedure SetDiag;
    procedure SetDiagFromHistory;
    procedure SetSelectedToRequestDetail(
      p :TRecFactSelect); overload;
    procedure SetSelectedToRequestDetail(
      reqid :String;
      p:TRecFactSelect);  overload;
    procedure SetSelectedToRequestHeader(p :TRecFactSelect);
    //
    procedure GenerateFactList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
    procedure DoCheckDischargePatient;
    procedure DoPointToAN(const s:String);
    procedure OnCommandSearch(Sender :TObject);
    procedure OnCommandInput(Sender :TObject);
    procedure OnEditKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OnLabelDoubleClick(Sender :TObject);
    procedure OnRequestDataChanged(
      Sender: TObject; Field: TField);
    //
    function View :TForm;
    //
    property CallBackFactSelect :TNotifyEvent
      read FCallBackFactSelect write FCallBackFactSelect;
    property FactSelect :TRecFactSelect
      read GetFactSelect write SetFactSelect;
    property DbDirectMode :Boolean
      read FDbDirectMode write FDbDirectMode;

    //ICtrlReqFoodDet
    function DiagDetLabel(const dCode :String) :String;
    function FoodDetLabel(const reqID :String) :String;
    procedure GetFeedLabel(var p:TRecFeedLabel);
  end;

implementation

uses FrFactInput, FrFoodReqInput;

const
  CMP_ACTAW = 'actPatAddWrite';
  CMP_ACTDC = 'actPatDelCanc';
  CMP_ACTNX = 'actPatNext';
  CMP_ACTPV = 'actPatPrev';
  CMP_ACTPN = 'actPatNew';
  //
  CMP_ACTDX = 'actHcDiag';
  CMP_DXHIS = 'actHcDiagHist';
  CMP_ACTSC = 'actHcSearch';
  CMP_ACTSL = 'actSelect';
  CMP_ACTXT = 'actExit';
  //
  CMP_AREQAW = 'actReqAddWrite';
  CMP_AREQDC = 'actReqDelCanc';
  CMP_AREQNX = 'actReqNext';
  CMP_AREQPV = 'actReqPrev';
  CMP_AREQNP = 'actReqNewPat';
  CMP_AREQFT = 'actReqFoodType';
  CMP_AREQEN = 'actReqEnd';
  CMP_AREQENR= 'actReqEndReset'; 
  //
  CMP_AREQFR = 'actReqFr';
  CMP_AREQTO = 'actReqTo';
  CMP_AREQDT = 'actReqDt';
  //
  CMP_DPRQF = 'dpkReqFr';
  CMP_DPRQT = 'dpkReqTo';
  //
  CMP_LBSTIFO = 'lbStopInfo';
  //
  RDO_BYFNAME = 'radByFName';
  RDO_BYHN    = 'radByHn';
  RDO_BYWARD  = 'radByWard';
  //
  SRC_PATADM = 'srcPatAdm';
  SRC_FODREQ = 'srcReq';
  //
  CFM_DEL     = 'ź�����Ź��?';
  CFM_END_REQ = '�׹�ѹ������ش��������';
  CFM_ISNPO   = '�� NPO ���������?';  
  //
  IFM_SAVED = '�ѹ�֡����������';
  //
  WRN_NODAT = '�Ҵ�����ſ�Ŵ� %S';
  WRN_FREQD  = '��س����͡��������´�����������';
                                                              
{ TControllerFoodReq }

constructor TControllerFoodReq.Create;
begin
  Start;
end;

destructor TControllerFoodReq.Destroy;
begin
  FFoodTypeList.Free;
  FFoodTypeListView.Free;
  FDiagList.Free;
  FWardList.Free;
  FFactList.Free;
  //
  FManPatAdm.Free;
  FFrHcSrc.Free;
  //
  FManFoodReq.Free;
  FFrFoodReq.Free;
  inherited;
end;

{public}
function TControllerFoodReq.DiagDetLabel(const dCode: String): String;
var ds :TDataSet; sz :Integer; sCode :String;
begin
  ds := DFoodReq.HcDiagDataSet;
  sz := ds.FieldByName('ACODE').Size;
  sCode := LeftStr(dCode+DupeString(' ',sz),sz);
  //
  if ds.Locate('ACODE',sCode,[]) then
    Result := ds.FieldByName('ADESC').AsString
  else Result := '';
end;

procedure TControllerFoodReq.OnCommandInput(Sender: TObject);
begin
  if Sender Is TCustomAction then begin
    if TCustomAction(Sender).Name=CMP_ACTSC then
      DoHcSearch
    else if TCustomAction(Sender).Name=CMP_AREQAW then
      DoAddWrite
    else if TCustomAction(Sender).Name=CMP_AREQDC then
      DoDelCancel
    else if TCustomAction(Sender).Name=CMP_AREQNX then
      DoMoveNext
    else if TCustomAction(Sender).Name=CMP_AREQPV then
      DoMovePrev
    else if TCustomAction(Sender).Name=CMP_AREQNP then
      DoNewData
    else if TCustomAction(Sender).Name=CMP_AREQDT then
      DoSetReqDate
    else if TCustomAction(Sender).Name=CMP_AREQFT then
      DoSelectFoodType
    else if TCustomAction(Sender).Name=CMP_AREQEN then
      DoMakeRequestToEnd
    else if TCustomAction(Sender).Name=CMP_DXHIS then
      SetDiagFromHistory
    else if TCustomAction(Sender).Name=CMP_ACTDX then
      SetDiag
    else If TCustomAction(Sender).Name=CMP_ACTDC then
      DoNewDataCancel
    else if TCustomAction(Sender).Name=CMP_AREQENR then
      DoMakeRequestEndReset;
      
    //
  end else if Sender Is TDateTimePicker then begin
   //
  end else if Sender is TForm then begin
    DoCheckDischargePatient;
  end;

end;

procedure TControllerFoodReq.OnCommandSearch(Sender: TObject);
begin
  if FFrHcSrc=nil then
    Exit;
  //
  if Sender Is TCustomAction then begin
    if TCustomAction(Sender).Name=CMP_ACTSL then begin
      FFrHcSrc.ModalResult := mrOK;
    end else if TCustomAction(Sender).Name=CMP_ACTXT then begin
      FFrHcSrc.ModalResult := mrCancel;
    end;
  end else if Sender Is TRadioButton then begin
    FFrHcSrc.SetShowWardList(TRadioButton(Sender).Tag=2);
    if TRadioButton(Sender).Name <> RDO_BYWARD then
      ClearWardList
    else GenerateWardList;
  end;
end;

procedure TControllerFoodReq.OnEditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    DoSearchByCond(TEdit(Sender).Text);
end;

procedure TControllerFoodReq.OnLabelDoubleClick(Sender: TObject);
begin
  if TLabel(Sender).Name = CMP_LBSTIFO then
    DoMakeRequestEndReset;
end;

procedure TControllerFoodReq.OnRequestDataChanged(Sender: TObject; Field: TField);
var src :TDataSource;
begin
  if Sender is TDataSource then begin
    src := TDataSource(Sender);
    if src.Name = SRC_PATADM then
      DoAfterHcDataChanged(src)
    else if src.Name = SRC_FODREQ then begin
      if src.DataSet.State=dsBrowse then begin
        DoAfterFoodReqChanged(src);
        KeepDiagCode;
      end;
    end;
  end;
end;

procedure TControllerFoodReq.Start;
begin
  FFoodTypeList     := TStringList.Create;
  FFoodTypeListView := TStringList.Create;
  FDiagList         := TStringList.Create;
  FWardList         := TStringList.Create;
  FFactList         := TStringList.Create;
  //
  FFrFoodReq := TfrmFoodReq.Create(nil);
  FFrFoodReq.DataInterface(CreateModelFoodReq);
  FFrFoodReq.SetActionEvents(OnCommandInput);
  FFrFoodReq.SetEditKeyDownEvents(OnEditKeyDown);
  FFrFoodReq.SetDataChangedEvents(OnRequestDataChanged);
  FFrFoodReq.SetLabelDblClickEvents(OnLabelDoubleClick);
  //
  FManFoodReq := FFrFoodReq.DataManFoodReq;
  FManFoodReq.AfterInsert := DoFoodReqAfterInsert;
  FManFoodReq.BeforePost  := DoFoodReqBeforePost;
  //
  FManFoodReqDet := FFrFoodReq.DataManFoodReqDet;
  //
  FManPatAdm           := FFrFoodReq.DataManPatAdm;
  FManPatAdm.AfterOpen := DoAfterOpenPatAdm;
  //
  FManHcDiag           := FFrFoodReq.DataManDiag;
  //
  Supports(FFrFoodReq, IViewFoodReq, FViewReq);
  //
  FBrowseMode := False;
  FlgMsgSaved := False;
  //
  FMode         := 1;
  FDbDirectMode := False;
  //
  FRecKeep.Initial;
end;

function TControllerFoodReq.View: TForm;
begin
  Result := FFrFoodReq;
end;

{private}
function TControllerFoodReq.CreateModelFoodReq: IFoodReqDataX;
var p :TRecDataXSearch;
begin
  DFoodReq := TDmoFoodReq.Create(nil);
  DFoodReq.SearchKey := p;
  Result   := DFoodReq;
end;

function TControllerFoodReq.CurrentReqID: String;
begin
  Result := FManFoodReq.FieldByName('REQID').AsString;
end;

procedure TControllerFoodReq.DoAddWrite;
var sReqID :String; bChkState :Boolean;
begin
  //
  if (FManFoodReq.State=dsBrowse) then begin
    FManFoodReq.Append;
    FlgMsgSaved := True;
  end else if(FManFoodReq.State in [dsInsert,dsEdit])then begin

    //
    if FManFoodReqDet.IsEmpty then begin
      MessageDlg(WRN_FREQD,mtWarning,[mboK],0);
      Exit;
    end;

    //
    if FManFoodReq.State = dsInsert then begin
      sReqID := DFoodReq.MaxReqID;
      sReqID := NextIpacc(sReqID);
      FManFoodReq.FieldByName('REQID').AsString := sReqID;
    end;

    //
    FManFoodReq.Post;
    FManFoodReq.ApplyUpdates(-1);
    if FlgMsgSaved then begin
      MessageDlg(IFM_SAVED,mtInformation,[mbOK],0);
      FlgMsgSaved := False;
    end;
  end;
  //

  bChkState := (FManPatAdm.State in [dsInsert,dsEdit]);
  bChkState := bChkState and not(FManFoodReq.State in [dsInsert,dsEdit]);
  FlgMsgSaved := bChkState;
  //
  if bchkState then begin
    FManPatAdm.Post;
    FManPatAdm.ApplyUpdates(-1);
    if FlgMsgSaved then begin
      MessageDlg(IFM_SAVED,mtInformation,[mbOK],0);
      FlgMsgSaved := False;
    end;
  end;
end;

procedure TControllerFoodReq.DoAfterFoodReqChanged(src: TDataSource);
var snd :TRecEndRequest;
begin
  FFrFoodReq.PatAdmDataContact(False);
  try
    snd.InitRec;
    if not((src.DataSet=nil)or(src.DataSet.IsEmpty))then begin
      snd.IsEnd   := IsEndRequest;
      snd.EndType := EndRequestType;
    end;
    FFrFoodReq.ShowIsEndRequest(snd);
  finally
    FFrFoodReq.PatAdmDataContact(True);
  end;
end;

procedure TControllerFoodReq.DoAfterHcDataChanged(src :TDataSource);
var snd :TRecFoodReqCalcFields;
    fldTName, fldFName, fldLName, fldBirth :TField;
begin
  if(src.DataSet=nil)or(src.DataSet.IsEmpty)then
    Exit;
  //
  fldTName := src.DataSet.FieldByName('TNAME');
  fldFName := src.DataSet.FieldByName('FNAME');
  fldLName := src.DataSet.FieldByName('LNAME');
  //
  fldBirth := src.DataSet.FieldByName('BIRTH');
  //
  snd.PatName := fldTName.AsString+fldFName.AsString+' '+fldLName.AsString;
  snd.Age     := IntToStr(AgeFrDate(fldBirth.AsDateTime));
  //
  FFrFoodReq.SetCalcFields(snd);
end;

procedure TControllerFoodReq.DoAfterOpenPatAdm(DataSet: TDataset);
begin
  //FListAn :=  GetFoodRequestingAn;
  //FListHn :=  GetFoodRequestingHn;
end;

procedure TControllerFoodReq.DoCheckDischargePatient;
begin
  DFoodReq.DoCheckUpdDischPatient;
end;

procedure TControllerFoodReq.DoDelCancel;
var sReqID, sHn :String;
begin
  //
  if FManFoodReq.State = dsBrowse then begin
    if MessageDlg(CFM_DEL,mtWarning,[mbYes,mbNo],0) = mrYes then begin
      sHn    := FManPatAdm.FieldByName('HN').AsString;
      sReqID := FManFoodReq.FieldByName('REQID').AsString;
      DFoodReq.DoExecDelFoodReq(sReqID);
      //
      FViewReq.Contact('');
      FManPatAdm.Locate('HN',sHn,[]);
    end;
  end else if FManFoodReq.State in [dsInsert,dsEdit] then begin
    FManFoodReq.Cancel;
    FManFoodReq.First;
    FlgMsgSaved := False;
  end;
end;

procedure TControllerFoodReq.DoFoodReqAfterInsert(DataSet: TDataSet);
var sReqID :String;
begin
  sReqID := DFoodReq.MaxReqID;
  sReqID := NextIpacc(sReqID);
  DataSet.FieldByName('REQID').AsString     := sReqID;
  DataSet.FieldByName('REQDATE').AsDateTime := DateOnly(Now);
  //
  if not FRecKeep.IsEmpty then begin
    if FRecKeep.Diag<>'' then
      DataSet.FieldByName('DIAG').AsString  := FRecKeep.Diag;
    if FRecKeep.Hts>0 then
      DataSet.FieldByName('HTS').AsFloat := FRecKeep.Hts;
    if FRecKeep.Wts>0 then
      DataSet.FieldByName('WTS').AsFloat := FRecKeep.Wts;
  end;
end;

procedure TControllerFoodReq.DoFoodReqBeforePost(DataSet: TDataSet);
var fldReqID, fldHn, fldAN, fldDiag :TField;
  procedure CheckFieldNoData(fld :TField);
  begin
    if(fld.IsNull)or(fld.AsString='') then begin
      MessageDlg(Format(WRN_NODAT,[fld.FieldName]),mtWarning,[mbOK],0);
      Abort;
    end;
  end;
begin
  fldReqID := DataSet.FieldByName('REQID');
  fldHn    := DataSet.FieldByName('HN');
  fldAN    := DataSet.FieldByName('AN');
  fldDiag  := DataSet.FieldByName('DIAG');
  //
  CheckFieldNoData(fldReqID);
  CheckFieldNoData(fldHn);
  CheckFieldNoData(fldAN);
  CheckFieldNoData(fldDiag);
end;

procedure TControllerFoodReq.DoHcSearch;
var ds :TDataSet; an :String;
begin
  if not(FManPatAdm.State in [dsInsert, dsEdit])then
    Exit;

  //
  FFrHcSrc := TfrmHcSearch.Create(nil);
  try
    FFrHcSrc.DataInterface(DFoodReq);
    FFrHcSrc.SetActionEvents(OnCommandSearch);
    //FFrHcSrc.SetFoodRequestedAnList(FListAn);
    //FFrHcSrc.SetFoodRequetedHnList(FListHn);

    //
    ds := FFrHcSrc.AnswerSet;
    if ds = nil then
      Exit;

    an := ds.FieldByName('AN').AsString;
    with DFoodReq.PatientAdmitDataSet(an) do begin
      if IsEmpty then begin
        DoSetHcData(ds);
      end else begin
        if FManPatAdm.State = dsInsert then
          FManPatAdm.Cancel;
        FManPatAdm.Locate('AN',an,[]);
      end;
    end;
    
  finally
    //FFrHcSrc.Free;  comment because invalid pointer operation
  end;
end;

procedure TControllerFoodReq.DoMakeRequestEndReset;
var sAn :String;
const c_msg_endreset = '¡��ԡ�����ش��������';
begin
  sAn := FManFoodReq.FieldByName('AN').AsString;
  if(MessageDlg(c_msg_endreset,mtConfirmation,[mbYes,mbNo],0)=mrYes)then begin
    DFoodReq.DoResetFoodRequestEnd(sAn);
  end;
  //
  if Assigned(FViewReq) then begin
    FViewReq.Contact;
    FManPatAdm.Locate('AN',sAn,[]);
  end;
end;

procedure TControllerFoodReq.DoMakeRequestToEnd;
var sAn, sSel :String;
    sLst :TStrings;
    vLst :Variant; //b :Boolean;
const c_msg_endtype = '  ���͡�����������ش�����';
      c_endtype     = '����ӧ������(NPO)| ��Ѻ��ҹ���Ǥ���|��ش����';
begin
  sAn := FManFoodReq.FieldByName('AN').AsString;
  if(MessageDlg(CFM_END_REQ,mtConfirmation,[mbYes,mbNo],0)=mrYes)then begin
    AssignStringList(sLst,'|',c_endtype);
    try
      vLst := StringListToArrayVariant(sLst);
      sSel := PopMessage(c_msg_endtype,vLst);
      if sSel = C_ReqEndType_XXX then
        Exit;
      DFoodReq.DoStopFoodRequest(sAn,sSel);
    finally
      sLst.Free;
    end;
  end;
  //
  if Assigned(FViewReq) then begin
    FViewReq.Contact;
    FManPatAdm.Locate('AN',sAn,[]);
  end;
end;

procedure TControllerFoodReq.DoMoveNext;
begin
  if FManPatAdm.Eof then
    FManPatAdm.Last
  else FManPatAdm.Next;
end;

procedure TControllerFoodReq.DoMovePrev;
begin
  if FManPatAdm.Bof then
    FManPatAdm.First
  else FManPatAdm.Prior;
end;

procedure TControllerFoodReq.DoNewData;
begin
  if not((FManPatAdm.State=dsBrowse)and(FManFoodReq.State=dsBrowse))then
    Exit;
  //
  FFrFoodReq.DoClearSearchPatient;
  //
  FManPatAdm.Append;
  FlgMsgSaved := True;
end;

procedure TControllerFoodReq.DoNewDataCancel;
begin

  //
  if FManFoodReq.State in [dsInsert,dsEdit] then begin
    FManFoodReq.Cancel;
    FManFoodReq.First;
    FlgMsgSaved := False;
  end;

  //
  if FManPatAdm.State in [dsInsert,dsEdit] then begin
    FManPatAdm.Cancel;
    FManPatAdm.First;
    FlgmsgSaved := False;
  end;

end;

procedure TControllerFoodReq.DoPointToAN(const s: String);
begin
  if FManPatAdm.IsEmpty then
    Exit;
  FManPatAdm.Locate('AN',s,[]);
end;

procedure TControllerFoodReq.DoSearchByCond(const s: String);
const cnd_hn='hn=';
var   sSrcDat :String;
begin
  if Pos(cnd_hn,s)>0 then begin
    sSrcDat := Copy(s,Pos(cnd_hn,s)+3,Length(s));
    ssrcDat := RightStr('       '+sSrcDat,7);
    if sSrcDat<>'' then
      FManPatAdm.Locate('HN',sSrcDat,[]);
  end;
end;

procedure TControllerFoodReq.DoSelectFoodType;
begin
  if Assigned(FCallBackFactSelect)then
    FCallBackFactSelect(Self);
end;

procedure TControllerFoodReq.DoSetHcData(const ds: TDataSet);
//
var
snd :TRecHcDat;
fldWts, fldHts :TField;
//
const
cfm_bedno_isempty = '����բ�������§ ��ͧ��ù���Ң������������' ;
//
begin
  if(FManPatAdm.State in [dsInsert,dsEdit])then begin
    snd.InitRec;
    snd.Hn  := TrimRight(ds.FieldByName('HN').AsString);
    snd.An  := TrimRight(ds.FieldByName('AN').AsString);
    snd.PID := ds.FieldByName('PID').AsString;
    //
    snd.TName   := Trimright(ds.FieldByName('TName').AsString);
    snd.FName   := TrimRight(ds.FieldByName('FNAME').AsString);
    snd.LName   := TrimRight(ds.FieldByName('LNAME').AsString);
    snd.PatName := TrimRight(ds.FieldByName('PATNAME').AsString);
    //
    if ds.FieldByName('GENDER').AsString = '�' then
      snd.Gender := 'M'
    else snd.Gender := 'F';
    //
    if Pos('/',ds.FieldByName('BIRTH').AsString)>0 then
    snd.Birth := ds.FieldByName('BIRTH').AsDateTime
    else snd.Birth := YmdToDate(ds.FieldByName('BIRTH').AsString);
    snd.Age := AgeFrDate(snd.Birth);

    fldWts  := ds.FindField('WTS');
    if fldWts<>nil then
      snd.Wt  := fldWts.AsString;

    fldHts  := ds.FindField('HTS');
    if fldHts<>nil then
      snd.Ht  := fldHts.AsString;
    //
    snd.WardID   := ds.FieldByName('WARDID').AsString;
    snd.WardName := ds.FieldByName('WARDNAME').AsString;

    if POS('/',ds.FieldByName('ADMITDATE').AsString)>0 then
      snd.AdmitDt  := ds.FieldByName('ADMITDATE').AsDateTime
    else snd.AdmitDt  := YmdHmToDate(ds.FieldByName('ADMITDATE').AsString);

    if POS('/',ds.FieldByName('ADMITDATE').AsString)>0 then
      snd.DiscDt   := ds.FieldByName('DISCHDATE').AsDateTime
    else snd.DiscDt   := YmdHmToDate(ds.FieldByName('DISCHDATE').AsString);
    //
    snd.RoomNo := ds.FieldByName('ROOMNO').AsString;
    snd.BedNo  := ds.FieldByName('BEDNO').AsString;
    //
    snd.RelgCode := ds.FieldByName('REGCODE').AsString;
    snd.RelgDesc := ds.FieldByName('REGDES').AsString;
    //
    if not snd.IsHaveBedNo then begin
      if MessageDlg(cfm_bedno_isempty,mtWarning,[mbYes,mbNo],0)=mrNo then begin
        //auto cancel may be no need
        {if FManPatAdm.State in [dsInsert,dsEdit] then
          FManPatAdm.Cancel;}
        Abort;
      end;
    end;
    //
    SetHcDat(snd);
    //
    FBrowseMode := False;
  end;
end;

procedure TControllerFoodReq.DoSetReqDate;
var frm :TfrmFactInputter; snd :TRecCaptionTmpl;
begin
  if(FManFoodReq.State=dsBrowse) then
    FManFoodReq.Edit;
  //
  frm := TfrmFactInputter.Create(nil);
  try
    snd.Initial;
    snd.IsSetDateTime := True;
    if not frm.Answer(snd) then
      Exit;
  finally
    frm.Free;
  end;
  //
  snd.Dt := DateOnly(snd.Dt);
  FManFoodReq.FieldByName('REQDATE').AsDateTime := snd.Dt
end;

function TControllerFoodReq.EndRequestType: String;
begin
  Result := (FManFoodReq.FieldByName('REQENDTYPE').AsString);
end;

function TControllerFoodReq.FoodDetLabel(const reqID :String): String;
var ds :TDataSet;  iCode :Integer;
    sCode, sRet, sPatType, sFood, sExcept, sFreeText:String;
    sFGrp, sFPrt, sFeedType, sFeedMeal :String;
//
const replace_str = '������';
      //
      c_space = ' ';
      c_newline = chr(13)+chr(10);
//
  function FoodDetail(p :String):String;
  var fCode, fDesc :String;
  begin
    //
    Result := '';
    if ds.IsEmpty then
      Exit;
    //
    GenerateFactList;
    //
    fCode := ds.FieldByName('REQCODE').AsString;
    fDesc := ds.FieldByName('REQDESC').AsString;
    if FFactList.IndexOf(fCode)<>-1 then
      sFood := Copy(sFood,1,Length(sFood)-2)+' '+fDesc+c_newline
    else sFood  := sFood+'-'+fDesc+c_space;
    //
    Result := sFood;
  end;

begin
  ds := DFoodReq.FoodReqDet(reqID);
  //
  if not ds.IsEmpty then begin
    FFeedLabel.Reset;
    //
    sFGrp := ds.FieldByName('FGRP').AsString;
    repeat
      iCode := StrToIntDef(Copy(ds.FieldByName('REQCODE').AsString,1,4),0);
      sCode := Copy(IntToStr(iCode),1,1);
      iCode := StrToInt(sCode);
      //
      case iCode of
        0 : sFreeText := ds.FieldByName('REQDESC').AsString;
        1 : sPatType  := ds.FieldByName('REQDESC').AsString;
        2 : sFood     := FoodDetail(sFood);
        3 : sExcept   := ds.FieldByName('REQDESC').AsString;
      end;

      //feed label
      sFPrt := ds.FieldByName('FPRT').AsString;
      if(iCode=2)then begin
        if sFPrt='FTY' then begin
          if TrimRight(ds.FieldByName('REQDESC').AsString)<>'' then begin
            if (Pos(':',sFeedType)>0) then
              sFeedType := ds.FieldByName('REQDESC').AsString+' '+sFeedType
            else sFeedType :=  sFeedType+' '+ds.FieldByName('REQDESC').AsString
          end;
        end else if sFPrt='FME' then begin
          if TrimRight(ds.FieldByName('REQDESC').AsString)<>'' then
            sFeedMeal := sFeedMeal+' '+ds.FieldByName('REQDESC').AsString;
        end;
      end;

      ds.Next
    until ds.Eof;

    FFeedLabel.FeedType := sFeedType;
    FFeedLabel.FeedMeal := sFeedMeal;
    FFeedLabel.FeedText := sExcept+' '+sFreeText;
  end;
  //
  sRet := sFGrp+' '+ StringRePlace(sPatType,replace_str,'',[rfReplaceAll]);
  sRet := sRet+c_newline;
  sRet := sRet+sFood+sExcept+c_newline+sFreeText;
  //
  Result := sRet;
end;

procedure TControllerFoodReq.ClearWardList;
var wList :TStrings;
begin
  wList := FFrHcSrc.WardList;
  wList.Clear;
end;

procedure TControllerFoodReq.GenerateFactList;
var ds :TDataSet; sVal :String;
begin
  if FFactList.Count>0 then
    Exit;

  //
  sVal := DFoodReq.GetMiscValue(C_Misc_Concat);
  if sVal='' then
    Exit;

  //
  ds := DFoodReq.FactByGroup(sVal);
  if ds.IsEmpty then
    Exit;

  //
  repeat
    FFactList.Append(ds.FieldByName('CODE').AsString);
    ds.Next;
  until ds.Eof;

end;

procedure TControllerFoodReq.GenerateWardList;
var ds :TDataSet; sWard :String;
begin
   if FWardList.Count = 0 then begin
     //
     ds := DFoodReq.HcWardDataSet;
     if ds.IsEmpty then
       Exit;
     repeat
       sWard := ds.FieldByName('ward').AsString;
       FWardList.Append(sWard);
       ds.Next;
     until ds.Eof;
   end;
   //
   FFrHcSrc.WardList.Assign(FWardList);
end;

function TControllerFoodReq.GetFactSelect: TRecFactSelect;
var snd :TRecFactSelect;
    fldPatType, fldProp1, fldProp2, fldRestr, fldReqDesc :TField;
    fldReqID, fldCode :TField;
var ds :TDataSet; cnt :Integer;
begin
  //
  fldReqID   := FManFoodReq.FieldByName('REQID');
  fldPatType := FManFoodReq.FieldByName('PATTYPE');
  fldProp1   := FManFoodReq.FieldByName('FOODPROP1');
  fldProp2   := FManFoodReq.FieldByName('FOODPROP2');
  fldRestr   := FManFoodReq.FieldByName('FOODRESTR');
  fldReqDesc := FManFoodReq.FieldByName('FOODREQDESC');
  //
  snd.pattype   := fldPatType.AsString;
  snd.foodprop1 := fldProp1.AsString;
  snd.foodprop2 := fldProp2.AsString;
  snd.restrict  := fldRestr.AsString;
  snd.reqdesc   := fldReqDesc.AsString;
  //
  ds := DFoodReq.FoodReqProp(fldReqID.AsString);
  if not ds.IsEmpty then begin
    cnt     := 0;
    fldCode := ds.FieldByName('CODE');
    repeat
      Inc(cnt);
      case cnt of
      1 : snd.foodprop3 := fldCode.AsString;
      2 : snd.foodprop4 := fldCode.AsString;
      3 : snd.foodprop5 := fldCode.AsString;
      4 : snd.foodprop6 := fldCode.AsString;
      end;
      //
      ds.Next;
    until ds.Eof ;
  end;
  //
  Result := snd;
end;

procedure TControllerFoodReq.GetFeedLabel(var p: TRecFeedLabel);
begin
  p := FFeedLabel;
end;

function TControllerFoodReq.IsEndRequest: Boolean;
begin
  Result := (FManFoodReq.FieldByName('REQEND').AsString='Y');
end;

procedure TControllerFoodReq.KeepDiagCode;
begin
  FRecKeep.Diag := FManFoodReq.FieldByName('DIAG').AsString;
  FRecKeep.Hts  := FManFoodReq.FieldByName('HTS').AsFloat;
  FRecKeep.Wts  := FManFoodReq.FieldByName('WTS').AsFloat;
end;

procedure TControllerFoodReq.SetDiag;
var frm :TfrmFoodReqInputter; p :TRecSearch;
begin
  frm := TfrmFoodReqInputter.Create(nil);
  try
     p.Ds := FManHcDiag;
     if frm.Answer(p) then begin
       if FManFoodReq.State in [dsInsert,dsEdit] then
         FManFoodReq.FieldByName('DIAG').AsString := p.ACode;
     end;
  finally
    frm.Free;
  end;
end;

procedure TControllerFoodReq.SetDiagFromHistory;
var frm :TfrmFactInputter; snd :TRecCaptionTmpl;
    ds :TDataSet; Hn :String;
begin
  //
  Hn := FManFoodReq.FieldByName('HN').AsString;
  ds := DFoodReq.DiagHist(Hn);
  //
  frm := TfrmFactInputter.Create(nil);
  try
    frm.SetDiagHist(ds);
    //
    snd.Initial;
    snd.IsSetDiagHist := True;
    if frm.Answer(snd) then begin
      if FManFoodReq.State in [dsInsert,dsEdit] then
        FManFoodReq.FieldByName('DIAG').AsString := frm.DiagCode
      else if FManFoodReq.State = dsBrowse then begin
        FManFoodReq.Edit;
        FManFoodReq.FieldByName('DIAG').AsString := frm.DiagCode;
        FManFoodReq.Post;
        FManFoodReq.ApplyUpdates(-1);
      end;
    end;
  finally
    frm.Free;
  end;
end;

procedure TControllerFoodReq.SetFactSelect(p: TRecFactSelect);
begin
  if FDbDirectMode then begin
    DFoodReq.DoExecFoodReq(CurrentReqID,p);
    FFrFoodReq.DoProvideFoodReqDet;
  end else begin
     SetSelectedToRequestHeader(p);
     case FMode of
     1 : SetSelectedToRequestDetail(p);
     2 : SetSelectedToRequestDetail(CurrentReqID,p);
     end;
  end;
end;

procedure TControllerFoodReq.SetHcDat(const p: TRecHcDat);
var fHn, fAn, fGender, fBirth :TField;
    fTName, fFName, fLName, fWId, fWName, fPID, fAdmDt, fDscDt :TField;
    fRoom, fBed, fRelgC, fRelgD :TField;
begin
  fHn := FManPatAdm.FieldByName('HN');
  fAn := FManPatAdm.FieldByName('AN');
  fPID     := FManPatAdm.FieldByName('PID');
  //
  fTName   := FManPatAdm.FieldByName('TNAME');
  fFName   := FManPatAdm.FieldByName('FNAME');
  fLName   := FManPatAdm.FieldByName('LNAME');
  //
  fGender  := FManPatAdm.FieldByName('GENDER');
  fBirth   := FManPatAdm.FieldByName('BIRTH');
  fWId     := FManPatAdm.FieldByName('WARDID');
  fWName   := FManPatAdm.FieldByName('WARDNAME');
  fAdmDt   := FManPatAdm.FieldByName('ADMITDATE');
  fDscDt   := FManPatAdm.FieldByName('DISCHDATE');
  fRoom    := FManPatAdm.FieldByName('ROOMNO');
  fBed     := FManPatAdm.FieldByName('BEDNO');
  //
  fRelgC   := FManPatAdm.FieldByName('RELGCODE');
  fRelgD   := FManPatAdm.FieldByName('RELGDESC');
  //

  fHn.AsString  := p.Hn;
  fAn.AsString  := p.An;
  fPID.AsString := p.PID;
  //
  fTName.AsString   := p.TName;
  fFName.AsString   := p.FName;
  fLName.AsString   := p.LName;
  //
  fGender.AsString  := p.Gender;
  fBirth.AsDateTime := p.Birth;
  fWId.AsString     := p.WardID;
  fWName.AsString   := p.WardName;
  fAdmDt.AsDateTime := p.AdmitDt;
  fDscDt.AsDateTime := p.DiscDt;
  fRoom.AsString    := p.RoomNo;
  fBed.AsString     := p.BedNo;
  //
  fRelgC.AsString   := p.RelgCode;
  fRelgD.AsString   := p.RelgDesc;
end;

procedure TControllerFoodReq.SetSelectedToRequestDetail(p: TRecFactSelect);
var sLstDet :TStrings; sFoodProp, sReqID :String; i, iRn:Integer;
begin

  sLstDet := TStringList.Create;
  try
    //
    sLstDet.Delimiter     := W_DELIM;
    sLstDet.DelimitedText := p.reqdesc;
    //

    if FManPatAdm.State in [dsInsert,dsEdit] then begin
      FManPatAdm.Post;
      FManPatAdm.ApplyUpdates(-1);
    end;
    //
    if FManFoodReq.State in [dsInsert,dsEdit] then begin
      FManFoodReq.Post;
      FManFoodReq.ApplyUpdates(-1);
    end;

    if FManPatAdm.ChangeCount>0 then
      FManPatAdm.ApplyUpdates(-1);

    if FManFoodReq.ChangeCount>0 then
      FManFoodReq.ApplyUpdates(-1);

    sReqID  := FManFoodReq.FieldByName('REQID').AsString;
    //
    if not FManFoodReqDet.IsEmpty then begin
      FManFoodReqDet.DisableControls;
      try
        repeat
          FManFoodReqDet.Delete;
        until FManFoodReqDet.Eof;
        //
        if FManFoodReqDet.ChangeCount>0 then
          FManFoodReqDet.ApplyUpdates(-1);
      finally
        FManFoodReqDet.EnableControls;
      end;
    end;


    //
    iRn := 0;
    if p.pattype >'' then begin
      Inc(iRn);
      FManFoodReqDet.AppendRecord([sReqID,
                                   p.pattype,
                                   sLstDet.Values[p.pattype],
                                   iRn]);
    end;

    //
    for i := 1 to 6 do begin
      case i of
      1: sFoodProp := p.foodprop1;
      2: sFoodProp := p.foodprop2;
      3: sFoodProp := p.foodprop3;
      4: sFoodProp := p.foodprop4;
      5: sFoodProp := p.foodprop5;
      6: sFoodProp := p.foodprop6;
      end;
      //
      if (sFoodProp>'')and
         (sLstDet.Values[sFoodProp]>'')and
         (length(sFoodProp)=8) then begin
        Inc(iRn);
        FManFoodReqDet.AppendRecord([sReqID,
                                     sFoodProp,
                                     sLstDet.Values[sFoodProp],
                                     iRn]);
      end;
    end;
    //
    if p.restrict>'' then begin
      Inc(iRn);
      FManFoodReqDet.AppendRecord([sReqID,
                                   p.restrict,
                                   sLstDet.Values[p.restrict],
                                   iRn]);
    end;

    if p.note>'' then begin
      Inc(iRn);
      FManFoodReqDet.AppendRecord([sReqID,
                                   'freetext',
                                   p.note,
                                   iRn]);
    end;
    //
    if FManFoodReqDet.ChangeCount>0 then
      FManFoodReqDet.ApplyUpdates(-1);

  finally
    sLstDet.Free
  end;
end;

procedure TControllerFoodReq.SetSelectedToRequestDetail(
  reqid: String;
  p: TRecFactSelect);
var ds :TDataSet;
//
function GetDesc(s :String):String;
begin
  Result := '';
  if not Assigned(ds)then
    ds := DFoodReq.FoodTypeList('','');
  if ds.Locate('CODE',s,[]) then
    Result := ds.FieldByName('FDES').AsString;
end;
//
procedure AppendReq(const reqid, reqcode, reqdesc : String);
begin
  if Length(reqCode)<>8 then
    Exit;
  FManFoodReqDet.Append;
  FManFoodReqDet.FieldByName('REQID').AsString := reqid;
  FManFoodReqDet.FieldByName('REQCODE').AsString := reqcode;
  FManFoodReqDet.FieldByName('REQDESC').AsString := reqdesc;
  FManFoodReqDet.Post;
end;

begin
  //
  if not FManFoodReqDet.IsEmpty then begin
    FManFoodReqDet.DisableControls;
    try
      repeat
        FManFoodReqDet.Delete;
        FManFoodReqDet.ApplyUpdates(-1);
      until FManFoodReqDet.Eof
    finally
      FManFoodReqDet.EnableControls;
    end;
  end;
  //
  if p.pattype >'' then
    AppendReq(reqid, p.pattype, GetDesc(p.pattype));
  //
  AppendReq(reqid,p.foodprop1,GetDesc(p.foodprop1));
  AppendReq(reqid,p.foodprop2,GetDesc(p.foodprop2));
  AppendReq(reqid,p.foodprop3,GetDesc(p.foodprop3));
  AppendReq(reqid,p.foodprop4,GetDesc(p.foodprop4));
  AppendReq(reqid,p.foodprop5,GetDesc(p.foodprop5));
  AppendReq(reqid,p.foodprop6,GetDesc(p.foodprop6));
  //
  if p.restrict>'' then
    AppendReq(reqid,p.restrict,GetDesc(p.restrict));
  //
  if p.note>'' then
    AppendReq(reqID,'freetext',p.note);
  //
  if FManFoodReqDet.ChangeCount>0 then
    FManFoodReqDet.ApplyUpdates(-1);
end;

procedure TControllerFoodReq.SetSelectedToRequestHeader(p: TRecFactSelect);
var fldPatType, fldProp1, fldProp2, fldRestr, fldReqDesc :TField;
begin
  //
  fldPatType := FManFoodReq.FieldByName('PATTYPE');
  fldProp1   := FManFoodReq.FieldByName('FOODPROP1');
  fldProp2   := FManFoodReq.FieldByName('FOODPROP2');
  fldRestr   := FManFoodReq.FieldByName('FOODRESTR');
  fldReqDesc := FManFoodReq.FieldByName('FOODREQDESC');

  if FManFoodReq.State=dsBrowse then begin
    FManFoodReq.Edit;
    FlgMsgSaved := True;
  end;
    //
  fldPatType.AsString := p.pattype;
  fldProp1.AsString   := p.foodprop1;
  fldProp2.AsString   := p.foodprop2;
  fldRestr.AsString   := p.restrict;
  fldReqDesc.AsString := p.reqdesc;
end;

{ TRecKeepReqDat }

procedure TRecKeepReqDat.Initial;
begin
  Self.Diag := '';
  Self.Hts  := 0;
  Self.Wts  := 0;
end;

function TRecKeepReqDat.IsEmpty: Boolean;
begin
  Result := (Self.Diag='')and(Self.Hts=0)and(Self.Wts=0);
end;

end.


