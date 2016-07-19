unit ShareMethod;

interface

uses
  Classes, Controls, Windows, XMLIntf, xmldom, msxmldom, XMLDoc, Variants,
  Dialogs, StrUtils, SysUtils, Messages, ShareCommon, Forms, DateUtils, DB,
  DBClient;

//datetime
function AgeFrYmdDate(const ymd :String):Integer;
function AgeFrDate(const dt :TDateTime):Integer;
function DateFrDMY(const sDt :String; isBD :Boolean=False):TDateTime;
function DateToDMY(const dt :TDateTime; isBD :Boolean=False):String;
function DateToYMD(const dt :TDateTime; isBD :Boolean=False):String;
function DateOnly(const dt :TDateTime):TDateTime;
function DateStrIsBD(const sDt :String) :Boolean;
function DateThaiFull(const dt :TDatetime) :String;
function DateTimeToSqlServerDateTimeString(const pDate :TDateTime) :String;
//data
procedure DataCopy(var dsFr, dsTo :TDataSet;exact :boolean=False);
procedure DataCdsCopy(var cdsFr, cdsTo :TClientDataSet; exact :boolean=False);
//email
function ValidEmail(email: string): boolean;
//xml
function XmlToSqlCreateCommand(xmlDoc :TXmlDocument) :String;
function XmlGetTableName(xmlDoc :TXmlDocument) :String;
function YmdToDate(const ymd :String):TDateTime;
function YmdHmToDate(const yh :String):TDateTime;
function YmdHmToDmyHm(const yh :String):String;
//
function ReadConfig :TRecConnectParams;
procedure WriteConfig(p: TRecConnectParams);
//
procedure OnGridKeyEnterToNextCell(
  Sender: TObject;
  var Key: Word;
  Shift: TShiftState);
//
function NextIpacc(IpaccNo: String): String;
//
function  GetAppVersion:string;

//---------------------------------------------------------------//

const
  FILE_CONFIG = 'config.xml';
  ERR_CFG     = 'ไม่พบไฟล์ที่ใช้ตั้งค่า';
  //file config xml element
  element_db     = 'database';
  element_server = 'server';
  element_name   = 'name';
  element_user   = 'user';
  element_pwd    = 'password';
  //
  tb_node=         'table';
  tb_attrb_name=   'name';
  fl_attrb_type=   'type';
  fl_attrb_length= 'length';
  fl_attrb_pk=     'pk';
  fl_attrb_vary=   'vary';
  fl_attrb_ident=  'identity';
  //
  iln_smallint=    1;
  iln_integer=     2;
  iln_bigint=      3;

implementation

function AgeFrYmdDate(const ymd :String):Integer;
var y,m,d :word; dt :TDateTime; days :Integer;
begin
  Result := 0;
  if TrimRight(ymd)='' then
    Exit;

  y := StrToInt(Copy(ymd,1,4))-543;
  m := StrToInt(Copy(ymd,5,2));
  d := StrToInt(Copy(ymd,7,2));
  //
  dt   := EncodeDate(y,m,d);
  days := DaysBetween(dt,Now);
  //
  Result := Round(days/365);
end;

function AgeFrDate(const dt :TDateTime):Integer;
var days :Integer;
begin
  if dt=0 then begin
    Result := 0;
    Exit;
  end;
  //
  days   := DaysBetween(dt,Now);
  Result := Round(days/365);
end;

procedure DataCopy(var dsFr, dsTo :TDataSet;exact :boolean);
var i :Integer; fld :TField;
begin
  if (dsFr=nil)or(dsFr.IsEmpty)or(dsTo=nil)then
    Exit;
  //
  if dsFr.FieldCount<>dsTo.FieldCount then
    Exit;
  dsFr.First;
  repeat
    dsTo.Append;
    for i := 0 to dsFr.FieldCount - 1 do begin
      if exact then begin
        fld := dsTo.FindField(dsFr.Fields[i].FieldName);
        if fld<>nil then
          fld.Value := dsTo.Fields[i].Value;
      end else begin
        dsTo.Fields[i].Value := dsFr.Fields[i].Value;
      end;
    end;
    dsTo.Post;
    dsFr.Next;
  until dsFr.Eof;
end;

procedure DataCdsCopy(var cdsFr, cdsTo :TClientDataSet; exact :boolean=False);
var i :Integer; fld :TField;
begin
  if (cdsFr=nil)or(cdsFr.IsEmpty)or(cdsTo=nil)then
    Exit;
  //
  if cdsFr.FieldCount<>cdsTo.FieldCount then
    Exit;
  cdsFr.First;
  repeat
    cdsTo.Append;
    for i := 0 to cdsFr.FieldCount - 1 do begin
      if exact then begin
        fld := cdsTo.FindField(cdsFr.Fields[i].FieldName);
        if fld<>nil then
          fld.Value := cdsTo.Fields[i].Value;
      end else begin
        cdsTo.Fields[i].Value := cdsFr.Fields[i].Value;
      end;
    end;
    cdsTo.Post;
    cdsFr.Next;
  until cdsFr.Eof;
end;

function DateFrDMY(const sDt :String;isBD :Boolean=False):TDateTime;
var lst :TStrings; y,m,d :Word;
const corr = 543;
begin
  lst := TStringList.Create;
  try
    lst.Delimiter := '/';
    lst.StrictDelimiter := True;
    lst.DelimitedText := sDt;
    //
    y := StrToIntDef(lst[2],0);
    m := StrToIntDef(lst[1],0);
    d := StrToIntDef(lst[0],0);
    //
    if isBD then
      y := y - corr;
    Result := EncodeDate(y,m,d);
  finally
    lst.Free;
  end;
end;

function DateToDMY(const dt :TDateTime;isBD :Boolean=False):String;
var y,m,d,hr,mm,ss,ms :Word;
const corr = 543;
begin
  DecodeDateTime(dt,y,m,d,hr,mm,ss,ms);
  if isBD then
    y := y+corr;
  Result := Format('%.*d/%.*d/%*.d',[2,d,2,m,2,y]);
end;

function DateToYMD(const dt :TDateTime; isBD :Boolean=False):String;
var y,m,d,hr,mm,ss,ms :Word;
const corr = 543;
begin
  DecodeDateTime(dt,y,m,d,hr,mm,ss,ms);
  if isBD then
    y := y+corr;
  Result := Format('%.*d%.*d%.*d',[2,y,2,m,2,d]);
end;

function DateOnly(const dt :TDateTime):TDateTime;
var d, m, y :Word;
begin
  if dt<>0 then begin
    d := DayOf(dt);
    m := MonthOf(dt);
    y := Yearof(dt);
    Result := EncodeDateTime(y,m,d,0,0,0,0);
    Exit;
  end;
  Result := dt;
end;

function DateStrIsBD(const sDt :String) :Boolean;
var lst :TStrings; yrBd, yrAd :Integer;
    y, m, d : word; bChk :Boolean;
const corr = 543; ad = 1916;
begin
  lst := TStringList.Create;
  try
    lst.Delimiter := '/';
    lst.StrictDelimiter := True;
    lst.DelimitedText := sDt;
    //
    if lst.Count<>3 then begin
      Result := False;
      Exit;
    end;
    //
    y := StrToIntDef(lst[2],0);
    m := StrToIntDef(lst[1],0);
    d := StrToIntDef(lst[0],0);
    if (y=0)or(m=0)or(d=0) then begin
      Result := False;
      Exit;
    end;
    //
    yrBd := ad + corr;
    if y < yrBd then begin
      Result := False;
      Exit;
    end;
    //
    if not(m in [1..12]) then begin
      Result := False;
      Exit;
    end;
    //
    yrAd := y-corr;
    bChk := False;
    case m of
      1,3,5,7,8,10,12 : bChk := (d<=31);
      4,6,9,11        : bChk := (d<=30);
      2 :  begin
         if (yrAd mod 4)=0 then
           bChk := (d<=29)
         else bChk := (d<=28);
      end;
    end;
    if not bChk then begin
      Result := False;
      Exit;
    end;
  finally
    lst.Free;
  end;
  Result := True;
end;

function DateThaiFull(const dt :TDatetime) :String;
var d, m, y :Word;
    ThFullMonths :TStrings;
begin
  ThFullMonths := TStringList.Create;
  try
    if dt=0 then
      Exit;
    ThFullMonths.Append('มกราคม');
    ThFullMonths.Append('กุมภาพันธ์');
    ThFullMonths.Append('มีนาคม');
    ThFullMonths.Append('เมษายน');
    ThFullMonths.Append('พฤษภาคม');
    ThFullMonths.Append('มิถุนายน');
    ThFullMonths.Append('กรกฎาคม');
    ThFullMonths.Append('สิงหาคม');
    ThFullMonths.Append('กันยายน');
    ThFullMonths.Append('ตุลาคม');
    ThFullMonths.Append('พฤศจิกายน');
    ThFullMonths.Append('ธันวาคม');
    //
    d := DayOf(dt);
    m := MonthOf(dt);
    y := Yearof(dt);
    //
    Result := 'วันที่ '+IntToStr(d)+' ';
    Result := Result+ThFullMonths[m-1];
    Result := Result+'  พ.ศ. '+IntToStr(y+543);
  finally
    ThFullMonths.Free;
  end;
end;

function DateTimeToSqlServerDateTimeString(const pDate :TDateTime) :String;
begin
  Result := FormatDateTime('yyyymmdd hh:nn:ss.zzz',pDate);
end;

function ValidEmail(email: string): boolean;
// Returns True if the email address is valid
// Author: Ernesto D'Spirito
const
  // Valid characters in an "atom"
  atom_chars = [#33..#255] - ['(', ')', '<', '>', '@', ',', ';', ':',
                                '\', '/', '"', '.', '[', ']', #127];

  // Valid characters in a "quoted-string"
  quoted_string_chars = [#0..#255] - ['"', #13, '\'];

  // Valid characters in a subdomain
  letters = ['A'..'Z', 'a'..'z'];
  letters_digits = ['0'..'9', 'A'..'Z', 'a'..'z'];
  subdomain_chars = ['-', '0'..'9', 'A'..'Z', 'a'..'z'];

type
  States = (STATE_BEGIN, STATE_ATOM, STATE_QTEXT, STATE_QCHAR,
            STATE_QUOTE, STATE_LOCAL_PERIOD, STATE_EXPECTING_SUBDOMAIN,
            STATE_SUBDOMAIN, STATE_HYPHEN);
var
  State: States;
  i, n, subdomains: integer;
  c: char;
begin
  State := STATE_BEGIN;
  n     := Length(email);
  i     := 1;
  subdomains := 1;
  //
  while (i <= n) do begin
    c := email[i];
    case State of
      //
      STATE_BEGIN:
        if c in atom_chars then
          State := STATE_ATOM
        else if c = '"' then
          State := STATE_QTEXT
        else
        break;
      //
      STATE_ATOM:
        if c = '@' then
          State := STATE_EXPECTING_SUBDOMAIN
        else if c = '.' then
          State := STATE_LOCAL_PERIOD
        else if not (c in atom_chars) then
        break;
      //
      STATE_QTEXT:
        if c = '\' then
          State := STATE_QCHAR
        else if c = '"' then
          State := STATE_QUOTE
        else if not (c in quoted_string_chars) then
        break;
      //
      STATE_QCHAR:
        State := STATE_QTEXT;
      //
      STATE_QUOTE:
        if c = '@' then
          State := STATE_EXPECTING_SUBDOMAIN
        else if c = '.' then
          State := STATE_LOCAL_PERIOD
        else
        break;
      //
      STATE_LOCAL_PERIOD:
        if c in atom_chars then
          State := STATE_ATOM
        else if c = '"' then
          State := STATE_QTEXT
        else
        break;
      //
      STATE_EXPECTING_SUBDOMAIN:
        if c in letters then
          State := STATE_SUBDOMAIN
        else
        break;
      //
      STATE_SUBDOMAIN:
        if c = '.' then begin
          inc(subdomains);
          State := STATE_EXPECTING_SUBDOMAIN
        end else if c = '-' then
          State := STATE_HYPHEN
        else if not (c in letters_digits) then
        break;
      //
      STATE_HYPHEN:
        if c in letters_digits then
          State := STATE_SUBDOMAIN
        else if c <> '-' then
        break;
      end;
      inc(i);
  end;
  //
  if i <= n then
    Result := False
  else
    Result := (State = STATE_SUBDOMAIN) and (subdomains >= 2);
end;

function GetAppVersion:string;
var
  Size, Size2: DWord;
  Pt, Pt2: Pointer;
begin
  Size := GetFileVersionInfoSize(PChar (ParamStr (0)), Size2);
  if Size > 0 then begin
    GetMem (Pt, Size);
    try
      GetFileVersionInfo (PChar (ParamStr (0)), 0, Size, Pt);
      VerQueryValue (Pt, '\', Pt2, Size2);
      with TVSFixedFileInfo (Pt2^) do begin
        Result:= ' ver. '+
                 IntToStr (HiWord (dwFileVersionMS)) + '.' +
                 IntToStr (LoWord (dwFileVersionMS)) + '.' +
                 IntToStr (HiWord (dwFileVersionLS)) + '.' +
                 IntToStr (LoWord (dwFileVersionLS)) + ' ';
      end;
    finally
      FreeMem(Pt);
    end;
  end;
end;

function ReadConfig :TRecConnectParams;
var xmlRead :TXMLDocument;
    dbNode  :IXMLNode;
    p       :TRecConnectParams;
    sFile   :String;
begin
  sFile := GetCurrentDir+'\'+FILE_CONFIG;
  if not FileExists(sFile) then
    MessageDlg(ERR_CFG,mtError,[mbOK],0)
  else begin
    xmlRead := TXMLDocument.Create(Application);
    try
      xmlRead.FileName := sFile;
      xmlRead.Active   := True;
      if xmlRead.Active then begin
        dbNode := xmlRead.DocumentElement;
        p.Server   := dbNode.ChildNodes[element_server].NodeValue;
        p.Database := dbNode.ChildNodes[element_name].NodeValue;
        p.User     := dbNode.ChildNodes[element_user].NodeValue;
        p.Password := dbNode.ChildNodes[element_pwd].NodeValue;
      end;
      Result := p;
    finally
      xmlRead.Active := False;
      xmlRead.Free;
    end;
  end;
end;

procedure WriteConfig(p: TRecConnectParams);
var xmlSave :TXMLDocument;
    dbNode  :IXMLNode;
    sFile   :String;
begin
  sFile := GetCurrentDir+'\'+FILE_CONFIG;
  if not FileExists(sFile) then
    MessageDlg(ERR_CFG,mtError,[mbOK],0)
  else begin
    xmlSave := TXMLDocument.Create(Application);
    try
      xmlSave.FileName := sFile;
      xmlSave.Active   := True;
      if xmlSave.Active then begin
        dbNode := xmlSave.DocumentElement;
        dbNode.ChildNodes[element_server].NodeValue := p.Server;
        dbNode.ChildNodes[element_name].NodeValue   := p.Database;
        dbNode.ChildNodes[element_user].NodeValue   := p.User;
        dbNode.ChildNodes[element_pwd].NodeValue    := p.Password;
      end;
      xmlSave.SaveToFile(sFile);
    finally
      xmlSave.Active := False;
      xmlSave.Free;
    end;
  end;
end;

function XmlToSqlCreateCommand(xmlDoc :TXmlDocument) :String;
var tNode,cNode              :IXMLNode;
    sRet,sFld,sFTy,sFldSql   :String;
    i,iFLen                  :Integer;
    bIsPk, bVary, bIdent     :Boolean;
begin
    xmlDoc.Active := True;
    try
      tNode := xmlDoc.ChildNodes.Nodes[tb_node];
      sRet := 'CREATE TABLE '+(VarToStr(tNode.Attributes[tb_attrb_name]));

      for i := 0 to tNode.ChildNodes.Count - 1 do begin
        cNode := tNode.ChildNodes[i];
        sFld := cNode.NodeName;

        sFTy := '';
        if cNode.HasAttribute(fl_attrb_type) then
          sFTy := VarToStr(cNode.Attributes[fl_attrb_type]);

        iFLen := 0;
        if cNode.HasAttribute(fl_attrb_length) then
          iFLen := StrToIntDef(VarToStr(cNode.Attributes[fl_attrb_length]),0);

        bIsPK := False;
        if cNode.HasAttribute(fl_attrb_pk) then
          bIsPK := (VarToStr(cNode.Attributes[fl_attrb_pk])='Y');

        bVary := False;
        if cNode.HasAttribute(fl_attrb_vary) then
          bVary := (VarToStr(cNode.Attributes[fl_attrb_vary])='Y');

        bIdent := False;
        if cNode.HasAttribute(fl_attrb_ident) then
          bIdent := (VarToStr(cNode.Attributes[fl_attrb_ident])='Y');

        sFldSql := sFld+' ';
        if(sFTy='string')then begin
          if bVary then
            sFldSql := sFldSql+'varchar('+IntToStr(iFLen)+')'
          else sFldSql := sFldSql+'char('+IntToStr(iFLen)+')';
        end else if(sFTy='integer')then begin
          case iFLen of
            iln_smallint : sFldSql := sFldSql+'smallint';
            iln_integer  : sFldSql := sFldSql+'integer';
            iln_bigint   : sFldSql := sFldSql+'bigint';
          end;
        end  else begin
          sFldSql := sFldSql+sFTy;
        end;

        if bIsPK then
          sFldSql := sFldSql+' not null'
        else sFldSQL := sFldSql+' null';

        if bIdent and (sFTy='integer') then
          sFldSql := sFldSql +' identity(1,1)';

        if(i=0)then
          sRet := sRet+'('+sFldSQL+','
        else if(i=(tNode.ChildNodes.Count-1)) then
          sRet := sRet+sFldSQL+')'
        else sRet := sRet+sFldSQL+',';

      end;
      sRet := UPPERCASE(sRet);
      Result := sRet;
    finally
      xmlDoc.Active := False;
    end;
end;

function XmlGetTableName(xmlDoc :TXmlDocument) :String;
var tNode :IXMLNode;
begin
  xmlDoc.Active := True;
  try
    tNode := xmlDoc.ChildNodes.Nodes[tb_node];
    Result := VarToStr(tNode.Attributes[tb_attrb_name]);
  finally
    xmlDoc.Active := False;
  end;
end;

procedure OnGridKeyEnterToNextCell(
  Sender: TObject;
  var Key: Word;
  Shift: TShiftState);
begin
  {if Key = VK_RETURN then
    begin
      Perform(WM_NEXTDLGCTL,0,0);
    Key := #0;
  end}
end;

function NextIpacc(IpaccNo: String): String;
const baseno = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var ibase, ln, i, idx :Integer;
    s, sNew :String;
    b :Boolean;
begin
  Result := '';
  //
  if IpaccNo = '' then
    Exit;
  //
  iBase := Length(baseno);
  ln    := Length(IpaccNo);
  b     := False;
  //
  for i := ln downto 1 do begin
    s   := Copy(IpaccNo,i,1);
    idx := Pos(s,baseno);
    //
    if i=ln then begin
      if idx < iBase then begin
        sNew := Copy(baseno,idx+1,1);
        sNew := Copy(Ipaccno,1,ln-1)+sNew;
        Break;
      end else if idx = iBase then begin
        sNew := '0';
        b    := True;
      end;
    end else begin
      if (idx < iBase)and b then begin
        sNew := Copy(baseno,idx+1,1)+sNew;
        b := False;
      end else if idx = iBase then begin
        sNew := '0'+sNew;
        b    := True;
      end else begin
        sNew := s+sNew;
      end;
    end;
  end;
  //
  Result := sNew;
end;

function YmdToDate(const ymd :String):TDateTime;
var y,m,d :word;
begin
  if TrimRight(ymd)='' then begin
    Result := 0;
    Exit;
  end;

  y := StrToInt(Copy(ymd,1,4))-543;
  m := StrToInt(Copy(ymd,5,2));
  d := StrToInt(Copy(ymd,7,2));
  //
  Result := EncodeDate(y,m,d);
end;

function YmdHmToDate(const yh :String):TDateTime;
var y,m,d,hh,mm :word;
begin
  if TrimRight(yh)='' then begin
    Result := 0;
    Exit;
  end;

  y := StrToInt(Copy(yh,1,4))-543;
  m := StrToInt(Copy(yh,5,2));
  d := StrToInt(Copy(yh,7,2));
  hh := StrToInt(Copy(yh,9,2));
  mm := StrToInt(Copy(yh,11,2));
  //
  Result := EncodeDateTime(y,m,d,hh,mm,0,0);
end;

function YmdHmToDmyHm(const yh :String):String;
var y,m,d,hh,mm :String;
begin
  if TrimRight(yh)='' then begin
    Result := '';
    Exit;
  end;
  //
  y := Copy(yh,1,4);
  m := Copy(yh,5,2);
  d := Copy(yh,7,2);
  hh := Copy(yh,9,2);
  mm := Copy(yh,11,2);
  //
  Result := d+'/'+m+'/'+y+' '+hh+':'+mm+':'+'00';
end;

end.
