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

procedure TControllerFoodRep.DoPrintReport(const idx: Integer);
var ds :TDataSet; snd :TRecGetReport;
begin
  snd.Index := idx;
  case idx of
    0: begin
      snd.FrDate := DateOnly(FFrFoodRep.GetDate);
      //
      ds := FFoodRep.GetFoodReport(snd);
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
var snd :TRecSetReportParamInputter;
begin
  case idx of
    0 : FFrFoodRep.DoSetHasParams(True);
  else
    FFrFoodRep.DoSetHasParams(False);
  end;
end;

end.
