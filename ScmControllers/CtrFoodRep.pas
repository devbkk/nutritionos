unit CtrFoodRep;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, StrUtils, SysUtils, ComCtrls,
     Buttons, Provider,
     //
     ShareCommon, ShareInterface, ShareMethod,
     FrFoodRep, DmFoodRep;

type
  TEnumFeedTime = (tfAM=1, tfPM=2);
  TEnumFeedType = (ttNorm=1, ttDiab=2);
  //
  TRecRep4Fields = record
    WardID, WardName :String;
    Normal, Special :Integer;
  end;

  TControllerFoodRep = Class
  private
    FFrFoodRep  :TfrmFoodRep;
    DFoodRep    :IFoodRepDataX;
    FManFoodRep :TClientDataSet;
    //
    FCdsFeedNorm  :TClientDataSet;
    FCdsFeedDiab  :TClientDataSet;
    FFeeds        :TStrings;
    FFeedRowHeads :TStrings;
    FFeedTime     :TEnumFeedTime;
    FFeedType     :TEnumFeedType;
    //
    procedure DoGenerateReportDataSet(var cds :TClientDataSet); overload;
    procedure DoGenerateReportDataSet(var cds :TClientDataSet; ds:TDataSet); overload;
    procedure DoGenerateReport1DataSet(var cds :TClientDataSet; ds:TDataSet);
    procedure DoGenerateReport4DataSet(var cds :TClientDataSet; ds:TDataSet);
    procedure DoPrintReport(const idx :Integer);
    //
    procedure DoReportCreate;
    procedure DoReportEdit;
    procedure DoReportDelete;
    procedure DoReportCopy;
    procedure DoReportPrint;
    procedure DoSetReportParamsInputter(const idx :Integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
    function CreateModelFoodRep :IDataSetX;
    function View :TForm;
    //
    procedure OnCommandInput(Sender :TObject);
  End;

implementation

const
  ACT_REP_CR  = 'actRepCr';
  ACT_REP_ED  = 'actRepEdt';
  ACT_REP_DEL = 'actRepDel';
  ACT_REP_CPY = 'actRepCopy';
  ACT_REP_PRN = 'actRepPrn';
  //
  BBT_PRN    = 'bbtPrint';
  LST_REP    = 'lstRep';
  //
  CFM_DEL    = 'ź��§ҹ���';
  CFM_CPY    = '�׹�ѹ������§ҹ���';
  
{ TControllerFoodRep }

constructor TControllerFoodRep.Create;
begin
  Start;
end;

destructor TControllerFoodRep.Destroy;
begin
  FFeeds.Free;
  FFeedRowHeads.Free;
  FreeAndNil(FCdsFeedNorm);
  FreeAndNil(FCdsFeedDiab);
  FreeAndNil(FFrFoodRep);
  inherited;
end;

procedure TControllerFoodRep.OnCommandInput(Sender: TObject);
begin
  if Sender Is TBitBtn then begin
    if TBitBtn(Sender).Name=BBT_PRN then
      DoPrintReport(FFrFoodRep.SelectedReportIndex);
  end else if Sender Is TListBox then begin
    if TListBox(Sender).Name=LST_REP then
      DoSetReportParamsInputter(TListBox(Sender).ItemIndex);
  end else if Sender Is TAction then begin
    if TCustomAction(Sender).Name=ACT_REP_CR then
      DoReportCreate
    else if TCustomAction(Sender).Name=ACT_REP_ED then
      DoReportEdit
    else if TCustomAction(Sender).Name=ACT_REP_DEL then
      DoReportDelete
    else if TCustomAction(Sender).Name=ACT_REP_CPY then
      DoReportCopy
    else if TCustomAction(Sender).Name=ACT_REP_PRN then
      DoReportPrint;
  end;
end;

function TControllerFoodRep.CreateModelFoodRep: IDataSetX;
var p :TRecDataXSearch;
begin
  DFoodRep := TDmoFoodRep.Create(nil);
  DFoodRep.SearchKey := p;
  Result := DFoodRep;
end;

procedure TControllerFoodRep.Start;
begin
  FFrFoodRep := TfrmFoodRep.Create(nil);
  FFrFoodRep.DataInterface(CreateModelFoodRep);
  FFrFoodRep.SetActionEvents(OnCommandInput);
  //
  FManFoodRep := FFrFoodRep.DataManFoodRep;
  //
  FFeedTime  := tfAM;
  FFeedType  := ttNorm;
  //
  FCdsFeedNorm := TClientDataSet.Create(nil);
  FCdsFeedDiab := TClientDataSet.Create(nil);
  //
  FFeeds        := TStringList.Create;
  FFeedRowHeads := TStringList.Create;
end;

function TControllerFoodRep.View: TForm;
begin
  Result := FFrFoodRep;
end;

{private}
procedure TControllerFoodRep.DoGenerateReportDataSet(var cds: TClientDataSet);
begin
//
end;

procedure TControllerFoodRep.DoGenerateReport1DataSet(
  var cds: TClientDataSet;
  ds: TDataSet);
begin
  cds := FFrFoodRep.DataManFoodRep;
  DoGenerateReportDataSet(cds,ds);
end;

procedure TControllerFoodRep.DoGenerateReport4DataSet(
  var cds: TClientDataSet;
  ds: TDataSet);
const pat_norm = '00010001';
      pat_spec = '00010002';
var snd :TRecRep4Fields;
begin
  //
  cds := FFrFoodRep.DataManFoodRep4;
  repeat
    snd.WardID   := ds.FieldByName('WARDID').AsString;
    snd.WardName := ds.FieldByName('WARDNAME').AsString;
    if ds.FieldByName('REQCODE').AsString=pat_norm then
      snd.Normal := ds.FieldByName('MEALS').AsInteger
    else if ds.FieldByName('REQCODE').AsString=pat_spec then
      snd.Special := ds.FieldByName('MEALS').AsInteger;
    //
    if not cds.Locate('WARDID',snd.WardID,[]) then
      cds.Append
    else cds.Edit;
    //
    if cds.State = dsInsert then begin
      cds.FieldByName('WARDID').AsString   := snd.WardID;
      cds.FieldByName('WARDNAME').AsString := snd.WardName;
      cds.FieldByName('NORMAL').AsInteger  := snd.Normal;
      cds.FieldByName('SPECIAL').AsInteger := snd.Special;
    end else if cds.State = dsEdit then begin
      if snd.Normal>0 then
        cds.FieldByName('NORMAL').AsInteger := snd.Normal
      else if snd.Special>0 then
        cds.FieldByName('SPECIAL').AsInteger := snd.Special;
    end;
    //
    cds.Post;
    ds.Next;
  until ds.Eof ;
end;

procedure TControllerFoodRep.DoGenerateReportDataSet(
  var cds: TClientDataSet;  ds: TDataSet);
var dsp :TDataSetProvider;
begin
//
  dsp := TDataSetProvider.Create(nil);
  try
     dsp.DataSet := ds;
     cds.Data    := dsp.Data;
  finally
    dsp.Free;
  end;
end;

procedure TControllerFoodRep.DoPrintReport(const idx: Integer);
var ds :TDataSet; snd :TRecGetReport;
begin
  if (idx=1)or(idx=2) then
    Exit;
  //
  snd.Index := idx;
  snd.FrDate := DateOnly(FFrFoodRep.GetFrDate);
  snd.ToDate := DateOnly(FFrFoodRep.GetToDate);
  ds := DFoodRep.GetFoodReport(snd);
  if ds.IsEmpty then
    Exit;
  //
  case idx of
    0: DoGenerateReport1DataSet(FManFoodRep,ds);
    3: DoGenerateReport4DataSet(FManFoodRep,ds);
  end;
  //
  if not(FManFoodRep.IsEmpty) then
    DFoodRep.PrintReport(idx,FManFoodRep);
end;

procedure TControllerFoodRep.DoReportCopy;
var sRepCode :String;
begin
  if MessageDlg(CFM_CPY,mtWarning,[mbYes,mbNo],0)=mrNo then
    Exit;
  sRepCode := FFrFoodRep.GetReportCode;
  DFoodRep.ReportCopy(sRepCode);
  FFrFoodRep.Contact;
end;

procedure TControllerFoodRep.DoReportCreate;
var sRepName :String;
begin
  sRepName := FFrFoodRep.GetReportName;
  DFoodRep.ReportCreate(sRepName);
  FFrFoodRep.Contact;
  FFrFoodRep.DoClearInput;
end;

procedure TControllerFoodRep.DoReportDelete;
var sRepCode :String;
begin
  if MessageDlg(CFM_DEL,mtWarning,[mbYes,mbNo],0)=mrNo then
    Exit;
  sRepCode := FFrFoodRep.GetReportCode;
  DFoodRep.ReportDelete(sRepCode);
  FFrFoodRep.Contact;
end;

procedure TControllerFoodRep.DoReportEdit;
var sRepCode :String;
begin
  sRepCode := FFrFoodRep.GetReportCode;
  DFoodRep.ReportEdit(sRepCode);
  FFrFoodRep.Contact(sRepCode);
end;

procedure TControllerFoodRep.DoReportPrint;
var sRepCode :String;
begin
  sRepCode := FFrFoodRep.GetReportCode;
  DFoodRep.ReportPrint(sRepCode);
end;

procedure TControllerFoodRep.DoSetReportParamsInputter(const idx: Integer);
var snd :TRecSetReportParamInputter;
begin
  case idx of
    0 : FFrFoodRep.DoSetHasParams(snd.SetFrDate);
    3 : FFrFoodRep.DoSetHasParams(snd.SetRangeDate);
  else
    FFrFoodRep.DoSetHasParams(snd.ResetDate);
  end;
  FFrFoodRep.DoSetDateInputters;
end;

end.
