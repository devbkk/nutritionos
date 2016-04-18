unit CtrFact;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms, Graphics,
     Dialogs, Controls, DBGrids, DBCtrls, SysUtils, ComCtrls,
     Menus, Provider, StrUtils,
     ShareInterface, FaFactData, FrFactInput, FrFactSelect,
     FrFactTreeInput, FaFactTree, DmFactDat;

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
     procedure GenerateFoodSelectArray;
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
     procedure DoCheckSetPopupMenu;
     function  DoGenerateGroupCode(nPar :TTreeNode):String;
     //
     procedure DoTreeNodeAdd;
     procedure DoTreeNodeDel;
     procedure DoGenerateTree(ATree :TTreeView);
     procedure DoShowDataByTreeNode(NodeText :String);
     procedure DoTreeNodeActions(Sender: TObject; Node: TTreeNode);
     //
     function IsGroupCodeExist(code :String):Boolean;
     //
     procedure OnManFactAfterInsert(DataSet :TDataSet);
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
  //
  PMU_FTREE = 'pmuFactTree';
  //
  CFM_DEL   = 'ยืนยันลบข้อมูลนี้?';
  IFM_SAVED = 'บันทึกข้อมูลแล้ว';
  WRN_NDEL  = 'ไม่สามารถลบข้อมูลนี้';
  WRN_DDEL  = 'มีข้อมูลย่อย ไม่สามารถลบ';
  CAP_INPUT = 'ลบข้อมูลนี้';
  PRM_INPUT = 'กรุณาใส่รหัสข้อมูล';
  //
  GRD_COL_NOTE = 'NOTE';
  //
  CBO_FACTL1 = 'cboFoodTypeL1';
  CBO_FACTL2 = 'cboFoodTypeL2';
  CBO_FACTL3 = 'cboFoodTypeL3';
  CBO_FACTL4 = 'cboFoodTypeL4';
  CBO_FACTL5 = 'cboFoodTypeL5';
  //
  CODE_DELIM = '=';
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
      if(sPrp='P1')or(sPrp='P2')or(sPrp='P3')then begin
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

procedure TControllerFactSelect.GenerateFoodSelectArray;
begin
  SetLength(FRecFaSel.foodselect,5);
  FRecFaSel.foodselect[1] := FRecFaSel.foodprop1;
  FRecFaSel.foodselect[2] := FRecFaSel.foodprop2;
  FRecFaSel.foodselect[3] := FRecFaSel.foodprop3;
  FRecFaSel.foodselect[4] := FRecFaSel.foodprop4;
  FRecFaSel.foodselect[5] := FRecFaSel.foodprop5;
end;

procedure TControllerFactSelect.LoadDatas(
  ds: TDataSet; cb: TComboBox; bFirst: Boolean);
var s :String;
begin
  cb.Items.Clear;
  ds.First;
  repeat
    s := TrimRight(ds.FieldByName('CODE').AsString)+CODE_DELIM+
         ds.FieldByName('FDES').AsString;
    s := TrimLeft(TrimRight(s));
    if not(s=CODE_DELIM)then
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
  //FFrFaSel.GetReqDesc(FRecFaSel.reqdesc);
  FFrFaSel.GetReqDet(FRecFaSel);
  GenerateFoodSelectArray;
  FFrFaSel.ModalResult := mrOK;
end;

procedure TControllerFactSelect.OnSelectFactType(Sender: TObject);
var s :String; idx, tg :Integer; ds :TDataSet;
begin
  //
  idx := TComboBox(Sender).ItemIndex;
  s := TCombobox(Sender).Items[idx];
  s := TrimLeft(TrimRight(s));
  if(s='')or(s=CODE_DELIM)then
    Exit;
  //
  s := Copy(s,1,Pos(CODE_DELIM,s)-1);
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
      FFraFaTree.SetAllowActions(True);
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
  FFraFaTree.Contact;
  //
  FManFaTree := FFraFaTree.DataManage;
  FManFaTree.AfterInsert := OnManFactAfterInsert;
  //
  FLstMaxNodes := TStringList.Create;
  FLstGrpCodes := TStringList.Create;
  //
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
    FManFaTree.Post;
    FManFaTree.ApplyUpdates(-1);
    if FFraFaTree.IsSqeuenceAppend then
      DoAddWrite
  end;
end;

procedure TControllerFactTree.DoCheckSetPopupMenu;
var node :TTreeNode; s :String;
begin
  node := FFraFaTree.Tree.Selected;
  s := Copy(node.Text,1,Pos(CODE_DELIM,node.Text)-1);
  FFraFaTree.SetAllowPopupMenus((FLstMaxNodes.IndexOf(s)=-1 ));
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
  sCode := Copy(nPar.Text,1,Pos(CODE_DELIM,nPar.Text)-1);
  iCode := StrToInt(sCode);
  sPCode := IntToStr(iCode);
  //
  sRet := RightStr(DupeString('0',CODE_LEN)+sPCode+IntToStr(rnCode), CODE_LEN);
  //
  Result := sRet;
end;

procedure TControllerFactTree.DoGenerateTree(ATree: TTreeView);
var node :TTreeNode; ds :TDataSet;
    s, sPCod : String;
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
      s := ds.FieldByName('FGRC').AsString+CODE_DELIM+
           ds.FieldByName('FGRP').AsString;
      //
      sPCod := ds.FieldByName('PCOD').AsString;
      //
      case ds.FieldByName('FLEV').AsInteger of
        0 : ATree.Items.Add(nil,s);
        1,2,3 : begin
          node := FindNode(sPCod);
          if node<>nil then
            ATree.Items.AddChild(node,s);
        end;
      end;
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
  ATree.FullExpand;
  ATree.Selected := ATree.Items[0];
  ATree.Selected.Expand(True);
  DoShowDataByTreeNode(ATree.Selected.Text);
end;

procedure TControllerFactTree.DoShowDataByTreeNode(NodeText: String);
var sCode :String; b :Boolean;
begin
  sCode := Copy(NodeText,1,Pos(CODE_DELIM,NodeText)-1);
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
end;

procedure TControllerFactTree.DoTreeNodeActions(
  Sender: TObject;
  Node: TTreeNode);
begin
  Node.Expand(True);
end;

procedure TControllerFactTree.DoTreeNodeAdd;
var rec  :TRecFactTreeInput; iLev :Integer;
    s, sPCode, sProp :String; node :TTreeNode;
    //
    cds :TClientDataSet; dsp :TDataSetProvider;
begin
  //
  node := FFraFaTree.Tree.Selected;
  //
  FFrInput := TfrmFactTreeInput.Create(nil);
  FFrInput.SetCodeLlist(FLstGrpCodes);
  FFrInput.Code := DoGenerateGroupCode(node);
  //
  rec := FFrInput.Answer;
  if(rec.Code<>'')and(rec.Desc<>'')then begin
    s := rec.Code+CODE_DELIM+rec.Desc;
    FFraFaTree.Tree.Items.AddChild(node,s);
    node.Expand(True);
    //
    sPCode := Copy(node.Text,1,Pos(CODE_DELIM,node.Text)-1);
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
        cds.AppendRecord([rec.Code,
                          rec.Desc,
                          iLev,
                          rec.Note,
                          sProp,
                          sPCode]);
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
    sChldCode :=Copy(cNode.Text,1,Pos(CODE_DELIM,cNode.Text)-1);
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
   sCode := Copy(node.Text,1,Pos(CODE_DELIM,node.Text)-1);
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
  sFGRC := Copy(node.Text,1,Pos(CODE_DELIM,node.Text)-1);
  //
  if sFGRC='' then
    Exit;
  //
  FManFaTree.FieldByName('FGRC').AsString := sFGRC;
  FGenCode.FGrc := sFGRC;
  FManFaTree.FieldByName('CODE').AsString := FFact.FactNextCode(FGenCode);
end;

end.
