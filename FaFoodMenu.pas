unit FaFoodMenu;

interface

uses
  Classes, ActnList, ImgList, Controls, StdCtrls, Mask, DBCtrls, Buttons,
  ExtCtrls, Forms, DB, DBClient,
  ShareInterface, Provider;

type
  TfraFoodMenu = class(TFrame, IFraDataX)
    grSearch: TGroupBox;
    edSearch: TEdit;
    pnlButtons: TPanel;
    sbDelCanc: TSpeedButton;
    sbAddWrite: TSpeedButton;
    lbFactDataType: TLabel;
    chkSeqAdd: TCheckBox;
    cboFactDataType: TComboBox;
    lstFood: TListBox;
    grSave: TGroupBox;
    lbID: TLabel;
    lbFName: TLabel;
    edID: TDBEdit;
    edFName: TDBEdit;
    Panel1: TPanel;
    ListBox2: TListBox;
    Button1: TButton;
    Button2: TButton;
    imgList: TImageList;
    acList: TActionList;
    actAddWrite: TAction;
    actDelCanc: TAction;
    actFactGroup: TAction;
    spbPrev: TSpeedButton;
    spbNext: TSpeedButton;
    dspFoodMenu: TDataSetProvider;
    cdsFoodMenu: TClientDataSet;
    srcFoodMenu: TDataSource;
  private
    { Private declarations }
    FDM :IDataSetX;    
  public
    { Public declarations }
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
    //
    procedure Contact;
    procedure DataInterface(const IDat :IDataSetX);    
    function  DataManage :TClientDataSet;
    //
    procedure FocusFirst;
    function IsSqeuenceAppend :Boolean;    
    procedure SetActionEvents(evt :TNotifyEvent);
    procedure SetFoodList(pList :TStrings);
  end;

implementation

{$R *.dfm}

{ TfraFoodMenu }

constructor TfraFoodMenu.Create(AOwner: TComponent);
begin
  inherited;
//
end;

destructor TfraFoodMenu.Destroy;
begin
//
  inherited;
end;

procedure TfraFoodMenu.FocusFirst;
begin
  if edID.CanFocus then
    edId.SetFocus;
end;

procedure TfraFoodMenu.Contact;
begin
  dspFoodMenu.DataSet := FDM.XDataSet;
  cdsFoodMenu.Close;
  cdsFoodMenu.SetProvider(dspFoodMenu);
  cdsFoodMenu.Open;
end;

procedure TfraFoodMenu.DataInterface(const IDat: IDataSetX);
begin
  FDM := IDat;
end;

function TfraFoodMenu.DataManage: TClientDataSet;
begin
  Result := cdsFoodMenu;
end;

function TfraFoodMenu.IsSqeuenceAppend: Boolean;
begin
  Result := chkSeqAdd.Checked;
end;

procedure TfraFoodMenu.SetActionEvents(evt: TNotifyEvent);
begin
  actAddWrite.OnExecute := evt;
  actDelCanc.OnExecute  := evt;
end;

procedure TfraFoodMenu.SetFoodList(pList: TStrings);
begin
  lstFood.Clear;
  lstFood.Items := pList;
end;

end.
