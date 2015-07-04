unit FaFactData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DBCGrids, Buttons, DB, DBClient,
  ActnList, ImgList, ShareInterface, Provider;

type
  IfraFactData = Interface(IInterface)
  ['{76F6FDA7-55D4-4547-95EF-59741A194E32}']
    procedure Contact;
    procedure DoRequestFactInput(p :TFactDataType);
    //
    function GetFactDataType :TFactDataType;
    procedure SetFactDataType(SetValue :TFactDataType);
    property FactDataType :TFactDataType
      read GetFactDataType write SetFactDataType;
    //
    procedure FactDataInterface(const AFact :IFact);
    function  FactDataManage :TClientDataSet;
  end;

 //
  TfraFactData = class(TFrame, IfraFactData)
    grSearch: TGroupBox;
    edSearch: TEdit;
    grdFact: TDBGrid;
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    cdsFact: TClientDataSet;
    srcFact: TDataSource;
    lbFactDataType: TLabel;
    acList: TActionList;
    tmrSearch: TTimer;
    imgList: TImageList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    chkSeqAdd: TCheckBox;
    cboFactDataType: TComboBox;
    dspFact: TDataSetProvider;
  private
    { Private declarations }
    FFact         :IFact;
    FFactDataType :TFactDataType;
    function GetFactDataType :TFactDataType;
    procedure SetFactDataType(SetValue :TFactDataType);
    //
    procedure SetFactDataTypeDesc(p :TFactDataType);
  public
    { Public declarations }
    procedure Contact;
    //IfraFactData
    procedure DoRequestFactInput(p :TFactDataType);
    property FactDataType :TFactDataType
      read GetFactDataType write SetFactDataType;
    procedure FactDataInterface(const AFact :IFact);
    function  FactDataManage :TClientDataSet;
  end;

const
   c_title_init      = '������ :';
   c_title_user      = '�����ҹ';
   c_title_material  = '��ǹ��Сͺ�����';
implementation

{$R *.dfm}

{ TfraFactData }

procedure TfraFactData.Contact;
begin
  dspFact.DataSet := FFact.FactDataSet;
  cdsFact.Close;
  cdsFact.SetProvider(dspFact);
  cdsFact.Open;
end;

{public}
procedure TfraFactData.DoRequestFactInput(p: TFactDataType);
begin
  FFactDataType := p;
  SetFactDataTypeDesc(p);
  Self.Visible := True;
end;

{private}
function TfraFactData.GetFactDataType: TFactDataType;
begin
  Result := FFactDataType;
end;

procedure TfraFactData.SetFactDataType(SetValue: TFactDataType);
begin
  FFactDataType := SetValue;
end;

procedure TfraFactData.SetFactDataTypeDesc(p: TFactDataType);
var sDesc :String;
begin
   sDesc := c_title_init;
  case p of
    fdtMaterial : lbFactDataType.Caption := sDesc+c_title_material;
    fdtUser     : lbFactDataType.Caption := sDesc+c_title_user;
  end;
end;

procedure TfraFactData.FactDataInterface(const AFact: IFact);
begin
  FFact := AFact;
end;

function TfraFactData.FactDataManage: TClientDataSet;
begin
  Result := cdsFact;
end;

end.
