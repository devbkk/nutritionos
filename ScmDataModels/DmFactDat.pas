unit DmFactDat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc, StrUtils,
  DmBase, DmCnMain, ShareMethod, ShareInterface;

type
  TDmoFactdat = class(TDmoBase, IFact)
    schemaFact: TXMLDocument;
    qryFact: TSQLQuery;
    qryFtyp: TSQLQuery;
    qryPatType: TSQLQuery;
    qryLupFacts: TSQLQuery;
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
    function FactNextCode(p :TRecGenCode) :String;
    function FactTypeDataSet :TDataSet;
    //
    function GetCaptionTemplate(code :String):String;
    //
    function LookupPatientType :TDataSet;
    function LookupFacts(code :String) :TDataSet;
  end;

var
  DmoFactdat: TDmoFactdat;

implementation

const
QRY_SEL_FACT = 'SELECT * FROM NUTR_FACT '+
               'WHERE ISNULL(CODE,'''') LIKE %S '+
               'AND ISNULL(FDES,'''') LIKE %S '+
               'AND ISNULL(FGRC,'''') LIKE %S '+
               'ORDER BY CODE';

//QRY_SEL_FTYP = 'SELECT FTYP FROM NUTR_FACT GROUP BY FTYP';

//QRY_SEL_FTYP = 'SELECT FGRC, FGRP, NOTE FROM NUTR_FACT_GRPS';

QRY_SEL_FTYP = 'SELECT * FROM NUTR_FACT_GRPS';

{QRY_MAX_CODE = 'SELECT MAX(CODE) FROM NUTR_FACT '+
               'WHERE FGRC = %S AND FTYC = %S'; }

QRY_MAX_CODE = 'SELECT MAX(CODE) FROM NUTR_FACT WHERE FGRC = %S';

QRY_SEL_NOTE = 'SELECT NOTE FROM NUTR_FACT WHERE CODE =:CODE';

QRY_LUP_PATT = 'SELECT CODE, FDES FROM NUTR_FACT WHERE FGRC = ''0001''';

QRY_LUP_FACS = 'SELECT G.FGRC AS CODE , G.NOTE AS FDES, G.FPRP '+
               'FROM NUTR_FACT_GRPS G '+
               'LEFT JOIN NUTR_FACT F ON F.FGRC = G.FGRC '+
               'WHERE G.PCOD = %S '+
               'UNION '+
               'SELECT CODE, FDES, '''' AS FPRP '+
               'FROM NUTR_FACT '+
               'WHERE FGRC = %S';

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
var sQry, sCode, sDesc, sType :String;
begin
  if not MainDB.IsConnected then begin
    Result := nil;
    Exit;
  end;
  //
  qryFact.DisableControls;
  try
    qryFact.Close;
    //
    if p.code='' then
      sCode := '%'
    else sCode := p.code;

    if p.fdes='' then
      sDesc  := '%'
    else sDesc  := p.fdes;

    if p.ftyp='' then
      sType := '%'
    else sType  := p.ftyp;
    //
    sQry := Format(QRY_SEL_FACT,[QuotedStr(sCode),
                                 QuotedStr(sDesc),
                                 QuotedStr(sType)]);
    qryFact.SQL.Text := sQry;
    //
    qryFact.Open;
  finally
    qryFact.EnableControls;
  end;

  Result := qryFact;
end;

function TDmoFactdat.FactNextCode(p: TRecGenCode): String;
var sQry, sRes :String; iSize :Integer;
begin
  //
  sQry := Format(QRY_MAX_CODE,[QuotedStr(p.FGrc)]);
  sRes := GetMaxDataStr(sQry,iSize);
  if sRes='' then
    sRes := DupeString('0',iSize-Length(p.FGrc));
  sRes := RightStr(DupeString('0',iSize)+p.FGrc+sRes,iSize);
  sRes := NextIpacc(sRes);
  Result := sRes;
end;

function TDmoFactdat.FactTypeDataSet: TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := nil;
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

function TDmoFactdat.GetCaptionTemplate(code: String): String;
var qry :TSQLQuery;
begin
  qry := TSQLQuery.Create(nil);
  try
    qry.SQLConnection := MainDB.Connection;
    qry.SQL.Text := QRY_SEL_NOTE;
    qry.ParamByName('CODE').AsString := code;
    qry.Open;
    Result := qry.Fields[0].AsString;
  finally
    qry.Free;
  end;
end;

function TDmoFactdat.GetData: TRecFactData;
begin
  Result := FFactDat;
end;

function TDmoFactdat.GetSearchKey: TRecFactSearch;
begin
  Result := FSearch;
end;

function TDmoFactdat.LookupFacts(code: String): TDataSet;
var sQry :String;
begin
  if not MainDB.IsConnected then begin
    Result := nil;
    Exit;
  end;

  qryLupFacts.DisableControls;
  try
    sQry := Format(QRY_LUP_FACS,[code,code]);
    //
    qryLupFacts.Close;
    qryLupFacts.SQL.Text := sQry;
    qryLupFacts.Open;
  finally
    qryLupFacts.EnableControls;
  end;

  Result := qryLupFacts;
end;

function TDmoFactdat.LookupPatientType: TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := nil;
    Exit;
  end;

  qryPatType.DisableControls;
  try
    qryPatType.Close;
    qryPatType.SQL.Text := QRY_LUP_PATT;
    qryPatType.Open;
  finally
    qryPatType.EnableControls;
  end;

  Result := qryPatType;
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
