unit ShareMethod;

interface

uses
  Classes, XMLIntf, xmldom, msxmldom, XMLDoc, Variants, Dialogs,
  StrUtils, SysUtils;

function XmlToSqlCreateCommand(xmlDoc :TXmlDocument) :String;
function XmlGetTableName(xmlDoc :TXmlDocument) :String;

const
  tb_node=         'table';
  tb_attrb_name=   'name';
  fl_attrb_type=   'type';
  fl_attrb_length= 'length';
  fl_attrb_pk=     'pk';
  fl_attrb_vary=   'vary';

implementation

function XmlToSqlCreateCommand(xmlDoc :TXmlDocument) :String;
var tNode,cNode              :IXMLNode;
    sRet,sFld,sFTy,sFldSql   :String;
    i,iFLen                  :Integer;
    bIsPk, bVary             :Boolean;
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

        sFldSql := sFld+' ';
        if(sFTy='string')then begin
          if bVary then
            sFldSql := sFldSql+'varchar('+IntToStr(iFLen)+')'
          else sFldSql := sFldSql+'char('+IntToStr(iFLen)+')';
        end else begin
          sFldSql := sFldSql+sFTy;
        end;

        if bIsPK then
          sFldSql := sFldSql+' not null'
        else sFldSQL := sFldSql+' null';

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

end.
