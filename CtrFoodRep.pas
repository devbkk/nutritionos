unit CtrFoodRep;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, StrUtils, SysUtils, ComCtrls,
     Buttons,
     //
     ShareInterface, ShareMethod, FrFoodRep, DmFoodRep;

type

  TControllerFoodRep = Class
  private
    FFrFoodRep  :TfrmFoodRep;
    FFoodRep    :IFoodRepDataX;
    FManFoodRep :TClientDataSet;
    FCdsFormula :TClientDataSet;
    FFeeds        :TStrings;
    FFeedRowHeads :TStrings;
    //
    procedure DoGenRepFeedFormulaBuffer;
    procedure DoGenRepFeedFormulaColumn;
    procedure DoGenRepFeedCormulaDataSet;
    procedure DoGenRepFeedFormulaRowHead;
    //
    procedure DoGenerateReportDataSet(var cds :TClientDataSet);
    procedure DoPrintReport(const idx :Integer);
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

{ TControllerFoodRep }

constructor TControllerFoodRep.Create;
begin
  Start;
end;

destructor TControllerFoodRep.Destroy;
begin
  FFeeds.Free;
  FFeedRowHeads.Free;
  FreeAndNil(FCdsFormula);
  FreeAndNil(FFrFoodRep);
  inherited;
end;

procedure TControllerFoodRep.OnCommandInput(Sender: TObject);
begin
  if Sender Is TBitBtn then begin
    if TBitBtn(Sender).Name=BBT_PRN then
      DoPrintReport(FFrFoodRep.SelectedReportIndex);

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
  FCdsFormula := TClientDataSet.Create(nil);
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

procedure TControllerFoodRep.DoGenRepFeedCormulaDataSet;
begin
  DoGenRepFeedFormulaColumn;
  DoGenRepFeedFormulaRowHead;
  DoGenRepFeedFormulaBuffer;
end;

procedure TControllerFoodRep.DoGenRepFeedFormulaBuffer;
var ds :TDataSet; i, iAmT :Integer;
    sTypC,sNote, sVal :String;
    sExtr :TStrings; fld :TField; amt :Extended;
begin

  //
  for i := 0 to FFeedRowHeads.Count-1 do begin
    FCdsFormula.Append;
    FCdsFormula.FieldByName('C00').AsString := FFeedRowHeads[i];
    FCdsFormula.Post;
  end;
  //
  ds := FFoodRep.GetFeedFormulaTotal;
  repeat
    iAmT  := StrToIntDef(ds.FieldByName('TOTALAM').AsString,0);
    sTypC := ds.FieldByName('FOODTYPC').AsString;
    sNote := FFeeds.Values[sTypC];
    sExtr := TStringList.Create;
    try
      sExtr.Delimiter := '|';
      sExtr.StrictDelimiter := True;
      sExtr.DelimitedText := sNote;
      //
      fld := FCdsFormula.FindField(sTypc);
      if fld=nil then
        Continue;
      //
      i:= 0;
      FCdsFormula.First;
      FCdsFormula.Next;
      repeat
        FcdsFormula.Edit;
        if(i=0)or(i=1) then
          sVal := ReplaceStr(sExtr[i],'''','')
        else begin
          amt  := StrToFloat(ReplaceStr(sExtr[i],'''',''))*iAmt/1000;
          sVal := FloatToStr(amt);
        end;
        fld.AsString := sVal;
        FCdsFormula.Post;
        //
        Inc(i);
        FCdsFormula.Next;
      until FCdsFormula.Eof;
    finally
      sExtr.Free;
    end;
    ds.Next;
  until ds.Eof;
end;

procedure TControllerFoodRep.DoGenRepFeedFormulaColumn;
var ds :TDataSet; i :Integer; sCol, sLst :String;
begin
  if FCdsFormula.Active then
    FCdsFormula.Close;
  FCdsFormula.FieldDefs.Clear;
  //
  ds := FFoodRep.GetFeedFormulaColumn('01','001');
  FCdsFormula.FieldDefs.Add('C00', ftString, 30, False);
  //
  //i  := 1;
  repeat
    //sCol := 'C'+ RightStr('00'+IntToStr(i),2);
    sCol := ds.Fields[0].AsString;
    FCdsFormula.FieldDefs.Add(sCol, ftString, 10, False);
    //
    //Inc(i);
    ds.Next;
  until ds.Eof;
  FCdsFormula.CreateDataSet;
  //add header for first row
  FCdsFormula.Append;
  FCdsFormula.Fields[0].AsString := 'มื้อ';
  ds.First;
  i := 0;
  //
  repeat
    FCdsFormula.Fields[i+1].AsString := ds.Fields[1].AsString;
    sLst := sLst+ ds.Fields[0].AsString+'='+
            QuotedStr(ds.Fields[2].AsString)+'^';
    Inc(i);
    ds.Next;
  until ds.Eof;
  FCdsFormula.Post;
  //
  FFeeds.Clear;
  sLst := Copy(sLst,1,Length(sLst)-1);
  FFeeds.Delimiter := '^';
  FFeeds.StrictDelimiter := True;
  FFeeds.DelimitedText := sLst;
end;

procedure TControllerFoodRep.DoGenRepFeedFormulaRowHead;
var ds :TDataSet;
begin
  ds := FFoodRep.GetFeedFormulaRowHead('00001001');
  FFeedRowHeads.Delimiter := '|';
  FFeedRowHeads.StrictDelimiter := True;
  FFeedRowHeads.DelimitedText := ds.FieldByName('NOTE').AsString;
end;

procedure TControllerFoodRep.DoPrintReport(const idx: Integer);
begin
  if Idx=-1 then
    Exit;
  if Idx=0 then begin
    DoGenRepFeedCormulaDataSet;
    FFoodRep.PrintReport(Idx,FCdsFormula);
  end else begin
    DoGenerateReportDataSet(FManFoodRep);
    FFoodRep.PrintReport(Idx,FManFoodRep);
  end;
end;

end.
