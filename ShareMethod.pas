unit ShareMethod;

interface

uses
  Classes, Controls, Windows, XMLIntf, xmldom, msxmldom, XMLDoc, Variants,
  Dialogs, StrUtils, SysUtils, Messages, ShareCommon, Forms, DateUtils;

function AgeFrYmdDate(const ymd :String):Integer;
function AgeFrDate(const dt :TDateTime):Integer;
function DateOnly(const dt :TDateTime):TDateTime;
function DateTimeToSqlServerDateTimeString(const pDate :TDateTime) :String;
function ValidEmail(email: string): boolean;
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

const
  FILE_CONFIG = 'config.xml';
  ERR_CFG     = '‰¡Ëæ∫‰ø≈Ï∑’Ë„™Èµ—Èß§Ë“';
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
