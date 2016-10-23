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
procedure TControllerFoodPrep.DoPrintAll;
begin
  FFoodPrep.SetPrintAmPm(FSelAmPm);
  FFoodPrep.PrintAll;
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
var i :Integer;
    dtPrn :TDateTime;
    sHn, sPatLoc, sPatName, sDiag, sFood, sMeal, sReqID :String;
    sComDis :String;
begin
  if FFrFoodPrep.GetSelectedList.Count = 0 then
    Exit;

  //
  FManSelPrn.EmptyDataSet;
  for i := 0 to FFrFoodPrep.GetSelectedList.Count - 1 do begin
    FManFoodPrep.GotoBookmark(Pointer(FFrFoodPrep.GetSelectedList.Items[i]));

    //
    dtPrn := DateOnly(FManFoodPrep.FieldByName('PRNDATE').AsDateTime);
    sHn   := FManFoodPrep.FieldByName('HN').AsString;
    sPatLoc  := FManFoodPrep.FieldByName('WARDNAME').AsString+'/' +
                FManFoodPrep.FieldByName('ROOMNO').AsString+'/' +
                FManFoodPrep.FieldByName('BEDNO').AsString;
    sPatName := FManFoodPrep.FieldByName('PATNAME').AsString;
    sDiag    := FManFoodPrep.FieldByName('DIAG').AsString;
    sDiag    := ICtrlFoodDet.DiagDetLabel(sDiag);
    sReqID   := FManFoodPrep.FieldByName('REQID').AsString;
    sFood    := ICtrlFoodDet.FoodDetLabel(sReqID);
    sMeal    := FManFoodPrep.FieldByName('MEALORD').AsString;
    sComDis  := FManFoodPrep.FieldByName('COMDIS').AsString;
    if sComDis = 'Y' then
      sComDis := '***';



    //
    FManSelPrn.AppendRecord([dtPrn,
                             sHn,
                             sPatLoc,
                             sPatName,
                             sDiag,
                             sFood,
                             sMeal,
                             sComDis]);
  end;
  FFoodPrep.PrintSelected(FManSelPrn);
end;

end.
