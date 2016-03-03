unit FrHcSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, Provider, DB, DBClient, Grids, DBGrids, ImgList,
  Buttons, ExtCtrls, ShareInterface, ShareMethod;

type
  TfrmHcSearch = class(TForm)
    pnlButtons: TPanel;
    sbExcit: TSpeedButton;
    sbOK: TSpeedButton;
    lbFactDataType: TLabel;
    actList: TActionList;
    imgList: TImageList;
    grdHcDat: TDBGrid;
    cdsHcDat: TClientDataSet;
    srcHcDat: TDataSource;
    dspHcDat: TDataSetProvider;
    actSelect: TAction;
    actExit: TAction;
    tmrSearch: TTimer;
    grSearch: TGroupBox;
    radByFName: TRadioButton;
    radByHn: TRadioButton;
    radByWard: TRadioButton;
    edSearch: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edSearchKeyDown(
      Sender: TObject;
      var Key: Word;
      Shift: TShiftState);
    procedure tmrSearchTimer(Sender: TObject);
  private
    { Private declarations }
    FDM     :IFoodReqDataX;
    procedure DateGetText(
      Sender: TField; var Text: string; DisplayText: Boolean);
    function GetRadioSelectValue :Integer;
    function ReturnValue :String; overload;
  public
    { Public declarations }
    function Answer :String;
    function AnswerSet :TDataSet;
    procedure DataInterface(const IDat :IFoodReqDataX);
    procedure DoSearch;
    procedure SetActionEvents(evt :TNotifyEvent);
  end;

var
  frmHcSearch: TfrmHcSearch;

implementation

{$R *.dfm}

procedure TfrmHcSearch.FormCreate(Sender: TObject);
begin
  dspHcDat.Options := dspHcDat.Options +[poFetchDetailsOnDemand];
  cdsHcDat.FetchOnDemand := True;
  cdsHcDat.PacketRecords := 100;
end;

procedure TfrmHcSearch.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfrmHcSearch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmHcSearch.FormShow(Sender: TObject);
begin
//
end;

procedure TfrmHcSearch.edSearchKeyDown(
  Sender: TObject;
  var Key: Word;
  Shift: TShiftState);
begin
  tmrSearch.Enabled := True;
end;

procedure TfrmHcSearch.tmrSearchTimer(Sender: TObject);
begin
  DoSearch;
end;

function TfrmHcSearch.Answer: String;
begin
   if ShowModal=mrOK then begin
     Result := ReturnValue;
   end else Result := '';
end;

function TfrmHcSearch.AnswerSet: TDataSet;
begin
  if ShowModal=mrOK then begin
    Result := cdsHcDat;
  end else Result := nil;
end;

procedure TfrmHcSearch.DataInterface(const IDat: IFoodReqDataX);
begin
  FDM := iDat;
end;

procedure TfrmHcSearch.DoSearch;
var s :String; sel :Integer;
begin
  s   := edSearch.Text;
  sel := GetRadioSelectValue;
  dspHcDat.DataSet := FDM.HcDataSet(s,sel);
  //
  cdsHcDat.Close;
  cdsHcDat.SetProvider(dspHcDat);
  cdsHcDat.Open;
  cdsHcDat.FieldByName('ADMITDATE').OnGetText := DateGetText;
  //
  tmrSearch.Enabled := False;
end;

procedure TfrmHcSearch.SetActionEvents(evt: TNotifyEvent);
begin
  actSelect.OnExecute := evt;
  actExit.OnExecute := evt;
end;

{private}
procedure TfrmHcSearch.DateGetText(
  Sender: TField; var Text: string;  DisplayText: Boolean);
begin
  Text := YmdHmToDmyHm(Sender.AsString);
end;

function TfrmHcSearch.GetRadioSelectValue: Integer;
begin
  if radByFName.Checked then
    Result := 1
  else if radByHn.Checked then
    Result := 2
  else if radByWard.Checked then
    Result := 3
  else Result := 1;
end;

function TfrmHcSearch.ReturnValue: String;
var i :Integer; rVal :String;
begin
  for i := 0 to cdsHcDat.FieldCount - 1 do
    rVal := rVal+cdsHcDat.Fields[i].AsString+'|';
  Result := Copy(rVal,1,Length(rVal)-1);
end;

end.
