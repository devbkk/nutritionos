unit DmFactGroups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  //
  ShareCommon, ShareMethod, ShareInterface;

type
  TDmoFactGroups = class(TDmoBase, IFoodGroupsDataX)
    schmeFactGroups: TXMLDocument;
    qryFactGroups: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FSearch  :TRecDataXSearch;
    function GetSearchKey :TRecDataXSearch;
    procedure SetSearchKey(const Value :TRecDataXSearch);
  public
    { Public declarations }
    property SearchKey :TRecDataXSearch
      read GetSearchKey write SetSearchKey;
    //
    function XDataSet :TDataSet; overload;
    function XDataSet(const p :TRecDataXSearch):TDataSet; overload;
  end;

var
  DmoFactGroups: TDmoFactGroups;

implementation

const QRY_SEL_FGRP = 'SELECT * FROM NUTR_FACT_GRPS';


{$R *.dfm}

procedure TDmoFactGroups.DataModuleCreate(Sender: TObject);
begin
  inherited;
//
end;

procedure TDmoFactGroups.DataModuleDestroy(Sender: TObject);
begin
  inherited;
//
end;

{public}
function TDmoFactGroups.XDataSet: TDataSet;
begin
  Result := XDataSet(FSearch);
end;

function TDmoFactGroups.XDataSet(const p: TRecDataXSearch): TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := nil;
    Exit;
  end;
  //
  qryFactGroups.DisableControls;
  try
    qryFactGroups.Close;
    //
    qryFactGroups.SQL.Text   := QRY_SEL_FGRP;
    //
    {if p.code='' then
      qryFactGroups.ParamByName('CODE').AsString := '%'
    else qryFactGroups.ParamByName('CODE').AsString := p.code;}
    //
    qryFactGroups.Open;
  finally
    qryFactGroups.EnableControls;
  end;

  Result := qryFactGroups;
end;

{private}
function TDmoFactGroups.GetSearchKey: TRecDataXSearch;
begin
  Result := FSearch;
end;

procedure TDmoFactGroups.SetSearchKey(const Value: TRecDataXSearch);
begin
  FSearch := Value;
end;

end.
