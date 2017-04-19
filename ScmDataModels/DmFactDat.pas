unit DmFactDat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc, StrUtils,
  DmBase, DmCnMain, ShareCommon, ShareMethod, ShareInterface;

type
  TDmoFactdat = class(TDmoBase, IFact)
    schemaFact: TXMLDocument;
    qryFact: TSQLQuery;
    qryFtyp: TSQLQuery;
    qryPatType: TSQLQuery;
    qryLupFacts: TSQLQuery;
    qryDelFactGrps: TSQLQuery;
    qryPrnCond: TSQLQuery;
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
    function LookupFacts(code :String) :TDataSet;
    function LookupPatientType :TDataSet;
    function LookUpPrintCond :TDataSet;
    //
    procedure AppendFactGroupParent(rec :TRecFactGroup);
    procedure DelFactGroup(code :String);
    procedure UpdateFactGroup(p :TRecFactTreeInput);
    //
    procedure UpdateFoodReqdDesc(code, desc :String);
  end;

var
  DmoFactdat: TDmoFactdat;

implementation

const
QRY_DEL_FAGR =
'DELETE FROM NUTR_FACT_GRPS WHERE FGRC =%S';

QRY_SEL_FACT =
'SELECT * FROM NUTR_FACT '+
'WHERE ISNULL(CODE,'''') LIKE %S '+
'AND ISNULL(FDES,'''') LIKE %S '+
'AND ISNULL(FGRC,'''') LIKE %S '+
'ORDER BY CODE';

QRY_SEL_FTYP =
'SELECT * FROM NUTR_FACT_GRPS';

QRY_MAX_CODE =
'SELECT MAX(CODE) FROM NUTR_FACT WHERE FGRC = %S';

QRY_SEL_NOTE =
'SELECT NOTE FROM NUTR_FACT WHERE CODE =:CODE';

QRY_LUP_PATT =
'SELECT CODE, FDES FROM NUTR_FACT WHERE FGRC = ''0001''';

QRY_SEL_PRNCOND=
'SELECT * FROM VW_PRINTCOND';

QRY_LUP_FACS =
'SELECT G.FGRC AS CODE , G.FGRP AS FDES, G.FPRP '+
'FROM NUTR_FACT_GRPS G '+
'LEFT JOIN NUTR_FACT F ON F.FGRC = G.FGRC '+
'WHERE G.PCOD = %S '+
'UNION '+
'SELECT CODE, FDES, '''' AS FPRP '+
'FROM NUTR_FACT '+
'WHERE FGRC = %S '+
'ORDER BY FPRP';

QRY_INS_FTYP_PARENT=
'INSERT INTO NUTR_FACT_GRPS '+
'VALUES (%S, %S, %S, %S, %S, NULL, %S)';

QRY_UPD_FTYP =
'UPDATE NUTR_FACT_GRPS '+
'SET FGRP = %S,'+
'NOTE = %S,'+
'SLIPPRN =%S,'+
'FPRP = %S '+
'WHERE FGRC = %S';

QRY_UPD_REQD=
'UPDATE NUTR_FOOD_REQD '+
'SET REQDESC = %S '+
'WHERE REQCODE = %S';

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

procedure TDmoFactdat.AppendFactGroupParent(rec: TRecFactGroup);
var sQry :String;
begin
  if not MainDB.IsConnected then begin
    Exit;
  end;
  //
  sQry := Format(QRY_INS_FTYP_PARENT,[QuotedStr(rec.FGRC),
                                      Quotedstr(rec.FGRP),
                                      IntToStr(rec.FLEV),
                                      QuotedStr(rec.NOTE),
                                      QuotedStr(rec.FPRP),
                                      QuotedStr(rec.SLIPPRN)]);
  MainDB.ExecCmd(sQry);
end;

procedure TDmoFactdat.DelFactGroup(code: String);
var sQry :String;
begin
  if not MainDB.IsConnected then begin
    Exit;
  end;
  //
  sQry := Format(QRY_DEL_FAGR,[QuotedStr(code)]);
  MainDB.ExecCmd(sQry);
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

function TDmoFactdat.LookUpPrintCond: TDataSet;
var   sQry :String;
begin
  if not MainDB.IsConnected then begin
    Result := qryPrnCond;
    Exit;
  end;
  //
  qryPrnCond.DisableControls;
  try
    qryPrnCond.Close;
    //
    sQry := QRY_SEL_PRNCOND;
    //
    qryPrnCond.SQL.Text   := sQry;
    //
    qryPrnCond.Open;
  finally
    qryPrnCond.EnableControls;
  end;

  Result := qryPrnCond;
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

procedure TDmoFactdat.UpdateFactGroup(p :TRecFactTreeInput);
var sQry :String;
begin
  if not MainDB.IsConnected then
    Exit;

  //
  sQry := Format(QRY_UPD_FTYP,[QuotedStr(p.Desc),
                               QuotedStr(p.Note),
                               QuotedStr(ifthen(p.IsSlipPrn,'Y','N')),
                               QuotedSTr(p.Prop),
                               QuotedStr(p.Code)]);
  MainDB.ExecCmd(sQry);
end;

procedure TDmoFactdat.UpdateFoodReqdDesc(code, desc: String);
var sQry :String;
begin
  if not MainDB.IsConnected then
    Exit;

  //
  sQry := Format(QRY_UPD_REQD, [QuotedStr(desc),
                                QuotedStr(code)]);
  MainDB.ExecCmd(sQry);
end;

end.
