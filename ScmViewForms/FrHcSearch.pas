unit FrHcSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, Provider, DB, DBClient, Grids, DBGrids, ImgList,
  Buttons, ExtCtrls, ShareCommon, ShareInterface, ShareMethod;

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
    lbMarginLeft: TLabel;
    //
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edSearchKeyDown(
      Sender: TObject;
      var Key: Word;
      Shift: TShiftState);
    procedure tmrSearchTimer(Sender: TObject);
    procedure edSearchCloseUp(Sender: TObject);
  private
    { Private declarations }
    FDM     :IFoodReqDataX;
    FListAn :String;
    FListHn :String;
    procedure DateGetText(
      Sender: TField; var Text: string; DisplayText: Boolean);
    function GetRadioSelectValue :Integer;
    function ReturnValue :String; overload;
  public
    { Public declarations }
    function Answer :String;
    function AnswerSet :TDataSet;
    function WardList :TStrings;
    procedure DataInterface(const IDat :IFoodReqDataX);
    procedure DoSearch;
    procedure SetActionEvents(evt :TNotifyEvent);
    procedure SetFoodRequestedAnList(const s :String);
    procedure SetFoodRequetedHnList(const s :String);
    procedure SetShowWardList(const b :Boolean);
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
  //
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

procedure TfrmHcSearch.edSearchCloseUp(Sender: TObject);
begin
  tmrSearch.Enabled := True;
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

{public}
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

function TfrmHcSearch.WardList: TStrings;
begin
  Result := edSearch.Items;
end;

procedure TfrmHcSearch.DataInterface(const IDat: IFoodReqDataX);
begin
  FDM := iDat;
end;

procedure TfrmHcSearch.DoSearch;
var snd :TRecHcSearch;
  //
  function ExtractSearchText :String;
  var sExtr :TStrings;
  begin
    sExtr := TStringList.Create;
    try
      if snd.Selector=3 then begin
        //
        if edSearch.Text<>'' then begin
          //
          sExtr.Delimiter       := ':';
          sExtr.DelimitedText   := edSearch.Text;
          sExtr.StrictDelimiter := True;
          //
          if sExtr.Count=1 then
            Result := edSearch.Text
          else Result := Trim(sExtr[1]);
        end else Result := edSearch.Text;
      end else Result := edSearch.Text;
    finally
      sExtr.Free;
    end;
  end;

begin
  snd.Selector  := GetRadioSelectValue;
  snd.SearchTxt := ExtractSearchText;
  snd.ListHn    := FListHn;
  snd.ListAn    := FListAn;
  //
  dspHcDat.DataSet := FDM.HcDataSet(snd);
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
  actExit.OnExecute   := evt;
  //
  radByFName.OnClick  := evt;
  radByHn.OnClick     := evt;
  radByWard.OnClick   := evt;
end;

procedure TfrmHcSearch.SetFoodRequestedAnList(const s: String);
begin
  FListAn := s;
end;

procedure TfrmHcSearch.SetFoodRequetedHnList(const s: String);
begin
  FListHn := s;
end;

procedure TfrmHcSearch.SetShowWardList(const b: Boolean);
begin
  if not b then begin
    edSearch.Text := '';
  end;
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
