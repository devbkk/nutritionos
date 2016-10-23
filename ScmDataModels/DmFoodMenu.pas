unit DmFoodMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  ShareCommon, ShareInterface;

type
  TDmoFoodMenu = class(TDmoBase, IFoodDataX)
    qryFoodMenu: TSQLQuery;
    qryFoodList: TSQLQuery;
    qryFoodMenuItems: TSQLQuery;
    //
    schemaFoodMenu: TXMLDocument;
    schemaMenuItems: TXMLDocument;
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
    function FoodMenuItemsList(const mnuId:String) :TDataSet;
    procedure SaveMenuItems(const mnuId:String; items :TStrings);
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
             'AND ISNULL(MNUNAME,'''') LIKE :NAME';//+
             //'AND ISNULL(FDID,'''') LIKE :FID';

QRY_LST_FOOD='SELECT FDID, FDNAME, FDID+'' ''+FDNAME AS FDLIST '+
             'FROM NUTR_FOOD';

QRY_LST_FMNU_ITEMS='SELECT I.FDID+'' ''+F.FDNAME AS FDLIST ' +
                   'FROM NUTR_FMNU_ITMS I '+
                   'JOIN NUTR_FOOD F ON F.FDID = I.FDID '+
                   'WHERE I.MNUID LIKE %S';

QRY_DEL_FMNU_ITEMS='DELETE NUTR_FMNU_ITMS WHERE MNUID=%s';

QRY_INS_FMNU_ITEMS='INSERT INTO NUTR_FMNU_ITMS VALUES ';

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
  //
  Result := qryFoodList;
end;

function TDmoFoodMenu.FoodMenuItemsList(const mnuId:String): TDataSet;
var sMenuId :String;
begin
  if not MainDB.IsConnected then begin
    Result := qryFoodMenuItems;
    Exit;
  end;
  //
  qryFoodMenuItems.DisableControls;
  try
    if mnuId<>'' then
      sMenuID := QuotedStr(mnuId)
    else sMenuID := QuotedStr('');
    //
    qryFoodMenuItems.Close;
    qryFoodMenuItems.SQL.Text := Format(QRY_LST_FMNU_ITEMS,[sMenuId]);
    qryFoodMenuItems.Open;
  finally
    qryFoodMenuItems.EnableControls;
  end;
  //
  Result := qryFoodMenuItems;
end;

procedure TDmoFoodMenu.SaveMenuItems(const mnuId:String; items: TStrings);
var qStr :String; i:Integer;
begin

  if(mnuID<>'')and(items.Count>0)then begin
    //
    qStr := Format(QRY_DEL_FMNU_ITEMS,[mnuId]);
    MainDB.AddTransCmd(qStr);

    //
    qStr := QRY_INS_FMNU_ITEMS;
    for i := 0 to items.Count - 1 do begin
      qStr := qStr+'('+QuotedStr(mnuID)+','+QuotedSTr(items[i])+'),';
    end;
    qStr := Copy(qStr,1,Length(qStr)-1);
    MainDB.AddTransCmd(qStr);

    MainDB.DoTransCmd;
  end;
end;

function TDmoFoodMenu.XDataSet(const p: TRecDataXSearch): TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := nil;
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

    {if p.TYP='' then
      qryFoodMenu.ParamByName('FID').AsString  := '%'
    else qryFoodMenu.ParamByName('FID').AsString  := p.TYP;}
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
