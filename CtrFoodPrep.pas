unit CtrFoodPrep;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, StrUtils, SysUtils, ComCtrls,
     //
     ShareInterface, ShareMethod, FrFoodPrep, DmFoodPrep;

type

  TControllerFoodPrep = class
  private
    FFrFoodPrep  :TfrmFoodPrep;
    FFoodPrep    :IFoodPrepDataX;
    FManFoodPrep :TClientDataSet;
    FManSelPrn   :TClientDataSet;
    FSelAmPm     :Integer;
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
    procedure OnCommandInput(Sender :TObject);
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

procedure TControllerFoodPrep.Start;
begin
  FFrFoodPrep := TfrmFoodPrep.Create(nil);
  FFrFoodPrep.DataInterface(CreateModelFoodPrep);
  FFrFoodPrep.SetActionEvents(OnCommandInput);
  //
  FManFoodPrep := FFrFoodPrep.DataManFoodPrep;
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

procedure TControllerFoodPrep.DoSelPrint;
var i :Integer;
begin
  if FFrFoodPrep.GetSelectedList.Count = 0 then
    Exit;
  //
  FManSelPrn.EmptyDataSet;
  for i := 0 to FFrFoodPrep.GetSelectedList.Count - 1 do begin
    FManFoodPrep.GotoBookmark(Pointer(FFrFoodPrep.GetSelectedList.Items[i]));
    FManSelPrn.AppendRecord([FManFoodPrep.Fields[0].AsString,
                             FManFoodPrep.Fields[1].AsString,
                             FManFoodPrep.Fields[2].AsString,
                             FManFoodPrep.Fields[3].AsString,
                             FManFoodPrep.Fields[4].AsString,
                             FManFoodPrep.Fields[5].AsString,
                             FManFoodPrep.Fields[6].AsString,
                             FManFoodPrep.Fields[7].AsString,
                             FManFoodPrep.Fields[8].AsString]);
  end;
  FFoodPrep.SetPrintAmPm(FSelAmPm);  
  FFoodPrep.PrintSelected(FManSelPrn);
end;

end.
