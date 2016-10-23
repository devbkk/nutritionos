unit DmMeal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  ShareCommon, ShareInterface;

type
  TDmoMeal = class(TDmoBase, IMealDataX)
    schemaMeal: TXMLDocument;
    schemaMealItems: TXMLDocument;
    qryMeal: TSQLQuery;
    qryMealList: TSQLQuery;
    qryMealItems: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FSearchKey :TRecDataXSearch;
    function GetSearchKey: TRecDataXSearch;
    procedure SetSearchKey(const Value: TRecDataXSearch);
    { Private declarations }
  public
    { Public declarations }
    function MealList :TDataSet;
    function MealItemsList(const mlId:String) :TDataSet;
    procedure SaveMealItems(const mlId:String; items :TStrings);
    //
    function XDataSet :TDataSet; overload;
    function XDataSet(const p :TRecDataXSearch):TDataSet; overload;
    property SearchKey :TRecDataXSearch
      read GetSearchKey write SetSearchKey;
  end;

var
  DmoMeal: TDmoMeal;

implementation

const
QRY_SEL_MEAL='SELECT * FROM NUTR_MEAL '+
             'WHERE ISNULL(MLID,'''') LIKE :ID '+
             'AND ISNULL(MLNAME,'''') LIKE :NAME';
//
QRY_LST_MEAL='SELECT MNUID, MNUNAME, MNUID+'' ''+MNUNAME AS MNULIST '+
             'FROM NUTR_FMNU';

QRY_LST_MEAL_ITEMS='SELECT I.MNUID+'' ''+F.MNUNAME AS FMNULIST ' +
                   'FROM NUTR_MEAL_ITMS I '+
                   'JOIN NUTR_FMNU F ON F.MNUID = I.MNUID '+
                   'WHERE I.MLID LIKE %S';

QRY_DEL_MEAL_ITEMS='DELETE NUTR_MEAL_ITMS WHERE MNUID=%s';

QRY_INS_MEAL_ITEMS='INSERT INTO NUTR_MEAL_ITMS VALUES ';

{$R *.dfm}

procedure TDmoMeal.DataModuleCreate(Sender: TObject);
begin
  inherited;
//
end;

procedure TDmoMeal.DataModuleDestroy(Sender: TObject);
begin
  inherited;
//
end;

{public}
function TDmoMeal.MealItemsList(const mlId: String): TDataSet;
var sMealId :String;
begin
  if not MainDB.IsConnected then begin
    Result := qryMealItems;
    Exit;
  end;
  //
  qryMealItems.DisableControls;
  try
    if mlId<>'' then
      sMealId := QuotedStr(mlId)
    else sMealId := QuotedStr('');
    //
    qryMealItems.Close;
    qryMealItems.SQL.Text := Format(QRY_LST_MEAL_ITEMS,[sMealId]);
    qryMealItems.Open;
  finally
    qryMealItems.EnableControls;
  end;
  //
  Result := qryMealItems;
end;

function TDmoMeal.MealList: TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qryMealList;
    Exit;
  end;
  //
  qryMealList.DisableControls;
  try
    qryMealList.Close;
    qryMealList.SQL.Text := QRY_LST_MEAL;
    qryMealList.Open;
  finally
    qryMealList.EnableControls;
  end;
  //
  Result := qryMealList;
end;

procedure TDmoMeal.SaveMealItems(const mlId: String; items: TStrings);
var qStr :String; i:Integer;
begin
  if(mlID<>'')and(items.Count>0)then begin
    //
    qStr := Format(QRY_DEL_MEAL_ITEMS,[mlId]);
    MainDB.AddTransCmd(qStr);

    //
    qStr := QRY_INS_MEAL_ITEMS;
    for i := 0 to items.Count - 1 do begin
      qStr := qStr+'('+QuotedStr(mlID)+','+QuotedSTr(items[i])+'),';
    end;
    qStr := Copy(qStr,1,Length(qStr)-1);
    MainDB.AddTransCmd(qStr);

    MainDB.DoTransCmd;
  end;
end;

function TDmoMeal.XDataSet: TDataSet;
begin
  Result := XDataSet(FSearchKey);
end;

function TDmoMeal.XDataSet(const p: TRecDataXSearch): TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := nil;
    Exit;
  end;
  //
  qryMeal.DisableControls;
  try
    qryMeal.Close;
    //
    qryMeal.SQL.Text   := QRY_SEL_MEAL;
    //
    if p.ID='' then
      qryMeal.ParamByName('ID').AsString := '%'
    else qryMeal.ParamByName('ID').AsString := p.ID;

    if p.NAME='' then
      qryMeal.ParamByName('NAME').AsString  := '%'
    else qryMeal.ParamByName('NAME').AsString  := p.NAME;

    //
    qryMeal.Open;
  finally
    qryMeal.EnableControls;
  end;

  Result := qryMeal;
end;

{private}
function TDmoMeal.GetSearchKey: TRecDataXSearch;
begin
  Result := FSearchKey;
end;

procedure TDmoMeal.SetSearchKey(const Value: TRecDataXSearch);
begin
  FSearchKey := Value;
end;

end.
