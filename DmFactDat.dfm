inherited DmoFactdat: TDmoFactdat
  OldCreateOrder = True
  Width = 229
  object schemaFact: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      ' <table name="NUTR_FACT">'
      '   <code type="string" length="5" pk="Y"/>'
      '   <fdes type="string" length="50" vary="Y"/>'
      '   <ftyp type="string" length="3" vary="N"/>'
      '   <note type="string" length="100" vary="Y"/>'
      '</table>')
    Left = 128
    Top = 15
    DOMVendorDesc = 'MSXML'
  end
  object qryFact: TSQLQuery
    Params = <>
    Left = 128
    Top = 79
  end
end
