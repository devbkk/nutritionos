unit CtrFact;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms, Graphics,
     Dialogs, Controls, DBGrids, DBCtrls, SysUtils, ComCtrls,
     Menus, Provider, StrUtils, Variants,
     ShareCommon, ShareInterface,
     FaFactData, FrFactInput, FrFactSelect, FrFactTreeInput,
     FaFactTree,
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
     procedure RefreshListFactGroups;
     function View :TFrame;
   end;

   TControllerFactSelect = class
   private
     FFact     :IFact;
     FFrFaSel  :TfrmFactselect;
     FRecFaSel :TRecFactSelect;
     function CheckFactProperty(ds :TDataSet; lv :Integer):Boolean;
     function CreateModelFactSelect :IFact;
     function GetFactSelect :TRecFactSelect;
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
     property FactSelect :TRecFactSelect read GetFactSelect;
   end;

   TControllerFactTree = class
   private
     FFact      :IFact;
     FFraFaTree :TfraFactTree;
     FFrInput   :TfrmFactTreeInput;
     FManFaTree :TClientDataSet;
     //
     FLstMaxNodes :TStrings;
     FLstGrpCodes :TStrings;
     //
     FGenCode   :TRecGenCode;
     function CreateModelFactTree :IFact;
     procedure DoAddWrite;
     procedure DoDelCancel;
     //
     procedure DoCheckParentGroupIsGenerated;
     procedure DoCheckSetPopupMenu;
     function  DoGenerateGroupCode(nPar :TTreeNode):String;
     //
     procedure DoTreeNodeAdd;
     procedure DoTreeNodeDel;
     procedure DoTreeNodeEdit;
     procedure DoGenerateTree(ATree :TTreeView);
     procedure DoShowDataByTreeNode(NodeText :String);
     procedure DoToggleShowPrintSlip(Code :String);
     procedure DoTreeNodeActions(Sender: TObject; Node: TTreeNode);
     procedure DoTreeNodeGetImageIndex(Sender :TObject; Node :TTreeNode);
     function  GetNextPropertyNumber:Integer;
     //
     function IsGroupCodeExist(code :String):Boolean;
     //
     procedure OnManFactAfterInsert(DataSet :TDataSet);
     //
     procedure ReqUpdDescInFoodReqD;
   public
     constructor Create;
     destructor Destroy; override;
     procedure Start;
     //
     procedure OnCommandInput(Sender :TObject);
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
  //
  ACT_CHADD = 'actChildAdd';
  ACT_CHDEL = 'actChildDel';
  ACT_FADET = 'actFactDet';
  ACT_FAEDT = 'actFactEdit';
  //
  PMU_FTREE = 'pmuFactTree';
  //
  TVW_FACT  = 'tvwFact';
  //
  CFM_DEL   = '�׹�ѹź�����Ź��?';
  IFM_SAVED = '�ѹ�֡����������';
  WRN_NDEL  = '�������öź�����Ź��';
  WRN_DDEL  = '�բ��������� �������öź';
  CAP_INPUT = 'ź�����Ź��';
  PRM_INPUT = '��س�������ʢ�����';
  //
  GRD_COL_NOTE = 'NOTE';
  //
  CBO_FACTL1 = 'cboFoodTypeL1';
  CBO_FACTL2 = 'cboFoodTypeL2';
  CBO_FACTL3 = 'cboFoodTypeL3';
  CBO_FACTL4 = 'cboFoodTypeL4';
  CBO_FACTL5 = 'cboFoodTypeL5';
  //
  NODE_MAX   = 3;
  CODE_LEN   = 4;

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
    FfraInpDat.FocusFirstCell;
  end else if FManFact.State in [dsInsert,dsEdit] then begin
    FManFact.Post;
    FManFact.ApplyUpdates(-1);
    if FfraInpDat.IsSqeuenceAppend then
      DoFactAddWrite
    else MessageDlg(IFM_SAVED,mtInformation,[mbOK],0);
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
  end else if Sender is TTreeView then begin
   {if TTreeView(Sender).Name = TVW_FACT then
     DoTogglePrintSlip;}
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

procedure TControllerFact.RefreshListFactGroups;
begin
  if Assigned(FfraInpDat) then
    FfraInpDat.SetFactTypeDataSet;
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
      {if(sPrp='P1')or(sPrp='P2')or(sPrp='P3')or('P4')then begin
        lst.Append(sCode);
        Inc(cnt);
      end;}
      if Copy(sPrp,1,1)='P' then begin
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

function TControllerFactSelect.GetFactSelect: TRecFactSelect;
begin
  Result := FRecFaSel;
end;

procedure TControllerFactSelect.LoadDatas(
  ds: TDataSet; cb: TComboBox; bFirst: Boolean);
var s :String;
begin
  cb.Items.Clear;
  ds.First;
  repeat
    s := TrimRight(ds.FieldByName('CODE').AsString)+C_DELIM+
         ds.FieldByName('FDES').AsString;
    s := TrimLeft(TrimRight(s));
    if not(s=C_DELIM)then
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
  FRecFaSel :=  FFrFaSel.GetSelectedData;
  FFrFaSel.ModalResult := mrOK;
end;

procedure TControllerFactSelect.OnSelectFactType(Sender: TObject);
var s :String; idx, tg :Integer; ds :TDataSet;
begin
  //
  idx := TComboBox(Sender).ItemIndex;
  s := TCombobox(Sender).Items[idx];
  s := TrimLeft(TrimRight(s));
  if(s='')or(s=C_DELIM)then
    Exit;
  //
  s := Copy(s,1,Pos(C_DELIM,s)-1);
  if length(s)>4 then begin
    tg := TComboBox(Sender).Tag;
    if(tg=0)then
      FRecFaSel.pattype := s
    else if(tg>0)and(tg<5) then begin
      if FRecFaSel.countprop=0 then begin
        FRecFaSel.foodprop1 := s;
        FRecFaSel.countprop := 1;
      end else if FRecFaSel.countprop=1 then begin
        FRecFaSel.foodprop2 := s;
        FRecFaSel.countprop := 2;
      end else if FRecFaSel.countprop=2 then begin
        FRecFaSel.foodprop3 := s;
        FRecFaSel.countprop := 3;
      end else if FRecFaSel.countprop=3 then begin
        FRecFaSel.foodprop3 := s;
        FRecFaSel.countprop := 4;
      end else if FRecFaSel.countprop=4 then begin
        FRecFaSel.foodprop3 := s;
        FRecFaSel.countprop := 5;
      end
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
      FFrFaSel.FactTypeClear(4);
      ds := FFact.LookupFacts(s);
      if not CheckFactProperty(ds,4) then
        LoadDatas(ds,FFrFaSel.FactTypeSelect(5));
    end;
  end;
end;


{ TControllerFactTree }

constructor TControllerFactTree.Create;
begin
  Start;
end;

destructor TControllerFactTree.Destroy;
begin
  //
  FLstMaxNodes.Free;
  FLstGrpCodes.Free;
  //  
  FFraFaTree.Free;
  FFrInput.Free;
  inherited;
end;

procedure TControllerFactTree.OnCommandInput(Sender: TObject);
begin
  if Sender is TCustomAction then begin
    if TCustomAction(Sender).Name=CMP_ACTAW then
      DoAddWrite
    else if TCustomAction(Sender).Name=CMP_ACTDC then
      DoDelCancel
    else if TCustomAction(Sender).Name=ACT_CHADD then
      DoTreeNodeAdd
    else if TCustomAction(Sender).Name=ACT_CHDEL then
      DoTreeNodeDel
    else if TCustomAction(Sender).Name=ACT_FADET then
      FFraFaTree.SetAllowActions(True)
    else if TCustomAction(Sender).Name=ACT_FAEDT then
      DoTreeNodeEdit;
  end else if Sender is TTreeView then begin
    DoShowDataByTreeNode(TTreeView(Sender).Selected.Text);
  end else if Sender is TPopupMenu then begin
    if TPopupMenu(Sender).Name = PMU_FTREE then
      DoCheckSetPopupMenu;
  end;

end;

procedure TControllerFactTree.Start;
begin
  FFraFaTree := TfraFactTree.Create(nil);
  FFraFaTree.DataInterface(CreateModelFactTree);
  FFraFaTree.SetActionEvents(OnCommandInput);
  FFraFaTree.SetTvwOnNodeActions(DoTreeNodeActions);
  FFraFaTree.SetTvwOnNodeGetImageIndex(DoTreeNodeGetImageIndex);
  FFraFaTree.Contact;
  //
  FManFaTree := FFraFaTree.DataManage;
  FManFaTree.AfterInsert := OnManFactAfterInsert;
  //
  FLstMaxNodes := TStringList.Create;
  FLstGrpCodes := TStringList.Create;
  //
  DoCheckParentGroupIsGenerated;
  DoGenerateTree(FfraFaTree.Tree);
end;

function TControllerFactTree.View: TFrame;
begin
  Result := FFraFaTree;
end;

{private}
function TControllerFactTree.CreateModelFactTree: IFact;
var p :TRecFactSearch;
begin
  FFact := TDmoFactdat.Create(nil);
  FFact.SearchKey := p;
  Result := FFact;
end;

procedure TControllerFactTree.DoAddWrite;
begin
  if FManFaTree.State = dsBrowse then begin
    FManFaTree.Append;
    FFraFaTree.FocusFirstCell;
  end else if FManFaTree.State in [dsInsert,dsEdit] then begin
    //
    if FManFaTree.State = dsEdit then
      ReqUpdDescInFoodReqD;
    //
    FManFaTree.Post;
    FManFaTree.ApplyUpdates(-1);
    if FFraFaTree.IsSqeuenceAppend then
      DoAddWrite
  end;
end;

procedure TControllerFactTree.DoCheckParentGroupIsGenerated;
var ds :TDataSet;
    rec :TRecFactGroup;

begin
  ds := FFact.FactTypeDataSet;
  if ds.IsEmpty then begin
    //patient type
    rec.FGRC := '0001';
    rec.FGRP := '������������';
    rec.FLEV := 0;
    rec.NOTE := '';
    rec.FPRP := '0';
    rec.SLIPPRN := 'N';
    FFact.AppendFactGroupParent(rec);
    //food type
    rec.FGRC := '0002';
    rec.FGRP := '��Դ�����';
    rec.FLEV := 0;
    rec.NOTE := '';
    rec.FPRP := '0';
    rec.SLIPPRN := 'N';
    FFact.AppendFactGroupParent(rec);
    //note
    rec.FGRC := '0003';
    rec.FGRP := '��ͨӡѴ';
    rec.FLEV := 0;
    rec.NOTE := '';
    rec.FPRP := '0';
    rec.SLIPPRN := 'N';
    FFact.AppendFactGroupParent(rec);
  end;
end;

procedure TControllerFactTree.DoCheckSetPopupMenu;
var node :TTreeNode; s :String; lstNoPopup :TStrings;
const c_nopopup = '0001,0003,999';
begin
  node := FFraFaTree.Tree.Selected;
  s := Copy(node.Text,1,Pos(C_DELIM,node.Text)-1);
  lstNoPopup := TStringList.Create;
  try
    lstNoPopup.CommaText := c_nopopup;
    if lstNoPopup.IndexOf(s)>-1 then
      Abort;
    FFraFaTree.SetAllowPopupMenus((FLstMaxNodes.IndexOf(s)=-1 ));
  finally
    lstNoPopup.Free;
  end;
end;

procedure TControllerFactTree.DoDelCancel;
begin
  if FManFaTree.State = dsBrowse then begin
    if MessageDlg(CFM_DEL,mtWarning,[mbYes,mbNo],0) = mrYes then begin
      FManFaTree.Delete;
      FManFaTree.ApplyUpdates(-1);
    end;
  end else if FManFaTree.State in [dsInsert,dsEdit] then begin
    FManFaTree.Cancel;
  end;
end;

function TControllerFactTree.DoGenerateGroupCode(nPar: TTreeNode): String;
var sRet, sCode, sPcode :String;  iCode, cntNode, rnCode:Integer;
    cNode :TTreeNode;

function CountNode:Integer;
begin
  cntNode := 0;
  cNode := nPar.getFirstChild;
  repeat
    cNode := nPar.GetNextChild(cNode);
    Inc(cntNode);
  until (cNode=nil);
  Result := cntNode;
end;

begin
  Result := '';
  if nPar=nil then
    Exit;
  //
  if nPar.HasChildren then begin
    rnCode := CountNode+1;
  end else begin
    rnCode := 1;
  end;
  //
  sCode := Copy(nPar.Text,1,Pos(C_DELIM,nPar.Text)-1);
  iCode := StrToInt(sCode);
  sPCode := IntToStr(iCode);
  //
  sRet := RightStr(DupeString('0',CODE_LEN)+sPCode+IntToStr(rnCode), CODE_LEN);
  //
  Result := sRet;
end;

procedure TControllerFactTree.DoGenerateTree(ATree: TTreeView);
var node :TTreeNode; ds :TDataSet;
    s, sPCod : String; bPrn :Boolean;
//
function FindNode(sNodeName :String) :TTreeNode;
begin
  Result := nil;
  //
  node := ATree.Items.GetFirstNode;
  while node<>nil do begin
    if Pos(sNodeName,node.Text)>0 then begin
      Result := node;
      Break;
    end;
    node := node.GetNext;
  end;
end;

begin
  ATree.AutoExpand := True;
  ATree.HideSelection := False;
  ATree.Items.Clear;
  //
  FLstMaxNodes.Clear;
  FLstGrpCodes.Clear;
  //
  ds := FFact.FactTypeDataSet;
  if not ds.IsEmpty then begin

    ds.First;
    repeat
      bPrn := (ds.FieldByName('SLIPPRN').AsString='Y');
      s    := ds.FieldByName('FGRC').AsString+C_DELIM+
              ds.FieldByName('FGRP').AsString;
      //
      sPCod := ds.FieldByName('PCOD').AsString;
      //
      case ds.FieldByName('FLEV').AsInteger of
        0 : node := ATree.Items.Add(nil,s);
        1,2,3 : begin
          node := FindNode(sPCod);
          if node<>nil then
            ATree.Items.AddChild(node,s);
        end;
      end;
      //
      if bPrn then
        node.ImageIndex := 0
      else node.ImageIndex := 0;
      //
      if ds.FieldByName('FLEV').AsInteger=NODE_MAX then
        if FLstMaxNodes.IndexOf(ds.FieldByName('FGRC').AsString)=-1 then
          FLstMaxNodes.Append(ds.FieldByName('FGRC').AsString);
      //
      if FLstGrpCodes.IndexOf(ds.FieldByName('FGRC').AsString)=-1 then begin
        FLstGrpCodes.Append(ds.FieldByName('FGRC').AsString);
      end;
      //
      ds.Next;
    until ds.Eof ;
  end;
  //
  if ATree.Items.Count > 0 then begin
    ATree.FullExpand;  
    ATree.Selected := ATree.Items[0];
    ATree.Selected.Expand(True);
    DoShowDataByTreeNode(ATree.Selected.Text);
  end;
end;

procedure TControllerFactTree.DoShowDataByTreeNode(NodeText: String);
var sCode :String; b :Boolean;
begin
  sCode := Copy(NodeText,1,Pos(C_DELIM,NodeText)-1);
  if(sCode<>'')then begin
    FManFaTree.Filter   := '';
    FManFaTree.Filtered := False;
    //
    FManFaTree.Filter   := 'FGRC='+QuotedStr(sCode);
    FManFaTree.Filtered := True;
  end;
  //
  b :=  not FManFaTree.IsEmpty;
  FFraFaTree.SetAllowActions(b);
  //
  DoToggleShowPrintSlip(sCode);
end;

procedure TControllerFactTree.DoToggleShowPrintSlip(Code: String);
var ds :TDataSet;
begin
  ds := FFact.FactTypeDataSet;
  if ds.Locate('FGRC',Code,[]) then
    FFraFaTree.SetShowPrintSlip((ds.FieldByName('SLIPPRN').AsString='Y'));
end;

procedure TControllerFactTree.DoTreeNodeActions(
  Sender: TObject;
  Node: TTreeNode);
begin
  Node.Expand(True);
end;

procedure TControllerFactTree.DoTreeNodeAdd;
var rec  :TRecFactTreeInput; iLev :Integer;
    s, sPCode, sProp, sSlipPrn :String; node :TTreeNode;
    //
    cds :TClientDataSet; dsp :TDataSetProvider;
begin
  //
  node := FFraFaTree.Tree.Selected;
  //
  FFrInput := TfrmFactTreeInput.Create(nil);
  FFrInput.SetCodeLlist(FLstGrpCodes);
  FFrInput.Code := DoGenerateGroupCode(node);
  FFrInput.EditMode := False;
  //
  rec := FFrInput.Answer;
  if(rec.Code<>'')and(rec.Desc<>'')then begin
    s := rec.Code+C_DELIM+rec.Desc;
    FFraFaTree.Tree.Items.AddChild(node,s);
    node.Expand(True);
    //
    sPCode := Copy(node.Text,1,Pos(C_DELIM,node.Text)-1);
    //
    cds := TClientDataSet.Create(nil);
    dsp := TDataSetProvider.Create(nil);
    try
      dsp.DataSet := FFact.FactTypeDataSet;
      cds.SetProvider(dsp);
      cds.Close;
      cds.Open;
      //
      if not cds.IsEmpty then begin
        iLev := 0;
        if cds.Locate('FGRC',sPCode,[]) then begin
          if cds.FieldByName('FLEV').AsInteger<NODE_MAX then
            iLev := cds.FieldByName('FLEV').AsInteger+1
        end;
        //
        if iLev = NODE_MAX then
          if FLstMaxNodes.IndexOf(rec.Code)=-1 then
            FLstMaxNodes.Append(rec.Code);
        //
        if FLstGrpCodes.IndexOf(rec.Code)=-1 then
          FLstGrpCodes.Append(rec.Code);
        //
        if rec.IsSubLevel then
          sProp := 'L'
        else begin
          cds.Filter   := 'PCOD='+QuotedStr(sPCode);
          cds.Filtered := True;
          try
            sProp := 'P'+IntToStr(cds.RecordCount+1);
          finally
            cds.Filter   := '';
            cds.Filtered := False;
          end;
        end;
        //
        if rec.IsSlipPrn then
          sSlipPrn := 'Y'
        else sSlipPrn := 'N';
        //
        cds.AppendRecord([rec.Code,
                          rec.Desc,
                          iLev,
                          rec.Note,
                          sProp,
                          sPCode,
                          sSlipPrn]);
        cds.ApplyUpdates(-1);
      end;

    //
    finally
      cds.Free;
      dsp.Free;
    end;
  end;
end;

procedure TControllerFactTree.DoTreeNodeDel;
var node, cNode :TTreeNode; sCode, sChldCode :String;
    idx :Integer;
//
function IsChildNode(code :String):Boolean;
begin
  Result := False;
  cNode := node.getFirstChild;
  repeat
    sChldCode :=Copy(cNode.Text,1,Pos(C_DELIM,cNode.Text)-1);
    if  sChldCode=code then begin
      Result := True;
      Break;
    end;
    cNode := node.GetNextChild(cNode);
  until (cNode=nil);
end;
//
begin
   node := FFraFaTree.Tree.Selected;
   sCode := Copy(node.Text,1,Pos(C_DELIM,node.Text)-1);
   if(node.HasChildren)and(FLstMaxNodes.IndexOf(sCode)=-1) then begin
      sCode := InputBox(CAP_INPUT,PRM_INPUT,'');
      if (sCode<>'')and(IsChildNode(sCode)) then  begin
        if MessageDlg(CFM_DEL,mtConfirmation,[mbYes,mbNo],0)=mrYes then begin
          //
          if IsGroupCodeExist(sCode) then
            MessageDlg(WRN_DDEL,mtWarning,[mbOK],0);
          cNode.Delete;
          FFact.DelFactGroup(sCode);
          //
          idx := FLstMaxNodes.IndexOf(sCode);
          if idx>-1 then
            FLstMaxNodes.Delete(idx);
          //
          idx := FLstGrpCodes.IndexOf(sCode);
          if idx>-1 then
            FLstGrpCodes.Delete(idx);
          //
        end;
      end;
   end;
end;

procedure TControllerFactTree.DoTreeNodeEdit;
var node :TTreeNode; sCode :String;
    cds  :TClientDataSet;
    dsp  :TDataSetProvider;
    rec  :TRecFactTreeInput;
begin
  //
  node  := FFraFaTree.Tree.Selected;
  sCode := Copy(node.Text,1,Pos('=',node.Text)-1);
  //
  //
  cds := TClientDataSet.Create(nil);
  dsp := TDataSetProvider.Create(nil);
  try
    dsp.DataSet := FFact.FactTypeDataSet;
    cds.SetProvider(dsp);
    cds.Close;
    cds.Open;
    //
    if cds.Locate('FGRC',sCode,[]) then begin
      rec.Code := cds.FieldByName('FGRC').AsString;
      rec.Desc := cds.FieldByName('FGRP').AsString;
      rec.Note := cds.FieldByName('NOTE').AsString;
      rec.IsSubLevel := (cds.FieldByName('FPRP').AsString='L');
      rec.IsSlipPrn  := (cds.FieldByName('SLIPPRN').AsString='Y');
    end;
  finally
    cds.Free;
    dsp.Free;
  end;
  //
  FFrInput := TfrmFactTreeInput.Create(nil);
  FFrInput.SetCodeLlist(FLstGrpCodes);
  FFrInput.SetDatas(rec);
  FFrInput.EditMode := True;
  //
  rec := FFrInput.Answer;
  if not rec.IsSubLevel then
    rec.Prop := 'P'+IntToStr(GetNextPropertyNumber)
  else rec.Prop := 'L';
  if not rec.IsEmptyRec then begin
    FFact.UpdateFactGroup(rec);
    DoGenerateTree(FfraFaTree.Tree);
  end;
end;

procedure TControllerFactTree.DoTreeNodeGetImageIndex(
  Sender: TObject;
  Node: TTreeNode);
begin
  if Node.ImageIndex=0 then
    Node.ImageIndex := 0;
end;

function TControllerFactTree.GetNextPropertyNumber: Integer;
var cds :TClientDataSet; dsp :TDataSetProvider;
    node :TTreeNode; sPCode :String; cntTotal, cntSubLev :Integer;
const c_filter   = 'PCOD=%S';
      c_filter_l = 'PCOD=%S AND FPRP = ''L''';

begin
  node   := FFraFaTree.Tree.Selected;
  if node.Parent = nil then
    Exit;
  sPCode := Copy(node.Parent.Text,1,Pos(C_DELIM,node.Parent.Text)-1);
  //
  cds := TClientDataSet.Create(nil);
  dsp := TDataSetProvider.Create(nil);
  //
  try
    dsp.DataSet := FFact.FactTypeDataSet;
    cds.SetProvider(dsp);
    cds.Close;
    cds.Open;
    //
    cds.Filter   := Format(c_filter,[QuotedStr(sPCode)]);
    cds.Filtered := True;
    cntTotal     := cds.RecordCount;
    //
    cds.Filter   := Format(c_filter_l,[QuotedStr(sPCode)]);
    cds.Filtered := True;
    cntSubLev    := cds.RecordCount;
    //
    try
      Result := cntTotal-cntSubLev +1;
    finally
      cds.Filter   := '';
      cds.Filtered := False;
    end;
  finally
    cds.Free;
    dsp.Free;
  end;
end;

function TControllerFactTree.IsGroupCodeExist(code: String): Boolean;
var sFilter :String; b :Boolean;
begin
  sFilter := FManFaTree.Filter;
  b       := FManFaTree.Filtered;
  //
  FManFaTree.Filter   := '';
  FManFaTree.Filtered := False;
  try
    Result := FManFaTree.Locate('FGRC',code,[]);
  finally
    FManFaTree.Filter   := sFilter;
    FManFatree.Filtered := b;
  end;
end;

procedure TControllerFactTree.OnManFactAfterInsert(DataSet: TDataSet);
var sFGRC :String; node :TTreeNode;
begin
  //
  node := FFraFaTree.Tree.Selected;
  if node=nil then
    Exit;
  //
  sFGRC := Copy(node.Text,1,Pos(C_DELIM,node.Text)-1);
  if sFGRC='' then
    Exit;
  //
  FManFaTree.FieldByName('FGRC').AsString := sFGRC;
  FGenCode.FGrc := sFGRC;
  FManFaTree.FieldByName('CODE').AsString := FFact.FactNextCode(FGenCode);
end;

procedure TControllerFactTree.ReqUpdDescInFoodReqD;
var sCode, sDesc :String;
begin
  sCode := FFraFaTree.InputCode;
  sDesc := FFraFaTree.InputDesc;
  //
  FFact.UpdateFoodReqdDesc(sCode,sDesc);
end;

end.
