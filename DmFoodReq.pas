unit DmFoodReq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  DmCnMain, DmCnHomc, ShareInterface, ShareMethod;

type
  TDmoFoodReq = class(TDmoBase, IFoodReqDataX)
    schemaFoodReq: TXMLDocument;
    qryFoodReq: TSQLQuery;
    schemaPatient: TXMLDocument;
    schemaAdmit: TXMLDocument;
    qryHcDat: TSQLQuery;
    qryAdmit: TSQLQuery;
    qryGetHcDat: TSQLQuery;
    qryFoodTypeList: TSQLQuery;
    qryDiagList: TSQLQuery;
    qryPatAdm: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FHomcDB :IDbConnect;
    FSearchKey :TRecDataXSearch;
    function GetSearchKey :TRecDataXSearch;
    procedure SetSearchKey(const Value :TRecDataXSearch);
  protected
    { Protected declarations }
    function Schema :TXMLDocument; override;
  public
    { Public declarations }
    function DiagList :TdataSet;
    function FoodTypeList :TDataSet;
    function HcDataSet(const s :String):TDataSet;
    function MaxReqID :String;
    function PatientAdmitDataSet(const an :String):TDataSet;    
    procedure SavePatientAdmit(p :TRecHcDat);
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

QRY_SEL_FREQ='SELECT * FROM NUTR_FOOD_REQS '+
             'WHERE ISNULL(AN,'''') LIKE :AN ';

QRY_SEL_HC='SELECT '+
           'ih.ladmit_n as an, ih.ward_id,'+
           'ih.admit_date, ih.admit_time,'+
           'p.hn, p.titleCode, p.firstName,'+
           'p.lastName,p.sex,'+
	         'w.ward_name as ward,'+
	         't.titleName,'+
	         'rtrim(t.titleName)+p.firstName+'' ''+p.lastName as patname '+
           'FROM Ipd_h ih '+
           'LEFT JOIN Ward w ON w.ward_id = ih.ward_id '+
           'LEFT JOIN PATIENT p ON p.hn = ih.hn '+
           'LEFT JOIN PTITLE t ON t.titleCode = p.titleCode '+
           'WHERE p.firstName LIKE %S';

QRY_MAX_REQID='SELECT MAX(REQID) FROM NUTR_FOOD_REQS';

QRY_INS_PATN='INSERT INTO NUTR_PATN VALUES ';

QRY_INS_ADMT='INSERT INTO NUTR_PATN_ADMT VALUES ';

QRY_SEL_PTAM='SELECT P.HN, A.AN, P.PID,'+
                    'P.TNAME, P.FNAME, P.LNAME,'+
                    'P.TNAME+P.FNAME+'' ''+P.LNAME AS PATNAME,'+
    	              'P.GENDER, P.BIRTH, A.WARDID, A.WARDNAME,'+
                    'A.ADMITDATE,A.DISCHDATE '+
             'FROM NUTR_PATN P '+
             'LEFT JOIN NUTR_PATN_ADMT A ON A.HN = P.HN '+
             'WHERE A.AN =%S';

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

function TDmoFoodReq.FoodTypeList: TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qryFoodTypeList;
    Exit;
  end;
  //
  qryFoodTypeList.DisableControls;
  try
    qryFoodTypeList.Close;
    qryFoodTypeList.SQL.Text := QRY_LST_FDTY;
    qryFoodTypeList.Open;
  finally
    qryFoodTypeList.EnableControls;
  end;
  //
  Result := qryFoodTypeList;
end;

function TDmoFoodReq.HcDataSet(const s: String): TDataSet;
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
    sQry := Format(qryHcDat.SQL.Text,[QuotedStr(s+'%')]);
    //
    qryGetHcDat.Close;
    qryGetHcDat.SQLConnection := FHomcDB.Connection;
    qryGetHcDat.SQL.Text := sQry;
    qryGetHcDat.Open;
  finally
    qryGetHcDat.EnableControls;
  end;
  //
  Result  := qryGetHcDat;
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
    qStr := Format(QRY_SEL_PTAM,[QuotedStr(an)]);
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
    if p.AN ='' then
      qryFoodReq.ParamByName('AN').AsString := '%'
    else qryFoodReq.ParamByName('AN').AsString := p.AN;

    //
    qryFoodReq.Open;
  finally
    qryFoodReq.EnableControls;
  end;

  Result := qryFoodReq;
end;

procedure TDmoFoodReq.SavePatientAdmit(p: TRecHcDat);
var qStr :String;
begin
  //Patient
  qStr := QRY_INS_PATN;
  qStr := qStr +'('+QuotedStr(p.Hn)+',';
  qStr := qStr +QuotedStr(p.PID)+',';
  qStr := qStr +QuotedStr(p.TName)+',';
  qStr := qStr +QuotedStr(p.FName)+',';
  qStr := qStr +QuotedStr(p.LName)+',';
  qStr := qStr +QuotedStr(p.Gender)+',';
  qStr := qStr +QuotedStr(DateTimeToSqlServerDateTimeString(p.Birth))+')';
  MainDB.AddTransCmd(qStr);
  //Admission
  qStr := QRY_INS_ADMT;
  qStr := qStr +'('+QuotedStr(p.Hn)+',';
  qStr := qStr +QuotedSTr(p.An)+',';
  qStr := qStr +QuotedStr(p.WardID)+',';
  qStr := qStr +QuotedStr(p.WardName)+',';
  qStr := qStr +QuotedStr(DateTimeToSqlServerDateTimeString(p.AdmitDt))+',';
  qStr := qStr +QuotedStr(DateTimeToSqlServerDateTimeString(p.AdmitDt))+')';
  MainDB.AddTransCmd(qStr);
  //
  MainDB.DoTransCmd;
end;

{protected}
function TDmoFoodReq.Schema: TXMLDocument;
begin
  Result := schemaFoodReq;
end;

{private}
function TDmoFoodReq.GetSearchKey: TRecDataXSearch;
begin
  Result := FSearchKey
end;

procedure TDmoFoodReq.SetSearchKey(const Value: TRecDataXSearch);
begin
  FSearchKey := Value;
end;

end.
