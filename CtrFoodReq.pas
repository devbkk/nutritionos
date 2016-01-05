unit CtrFoodReq;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, StrUtils, SysUtils, ComCtrls,
     //
     ShareInterface, ShareMethod,
     DmFoodReq, FrFoodReq, FrHcSearch;

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
  TControllerFoodReq = class
  private
    FFoodTypeList :TStrings;
    FDiagList     :TStrings;
    //
    FFrFoodReq  :TfrmFoodReq;
    FFoodReq    :IFoodReqDataX;
    FManFoodReq :TClientDataSet;
    FManHcData  :TClientDataSet;
    //
    FFrHcSrc    :TfrmHcSearch;
    FBrowseMode :Boolean;
    function CreateModelFoodReq :IDataSetX;
    procedure DoAddWrite;
    procedure DoCancelDel;
    procedure DoMoveNext;
    procedure DoMovePrev;
    procedure DoFoodReqAfterInsert(DataSet :TDataSet);
    procedure DoGenerateDiagList;
    procedure DoGenerateFoodTypeList;
    procedure DoHcSearch;
    procedure DoSavePatientAdmit;
    procedure DoSearch;
    procedure DoSearchByCond(const s :String);
    procedure DoSetHcData(const s :String);overload;
    procedure DoSetHcData(const ds :TDataSet);overload;
    //
    procedure SetFoodReq(const p :TRecFoodReq);
    procedure SetHcDat(const p :TRecHcDat);
    procedure SetReqFrTo(const dt :TDateTime;fr:Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
    procedure OnCommandSearch(Sender :TObject);
    procedure OnCommandInput(Sender :TObject);
    procedure OnEditKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OnFoodReqDetDataChanged(
      Sender: TObject; Field: TField);
    function View :TForm;
  end;

implementation

const
  CMP_ACTAW = 'actAddWrite';
  CMP_ACTDC = 'actDelCanc';
  CMP_ACTNX = 'actNext';
  CMP_ACTPV = 'actPrev';
  CMP_ACTSC = 'actHcSearch';
  CMP_ACTSL = 'actSelect';
  CMP_ACTXT = 'actExit';
  //
  CMP_DPRQF = 'dpkReqFr';
  CMP_DPRQT = 'dpkReqTo';
  //
  CFM_DEL   = 'ลบข้อมูลนี้?';
  IFM_SAVED = 'บันทึกข้อมูลแล้ว';

{ TControllerFoodReq }
constructor TControllerFoodReq.Create;
begin
  Start;
end;

destructor TControllerFoodReq.Destroy;
begin
  FFoodTypeList.Free;
  FDiagList.Free;
  //
  FManHcData.Free;
  FFrHcSrc.Free;
  //
  FManFoodReq.Free;
  FFrFoodReq.Free;
  inherited;
end;

{public}
procedure TControllerFoodReq.OnCommandInput(Sender: TObject);
begin
  if Sender Is TCustomAction then begin
    if TCustomAction(Sender).Name=CMP_ACTAW then
      DoAddWrite
    else if TCustomAction(Sender).Name=CMP_ACTDC then
      DoCancelDel
    else if TCustomAction(Sender).Name=CMP_ACTNX then
      DoMoveNext
    else if TCustomAction(Sender).Name=CMP_ACTPV then
      DoMovePrev
    else if TCustomAction(Sender).Name=CMP_ACTSC then
      DoHcSearch;
  end else if Sender Is TDateTimePicker then begin
    if TDateTimePicker(Sender).Name=CMP_DPRQF then
      SetReqFrTo(TDateTimePicker(Sender).DateTime,True)
    else if TDateTimePicker(Sender).Name=CMP_DPRQT then
      SetReqFrTo(TDateTimePicker(Sender).DateTime,False);
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
  end;
end;

procedure TControllerFoodReq.OnEditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    DoSearchByCond(TEdit(Sender).Text);
end;

procedure TControllerFoodReq.OnFoodReqDetDataChanged(
  Sender: TObject;  Field: TField);
var src :TDataSource; dtFr, dtTo :TDateTime;
    //ds :TDataset; sAn :String;
begin
  if Sender is TDataSource then begin
    src := TDataSource(Sender);
    if(src.DataSet=nil)or(src.DataSet.IsEmpty)then
      Exit;
    dtFr := FManFoodReq.FieldByName('REQFR').AsDateTime;
    dtTo := FManFoodReq.FieldByName('REQTO').AsDateTime;
    //
    FFrFoodReq.SetReqFrTo(dtFr,dtTo);
    //
    if FManHcData.State = dsBrowse then begin
      DoSearch;
    end;
  end;
end;

procedure TControllerFoodReq.Start;
begin
  FFoodTypeList := TStringList.Create;
  FDiagList     := TStringList.Create;
  //
  FFrFoodReq := TfrmFoodReq.Create(nil);
  FFrFoodReq.DataInterface(CreateModelFoodReq);
  FFrFoodReq.SetActionEvents(OnCommandInput);
  FFrFoodReq.SetDataChangedEvents(OnFoodReqDetDataChanged);
  FFrFoodReq.SetEditKeyDownEvents(OnEditKeyDown);
  //
  FManFoodReq := FFrFoodReq.DataManFoodReq;
  FManFoodReq.AfterInsert := DoFoodReqAfterInsert;
  FManFoodReq.IndexFieldNames := 'REQID';
  //
  FManHcData  := FFrFoodReq.DataManHcData;
  //
  DoGenerateDiagList;
  DoGenerateFoodTypeList;
  //
  FBrowseMode := False;
end;

function TControllerFoodReq.View: TForm;
begin
  Result := FFrFoodReq;
end;

{private}
function TControllerFoodReq.CreateModelFoodReq: IDataSetX;
var p :TRecDataXSearch;
begin
  FFoodReq := TDmoFoodReq.Create(nil);
  FFoodReq.SearchKey := p;
  Result   := FFoodReq;
end;

procedure TControllerFoodReq.DoAddWrite;
begin
  if FManFoodReq.State = dsBrowse then begin
    FManFoodReq.Append;
    FFrFoodReq.FocusFirst;
  end else if FManFoodReq.State in [dsInsert,dsEdit] then begin
    DoSavePatientAdmit;
    FManFoodReq.Post;
    FManFoodReq.ApplyUpdates(-1);
    MessageDlg(IFM_SAVED,mtInformation,[mbOK],0);
    //
    if  FFrFoodReq.IsSqeuenceAppend then
      DoAddWrite;
  end;
  //
  if FManHcData.State=dsBrowse then begin
    FManHcData.Append;
  end else if FManHcData.State in [dsInsert,dsEdit] then begin

  end;
end;

procedure TControllerFoodReq.DoCancelDel;
begin
  if FManFoodReq.State = dsBrowse then begin
    if MessageDlg(CFM_DEL,mtWarning,[mbYes,mbNo],0) = mrYes then begin
      FManFoodReq.Delete;
      FManFoodReq.ApplyUpdates(-1);
    end;
  end else if FManFoodReq.State in [dsInsert,dsEdit] then begin
    FManFoodReq.Cancel;
    DoSearch;
  end;
  //
  if FManHcData.State = dsBrowse then begin

  end else if FManHcData.State in [dsInsert,dsEdit] then begin
    FManHcData.Cancel;
  end;
end;

procedure TControllerFoodReq.DoFoodReqAfterInsert(DataSet: TDataSet);
begin
//
end;

procedure TControllerFoodReq.DoGenerateDiagList;
var ds :TDataSet;
begin
  ds :=  FFoodReq.DiagList;
  if not ds.IsEmpty then begin
    FDiagList.Clear;
    ds.First;
    repeat
      FDiagList.Append(ds.Fields[0].AsString);
      ds.Next;
    until ds.Eof;
    FFrFoodReq.SetListDiag(FDiagList);
  end;
end;

procedure TControllerFoodReq.DoGenerateFoodTypeList;
var ds :TDataSet;
begin
  ds :=  FFoodReq.FoodTypeList;
  if not ds.IsEmpty then begin
    FFoodTypeList.Clear;
    ds.First;
    repeat
      FFoodTypeList.Append(ds.Fields[0].AsString);
      ds.Next;
    until ds.Eof;
    FFrFoodReq.SetListFoodType(FFoodTypeList);
  end;
end;

procedure TControllerFoodReq.DoHcSearch;
//var sAns :String;
var ds :TDataSet;
begin
  if not(FManHcData.State in [dsInsert, dsEdit])then
    Exit;
  //
  FFrHcSrc := TfrmHcSearch.Create(nil);
  FFrHcSrc.DataInterface(FFoodReq);
  FFrHcSrc.SetActionEvents(OnCommandSearch);
  //
  ds := FFrHcSrc.AnswerSet;
  if ds = nil then
    Exit;
  DoSetHcData(ds);
end;

procedure TControllerFoodReq.DoMoveNext;
begin
  if FManFoodReq.Eof then
    FManFoodReq.Last
  else FManFoodReq.Next;
end;

procedure TControllerFoodReq.DoMovePrev;
begin
  if FManFoodReq.Bof then
    FManFoodReq.First
  else FManFoodReq.Prior;
end;

procedure TControllerFoodReq.DoSavePatientAdmit;
var snd :TRecHcDat;
begin
  snd.Hn  := FManHcData.FieldByName('HN').AsString;
  snd.An  := FManHcData.FieldByName('AN').AsString;
  snd.PID := FManHcData.FieldByName('PID').AsString;
  //
  snd.TName   := FManHcData.FieldByName('TNAME').AsString;
  snd.FName   := FManHcData.FieldByName('FNAME').AsString;
  snd.LName   := FManHcData.FieldByName('LNAME').AsString;
  snd.PatName := FManHcData.FieldByName('PATNAME').AsString;
  //
  snd.Gender   := FManHcData.FieldByName('GENDER').AsString;
  snd.Birth    := FManHcData.FieldByName('BIRTH').AsDateTime;
  snd.WardID   := FManHcData.FieldByName('WARDID').AsString;
  snd.WardName := FManHcData.FieldByName('WARDNAME').AsString;
  snd.AdmitDt  := FManHcData.FieldByName('ADMITDATE').AsDateTime;
  snd.DiscDt   := FManHcData.FieldByName('DISCHDATE').AsDateTime;
  snd.RoomNo   := FManHcData.FieldByName('ROOMNO').AsString;
  snd.BedNo    := FManHcData.FieldByName('BEDNO').AsString;
  //
  FFoodReq.SavePatientAdmit(snd);
end;

procedure TControllerFoodReq.DoSearch;
var ds :TDataSet; sAn :String;
begin
  FBrowseMode := True;
  FManHcData.EmptyDataSet;
  FManHcData.Append;
  sAn := FManFoodReq.FieldByName('AN').AsString;
  ds  := FFoodReq.PatientAdmitDataSet(sAn);
  DoSetHcData(ds);
  FManHcData.Post;
end;

procedure TControllerFoodReq.DoSearchByCond(const s: String);
const cnd_hn='hn=';
var   sSrcDat :String;
begin
  if Pos(cnd_hn,s)>0 then begin
    sSrcDat := Copy(s,Pos(cnd_hn,s)+3,Length(s));
    ssrcDat := RightStr('       '+sSrcDat,7);
    if sSrcDat<>'' then
      FManFoodReq.Locate('HN',sSrcDat,[]);
  end;
end;

procedure TControllerFoodReq.DoSetHcData(const ds: TDataSet);
var snd :TRecHcDat; sRq :TRecFoodReq; sReqID :String;
    fldWts, fldHts :TField;
begin
  if(FManHcData.State in [dsInsert,dsEdit])then begin

    snd.Hn  := TrimRight(ds.FieldByName('HN').AsString);
    snd.An  := TrimRight(ds.FieldByName('AN').AsString);
    snd.PID := ds.FieldByName('PID').AsString;
    //
    snd.TName   := Trimright(ds.FieldByName('TName').AsString);
    snd.FName   := TrimRight(ds.FieldByName('FNAME').AsString);
    snd.LName   := TrimRight(ds.FieldByName('LNAME').AsString);
    snd.PatName := TrimRight(ds.FieldByName('PATNAME').AsString);
    //
    if ds.FieldByName('GENDER').AsString = 'ช' then
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
    SetHcDat(snd);
    //
    if not FBrowseMode then begin
      if(FManFoodReq.State in [dsInsert,dsEdit])then begin
        sReqID := FFoodReq.MaxReqID;
        sReqID := NextIpacc(sReqID);
        //
        sRq.ReqID := sReqID;
        sRq.Hn    := snd.Hn;
        sRq.An    := snd.An;
        sRq.Wts   := StrToFloatDef(snd.Wt,0);
        sRq.Hts   := StrToFloatDef(snd.Ht,0);
        //
        SetFoodReq(sRq);
      end;
    end;
    FBrowseMode := False;
  end;
end;

procedure TControllerFoodReq.DoSetHcData(const s: String);
var sHn, sAn, sPatName {, sGender} :String;
//    sAge, sHeight, sWeight :String;
    sList :TStrings;
begin
  if FManHcData.State in [dsInsert,dsEdit] then begin
    sList := TStringList.Create;
    try
      sList.Delimiter := '|';
      sList.DelimitedText := s;
      sHn := TrimRight(sList[4]);
      sAn := TrimRight(sList[0]);
      sPatName := TrimRight(sList[10]);
      //
      FManHcData.AppendRecord([sHn,sAn,sPatName]);
    finally
      sList.Free;
    end;
  end;
end;

procedure TControllerFoodReq.SetFoodReq(const p: TRecFoodReq);
var fReqID, fHn, fAn, fDiag, fFoodType, fReqFr, fReqTo :TField;
    fMlFr, fMlTo, fAmountAM, fAmountPM, fWts, fHts :TField;
begin
  fReqID := FManFoodReq.FieldByName('REQID');
  fHn    := FManFoodReq.FieldByName('HN');
  fAn    := FManFoodReq.FieldByName('AN');
  fDiag  := FManFoodReq.FieldByName('DIAG');
  fFoodType := FManFoodReq.FieldByName('FOODTYPE');
  fReqFr := FManFoodReq.FieldByName('REQFR');
  fReqTo := FManFoodReq.FieldByName('REQTO');
  fMlFr  := FManFoodReq.FieldByName('MLFR');
  fMlTo  := FManFoodReq.FieldByName('MLTO');
  fAmountAM := FManFoodReq.FieldByName('AMOUNTAM');
  fAmountPM := FManFoodReq.FieldByName('AMOUNTPM');
  fWts      := FManFoodReq.FieldByName('WTS');
  fHts      := FManFoodReq.FieldByName('HTS');
  //
  fReqID.AsString := p.ReqID;
  fHn.AsString    := p.Hn;
  fAn.AsString    := p.An;
  fDiag.AsString  := p.Diag;
  fFoodType.AsString := p.FoodType;
  fReqFr.AsDateTime  := p.ReqFr;
  fReqTo.AsDateTime  := p.ReqTo;
  fMlFr.AsString     := p.MlFr;
  fMlTo.AsString     := p.MlTo;
  fAmountAM.AsInteger := p.AmountAM;
  fAmountPM.AsInteger := p.AmountPM;
  fHts.AsFloat        := p.Hts;
  fWts.AsFloat        := p.Wts;
end;

procedure TControllerFoodReq.SetHcDat(const p: TRecHcDat);
var fHn, fAn, fPatName, fGender, fBirth, fAge, fHt, fWt :TField;
    fTName, fFName, fLName, fWId, fWName, fPID, fAdmDt, fDscDt :TField;
    fRoom, fBed :TField;
begin
  fHn := FManHcData.FieldByName('HN');
  fAn := FManHcData.FieldByName('AN');
  fPID     := FManHcData.FieldByName('PID');
  //
  fTName   := FManHcData.FieldByName('TNAME');
  fFName   := FManHcData.FieldByName('FNAME');
  fLName   := FManHcData.FieldByName('LNAME');
  fPatName := FManHcData.FieldByName('PATNAME');
  //
  fGender  := FManHcData.FieldByName('GENDER');
  fBirth   := FManHcData.FieldByName('BIRTH');
  fAge     := FManHcData.FieldByName('AGE');
  fHt      := FManHcData.FieldByName('HTS');
  fWt      := FManHcData.FieldByName('WTS');
  fWId     := FManHcData.FieldByName('WARDID');
  fWName   := FManHcData.FieldByName('WARDNAME');
  fAdmDt   := FManHcData.FieldByName('ADMITDATE');
  fDscDt   := FManHcData.FieldByName('DISCHDATE');
  fRoom    := FManHcData.FieldByName('ROOMNO');
  fBed     := FManHcData.FieldByName('BEDNO');
  //
  fHn.AsString  := p.Hn;
  fAn.AsString  := p.An;
  fPID.AsString := p.PID;
  //
  fTName.AsString   := p.TName;
  fFName.AsString   := p.FName;
  fLName.AsString   := p.LName;
  fPatName.AsString := p.PatName;
  //
  fGender.AsString  := p.Gender;
  fBirth.AsDateTime := p.Birth;
  fAge.AsInteger    := p.Age;
  fHt.AsString      := p.Ht;
  fWt.AsString      := p.Wt;
  fWId.AsString     := p.WardID;
  fWName.AsString   := p.WardName;
  fAdmDt.AsDateTime := p.AdmitDt;
  fDscDt.AsDateTime := p.DiscDt;
  fRoom.AsString    := p.RoomNo;
  fBed.AsString     := p.BedNo;
end;

procedure TControllerFoodReq.SetReqFrTo(const dt: TDateTime; fr: Boolean);
begin
  if not(FManFoodReq.State in [dsInsert,dsEdit])then
    Exit;
  if fr then
    FManFoodReq.FieldByName('REQFR').AsDateTime := dt
  else FManFoodReq.FieldByName('REQTO').AsDateTime := dt;
end;

end.
