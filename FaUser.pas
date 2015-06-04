unit FaUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DBCGrids, Buttons, DB, DBClient,
  ActnList, ImgList, ShareInterface;

type

 //
  TfraUser = class(TFrame, IfraFactData)
    grSearch: TGroupBox;
    edSearch: TEdit;
    grdFact: TDBGrid;
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    cdsUser: TClientDataSet;
    srcUser: TDataSource;
    lbFactDataType: TLabel;
    acList: TActionList;
    tmrSearch: TTimer;
    imgList: TImageList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    chkEdit: TCheckBox;
  private
    { Private declarations }
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
  end;

const
   c_title_init      = 'ข้อมูล :';
   c_title_user      = 'ผู้ใช้งาน';
   c_title_material  = 'ส่วนประกอบอาหาร';
implementation

{$R *.dfm}

{ TfraFactData }

procedure TfraUser.Contact;
begin
//
end;

{public}
procedure TfraUser.DoRequestFactInput(p: TFactDataType);
begin
  FFactDataType := p;
  SetFactDataTypeDesc(p);
  Self.Visible := True;
end;

{private}
function TfraUser.GetFactDataType: TFactDataType;
begin
  Result := FFactDataType;
end;

procedure TfraUser.SetFactDataType(SetValue: TFactDataType);
begin
  FFactDataType := SetValue;
end;

procedure TfraUser.SetFactDataTypeDesc(p: TFactDataType);
var sDesc :String;
begin
   sDesc := c_title_init;
  case p of
    fdtMaterial : lbFactDataType.Caption := sDesc+c_title_material;
    fdtUser     : lbFactDataType.Caption := sDesc+c_title_user;
  end;
end;

end.
