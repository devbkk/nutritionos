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
end;

function TControllerFoodRep.View: TForm;
begin
  Result := FFrFoodRep;
end;

{private}
procedure TControllerFoodRep.DoGenerateReportDataSet(var cds: TClientDataSet);
begin
  
end;

procedure TControllerFoodRep.DoPrintReport(const idx: Integer);
begin
  if Idx=-1 then
    Exit;
  DoGenerateReportDataSet(FManFoodRep);
  FFoodRep.PrintReport(Idx,FManFoodRep);
end;

end.
