unit SvChecker;

interface

uses Classes, CtrChkUpdMan, CtrChkLogMan;

type
  IServChecker = interface(IInterface)
  ['{B2DEA8C0-BB0D-4D1D-9D61-C009C9DA8684}']
  end;

  TServChecker = class(TInterfacedObject,IServChecker)
  private
    FCtrChkUpdMan :TContollerCheckUpdateManager;
  public
    constructor Create;
    procedure Start;
  end;

implementation



{ TServChecker }

constructor TServChecker.Create;
begin
  inherited Create;
  Start;
end;

procedure TServChecker.Start;
begin
  if not Assigned(FCtrChkUpdMan) then begin
    FCtrChkUpdMan := TContollerCheckUpdateManager.Create;
  end;
end;

end.
