unit CtrFact;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, DBGrids, DBCtrls, SysUtils,
     ShareInterface, FaFactData, FrFactInput, DmFactDat;

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
     FFact      :IFact;
     function CreateModelFactSelect :IFact;
   public
     constructor Create;
     destructor Destroy; override;
     procedure Start;
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
//
end;

destructor TControllerFactSelect.Destroy;
begin
//
  inherited;
end;

procedure TControllerFactSelect.Start;
begin
//
end;

{private}
function TControllerFactSelect.CreateModelFactSelect: IFact;
var p :TRecFactSearch;
begin
  FFact := TDmoFactdat.Create(nil);
  FFact.SearchKey := p;
  Result := FFact;
end;


end.
