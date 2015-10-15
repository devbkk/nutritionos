unit CtrFact;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs,
     ShareInterface, FaFactData, DmFactDat;

type
   TControllerFact = class
   private
     FfraInpDat :TfraFactData;
     FFact      :IFact;
     FManFact   :TClientDataSet;
     FFtypList  :TStrings;
     FFactTypeSearch :String;
     function CreateModelFact :IFact;
   public
     constructor Create;
     destructor Destroy; override;
     procedure Start;
     //
     procedure DoFactAddWrite;
     procedure DoFactCancelDel;
     procedure DoGenerateFactTypeList;
     procedure OnFactCommandInput(Sender :TObject);
     procedure OnFactTypeCloseUp(Sender :TObject);
     procedure OnFactTypeDblClick(Sender :TObject);
     procedure OnFactTypeKeyDown(Sender: TObject;
                                 var Key:
                                 Word; Shift: TShiftState);
     procedure OnFactTypeTimerSearch(Sender :TObject);
     //
     function View :TFrame;
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

{ TControllerFact }

constructor TControllerFact.Create;
begin
  Start;
end;

destructor TControllerFact.Destroy;
begin
  FfraInpDat.Free;
  FFtypList.Free;
end;

procedure TControllerFact.DoFactAddWrite;
begin
  if FManFact.State = dsBrowse then begin
    FManFact.Append;
    FfraInpDat.FocusFirstCell;
  end else if FManFact.State in [dsInsert,dsEdit] then begin
    if FManFact.State = dsInsert then begin
      FManFact.FieldByName(FLD_FTY).AsString := FfraInpDat.FactType;
      if FManFact.FieldByName(FLD_NOT).IsNull then
        FManFact.FieldByName(FLD_NOT).AsString := '';
    end;
    FManFact.Post;
    FManFact.ApplyUpdates(-1);
    //
    DoGenerateFactTypeList;
    if FfraInpDat.IsSqeuenceAppend then
      DoFactAddWrite;
  end;
end;

procedure TControllerFact.DoFactCancelDel;
begin
  if FManFact.State = dsBrowse then begin
    FManFact.Delete;
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

procedure TControllerFact.OnFactCommandInput(Sender: TObject);
begin
  if TCustomAction(Sender).Name=CMP_ACTAW then
    DoFactAddWrite
  else if TCustomAction(Sender).Name=CMP_ACTDC then
    DoFactCancelDel
  else if TCustomAction(Sender).Name=CMP_ACTFG then
    FfraInpDat.ContactFactGroup;
  {else if TCustomAction(Sender).Name=CMP_ACTPV then
    DoUserMovePrev
  else if TCustomAction(Sender).Name=CMP_ACTNX then
    DoUserMoveNext;}
end;

procedure TControllerFact.OnFactTypeCloseUp(Sender: TObject);
var snd :TRecFactSearch;
begin
  if Sender is TComboBox then
    snd.ftyp := TComboBox(Sender).Items[TComboBox(Sender).ItemIndex];

  FFact.SearchKey := snd;
  //
  FfraInpDat.FactDataInterface(FFact);
  FfraInpDat.Contact;
end;

procedure TControllerFact.OnFactTypeDblClick(Sender: TObject);
begin
  //ShowMessage('Yes');
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

procedure TControllerFact.Start;
begin
  FFtypList := TStringList.Create;
  //
  FfraInpDat := TfraFactData.Create(nil);
  //events
  FfraInpDat.SetActionEvents(OnFactCommandInput);
  FfraInpDat.SetFactTypeCloseUp(OnFactTypeCloseUp);
  FfraInpDat.SetFactTypeDblClick(OnFactTypeDblClick);
  FfraInpDat.SetFactTypeKeyDown(OnFactTypeKeyDown);
  FfraInpDat.SetFactTypeTimerSearch(OnFactTypeTimerSearch);
  //interface with data model
  FfraInpDat.FactDataInterface(CreateModelFact);
  //contact db
  FfraInpDat.Contact;
  FfraInpDat.ContactFactGroup;
  DoGenerateFactTypeList;
  //data manage
  FManFact := FfraInpDat.FactDataManage;
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

end.
