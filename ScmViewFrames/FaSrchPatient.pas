unit FaSrchPatient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, DB, DBClient, Provider;

type
  ISearchPatient = Interface
  ['{25C18CB7-3ADD-4085-A630-F59B12E228A3}']
    procedure DoSetDataSource(ds :TDataSet);
  End;

  IViewPatient = Interface
  ['{CEDB529D-7C07-4567-837F-B2FD1B58C598}']
    procedure PatientEnableControls;
    procedure PatientDisableControls;    
  End;

  TfraSrchPat = class(TFrame, ISearchPatient)
    grSearch: TGroupBox;
    lbMarginLeft: TLabel;
    radByFName: TRadioButton;
    radByHn: TRadioButton;
    radByWard: TRadioButton;
    edSearch: TComboBox;
    tmrSearch: TTimer;
    src: TDataSource;
    cdsWard: TClientDataSet;
    dspWard: TDataSetProvider;
    procedure edSearchCloseUp(Sender: TObject);
    procedure edSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmrSearchTimer(Sender: TObject);
  private
    { Private declarations }
    FTag  :Integer;
    FView :IViewPatient;
    procedure ClearWardList;
    procedure GenerateWardList;
    //
    //procedure OnFilterByHn(DataSet: TDataSet; var Accept: Boolean);
    //procedure OnFilterByName(DataSet: TDataSet; var Accept: Boolean);
    procedure OnFilterByWard(DataSet: TDataSet; var Accept: Boolean);
    //
    procedure InitFrame;
    //
    procedure OnRadioButtonClick(Sender :TObject);
  public
    { Public declarations }
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
    //
    function WardList :TStrings;
    procedure DoSetDataSource(ds :TDataSet);
  end;

implementation

{$R *.dfm}

{public}

constructor TfraSrchPat.Create(AOwner: TComponent);
begin
  inherited;
  InitFrame;
end;

destructor TfraSrchPat.Destroy;
begin

  inherited;
end;

procedure TfraSrchPat.edSearchCloseUp(Sender: TObject);
begin
  tmrSearch.Enabled := True;
end;

procedure TfraSrchPat.edSearchKeyDown(
  Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if FTag = 2 then begin
    Key := 0;
    edSearch.Text := '';
    Exit;
  end;
  //
  tmrSearch.Enabled := True;
end;

procedure TfraSrchPat.tmrSearchTimer(Sender: TObject);
var sHn :String; iSz :Integer;
begin
  //
  tmrSearch.Enabled := False;

  //
  if FTag = 2 then begin
    {if edSearch.Text='' then
      src.DataSet.Filtered := False
    else src.DataSet.Filtered := True;}
    src.DataSet.Filtered := False;
    if edSearch.Text<>'' then
      src.DataSet.Filtered := True;
  end else if FTag = 1 then begin
    iSz := src.DataSet.FieldByName('HN').Size;
    sHn := Format('%*s',[iSz,edSearch.Text]);
    src.DataSet.Filtered := False;
    src.DataSet.Locate('HN',sHn,[]);
  end else if FTag = 0 then begin
    src.DataSet.Filtered := False;
    src.DataSet.Locate('FNAME',edSearch.Text,[]);
  end;
end;

function TfraSrchPat.WardList: TStrings;
begin
  Result := edSearch.Items;
end;

procedure TfraSrchPat.DoSetDataSource(ds: TDataSet);
begin
  src.DataSet := ds;
end;

{private}
procedure TfraSrchPat.ClearWardList;
begin
  edSearch.Items.Clear;
end;

procedure TfraSrchPat.GenerateWardList;
var ward :String;
begin

  //
  if(src.DataSet=nil)or(src.DataSet.IsEmpty)then
    Exit;

  //
  FView.PatientDisableControls;
  try
    //
    if cdsWard.Active then
      cdsWard.Close;
    dspWard.DataSet := src.DataSet;
    cdsWard.Open;
    cdsWard.LogChanges := False;

    //
    cdsWard.First;
    repeat
      ward := cdsWard.FieldByName('WARDID').AsString+':'+
              cdsWard.FieldByName('WARDNAME').AsString;
      if edSearch.Items.IndexOf(ward)=-1 then
        edSearch.Items.Append(ward);
      cdsWard.Next;
    until cdsWard.Eof;
  finally
    FView.PatientEnableControls;
  end;

end;

procedure TfraSrchPat.InitFrame;
begin
  radByFName.OnClick := OnRadioButtonClick;
  radByHn.OnClick    := OnRadioButtonClick;
  radByWard.OnClick  := OnRadioButtonClick;
  //
  Supports(Self.Owner,IViewPatient,FView);
end;

{procedure TfraSrchPat.OnFilterByHn(DataSet: TDataSet; var Accept: Boolean);
const c_field_name = 'HN';
begin
  Accept := (Pos(edSearch.Text,DataSet.FieldByName(c_field_name).AsString)>1);
end;}

{procedure TfraSrchPat.OnFilterByName(DataSet: TDataSet; var Accept: Boolean);
const c_field_name = 'FNAME';
begin
  //Accept := (Pos(edSearch.Text,DataSet.FieldByName(c_field_name).AsString)>1);
  Accept := (edSearch.Text=DataSet.FieldByName(c_field_name).AsString);
end;}

procedure TfraSrchPat.OnFilterByWard(DataSet: TDataSet; var Accept: Boolean);
const c_field_name = 'WARDID';
var wardid :String;
begin
  wardid := Copy(edSearch.Text,1,Pos(':',edSearch.Text)-1);
  Accept := (DataSet.FieldByName(c_field_name).AsString=wardid);
end;

procedure TfraSrchPat.OnRadioButtonClick(Sender: TObject);
begin

  //
  if TRadioButton(Sender).Tag=2 then
    GenerateWardList
  else ClearWardList;

  //
  FTag := TRadioButton(Sender).Tag;
  with src.DataSet do begin
    case FTag of
     //0 : OnFilterRecord := OnFilterByName;
     //1 : OnFilterRecord := OnFilterByHn;
     2 : OnFilterRecord := OnFilterByWard;
    end;
  end;

  //
  edSearch.Text := '';

  //
  src.DataSet.Filtered := False;
  src.DataSet.First;
end;

end.
