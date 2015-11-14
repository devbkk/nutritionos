unit DmFoodMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  ShareInterface;

type
  TDmoFoodMenu = class(TDmoBase, IFoodDataX)
    qryFoodMenu: TSQLQuery;
    qryFoodList: TSQLQuery;
    schemaFoodMenu: TXMLDocument;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FSearchKey :TRecDataXSearch;
    function GetSearchKey :TRecDataXSearch;
    procedure SetSearchKey(const Value :TRecDataXSearch);
  protected
    { Protected declarations }
    function Schema :TXMLDocument; override;
  public
    { Public declarations }
    function FoodList :TDataSet;
    //
    function XDataSet :TDataSet; overload;
    function XDataSet(const p :TRecDataXSearch):TDataSet; overload;
    property SearchKey :TRecDataXSearch
      read GetSearchKey write SetSearchKey;
  end;

var
  DmoFoodMenu: TDmoFoodMenu;

implementation

const
QRY_SEL_FMNU='SELECT * FROM NUTR_FMNU '+
             'WHERE ISNULL(MNUID,'''') LIKE :ID '+
             'AND ISNULL(MNUNAME,'''') LIKE :NAME '+
             'AND ISNULL(FDID,'''') LIKE :FID';

QRY_LST_FOOD='SELECT FDID, FDNAME, FDID+'' ''+FDNAME AS FDLIST '+
             'FROM NUTR_FOOD';

{$R *.dfm}

procedure TDmoFoodMenu.DataModuleCreate(Sender: TObject);
begin
  inherited;
//
end;

procedure TDmoFoodMenu.DataModuleDestroy(Sender: TObject);
begin
  inherited;
//
end;

function TDmoFoodMenu.FoodList: TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qryFoodList;
    Exit;
  end;
  //
  qryFoodList.DisableControls;
  try
    qryFoodList.Close;
    qryFoodList.SQL.Text := QRY_LST_FOOD;
    qryFoodList.Open;
  finally
    qryFoodList.EnableControls;
  end;

  Result := qryFoodList;
end;

function TDmoFoodMenu.XDataSet(const p: TRecDataXSearch): TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qryFoodMenu;
    Exit;
  end;
  //
  qryFoodMenu.DisableControls;
  try
    qryFoodMenu.Close;
    //
    qryFoodMenu.SQL.Text   := QRY_SEL_FMNU;
    //
    if p.ID='' then
      qryFoodMenu.ParamByName('ID').AsString := '%'
    else qryFoodMenu.ParamByName('ID').AsString := p.ID;

    if p.NAME='' then
      qryFoodMenu.ParamByName('NAME').AsString  := '%'
    else qryFoodMenu.ParamByName('NAME').AsString  := p.NAME;

    if p.TYP='' then
      qryFoodMenu.ParamByName('FID').AsString  := '%'
    else qryFoodMenu.ParamByName('FID').AsString  := p.TYP;
    //
    qryFoodMenu.Open;
  finally
    qryFoodMenu.EnableControls;
  end;

  Result := qryFoodMenu;
end;

function TDmoFoodMenu.XDataSet: TDataSet;
begin
  Result := XDataSet(FSearchKey);
end;

{protected}
function TDmoFoodMenu.Schema: TXMLDocument;
begin
  Result := schemaFoodMenu;
end;

{private}

function TDmoFoodMenu.GetSearchKey: TRecDataXSearch;
begin
  Result := FSearchKey;
end;

procedure TDmoFoodMenu.SetSearchKey(const Value: TRecDataXSearch);
begin
  FSearchKey := Value;
end;

end.
