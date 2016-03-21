unit CtrFact;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, DBGrids, DBCtrls, SysUtils,
     ShareInterface, FaFactData, FrFactInput, FrFactSelect,
     DmFactDat;

type
   TControllerFact = class
   private
     FfraInpDat :TfraFactData;
     FFact      :IFact;
     FManFact   :TClientDataSet;
     FManFaGrps :TClientDataSet;
     FFtypList  :TStrings;
     FFactTypeSearch :String;
     FGenCode   :TRecGenCode;
     function CreateModelFact :IFact;
   public
     constructor Create;
     destructor Destroy; override;
     procedure Start;
     //
     procedure DoFactAddWrite;
     procedure DoFactCancelDel;
     procedure DoGenerateFactTypeList;
     procedure DoRequestInputter(const pFldName :String);
     //
     procedure OnFactCommandInput(Sender :TObject);
     procedure OnFactDataChange(Sender: TObject; Field: TField);
     procedure OnFactTypeCloseUp(Sender :TObject);
     procedure OnFactTypeDblClick(Sender :TObject);
     procedure OnFactTypeKeyDown(Sender: TObject;
                                 var Key:
                                 Word; Shift: TShiftState);
     procedure OnFactTypeTimerSearch(Sender :TObject);
     //
     procedure OnManFactAfterInsert(DataSet :TDataSet);
     //
     function View :TFrame;
   end;

   TControllerFactSelect = class
   private
     FFact     :IFact;
     FFrFaSel  :TfrmFactselect;
     FRecFaSel :TRecFactSelect;
     function CheckFactProperty(ds :TDataSet; lv :Integer):Boolean;     
     function CreateModelFactSelect :IFact;
     procedure LoadDatas(
       ds :TDataSet; cb:TComboBox; bFirst:Boolean=False);
     procedure LoadMainLookUps;
   public
     constructor Create;
     destructor Destroy; override;
     procedure Start;
     //
     procedure OnButtonOK(Sender :TObject);
     procedure OnSelectFactType(Sender :TObject);
     function View :TForm;
     property FactSelect :TRecFactSelect read FRecFaSel;
   end;

implementation

const
  //FACT TYPE
  FLD_FTY   = 'FTYP';
  FLD_NOT   = 'NOTE';
  //
  CMP_ACTAW = 'actAddWrite';
  CMP_ACTDC = 'actDelCanc';
  CMP_ACTNX = 'actNext';
  CMP_ACTPV = 'actPrev';
  CMP_ACTFG = 'actFactGroup';
  //
  CFM_DEL   = 'ลบข้อมูลนี้?';
  IFM_SAVED = 'บันทึกข้อมูลแล้ว';
  //
  GRD_COL_NOTE = 'NOTE';
  //
  CBO_FACTL1 = 'cboFoodTypeL1';
  CBO_FACTL2 = 'cboFoodTypeL2';
  CBO_FACTL3 = 'cboFoodTypeL3';
  CBO_FACTL4 = 'cboFoodTypeL4';

{ TControllerFact }

constructor TControllerFact.Create;
begin
  Start;
end;

destructor TControllerFact.Destroy;
begin
  FfraInpDat.Free;
  FFtypList.Free;
  //
  FManFact.Free;
  FfraInpDat.Free;
end;

procedure TControllerFact.DoFactAddWrite;
begin
  if FManFact.State = dsBrowse then begin
    FManFact.Append;
    //FManFact.FieldByName('FGRC').AsString := FManFaGrps.FieldByName('FGRC').AsString;
    FfraInpDat.FocusFirstCell;
  end else if FManFact.State in [dsInsert,dsEdit] then begin
    if FManFact.State = dsInsert then begin
      {FManFact.FieldByName(FLD_FTY).AsString := FfraInpDat.FactType;
      if FManFact.FieldByName(FLD_NOT).IsNull then
        FManFact.FieldByName(FLD_NOT).AsString := '';}
    end;
    FManFact.Post;
    FManFact.ApplyUpdates(-1);
    if FfraInpDat.IsSqeuenceAppend then
      DoFactAddWrite
    else MessageDlg(IFM_SAVED,mtInformation,[mbOK],0);
    //
    {DoGenerateFactTypeList;
    if FfraInpDat.IsSqeuenceAppend then
      DoFactAddWrite;}
  end;
end;

procedure TControllerFact.DoFactCancelDel;
begin
  if FManFact.State = dsBrowse then begin
    if MessageDlg(CFM_DEL,mtWarning,[mbYes,mbNo],0) = mrYes then begin
      FManFact.Delete;
      FManFact.ApplyUpdates(-1);
    end;
  end else if FManFact.State in [dsInsert,dsEdit] then begin
    FManFact.Cancel;
  end;
end;

procedure TControllerFact.DoGenerateFactTypeList;
var ds :TDataSet;
begin
  ds := FFact.FactTypeDataSet;
  if not ds.IsEmpty then begin
    FFtypList.Clear;
    ds.First;
    repeat
      FFtypList.Append(ds.Fields[0].AsString);
      ds.Next;
    until ds.Eof;
    FfraInpDat.SetFactTypeList(FFtypList);
  end;
end;

procedure TControllerFact.DoRequestInputter(const pFldName: String);
var frm :TfrmFactInputter;  par :String; snd :TRecCaptionTmpl;
begin
  frm := TfrmFactInputter.Create(nil);
  try
    //
    snd.CurrentText   := FManFact.FieldByName('NOTE').AsString;
    //
    par := FManFact.FieldByName('PCOD').AsString;
    snd.Caption := FFact.GetCaptionTemplate(par);
    //
    snd.GroupCode     := FGenCode.FGrc;
    snd.IsSetDateTime := False;
    snd.Dt            := 0;
    //
    frm.Answer(snd);
    if snd.CurrentText>'' then begin
      if FManFact.State = dsBrowse then begin
        FManFact.Edit;
        FManFact.FieldByName(pFldName).AsString := snd.CurrentText;
        FManFact.Post;
        FManFact.ApplyUpdates(-1);
      end else if FManFact.State in [dsInsert,dsEdit] then begin
        FManFact.FieldByName(pFldName).AsString := snd.CurrentText;
      end;
    end;
    //
  finally
    //frm.Free; comment because invalid pointer operation
  end;
end;

procedure TControllerFact.OnFactCommandInput(Sender: TObject);
var grd :TDBGrid;
begin
  if Sender is TCustomAction then begin
    if TCustomAction(Sender).Name=CMP_ACTAW then
      DoFactAddWrite
    else if TCustomAction(Sender).Name=CMP_ACTDC then
      DoFactCancelDel
    else if TCustomAction(Sender).Name=CMP_ACTFG then
      FfraInpDat.ContactFactGroup;
  end else if Sender is TDBGrid then begin
    grd := TDBGrid(Sender);
    if grd.SelectedField.FieldName = GRD_COL_NOTE then
      DoRequestInputter(GRD_COL_NOTE);
  end;
end;

procedure TControllerFact.OnFactDataChange(Sender: TObject; Field: TField);
var src :TDataSource;
begin
  if Sender is TDataSource then begin
    src := TDataSource(Sender);
    if(src.DataSet=nil)or(src.DataSet.IsEmpty)then
      Exit;
  end;
end;

procedure TControllerFact.OnFactTypeCloseUp(Sender: TObject);
var snd :TRecFactSearch;
begin
  if Sender is TDBLookupComboBox  then begin
    snd.ftyp := TDBLookupComboBox(Sender).KeyValue;
    FFact.SearchKey := snd;
    FfraInpDat.SetFactDataSet;
  end;
end;

procedure TControllerFact.OnFactTypeDblClick(Sender: TObject);
begin
//
end;

procedure TControllerFact.OnFactTypeKeyDown(
  Sender: TObject;
  var Key: Word;
  Shift: TShiftState);
begin
  FfraInpDat.SetTimerSearch(True);
  FFactTypeSearch := TComboBox(Sender).Text;
end;

procedure TControllerFact.OnFactTypeTimerSearch(Sender: TObject);
var snd :TRecFactSearch;
begin
  FfraInpDat.SetTimerSearch(False);
  //
  snd.ftyp := FFactTypeSearch;
  FFact.SearchKey := snd;
  //
  FfraInpDat.FactDataInterface(FFact);
  FfraInpDat.Contact;
end;

procedure TControllerFact.OnManFactAfterInsert(DataSet: TDataSet);
var sFGRC :String;
begin
  {if(FGenCode.FGrc='')or(FGenCode.FTyc='')then
    Exit;
  FManFact.FieldByName('CODE').AsString := FFact.FactNextCode(FGenCode);}
  //
  sFGRC := FManFaGrps.FieldByName('FGRC').AsString;
  if sFGRC='' then
    Exit;
  //
  FManFact.FieldByName('FGRC').AsString := sFGRC;
  FGenCode.FGrc := sFGRC;
  FManFact.FieldByName('CODE').AsString := FFact.FactNextCode(FGenCode);
end;

procedure TControllerFact.Start;
var snd :TRecFactSearch;
begin
  FFtypList := TStringList.Create;
  //
  FfraInpDat := TfraFactData.Create(nil);
  //events
  FfraInpDat.SetActionEvents(OnFactCommandInput);
  FfraInpDat.SetFactDataChanged(OnFactDataChange);
  FfraInpDat.SetFactTypeCloseUp(OnFactTypeCloseUp);
  FfraInpDat.SetFactTypeDblClick(OnFactTypeDblClick);
  FfraInpDat.SetFactTypeKeyDown(OnFactTypeKeyDown);
  FfraInpDat.SetFactTypeTimerSearch(OnFactTypeTimerSearch);
  //
  FfraInpDat.FactDataInterface(CreateModelFact);
  FfraInpDat.Contact;
  FfraInpDat.ContactFactGroup;
  //
  FManFaGrps := FfraInpDat.FactTypeDataManage;
  FManFaGrps.First;
  snd.ftyp := FManFaGrps.FieldByName('FGRC').AsString;
  FfraInpdat.SetFactTypeFirstItem(snd.ftyp);
  //
  FManFact := FfraInpDat.FactDataManage;
  FManFact.AfterInsert := OnManFactAfterInsert;
  //
  FFact.SearchKey := snd;
  FfraInpDat.SetFactDataSet;
  //
end;

function TControllerFact.View: TFrame;
begin
  Result := FfraInpDat;
end;

{private}
function TControllerFact.CreateModelFact: IFact;
var p :TRecFactSearch;
begin
  FFact := TDmoFactdat.Create(nil);
  FFact.SearchKey := p;
  Result := FFact;
end;

{ TControllerFactSelect }

constructor TControllerFactSelect.Create;
begin
  Start;
end;

destructor TControllerFactSelect.Destroy;
begin
  FFrFaSel.Free;
  inherited;
end;

procedure TControllerFactSelect.Start;
begin
  FFrFaSel := TfrmFactselect.Create(nil);
  FFrFaSel.DataInterface(CreateModelFactSelect);
  FFrFaSel.SetButtonEvents(OnButtonOK);
  FFrFaSel.SetSelectCloseUp(OnSelectFactType);
  //
  LoadMainLookUps;
end;

function TControllerFactSelect.View: TForm;
begin
  Result := FFrFaSel;
end;

{private}
function TControllerFactSelect.CheckFactProperty(
  ds: TDataSet; lv :Integer) :Boolean;
//
var sPrp, sCode :String; i, cnt, lvChild :Integer;
    dsChild :TDataSet;  lst :TStrings;
begin
  cnt := 0;
  lst := TStringList.Create;
  try
    repeat
      sPrp  := ds.FieldByName('FPRP').AsString;
      sCode := ds.FieldByName('CODE').AsString;
      if(sPrp='P1')or(sPrp='P2')then begin
        lst.Append(sCode);
        Inc(cnt);
      end;
      ds.Next;
    until ds.Eof;
    //
    lvChild := lv;
    for i := 0 to lst.Count - 1 do begin
      lvChild := lvChild+1;
      dsChild := FFact.LookupFacts(lst[i]);
      LoadDatas(dsChild,FFrFaSel.FactTypeSelect(lvChild));
    end;
  finally
    lst.Free;
  end;
  //
  Result := (cnt>0);
end;

function TControllerFactSelect.CreateModelFactSelect: IFact;
var p :TRecFactSearch;
begin
  FFact := TDmoFactdat.Create(nil);
  FFact.SearchKey := p;
  Result := FFact;
end;

procedure TControllerFactSelect.LoadDatas(
  ds: TDataSet; cb: TComboBox; bFirst: Boolean);
var s :String;
begin
  cb.Items.Clear;
  ds.First;
  repeat
    s := TrimRight(ds.FieldByName('CODE').AsString)+':'+
         ds.FieldByName('FDES').AsString;
    s := TrimLeft(TrimRight(s));
    if not(s=':')then
      cb.Items.Append(s);
    ds.Next;
  until(ds.Eof);
  //
  if bFirst then
    cb.ItemIndex := 0;
end;

procedure TControllerFactSelect.LoadMainLookUps;

const c_pattype = '0001';
      c_foodTyp = '0002';
      c_restric = '0003';

begin
  LoadDatas(FFact.LookupFacts(c_pattype),FFrFaSel.PatTypeSelect);
  //
  LoadDatas(FFact.LookupFacts(c_foodTyp),FFrFaSel.FactTypeSelect);
  //
  LoadDatas(FFact.LookupFacts(c_restric),FFrFaSel.RestrictSeelect, False);
end;

procedure TControllerFactSelect.OnButtonOK(Sender: TObject);
begin
  FFrFaSel.GetReqDesc(FRecFaSel.reqdesc);
  FFrFaSel.ModalResult := mrOK;
end;

procedure TControllerFactSelect.OnSelectFactType(Sender: TObject);
var s :String; idx, tg :Integer; ds :TDataSet;
begin
  //
  idx := TComboBox(Sender).ItemIndex;
  s := TCombobox(Sender).Items[idx];
  s := TrimLeft(TrimRight(s));
  if(s='')or(s=':')then
    Exit;
  //
  s := Copy(s,1,Pos(':',s)-1);
  if length(s)>4 then begin
    tg := TComboBox(Sender).Tag;
    if(tg=0)then
      FRecFaSel.pattype := s
    else if(tg>0)and(tg<5) then begin
      if FRecFaSel.countprop=0 then begin
        FRecFaSel.foodprop1 := s;
        FRecFaSel.countprop := 1;
      end else begin
        FRecFaSel.foodprop2 := s;
        FRecFaSel.countprop := 2;
      end;
    end else if(tg=5)then
      FRecFaSel.restrict := s;
  end else begin
    //
    if TComboBox(Sender).Name=CBO_FACTL1 then begin
      FFrFaSel.FactTypeClear(1);
      ds := FFact.LookupFacts(s);
      if not CheckFactProperty(ds,1) then
        LoadDatas(ds,FFrFaSel.FactTypeSelect(2));

    end else if TComboBox(Sender).Name=CBO_FACTL2 then begin
      FFrFaSel.FactTypeClear(2);
      ds := FFact.LookupFacts(s);
      if not CheckFactProperty(ds,2) then
        LoadDatas(ds,FFrFaSel.FactTypeSelect(3));

    end else if TComboBox(Sender).Name=CBO_FACTL3 then begin
      FFrFaSel.FactTypeClear(3);
      ds := FFact.LookupFacts(s);
      if not CheckFactProperty(ds,3) then
        LoadDatas(ds,FFrFaSel.FactTypeSelect(4));

    end else if TComboBox(Sender).Name=CBO_FACTL4 then begin

    end;
  end;
end;

end.
