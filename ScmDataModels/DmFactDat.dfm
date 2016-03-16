inherited DmoFactdat: TDmoFactdat
  OldCreateOrder = True
  Height = 161
  Width = 320
  object schemaFact: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      ' <table name="NUTR_FACT">'
      '   <code type="string" length="8" pk="Y"/>'
      '   <fdes type="string" length="50" vary="Y"/>'
      '   <ftyc type="string" length="3" vary="N"/>'
      '   <ftyp type="string" length="30" vary="Y"/>'
      '   <fgrc type="string" length="2" vary="N"/>'
      '   <fgrp type="string" length="20" vary="Y"/>'
      '   <note type="string" length="250" vary="Y"/>'
      '</table>')
    Left = 128
    Top = 15
    DOMVendorDesc = 'MSXML'
  end
  object qryFact: TSQLQuery
    Params = <>
    Left = 128
    Top = 80
  end
  object qryFtyp: TSQLQuery
    Params = <>
    Left = 224
    Top = 80
  end
end
