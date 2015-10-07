unit CtrSysLog;

interface

uses Classes, Controls, DB, DBClient, ActnList, StdCtrls, Forms,
     ShareInterface, FaSysLog, DmSysLog;

type
  TControllerSysLog = class
  private
    FFraSysLog :TfraSysLog;
    FSysLog    :ISysLog;
    function CreateModelSysLog :ISysLog;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
    function View :TFrame;  
  end;     

implementation

{ TControllerSysLog }

constructor TControllerSysLog.Create;
begin
  Start;
end;

destructor TControllerSysLog.Destroy;
begin
  FFraSysLog.Free;
  inherited;
end;

procedure TControllerSysLog.Start;
begin
  FFraSysLog := TfraSysLog.Create(nil);
  FFraSysLog.SysLogDataInterface(CreateModelSysLog);
  FFraSysLog.Contact;
end;

function TControllerSysLog.View: TFrame;
begin
  Result :=  FFraSysLog;
end;

{private}
function TControllerSysLog.CreateModelSysLog: ISysLog;
var p :TRecSysLogSearch;
begin
  FSysLog := TDmoSysLog.Create(nil);
  FSysLog.SearchKey := p;
  Result := FSysLog;
end;

end.
