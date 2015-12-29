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

{ TControllerFoodPrep }

constructor TControllerFoodPrep.Create;
begin
  Start;
end;

destructor TControllerFoodPrep.Destroy;
begin
  //
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
      DoSelPrint;   
  end;
end;

procedure TControllerFoodPrep.Start;
begin
  FFrFoodPrep := TfrmFoodPrep.Create(nil);
  FFrFoodPrep.DataInterface(CreateModelFoodPrep);
  FFrFoodPrep.SetActionEvents(OnCommandInput);
  //
  FManFoodPrep := FFrFoodPrep.DataManFoodPrep;
end;

function TControllerFoodPrep.View: TForm;
begin
  Result := FFrFoodPrep;
end;

{private}
procedure TControllerFoodPrep.DoPrintAll;
begin
  FFoodPrep.PrintAll;
end;

procedure TControllerFoodPrep.DoSelPrint;
begin
  ShowMessage('Select Print');
end;

end.
