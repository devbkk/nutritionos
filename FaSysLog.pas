unit FaSysLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Provider, ImgList, ExtCtrls, ActnList, DB, DBClient, StdCtrls,
  Buttons, Grids, DBGrids,
  ShareInterface;

type
  IfraSysLog = Interface(IInterface)
   ['{A4BA7D95-BC9F-4FC7-8B79-4EF082BCBC61}']
    procedure Contact;
    procedure SysLogDataInterface(const ALog :ISysLog);
    function  SysLogDataManage :TClientDataSet;
  end;
  //
  TfraSysLog = class(TFrame, IfraSysLog)
    grSearch: TGroupBox;
    edSearch: TEdit;
    grdSysLog: TDBGrid;
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    lbFactDataType: TLabel;
    chkSeqAdd: TCheckBox;
    cdsSysLog: TClientDataSet;
    srcSysLog: TDataSource;
    acList: TActionList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    tmrSearch: TTimer;
    imgList: TImageList;
    dspSysLog: TDataSetProvider;
  private
    { Private declarations }
    FSysLog   :ISysLog;
  public
    { Public declarations }
    procedure Contact;
    constructor Create(AOwner :TComponent); override;
    procedure SysLogDataInterface(const ALog :ISysLog);
    function  SysLogDataManage :TClientDataSet;
  end;

implementation

{$R *.dfm}

{ TfraSysLog }

procedure TfraSysLog.Contact;
begin
  dspSysLog.DataSet := FSysLog.SysLogDataSet;
  cdsSysLog.Close;
  cdsSysLog.SetProvider(dspSysLog);
  cdsSysLog.Open;
end;

constructor TfraSysLog.Create(AOwner: TComponent);
begin
  inherited;
//
end;

procedure TfraSysLog.SysLogDataInterface(const ALog: ISysLog);
begin
  FSysLog := ALog;
end;

function TfraSysLog.SysLogDataManage: TClientDataSet;
begin
  Result := cdsSysLog;
end;

end.
