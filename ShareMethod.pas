unit ShareMethod;

interface

uses
  Classes, Controls, Windows, XMLIntf, xmldom, msxmldom, XMLDoc, Variants,
  Dialogs, StrUtils, SysUtils, Messages;

function DateTimeToSqlServerDateTimeString(const pDate :TDateTime) :String;
function ValidEmail(email: string): boolean;
function XmlToSqlCreateCommand(xmlDoc :TXmlDocument) :String;
function XmlGetTableName(xmlDoc :TXmlDocument) :String;
//
procedure OnGridKeyEnterToNextCell(
  Sender: TObject;
  var Key: Word;
  Shift: TShiftState);

const
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

//procedure
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

end.
