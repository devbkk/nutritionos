unit CtrFoodRep;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, StrUtils, SysUtils, ComCtrls,
     Buttons, Provider,
     //
     ShareInterface, ShareMethod, FrFoodRep, DmFoodRep;

type
  TEnumFeedTime = (tfAM=1, tfPM=2);
  TEnumFeedType = (ttNorm=1, ttDiab=2);

  TControllerFoodRep = Class
  private
    FFrFoodRep  :TfrmFoodRep;
    FFoodRep    :IFoodRepDataX;
    FManFoodRep :TClientDataSet;
    //
    FCdsFeedNorm  :TClientDataSet;
    FCdsFeedDiab  :TClientDataSet;
    FFeeds        :TStrings;
    FFeedRowHeads :TStrings;
    FFeedTime     :TEnumFeedTime;
    FFeedType     :TEnumFeedType;
    //
    //function  CurrentFeed :TClientDataSet;
    //procedure DoGenRepFeedFormulaBuffer;
    //procedure DoGenRepFeedFormulaColumn;
    //procedure DoGenRepFeedCormulaDataSet;
    //procedure DoGenRepFeedFormulaRowHead;
    //
    procedure DoGenerateReportDataSet(var cds :TClientDataSet); overload;
    procedure DoGenerateReportDataSet(var cds :TClientDataSet; ds:TDataSet); overload;
    procedure DoPrintReport(const idx :Integer);
    //
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
  BBT_PRN = 'bbtPrint';
  LST_REP = 'lstRep';

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
  end else If Sender Is TListBox then begin
    if TListBox(Sender).Name=LST_REP then
      DoSetReportParamsInputter(TListBox(Sender).ItemIndex);
  end;
end;

function TControllerFoodRep.CreateModelFoodRep: IDataSetX;
var p :TRecDataXSearch;
begin
  FFoodRep := TDmoFoodRep.Create(nil);
  FFoodRep.SearchKey := p;
  Result := FFoodRep;
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
{function TControllerFoodRep.CurrentFeed: TClientDataSet;
begin
  if FFeedType=ttNorm then
    Result := FCdsFeedNorm
  else Result := FCdsFeedDiab;
end;}

procedure TControllerFoodRep.DoGenerateReportDataSet(var cds: TClientDataSet);
begin
//
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

{procedure TControllerFoodRep.DoGenRepFeedCormulaDataSet;
begin
  DoGenRepFeedFormulaColumn;
  DoGenRepFeedFormulaRowHead;
  DoGenRepFeedFormulaBuffer;
end;}

{procedure TControllerFoodRep.DoGenRepFeedFormulaBuffer;
var ds :TDataSet; fld :TField;
    sTypC, sNote, sVal :String;
    sExtr :TStrings;  amt :Extended;
    i, iAmT, iCnt :Integer;
//
begin
  //
  for i := 0 to FFeedRowHeads.Count-1 do begin
    CurrentFeed.Append;
    CurrentFeed.FieldByName('C00').AsString := FFeedRowHeads[i];
    CurrentFeed.Post;
  end;
  //
  if FFeedType=ttNorm then
    ds := FFoodRep.GetFeedFormulaTotal('01','001')
  else ds := FFoodRep.GetFeedFormulaTotal('01','002');
  //
  repeat
    if FFeedTime=tfAM then
      iAmT  := StrToIntDef(ds.FieldByName('TOTALAM').AsString,0)
    else iAmt := StrToIntDef(ds.FieldByName('TOTALPM').AsString,0);
    iCnt  := StrToIntDef(ds.FieldByName('CNT').AsString,0);
    //
    sTypC := ds.FieldByName('CODE').AsString;
    sNote := FFeeds.Values[sTypC];
    sExtr := TStringList.Create;
    try
      sExtr.Delimiter := '|';
      sExtr.StrictDelimiter := True;
      sExtr.DelimitedText := sNote;
      //
      fld := CurrentFeed.FindField(sTypc);
      if fld=nil then
        Continue;
      //
      i:= 0;
      CurrentFeed.First;
      CurrentFeed.Next;
      repeat
        CurrentFeed.Edit;
        if(i=0)or(i=1) then
          sVal := ReplaceStr(sExtr[i],'''','')
        else if i=9 then begin
          sVal := IntToStr(iCnt);
        end else begin
          amt  := StrToFloat(ReplaceStr(sExtr[i],'''',''))*iAmt/1000;
          sVal := FloatToStr(amt);
        end;
        fld.AsString := sVal;
        CurrentFeed.Post;
        //
        Inc(i);
        CurrentFeed.Next;
      until CurrentFeed.Eof;
    finally
      sExtr.Free;
    end;
    ds.Next;
  until ds.Eof;
end;}

{procedure TControllerFoodRep.DoGenRepFeedFormulaColumn;
var ds :TDataSet;
    sCol, sLst, sVal :String;
    i :Integer;
const is_diab = 'เบาหวาน';

function ExtrColumn(idx :Integer) :String;
var s :TStrings;
begin
  sVal := StringReplace(sVal,' ','^',[rfReplaceAll]);
  s := TStringList.Create;
  try
    s.Delimiter := '^';
    s.StrictDelimiter := True;
    s.DelimitedText := sVal;
  Result := s[idx];
  finally
    s.Free;
  end;
end;
//
begin
  if CurrentFeed.Active then
    CurrentFeed.Close;
  CurrentFeed.FieldDefs.Clear;
  //
  if FFeedType=ttNorm then
    ds := FFoodRep.GetFeedFormulaColumn('01','001')
  else ds := FFoodRep.GetFeedFormulaColumn('01','002');
  //
  CurrentFeed.FieldDefs.Add('C00', ftString, 30, False);
  //
  repeat
    sCol := ds.Fields[0].AsString;
    CurrentFeed.FieldDefs.Add(sCol, ftString, 10, False);
    //
    ds.Next;
  until ds.Eof;
  CurrentFeed.CreateDataSet;
  //add header for first row
  CurrentFeed.Append;
  CurrentFeed.Fields[0].AsString := 'มื้อ';
  ds.First;
  i := 0;
  //
  repeat
    sVal := ds.Fields[1].AsString;
    if sVal <> '' then begin
      if FFeedType = ttNorm then
        sVal := ExtrColumn(0)
      else if FFeedType = ttDiab then
        sVal := ExtrColumn(1)
      else sVal := ExtrColumn(1);
    end;

    CurrentFeed.Fields[i+1].AsString := sVal;
    //
    sLst := sLst+ ds.Fields[0].AsString+'='+
            QuotedStr(ds.Fields[2].AsString)+'^';
    Inc(i);
    ds.Next;
  until ds.Eof;
  CurrentFeed.Post;
  //
  FFeeds.Clear;
  sLst := Copy(sLst,1,Length(sLst)-1);
  FFeeds.Delimiter := '^';
  FFeeds.StrictDelimiter := True;
  FFeeds.DelimitedText := sLst;
end;}

{procedure TControllerFoodRep.DoGenRepFeedFormulaRowHead;
var ds :TDataSet;
begin
  if FFeedType=ttNorm then
    ds := FFoodRep.GetFeedFormulaRowHead('00001001')
  else ds := FFoodRep.GetFeedFormulaRowHead('00001002');
  //
  FFeedRowHeads.Delimiter := '|';
  FFeedRowHeads.StrictDelimiter := True;
  FFeedRowHeads.DelimitedText := ds.FieldByName('NOTE').AsString;
  //
  FFeedRowHeads.Append('จำนวน(คน)');
end;}

{procedure TControllerFoodRep.DoPrintReport(const idx: Integer);
var cds :TClientDataSet; sMeal :String;
const meal_am = 'เช้า'; meal_pm = 'เย็น';

procedure LocAppendFeedBuffer(t :TEnumFeedType);
begin
  FFeedType := t;
  DoGenRepFeedCormulaDataSet;
  cds := CurrentFeed;
  FFoodRep.FeedAppendClientDS(cds,Ord(t));
end;
//
begin
  if Idx=-1 then
    Exit;
  //
  if Idx=0 then begin
    //
    sMeal := FFrFoodRep.GetMeal;
    if sMeal = meal_am then
      FFeedTime := tfAM
    else FFeedTime := tfPM;
    //
    LocAppendFeedBuffer(ttNorm);
    LocAppendFeedBuffer(ttDiab);
    //
    sMeal := QuotedStr('มื้อ'+sMeal);
    FFoodRep.SetMealDesc(sMeal);
    FFoodRep.PrintReport(Idx);
  end else begin
    DoGenerateReportDataSet(FManFoodRep);
    FFoodRep.PrintReport(Idx,FManFoodRep);
  end;
end;}

procedure TControllerFoodRep.DoPrintReport(const idx: Integer);
var ds :TDataSet; dtSel :TDateTime;
begin
  case idx of
    0: begin
      dtSel := DateOnly(FFrFoodRep.GetDate);
      //
      ds := FFoodRep.GetFoodReport(dtSel);
      if ds.IsEmpty then
        Exit;
      DoGenerateReportDataSet(FManFoodRep,ds);

    end;
  end;
  //
  if not(FManFoodRep.IsEmpty) then
    FFoodRep.PrintReport(idx,FManFoodRep);
end;

procedure TControllerFoodRep.DoSetReportParamsInputter(const idx: Integer);
begin
  case idx of
    0 : FFrFoodRep.DoSetHasParams(True);
  else
    FFrFoodRep.DoSetHasParams(False);
  end;
end;

end.
