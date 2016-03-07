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
    FFoodTypeListView :TStrings;
    FDiagList     :TStrings;
    //
    FFrFoodReq  :TfrmFoodReq;
    FFoodReq    :IFoodReqDataX;
    FManFoodReq :TClientDataSet;
    FManPatAdm  :TClientDataSet;
    //
    FFrHcSrc    :TfrmHcSearch;
    FBrowseMode :Boolean;
    FListHn     :String;
    function CreateModelFoodReq :IFoodReqDataX;
    //
    procedure DoAddWrite(const cds :TClientDataSet);
    procedure DoDelCancel(const cds :TClientDataSet);
    procedure DoMoveNext(const cds :TClientDataSet);
    procedure DoMovePrev(const cds :TClientDataSet);
    //
    procedure DoFoodReqAfterInsert(DataSet :TDataSet);
    procedure DoFoodReqBeforePost(DataSet :TDataSet);
    procedure DoGenerateDiagList;
    procedure DoGenerateFoodTypeList;
    procedure DoHcSearch;
    //
    procedure DoAfterOpenPatAdm(DataSet :TDataset);
    procedure DoSearchByCond(const s :String);
    procedure DoSetHcData(const ds :TDataSet);overload;
    function GetFoodRequestingHn :String;
    //
    procedure SetHcDat(const p :TRecHcDat);
    //
    procedure DoSetReqFrTo(fr :Boolean);
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
    procedure OnHcDataChanged(
      Sender: TObject; Field: TField);
    function View :TForm;
  end;

implementation

uses FrFactInput;

const
  CMP_ACTAW = 'actPatAddWrite';
  CMP_ACTDC = 'actPatDelCanc';
  CMP_ACTNX = 'actPatNext';
  CMP_ACTPV = 'actPatPrev';
  //
  CMP_ACTSC = 'actHcSearch';
  CMP_ACTSL = 'actSelect';
  CMP_ACTXT = 'actExit';
  //
  CMP_AREQAW = 'actReqAddWrite';
  CMP_AREQDC = 'actReqDelCanc';
  CMP_AREQNX = 'actReqNext';
  CMP_AREQPV = 'actReqPrev';
  //
  CMP_AREQFR = 'actReqFr';
  CMP_AREQTO = 'actReqTo';
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
  FFoodTypeListView.Free;
  FDiagList.Free;
  //
  FManPatAdm.Free;
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
      DoAddWrite(FManPatAdm)
    else if TCustomAction(Sender).Name=CMP_ACTDC then
      DoDelCancel(FManPatAdm)
    else if TCustomAction(Sender).Name=CMP_ACTNX then
      DoMoveNext(FManPatAdm)
    else if TCustomAction(Sender).Name=CMP_ACTPV then
      DoMovePrev(FManPatAdm)
    else if TCustomAction(Sender).Name=CMP_ACTSC then
      DoHcSearch
    else if TCustomAction(Sender).Name=CMP_AREQAW then
      DoAddWrite(FManFoodReq)
    else if TCustomAction(Sender).Name=CMP_AREQDC then
      DoDelCancel(FManFoodReq)
    else if TCustomAction(Sender).Name=CMP_AREQNX then
      DoMoveNext(FManFoodReq)
    else if TCustomAction(Sender).Name=CMP_AREQPV then
      DoMovePrev(FManFoodReq)
    else if TCustomAction(Sender).Name=CMP_AREQFR then
      DoSetReqFrTo(True)
    else if TCustomAction(Sender).Name=CMP_AREQTO then
      DoSetReqFrTo(False);
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

procedure TControllerFoodReq.OnHcDataChanged(Sender: TObject; Field: TField);
var src :TDataSource;  snd :TRecFoodReqCalcFields;
    fldTName, fldFName, fldLName, fldBirth :TField;
begin
  if Sender is TDataSource then begin
    src := TDataSource(Sender);
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
end;

procedure TControllerFoodReq.Start;
begin
  FFoodTypeList     :=  TStringList.Create;
  FFoodTypeListView := TStringList.Create;
  FDiagList         := TStringList.Create;
  //
  FFrFoodReq := TfrmFoodReq.Create(nil);
  FFrFoodReq.DataInterface(CreateModelFoodReq);
  FFrFoodReq.SetActionEvents(OnCommandInput);
  FFrFoodReq.SetEditKeyDownEvents(OnEditKeyDown);
  FFrFoodReq.SetDataChangedEvents(OnHcDataChanged);
  //
  FManFoodReq := FFrFoodReq.DataManFoodReq;
  FManFoodReq.AfterInsert := DoFoodReqAfterInsert;
  FManFoodReq.BeforePost  := DoFoodReqBeforePost;
  //
  FManPatAdm           := FFrFoodReq.DataManPatAdm;
  FManPatAdm.AfterOpen := DoAfterOpenPatAdm;
  //
  DoGenerateDiagList;
  DoGenerateFoodTypeList;
  //
  FBrowseMode := False;
  //
end;

function TControllerFoodReq.View: TForm;
begin
  Result := FFrFoodReq;
end;

{private}
function TControllerFoodReq.CreateModelFoodReq: IFoodReqDataX;
var p :TRecDataXSearch;
begin
  FFoodReq := TDmoFoodReq.Create(nil);
  FFoodReq.SearchKey := p;
  Result   := FFoodReq;
end;

procedure TControllerFoodReq.DoAddWrite(const cds: TClientDataSet);
begin
  if cds.State = dsBrowse then begin
    cds.Append;
  end else if cds.State in [dsInsert,dsEdit] then begin
    cds.Post;
    cds.ApplyUpdates(-1);
    MessageDlg(IFM_SAVED,mtInformation,[mbOK],0);
    //
    if  FFrFoodReq.IsPatSequenceAppend then
      DoAddWrite(cds);
  end;
end;

procedure TControllerFoodReq.DoAfterOpenPatAdm(DataSet: TDataset);
begin
  FListHn :=  GetFoodRequestingHn;
end;

procedure TControllerFoodReq.DoDelCancel(const cds: TClientDataSet);
begin
  if cds.State = dsBrowse then begin
    if MessageDlg(CFM_DEL,mtWarning,[mbYes,mbNo],0) = mrYes then begin
      cds.Delete;
      cds.ApplyUpdates(-1);
    end;
  end else if cds.State in [dsInsert,dsEdit] then begin
    cds.Cancel;
  end;
end;

procedure TControllerFoodReq.DoFoodReqAfterInsert(DataSet: TDataSet);
var sReqID :String;
begin
  sReqID := FFoodReq.MaxReqID;
  sReqID := NextIpacc(sReqID);
  DataSet.FieldByName('REQID').AsString := sReqID;
end;

procedure TControllerFoodReq.DoFoodReqBeforePost(DataSet: TDataSet);
var idx :Integer;
begin
  idx := FFoodTypeListView.IndexOf(DataSet.FieldByName('FOODTYPE').AsString);
  if idx >-1 then
    DataSet.FieldByName('FOODTYPC').AsString := FFoodTypeList.Names[idx];
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
var ds :TDataSet; sList :String;
begin
  ds :=  FFoodReq.FoodTypeList('01','%');
  if not ds.IsEmpty then begin
    //
    FFoodTypeList.Clear;
    FFoodTypeList.Delimiter := '|';
    FFoodTypeList.QuoteChar := '"';
    FFoodTypeList.StrictDelimiter := True;
    //
    FFoodTypeListView.Clear;
    ds.First;
    repeat
      FFoodTypeListView.Append(ds.Fields[1].AsString);
      sList := sList+ds.Fields[0].AsString+'='+QuotedStr(ds.Fields[1].AsString)+'|';
      ds.Next;
    until ds.Eof;
    sList := Copy(sList,1,Length(sList)-1);
    FFoodTypeList.DelimitedText := sList;
    FFrFoodReq.SetListFoodType(FFoodTypeListView);
  end;
end;

procedure TControllerFoodReq.DoHcSearch;
var ds :TDataSet;  s :String;
begin
  if not(FManPatAdm.State in [dsInsert, dsEdit])then
    Exit;
  //
  s := GetFoodRequestingHn;
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

procedure TControllerFoodReq.DoMoveNext(const cds: TClientDataSet);
begin
  if cds.Eof then
    cds.Last
  else cds.Next;
end;

procedure TControllerFoodReq.DoMovePrev(const cds: TClientDataSet);
begin
  if cds.Bof then
    cds.First
  else cds.Prior;
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

procedure TControllerFoodReq.DoSetHcData(const ds: TDataSet);
var snd :TRecHcDat; //sRq :TRecFoodReq; sReqID :String;
    fldWts, fldHts :TField;
begin
  if(FManPatAdm.State in [dsInsert,dsEdit])then begin

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
    snd.RelgCode := ds.FieldByName('REGCODE').AsString;
    snd.RelgDesc := ds.FieldByName('REGDES').AsString;
    //
    SetHcDat(snd);
    //
    FBrowseMode := False;
  end;
end;

procedure TControllerFoodReq.DoSetReqFrTo(fr: Boolean);
var frm :TfrmFactInputter; snd :TRecCaptionTmpl;
begin
  if(FManFoodReq.State=dsBrowse) then
    FManFoodReq.Edit;
  //
  frm := TfrmFactInputter.Create(nil);
  try
    snd.IsSetDateTime := True;
    if not frm.Answer(snd) then
      Exit;
  finally
    frm.Free;
  end;
  //
  snd.Dt := DateOnly(snd.Dt);
  if fr then
    FManFoodReq.FieldByName('REQFR').AsDateTime := snd.Dt
  else FManFoodReq.FieldByName('REQTO').AsDateTime := snd.Dt;
end;

function TControllerFoodReq.GetFoodRequestingHn: String;
var bk :TBookmark; sRes, s :String;
begin
  if (FManPatAdm.State<>dsBrowse)or(FManPatAdm.IsEmpty)then
    Exit;
  bk := FManPatAdm.GetBookmark;
  FManPatAdm.DisableControls;
  try
    FManPatAdm.First;
    repeat
      s    := Format('%*s',[7,FManPatAdm.FieldByName('HN').AsString]);
      sRes := sRes+s+',';
      //
      FManPatAdm.Next;
    until FManPatAdm.Eof;
  finally
    FManPatAdm.GotoBookmark(bk);
    FManPatAdm.EnableControls;
    FManPatAdm.FreeBookmark(bk);
  end;
  sRes := Copy(sRes,1,Length(sRes)-1);
  Result := sRes;
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

procedure TControllerFoodReq.SetReqFrTo(const dt: TDateTime; fr: Boolean);
begin
  if not(FManFoodReq.State in [dsInsert,dsEdit])then
    Exit;
  if fr then
    FManFoodReq.FieldByName('REQFR').AsDateTime := dt
  else FManFoodReq.FieldByName('REQTO').AsDateTime := dt;
end;

end.
