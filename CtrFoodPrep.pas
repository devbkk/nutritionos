unit CtrFoodPrep;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, StrUtils, SysUtils, ComCtrls,
     //
     ShareInterface, ShareMethod, FrFoodPrep;

type

  TControllerFoodPrep = class
  private
    FFrFoodPrep :TfrmFoodPrep;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
    function View :TForm;
  end;

implementation

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

procedure TControllerFoodPrep.Start;
begin
  FFrFoodPrep := TfrmFoodPrep.Create(nil);
end;

function TControllerFoodPrep.View: TForm;
begin
  Result := FFrFoodPrep;
end;

end.
