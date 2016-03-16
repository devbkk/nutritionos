inherited DmoFactGroups: TDmoFactGroups
  OldCreateOrder = True
  Height = 227
  Width = 247
  object schmeFactGroups: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      ' <table name="NUTR_FACT_GRPS">'
      '   <fgrc type="string" length="4" pk="Y"/>'
      '   <fgrp type="string" length="30" vary="Y"/>'
      '   <flev type="integer" length="2"/>'
      '   <note type="string" length="100" vary="Y"/>'
      '   <fprp type="string" length="1" vary="N"/>'
      '   <pcod type="string" length="4" vary="N"/>'
      '</table>')
    Left = 128
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
  object qryFactGroups: TSQLQuery
    Params = <>
    Left = 128
    Top = 80
  end
end
