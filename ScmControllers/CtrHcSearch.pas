unit CtrHcSearch;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, StrUtils, SysUtils, ComCtrls,
     //
     ShareInterface, ShareMethod;

type
  TControllerHcSearch = class
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
  end;

implementation

{ TControllerHcSearch }

constructor TControllerHcSearch.Create;
begin
  Start;
end;

destructor TControllerHcSearch.Destroy;
begin

  inherited;
end;

procedure TControllerHcSearch.Start;
begin
//
end;

end.
