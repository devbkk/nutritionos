unit FrMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls,Forms, Dialogs, Menus, StdCtrls, Buttons, ExtCtrls,
  SvAuth, SvFactData;

type
  TFrmMain = class(TForm)
    pnlMenuButtons: TPanel;
    sbtLogin: TSpeedButton;
    sbtFileMan: TSpeedButton;
    pnlMain: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbtLoginClick(Sender: TObject);
    procedure sbtFileManClick(Sender: TObject);
  private
    { Private declarations }
    procedure AuthorizeMenu(const utype :String);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses FrFactData;

{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
//
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmMain.sbtFileManClick(Sender: TObject);
begin
  CtrInputFact.DoInputData(pnlMain);
end;

procedure TFrmMain.sbtLoginClick(Sender: TObject);
begin
  CtrAuthen.DoLogin;
  AuthorizeMenu(CtrAuthen.AutohirzeUserType);
end;

{private}
procedure TFrmMain.AuthorizeMenu(const utype: String);
begin
  {if uType='A' then
    sbtFileMan.Enabled := True;}
  sbtFileMan.Enabled := (uType<>'X');    
end;

end.
