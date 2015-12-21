unit CtrFoodReq;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, StrUtils, SysUtils,
     //
     ShareInterface, ShareMethod,
     DmFoodReq, FrFoodReq, FrHcSearch;

type
  TControllerFoodReq = class
  private
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
    procedure DoHcSearch;
    procedure DoSetHcData(const s :String);overload;
    procedure DoSetHcData(const ds :TDataSet);overload;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
    procedure OnCommandSearch(Sender :TObject);
    procedure OnCommandInput(Sender :TObject);
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
  CFM_DEL   = 'ลบข้อมูลนี้?';

{ TControllerFoodReq }
constructor TControllerFoodReq.Create;
begin
  Start;
end;

destructor TControllerFoodReq.Destroy;
begin

  inherited;
end;

{public}
procedure TControllerFoodReq.OnCommandInput(Sender: TObject);
begin
  if TCustomAction(Sender).Name=CMP_ACTAW then
    DoAddWrite
  else if TCustomAction(Sender).Name=CMP_ACTDC then
    DoCancelDel
  else if TCustomAction(Sender).Name=CMP_ACTSC then
    DoHcSearch;
end;

procedure TControllerFoodReq.OnCommandSearch(Sender: TObject);
begin
  if FFrHcSrc=nil then
    Exit;
  //
  if TCustomAction(Sender).Name=CMP_ACTSL then begin
    FFrHcSrc.ModalResult := mrOK;
  end else if TCustomAction(Sender).Name=CMP_ACTXT then begin
    FFrHcSrc.ModalResult := mrCancel;
  end;
end;

procedure TControllerFoodReq.Start;
begin
  FFrFoodReq := TfrmFoodReq.Create(nil);
  FFrFoodReq.DataInterface(CreateModelFoodReq);
  FFrFoodReq.SetActionEvents(OnCommandInput);
  //
  FManFoodReq := FFrFoodReq.DataManFoodReq;
  FManHcData  := FFrFoodReq.DataManHcData;
  //
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
    FManHcData.Post;
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
end;

procedure TControllerFoodReq.DoHcSearch;
//var sAns :String;
var ds :TDataSet;
begin
  FFrHcSrc := TfrmHcSearch.Create(nil);
  FFrHcSrc.DataInterface(FFoodReq);
  FFrHcSrc.SetActionEvents(OnCommandSearch);
  //
  //sAns := FFrHcSrc.Answer;
  //DoSetHcData(sAns);
  ds := FFrHcSrc.AnswerSet;
  if ds = nil then
    Exit;
  DoSetHcData(ds);
end;

procedure TControllerFoodReq.DoSetHcData(const ds: TDataSet);
var sHn, sAn, sPatName, sGender :String;
    sWt, sHt :String; iAge :Integer;
begin
  if FManHcData.State in [dsInsert,dsEdit] then begin
    sHn := TrimRight(ds.FieldByName('HN').AsString);
    sAn := TrimRight(ds.FieldByName('AN').AsString);
    sPatName := TrimRight(ds.FieldByName('PATNAME').AsString);
    //
    if ds.FieldByName('GENDER').AsString = 'ช' then
      sGender := 'M'
    else sGender := 'F';
    //
    iAge := AgeFrYmdDate(ds.FieldByName('BIRTH').AsString);
    sWt  := ds.FieldByName('WTS').AsString;
    sHt  := ds.FieldByName('HTS').AsString;
    //
    FManHcData.AppendRecord([sHn,sAn,sPatName,sGender,iAge,sHt,sWt]);
  end;
end;

procedure TControllerFoodReq.DoSetHcData(const s: String);
var sHn, sAn, sPatName, sGender :String;
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

end.
