unit DmFoodReq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  DmCnMain, DmCnHomc, ShareInterface, ShareMethod, ShareIntfModel;

type
  TDmoFoodReq = class(TDmoBase, IFoodReqDataX)
    schemaFoodReq: TXMLDocument;
    qryFoodReq: TSQLQuery;
    schemaPatient: TXMLDocument;
    schemaAdmit: TXMLDocument;
    qryHcDatByParam: TSQLQuery;
    qryAdmit: TSQLQuery;
    qryGetHcDat: TSQLQuery;
    qryFoodTypeList: TSQLQuery;
    qryDiagList: TSQLQuery;
    qryPatAdm: TSQLQuery;
    qryChkPat: TSQLQuery;
    qryChkAdmit: TSQLQuery;
    schemaPatAdm: TXMLDocument;
    qryHcDatByFormat: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FHomcDB :IDbConnect;
    FSearchKey :TRecDataXSearch;
    procedure DateGetText(
      Sender: TField; var Text: string; DisplayText: Boolean);
    function GetSearchKey :TRecDataXSearch;
    procedure SetSearchKey(const Value :TRecDataXSearch);
  protected
    { Protected declarations }
    function Schema :TXMLDocument; override;
  public
    { Public declarations }
    function DiagList :TdataSet;
    function FoodTypeList(const grp,typ :String):TDataSet;
    function FoodReqSet(const s :String):TDataSet;
    function HcDataSet(const s :String;opt:Integer=1):TDataSet;
    function IsPatExist(const hn :String):Boolean;
    function IsAdmExist(const an, ward, room, bed :String):Boolean;
    function MaxReqID :String;
    function PatientAdmitDataSet(const an :String):TDataSet;
    //procedure SavePatientAdmit(p :TRecHcDat);
    //
    function XDataSet :TDataSet; overload;
    function XDataSet(const p :TRecDataXSearch):TDataSet; overload;
    property SearchKey :TRecDataXSearch
      read GetSearchKey write SetSearchKey;
  end;

var
  DmoFoodReq: TDmoFoodReq;

implementation

const

QRY_LST_DIAG='SELECT FDES FROM NUTR_FACT WHERE FGRP = ''diag''';

QRY_LST_FDTY='SELECT FDES FROM NUTR_FACT WHERE FGRP = ''fdtype''';

QRY_LST_FTYG='SELECT CODE,FDES FROM NUTR_FACT '+
             'WHERE FGRC= %S AND FTYC LIKE %S';

QRY_SEL_FREQ='SELECT * FROM NUTR_FOOD_REQS '+
             'WHERE ISNULL(AN,'''') LIKE :AN ';

QRY_MAX_REQID='SELECT MAX(REQID) FROM NUTR_FOOD_REQS';

QRY_INS_PATN='INSERT INTO NUTR_PATN VALUES ';

QRY_INS_ADMT='INSERT INTO NUTR_PATN_ADMT VALUES ';

QRY_SEL_PTAM='SELECT P.HN, A.AN, P.PID,'+
                    'P.TNAME, P.FNAME, P.LNAME,'+
                    'P.TNAME+P.FNAME+'' ''+P.LNAME AS PATNAME,'+
    	              'P.GENDER, P.BIRTH, A.WARDID, A.WARDNAME,'+
                    'A.ADMITDATE, A.DISCHDATE, A.ROOMNO,'+
                    'A.BEDNO '+
             'FROM NUTR_PATN P '+
             'LEFT JOIN NUTR_PATN_ADMT A ON A.HN = P.HN '+
             'WHERE A.AN LIKE %S';

QRY_SEL_PATN='SELECT * FROM NUTR_PATN WHERE HN =%S';

QRY_SEL_ADMT='SELECT * FROM NUTR_PATN_ADMT ' +
             'WHERE AN = %S '+
             'AND WARDID = %S '+
             'AND ROOMNO = %S '+
             'AND BEDNO = %S';

{QRY_SEL_PADM='SELECT *, TNAME+FNAME+'' ''+LNAME AS PATNAME '+
             'FROM NUTR_PADM WHERE AN LIKE :AN';}

QRY_SEL_PADM='SELECT * FROM NUTR_PADM WHERE AN LIKE :AN';             

QRY_SEL_PFRQ=
'SELECT '+
  'P.HN, P.PID, P.AN,'+
  'P.TNAME, P.FNAME, P.LNAME, P.GENDER, P.BIRTH,'+
  'P.WARDID, P.WARDNAME, P.ROOMNO, P.BEDNO,'+
  'P.ADMITDATE, P.DISCHDATE,'+
  '----------------------------------------------'+
  'R.REQID, R.REQFR, R.REQTO,'+
  'R.DIAG, R.FOODTYPC, R.FOODTYPE,'+
  'R.HTS, R.WTS,'+
  'R.AMOUNTAM, R.AMOUNTPM, R.SALTWT '+
'FROM NUTR_PADM P '+
'JOIN NUTR_FOOD_REQS R '+
  'ON R.AN = P.AN '+
  'AND R.HN = P.HN';

{$R *.dfm}

procedure TDmoFoodReq.DataModuleCreate(Sender: TObject);
var snd :TRecConnectParams;
begin
  inherited;
  snd := MainDB.GetHcCnParams;
  FHomcDB := TDmoCnHomc.Create(nil,snd);
end;

procedure TDmoFoodReq.DataModuleDestroy(Sender: TObject);
begin
  inherited;
//
end;

function TDmoFoodReq.DiagList: TdataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qryDiagList;
    Exit;
  end;
  //
  qryDiagList.DisableControls;
  try
    qryDiagList.Close;
    qryDiagList.SQL.Text := QRY_LST_DIAG;
    qryDiagList.Open;
  finally
    qryDiagList.EnableControls;
  end;
  //
  Result := qryDiagList;
end;

function TDmoFoodReq.FoodReqSet(const s: String): TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qryFoodReq;
    Exit;
  end;
  //
  qryFoodReq.DisableControls;
  try
    qryFoodReq.Close;
    //
    qryFoodReq.SQL.Text   := QRY_SEL_FREQ;
    //
    if s='' then
      qryFoodReq.ParamByName('AN').AsString := '%'
    else qryFoodReq.ParamByName('AN').AsString := s;
    //
    qryFoodReq.Open;
  finally
    qryFoodReq.EnableControls;
  end;
  //
  Result := qryFoodReq;
end;

function TDmoFoodReq.FoodTypeList(const grp,typ :String): TDataSet;
var sQry :String;
begin
  if not MainDB.IsConnected then begin
    Result := qryFoodTypeList;
    Exit;
  end;
  //
  qryFoodTypeList.DisableControls;
  try
    sQry := Format(QRY_LST_FTYG,[QuotedStr(grp),QuotedStr(typ)]);
    qryFoodTypeList.Close;
    qryFoodTypeList.SQL.Text := sQry;
    qryFoodTypeList.Open;
  finally
    qryFoodTypeList.EnableControls;
  end;
  //
  Result := qryFoodTypeList;
end;

function TDmoFoodReq.HcDataSet(const s: String;opt:Integer): TDataSet;
var sQry :String;
begin
  if not FHomcDB.IsConnected then begin
    Result := nil;
    Exit;
  end;
  //
  qryGetHcDat.DisableControls;
  try
    //
    sQry := Format(qryHcDatByFormat.SQL.Text,[QuotedStr(s+'%'),
                                              IntToStr(opt),
                                              QuotedStr(s+'%'),
                                              IntToStr(opt),
                                              QuotedStr(s+'%'),
                                              IntToStr(opt)
                                             ]);
    qryGetHcDat.Close;
    qryGetHcDat.SQLConnection := FHomcDB.Connection;
    qryGetHcDat.SQL.Text := sQry;
    //
    qryGetHcDat.Open;
    qryGetHcDat.FieldByName('ADMITDATE').OnGetText := DateGetText;
    //
  finally
    qryGetHcDat.EnableControls;
  end;
  //
  Result  := qryGetHcDat;
end;

function TDmoFoodReq.IsAdmExist(
  const an, ward, room, bed: String): Boolean;
var qry :TSQLQuery; sQry :String;
begin
  qry := TSQLQuery.Create(nil);
  try
    sQry := Format(QRY_SEL_ADMT,[QuotedStr(an),
                                 QuotedStr(ward),
                                 QuotedStr(room),
                                 QuotedStr(bed)]);
    //
    qry.SQLConnection := MainDB.Connection;
    qry.SQL.Text      := sQry;
    qry.Open;
    Result := not qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

function TDmoFoodReq.IsPatExist(const hn: String): Boolean;
var qry :TSQLQuery;
begin
  qry := TSQLQuery.Create(nil);
  try
    qry.SQLConnection := MainDB.Connection;
    qry.SQL.Text := Format(QRY_SEL_PATN,[hn]);
    qry.Open;
    Result := not qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

function TDmoFoodReq.MaxReqID: String;
var qry :TSQLQuery;
begin
  qry := TSQLQuery.Create(nil);
  try
    qry.SQLConnection := MainDB.Connection;
    qry.SQL.Text := QRY_MAX_REQID;
    qry.Open;
    if qry.IsEmpty then
      Result := '00000'
    else begin
      if qry.Fields[0].AsString='' then
        Result := '00000'
      else Result := qry.Fields[0].AsString;
    end;
  finally
    qry.Free;
  end;
end;

function TDmoFoodReq.PatientAdmitDataSet(const an: String): TDataSet;
var qStr :String;
begin
  if not MainDB.IsConnected then begin
    Result := qryPatAdm;
    Exit;
  end;
  //
  qryPatAdm.DisableControls;
  try
    qryPatAdm.Close;
    if an='' then
      qStr := Format(QRY_SEL_PTAM,[QuotedStr('%')])
    else qStr := Format(QRY_SEL_PTAM,[QuotedStr(an)]);
    qryPatAdm.SQL.Text := qStr;
    qryPatAdm.Open;
  finally
    qryPatAdm.EnableControls;
  end;
  //
  Result := qryPatAdm;
end;

function TDmoFoodReq.XDataSet: TDataSet;
begin
  Result := XDataSet(FSearchKey);
end;

function TDmoFoodReq.XDataSet(const p: TRecDataXSearch): TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := nil;
    Exit;
  end;
  //
  qryPatAdm.DisableControls;
  try
    qryPatAdm.Close;
    //
    qryPatAdm.SQL.Text := QRY_SEL_PADM;
    //
    if p.AN ='' then
      qryPatAdm.ParamByName('AN').AsString := '%'
    else qryPatAdm.ParamByName('AN').AsString := p.AN;
    //
    qryPatAdm.Open;
  finally
    qryPatAdm.EnableControls;
  end;

  Result := qryPatAdm;
end;

{procedure TDmoFoodReq.SavePatientAdmit(p: TRecHcDat);
var qStr :String;
begin
  //Patient
  if not IsPatExist(p.Hn) then begin
    qStr := QRY_INS_PATN;
    qStr := qStr +'('+QuotedStr(p.Hn)+',';
    qStr := qStr +QuotedStr(p.PID)+',';
    qStr := qStr +QuotedStr(p.TName)+',';
    qStr := qStr +QuotedStr(p.FName)+',';
    qStr := qStr +QuotedStr(p.LName)+',';
    qStr := qStr +QuotedStr(p.Gender)+',';
    qStr := qStr +QuotedStr(DateTimeToSqlServerDateTimeString(p.Birth))+')';
    MainDB.AddTransCmd(qStr);
  end;
  //Admission
  if not IsAdmExist(p.An, p.WardID, p.RoomNo, p.BedNo) then begin
    qStr := QRY_INS_ADMT;
    qStr := qStr +'('+QuotedStr(p.Hn)+',';
    qStr := qStr +QuotedSTr(p.An)+',';
    qStr := qStr +QuotedStr(p.WardID)+',';
    qStr := qStr +QuotedStr(p.WardName)+',';
    qStr := qStr +QuotedStr(DateTimeToSqlServerDateTimeString(p.AdmitDt))+',';
    qStr := qStr +QuotedStr(DateTimeToSqlServerDateTimeString(p.AdmitDt))+',';
    qStr := qStr +QuotedStr(p.RoomNo)+',';
    qstr := qStr +QuotedStr(p.BedNo)+')';
    MainDB.AddTransCmd(qStr);
  end;
  //
  MainDB.DoTransCmd;
end;}

{protected}
function TDmoFoodReq.Schema: TXMLDocument;
begin
  Result := schemaFoodReq;
end;

{private}
procedure TDmoFoodReq.DateGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  Text := YmdHmToDmyHm(Sender.AsString);
end;

function TDmoFoodReq.GetSearchKey: TRecDataXSearch;
begin
  Result := FSearchKey
end;

procedure TDmoFoodReq.SetSearchKey(const Value: TRecDataXSearch);
begin
  FSearchKey := Value;
end;

end.
