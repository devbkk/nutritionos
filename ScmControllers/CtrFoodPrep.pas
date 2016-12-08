unit CtrFoodPrep;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, StrUtils, SysUtils, ComCtrls,
     DBGrids,
     //
     ShareCommon, ShareController, ShareInterface, ShareMethod,
     FrFoodPrep, DmFoodPrep;

type
  TCallBackReqFoodDet = procedure(Sender :TObject; ReqID :String) of object;
  //
  TControllerFoodPrep = class
  private
    FFrFoodPrep  :TfrmFoodPrep;
    FFoodPrep    :IFoodPrepDataX;
    FManFoodPrep :TClientDataSet;
    FManSelPrn   :TClientDataSet;
    FSelAmPm     :Integer;
    FPrepDate    :TDateTime;
    //
    ICtrlFoodDet :ICtrlReqFoodDet;
    //
    function AssignPrintDataToRecord:TRecPrintData;
    procedure DoPrintAll;
    procedure DoSelPrint;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
    function CreateModelFoodPrep :IDataSetX;
    function View :TForm;
    //
    procedure DoSearchByCond(const s :String);
    procedure OnCommandInput(Sender :TObject);
    procedure OnDataFilter(
      DataSet: TDataSet; var Accept: Boolean);
    procedure OnKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SetInfCtrlFoodDet(inf :ICtrlReqFoodDet);
  end;

implementation

const
  CMP_ACPRN = 'actPrintAll';
  CMP_ACSPR = 'actSelPrint';
  CMP_ACPAM = 'actPrnAm';
  CMP_ACPPM = 'actPrnPm';
  //
  PRN_AM = 0;
  PRN_PM = 1;

{ TControllerFoodPrep }

constructor TControllerFoodPrep.Create;
begin
  Start;
end;

destructor TControllerFoodPrep.Destroy;
begin
  //
  FManSelPrn.Free;
  FManFoodPrep.Free;
  FFrFoodPrep.Free;
  FreeAndNil(FFoodPrep);
  inherited;
end;

function TControllerFoodPrep.CreateModelFoodPrep: IDataSetX;
var p :TRecDataXSearch;
begin
  FFoodPrep := TDmoFoodPrep.Create(nil);
  FFoodPrep.SearchKey := p;
  Result := FFoodPrep;
end;

procedure TControllerFoodPrep.OnCommandInput(Sender: TObject);
begin
  if Sender Is TCustomAction then begin
    if TCustomAction(Sender).Name=CMP_ACPRN then
      DoPrintAll
    else if TCustomAction(Sender).Name=CMP_ACSPR then
      DoSelPrint
    else if TCustomAction(Sender).Name=CMP_ACPAM then
      FSelAmPm := PRN_AM
    else if TCustomAction(Sender).Name=CMP_ACPPM then
      FSelAmPm := PRN_PM;
  end;
end;

procedure TControllerFoodPrep.OnDataFilter(DataSet: TDataSet;
  var Accept: Boolean);
var fldRqFr, fldRqTo :TField;
begin
  fldRqFr := DataSet.FindField('REQFR');
  fldRqTo := DataSet.FindField('REQTO');
  Accept:= (FPrepDate>=fldRqFr.AsDateTime)and(FPrepDate<=fldRqTo.AsDateTime);
end;

procedure TControllerFoodPrep.OnKeyDown(
  Sender: TObject; var Key: Word;  Shift: TShiftState);
var grd :TDBGrid;
begin
  if Sender is TEdit then begin
    if Key = 13 then
      DoSearchByCond(TEdit(Sender).Text);
  end else if Sender is TDBGrid then begin
    if(Shift=[ssCtrl])and(Key=65)then begin
      grd := TDBGrid(Sender);
      //
      FManFoodPrep.DisableControls;
      try
        FManFoodPrep.First;
        while not FManFoodPrep.Eof do begin
          grd.SelectedRows.CurrentRowSelected := True;
          FManFoodPrep.Next;
        end;
      finally
        FManFoodPrep.EnableControls;
      end;
    end;
  end;
end;

procedure TControllerFoodPrep.SetInfCtrlFoodDet(inf: ICtrlReqFoodDet);
begin
  ICtrlFoodDet := inf;
end;

procedure TControllerFoodPrep.Start;
begin
  FFrFoodPrep := TfrmFoodPrep.Create(nil);
  FFrFoodPrep.DataInterface(CreateModelFoodPrep);
  FFrFoodPrep.SetActionEvents(OnCommandInput);
  FFrFoodPrep.SetEditKeyDownEvents(OnKeyDown);
  //
  FManFoodPrep := FFrFoodPrep.DataManFoodPrep;
  FManFoodPrep.OnFilterRecord := OnDataFilter;
  FManSelPrn   := FFrFoodPrep.SelectedData;
end;

function TControllerFoodPrep.View: TForm;
begin
  Result := FFrFoodPrep;
end;

{private}
function TControllerFoodPrep.AssignPrintDataToRecord: TRecPrintData;
var res :TRecPrintData;
const c_loc   = 'ÇÍÃì´%S  àµÕÂ§%S';
      c_halal = 'ÍÔÊÅÒÁ';
      
begin
  if FManFoodPrep.IsEmpty then
    Exit;

  //
  res.DatePrint  := FManFoodPrep.FieldByName('PRNDATE').AsDateTime;
  res.PrnDateStr := DateThai(res.DatePrint,[tstShowTime], tmThFull);
  res.Hn         := FManFoodPrep.FieldByName('HN').AsString;

  //
  res.PatLoc     := Format(c_loc,[FManFoodPrep.FieldByName('WARDNAME').AsString,
                                  FManFoodPrep.FieldByName('BEDNO').AsString]);

  //
  res.PatName := FManFoodPrep.FieldByName('PATNAME').AsString;
  res.Diag    := FManFoodPrep.FieldByName('DIAG').AsString;
  res.Diag    := ICtrlFoodDet.DiagDetLabel(res.Diag);
  res.ReqID   := FManFoodPrep.FieldByName('REQID').AsString;
  res.MealFmt := ICtrlFoodDet.FoodDetLabel(res.ReqID);
  res.Meal    := FManFoodPrep.FieldByName('MEALORD').AsString;
  res.ComDis  := FManFoodPrep.FieldByName('COMDIS').AsString;
  res.Relg    := FManFoodPrep.FieldByName('HALAL').AsString;

  //
  if Trim(res.Relg)<>'' then
    res.Relg := c_halal;

  //
  if res.ComDis = 'Y' then
    res.ComDis := '***';

  //
  res.DateBirth := FManFoodPrep.FieldByName('BIRTH').AsDateTime;
  res.Age       := IntToStr(AgeFrDate(res.DateBirth))+' »Õ';

  Result := res;
end;

procedure TControllerFoodPrep.DoPrintAll;
var bk :TBookmark; i, last :Integer; snd :TRecPrintData;
begin
  if FManFoodPrep.IsEmpty then
    Exit;

  //
  bk := FManFoodPrep.GetBookmark;
  FManFoodPrep.DisableControls;
  try

    FManFoodPrep.First;
    repeat
      snd := AssignPrintDataToRecord;
      last := StrToIntDef(snd.Meal,1);

      for i := 1 to last do begin
        //
        snd.Meal := IntToStr(i);
        //
        FManSelPrn.AppendRecord([snd.PrnDateStr,
                                 snd.Hn,
                                 snd.PatLoc,
                                 snd.PatName,
                                 snd.Diag,
                                 snd.MealFmt,
                                 snd.Meal,
                                 snd.ComDis,
                                 snd.Relg,
                                 snd.Age]);
      end;
      //
      FManFoodPrep.Next;
    until FManFoodPrep.Eof;
    //
    FFoodPrep.PrintSelected(FManSelPrn);
  finally
    FManFoodPrep.GotoBookmark(bk);
    FManFoodPrep.EnableControls;
  end;
end;

procedure TControllerFoodPrep.DoSearchByCond(const s: String);
const cnd_dt='date=';
var   sSrcDat :String;
begin
  if Pos(cnd_dt,s)>0 then begin
    sSrcDat := Copy(s,Pos(cnd_dt,s)+Length(cnd_dt),Length(s));
    if DateStrIsBD(sSrcDat) then begin
      FPrepDate := DateFrDMY(sSrcDat,True);
      FManFoodPrep.Filtered := True;
    end;
  end else begin
    FManFoodPrep.Filtered := False;
  end;
end;

procedure TControllerFoodPrep.DoSelPrint;
var i,j,last :Integer; snd :TRecPrintData;
begin
  if FFrFoodPrep.GetSelectedList.Count = 0 then
    Exit;

  //
  FManSelPrn.EmptyDataSet;
  for i := 0 to FFrFoodPrep.GetSelectedList.Count - 1 do begin
    FManFoodPrep.GotoBookmark(Pointer(FFrFoodPrep.GetSelectedList.Items[i]));
    //
    snd := AssignPrintDataToRecord;
    last := StrToIntDef(snd.Meal,1);
    //
    for j := 1 to last do begin

      snd.Meal := IntToStr(j);
      //
      FManSelPrn.AppendRecord([snd.PrnDateStr,
                               snd.Hn,
                               snd.PatLoc,
                               snd.PatName,
                               snd.Diag,
                               snd.MealFmt,
                               snd.Meal,
                               snd.ComDis,
                               snd.Relg,
                               snd.Age]);
    end;
  end;
  FFoodPrep.PrintSelected(FManSelPrn);
end;

end.
