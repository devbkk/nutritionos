unit CtrDbCfg;

interface

uses Classes, Controls, DB, DBClient, ActnList, StdCtrls, Forms,
     ShareInterface, ShareMethod, FaDbConfig;

type
  TControllerDbConfig = class
  private
    FFraDbCfg  :TfraDBConfig;
    procedure OnDbConnectParamsSave(Sender :TObject);    
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
    function View :TFrame;
  end;

implementation

{ TControllerDbConfig }

constructor TControllerDbConfig.Create;
begin
  Start;
end;

destructor TControllerDbConfig.Destroy;
begin

  inherited;
end;

procedure TControllerDbConfig.OnDbConnectParamsSave(Sender: TObject);
begin
  WriteConfig(TConnectParam(Sender).Params);
end;

procedure TControllerDbConfig.Start;
begin
  FFraDbCfg := TfraDBConfig.Create(nil);
  FFraDbCfg.Params := ReadConfig;
  FFraDbCfg.OnSave := OnDbConnectParamsSave;
end;

function TControllerDbConfig.View: TFrame;
begin
  Result := FFraDbCfg;
end;

end.
