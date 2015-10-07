unit FrDbConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FaDbConfig, SvFactData, ShareInterface, ShareMethod;

type
  IViewDbConfig = Interface
   ['{E5BA4FE8-B1FB-465F-B67C-3AFDF5E7E8A8}']
   procedure Contact;
  end;

  TfrmDbConfig = class(TForm, IViewDbConfig)
    fraDbCfg: TfraDBConfig;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure OnDbConnectParamsSave(Sender :TObject);
  public
    { Public declarations }
    procedure Contact;
  end;

var
  frmDbConfig: TfrmDbConfig;

implementation

{$R *.dfm}

procedure TfrmDbConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmDbConfig.FormCreate(Sender: TObject);
begin
 // FInputter := TCtrlInputData.Create;
end;

procedure TfrmDbConfig.FormDestroy(Sender: TObject);
begin
  if frmDbConfig=Self then
    frmDbConfig := nil;
end;

procedure TfrmDbConfig.FormShow(Sender: TObject);
begin
  fraDbCfg.Params := ShareMethod.ReadConfig;
  fraDbCfg.OnSave := OnDbConnectParamsSave;
end;

procedure TfrmDbConfig.Contact;
begin
  ShowModal;
end;

procedure TfrmDbConfig.OnDbConnectParamsSave(Sender: TObject);
begin
  ShareMethod.WriteConfig(TConnectParam(Sender).Params);
  ModalResult := mrOk;
end;

end.
