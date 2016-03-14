unit FaFactGroup;

interface

uses
  StdCtrls, Controls, Classes, Buttons, Forms, DB, Provider, DBClient, ImgList,
  ActnList, Grids, DBGrids, ExtCtrls, ShareInterface, ShareMethod;

type
  TfraFactGroup = class(TFrame)
    grSearch: TGroupBox;
    edSearch: TEdit;
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbtAddWrite: TSpeedButton;
    lbPatient: TLabel;
    sbtNext: TSpeedButton;
    sbtPrev: TSpeedButton;
    chkPatSeqAdd: TCheckBox;
    grdFactGrps: TDBGrid;
    acList: TActionList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    actNext: TAction;
    actPrev: TAction;
    imgList: TImageList;
    cdsFactGrps: TClientDataSet;
    dspFactGrps: TDataSetProvider;
    srcFactGrps: TDataSource;
  private
    { Private declarations }
    FFactGrps  :IFoodGroupsDataX;
  public
    { Public declarations }
    constructor Create(AOwner :TComponent); override;
    procedure Contact;
    //
    procedure DataInterface(const AFact :IFoodGroupsDataX);
    //
    procedure SetActionEvents(evt :TNotifyEvent);
  end;

implementation

{$R *.dfm}

{ TfraFactGroup }

constructor TfraFactGroup.Create(AOwner: TComponent);
begin
  inherited;
//
end;

procedure TfraFactGroup.DataInterface(const AFact: IFoodGroupsDataX);
begin
  FFactGrps := AFact;
end;

procedure TfraFactGroup.Contact;
begin
  dspFactGrps.DataSet := FFactGrps.XDataSet;
  if dspFactGrps.DataSet=nil then
    Exit;
  //
  cdsFactGrps.Close;
  cdsFactGrps.SetProvider(dspFactGrps);
  cdsFactGrps.Open;
end;

procedure TfraFactGroup.SetActionEvents(evt: TNotifyEvent);
begin
  actAddWrite.OnExecute := evt;
  actDelCanc.OnExecute  := evt;
  actNext.OnExecute     := evt;
  actPrev.OnExecute     := evt;
end;

end.
