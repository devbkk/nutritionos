unit CtrFoodReq;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, StrUtils, SysUtils, ComCtrls,
     //
     ShareInterface, ShareMethod,
     DmFoodReq, FrFoodReq, FrHcSearch;

type
  //
  TRecHcDat = record
    Hn, An, PID, PatName, Gender, Ht, Wt :String;
    Age :Integer;
    WardID, WardName :String;
  end;
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
    function CreateModelFoodReq :IDataSetX;
    procedure DoAddWrite;
    procedure DoCancelDel;
    procedure DoFoodReqAfterInsert(DataSet :TDataSet);
    procedure DoGenerateDiagList;
    procedure DoGenerateFoodTypeList;
    procedure DoHcSearch;
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

{ TControllerFoodReq }
constructor TControllerFoodReq.Create;
begin
  Start;
end;

destructor TControllerFoodReq.Destroy;
begin
  FFoodTypeList.Free;
  FDiagList.Free;
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

procedure TControllerFoodReq.OnFoodReqDetDataChanged(
  Sender: TObject;  Field: TField);
var src :TDataSource; dtFr, dtTo :TDateTime;
begin
  if Sender is TDataSource then begin
    src := TDataSource(Sender);
    if(src.DataSet=nil)or(src.DataSet.IsEmpty)then
      Exit;
    dtFr := FManFoodReq.FieldByName('REQFR').AsDateTime;
    dtTo := FManFoodReq.FieldByName('REQTO').AsDateTime;
    //
    FFrFoodReq.SetReqFrTo(dtFr,dtTo);
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
  //
  FManFoodReq := FFrFoodReq.DataManFoodReq;
  FManFoodReq.AfterInsert := DoFoodReqAfterInsert;
  //
  FManHcData  := FFrFoodReq.DataManHcData;
  //
  DoGenerateDiagList;
  DoGenerateFoodTypeList;
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
    FManFoodReq.Post;
    FManFoodReq.ApplyUpdates(-1);
    //
    if  FFrFoodReq.IsSqeuenceAppend then
      DoAddWrite;
  end;
  //
  if FManHcData.State=dsBrowse then begin
    FManHcData.Append;
  end else if FManHcData.State in [dsInsert,dsEdit] then begin
    //FManHcData.Post;
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
  end;
  //
  if FManHcData.State = dsBrowse then begin
    {if MessageDlg(CFM_DEL,mtWarning,[mbYes,mbNo],0) = mrYes then begin
      FManHcData.Delete;
      FManHcData.ApplyUpdates(-1);
    end;}
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
  FFrHcSrc := TfrmHcSearch.Create(nil);
  FFrHcSrc.DataInterface(FFoodReq);
  FFrHcSrc.SetActionEvents(OnCommandSearch);
  //
  ds := FFrHcSrc.AnswerSet;
  if ds = nil then
    Exit;
  DoSetHcData(ds);
end;

procedure TControllerFoodReq.DoSetHcData(const ds: TDataSet);
var snd :TRecHcDat; sRq :TRecFoodReq; sReqID :String;
begin
  if (FManHcData.State in [dsInsert,dsEdit])and
     (FManFoodReq.State in [dsInsert,dsEdit]) then begin

    snd.Hn  := TrimRight(ds.FieldByName('HN').AsString);
    snd.An  := TrimRight(ds.FieldByName('AN').AsString);
    snd.PID := ds.FieldByName('PID').AsString;
    snd.PatName := TrimRight(ds.FieldByName('PATNAME').AsString);
    //
    if ds.FieldByName('GENDER').AsString = 'ช' then
      snd.Gender := 'M'
    else snd.Gender := 'F';
    //
    snd.Age := AgeFrYmdDate(ds.FieldByName('BIRTH').AsString);
    snd.Wt  := ds.FieldByName('WTS').AsString;
    snd.Ht  := ds.FieldByName('HTS').AsString;
    //
    snd.WardID   := ds.FieldByName('WARDID').AsString;
    snd.WardName := ds.FieldByName('WARDNAME').AsString;
    //
    SetHcDat(snd);
    //
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
var fHn, fAn, fPatName, fGender, fAge, fHt, fWt :TField;
    fWId, fWName, fPID :TField;
begin
  fHn := FManHcData.FieldByName('HN');
  fAn := FManHcData.FieldByName('AN');
  fPatName := FManHcData.FieldByName('PATNAME');
  fGender  := FManHcData.FieldByName('GENDER');
  fAge     := FManHcData.FieldByName('AGE');
  fHt      := FManHcData.FieldByName('HTS');
  fWt      := FManHcData.FieldByName('WTS');
  fWId     := FManHcData.FieldByName('WARDID');
  fWName   := FManHcData.FieldByName('WARDNAME');
  fPID     := FManHcData.FieldByName('PID');
  //
  fHn.AsString := p.Hn;
  fAn.AsString := p.An;
  fPatName.AsString := p.PatName;
  fGender.AsString  := p.Gender;
  fAge.AsInteger    := p.Age;
  fHt.AsString      := p.Ht;
  fWt.AsString      := p.Wt;
  fWId.AsString     := p.WardID;
  fWName.AsString   := p.WardName;
end;

procedure TControllerFoodReq.SetReqFrTo(const dt: TDateTime; fr: Boolean);
begin
  if fr then
    FManFoodReq.FieldByName('REQFR').AsDateTime := dt
  else FManFoodReq.FieldByName('REQTO').AsDateTime := dt;
end;

end.
