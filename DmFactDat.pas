unit DmFactDat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  DmBase, DmCnMain, ShareMethod, ShareInterface;

type
  TDmoFactdat = class(TDmoBase, IFact)
    schemaFact: TXMLDocument;
    qryFact: TSQLQuery;
    qryFtyp: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FFactDat :TRecFactData;
    FSearch  :TRecFactSearch;
    //
    function GetData :TRecFactData;
    procedure SetData(const Value :TRecFactData);
    //
    function GetSearchKey :TRecFactSearch;
    procedure SetSearchKey(const Value :TRecFactSearch);
  protected
    { Protected declarations }
    function Schema :TXMLDocument; override;
  public
    { Public declarations }
    property Data :TRecFactData read GetData write SetData;
    property SearchKey :TRecFactSearch
      read GetSearchKey write SetSearchKey;

    //
    function FactDataSet :TDataSet; overload;
    function FactDataSet(p :TRecFactSearch) :TDataSet; overload;
    function FactTypeDataSet :TDataSet;
  end;

var
  DmoFactdat: TDmoFactdat;

implementation

const
QRY_SEL_FACT = 'SELECT * FROM NUTR_FACT '+
               'WHERE ISNULL(CODE,'''') LIKE :CODE '+
               'AND ISNULL(FDES,'''') LIKE :FDES '+
               'AND ISNULL(FTYP,'''') LIKE :FTYP';

QRY_SEL_FTYP = 'SELECT FTYP FROM NUTR_FACT GROUP BY FTYP';

{$R *.dfm}

procedure TDmoFactdat.DataModuleCreate(Sender: TObject);
begin
  inherited;
//
end;

procedure TDmoFactdat.DataModuleDestroy(Sender: TObject);
begin
  inherited;
//
end;

function TDmoFactdat.FactDataSet(p: TRecFactSearch): TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qryFact;
    Exit;
  end;
  //
  qryFact.DisableControls;
  try
    qryFact.Close;
    //
    qryFact.SQL.Text   := QRY_SEL_FACT;
    //
    if p.code='' then
      qryFact.ParamByName('CODE').AsString := '%'
    else qryFact.ParamByName('CODE').AsString := p.code;

    if p.fdes='' then
      qryFact.ParamByName('FDES').AsString  := '%'
    else qryFact.ParamByName('FDES').AsString  := p.fdes;

    {if p.ftyp='' then
      qryFact.ParamByName('FTYP').AsString  := '%'
    else qryFact.ParamByName('FTYP').AsString  := p.ftyp;}
    qryFact.ParamByName('FTYP').AsString  := p.ftyp;
    //
    qryFact.Open;
  finally
    qryFact.EnableControls;
  end;

  Result := qryFact;
end;

function TDmoFactdat.FactTypeDataSet: TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qryFact;
    Exit;
  end;
  //
  qryFtyp.DisableControls;
  try
    qryFtyp.Close;
    qryFtyp.SQL.Text := QRY_SEL_FTYP;
    qryFtyp.Open;
  finally
    qryFtyp.EnableControls;
  end;

  Result := qryFtyp;
end;

function TDmoFactdat.FactDataSet: TDataSet;
begin
  Result := FactDataSet(FSearch);
end;

function TDmoFactdat.GetData: TRecFactData;
begin
  Result := FFactDat;
end;

function TDmoFactdat.GetSearchKey: TRecFactSearch;
begin
  Result := FSearch;
end;

function TDmoFactdat.Schema: TXMLDocument;
begin
  Result := schemaFact;
end;

procedure TDmoFactdat.SetData(const Value: TRecFactData);
begin
  FFactDat := Value;
end;

procedure TDmoFactdat.SetSearchKey(const Value: TRecFactSearch);
begin
  FSearch := Value;
end;

end.
