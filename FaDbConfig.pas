 unit FaDbConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls, DBCtrls, Mask, ImgList, ActnList,
  frxpngimage, ShareInterface;

type
  TfraDBConfig = class(TFrame)
    grSave: TGroupBox;
    lbServer: TLabel;
    lbDatabase: TLabel;
    lbLogin: TLabel;
    lbPassword: TLabel;
    edServer: TEdit;
    edDatabase: TEdit;
    edUser: TEdit;
    edPassword: TEdit;
    grCmd: TPanel;
    sbAddWrite: TSpeedButton;
    lbFactDataType: TLabel;
    acList: TActionList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    actPrev: TAction;
    actNext: TAction;
    imgList: TImageList;
    procedure actAddWriteExecute(Sender: TObject);
  private
    { Private declarations }
    FOnSave: TNotifyEvent;
    FParams: TRecConnectParams;
    function GetParams :TRecConnectParams;
    procedure SetParams(const Value: TRecConnectParams);
  public
    { Public declarations }
    constructor Create(AOwner :TComponent); override;
    property Params :TRecConnectParams read GetParams write SetParams;
    property OnSave :TNotifyEvent read FOnSave write FOnSave;
  end;

implementation

{$R *.dfm}

{ TfraDBConfig }
constructor TfraDBConfig.Create(AOwner: TComponent);
begin
  inherited;
//
end;

procedure TfraDBConfig.actAddWriteExecute(Sender: TObject);
begin
  if Assigned(FOnSave) then
    FOnSave(TConnectParam.Create(GetParams));
end;

function TfraDBConfig.GetParams: TRecConnectParams;
begin
  FParams.Server   := edServer.Text;
  FParams.Database := edDatabase.Text;
  FParams.User     := edUser.Text;
  FParams.Password := edPassword.Text;
  //
  Result := FParams;
end;

procedure TfraDBConfig.SetParams(const Value: TRecConnectParams);
begin
  FParams := Value;
  //
  edServer.Text   := FParams.Server;
  edDatabase.Text := FParams.Database;
  edUser.Text     := FParams.User;
  edPassword.Text := FParams.Password;
end;

end.
