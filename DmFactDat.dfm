inherited DmoFactdat: TDmoFactdat
  OldCreateOrder = True
  Height = 161
  Width = 315
  object schemaFact: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      ' <table name="NUTR_FACT">'
      '   <code type="string" length="5" pk="Y"/>'
      '   <fdes type="string" length="50" vary="Y"/>'
      '   <ftyp type="string" length="20" vary="Y"/>'
      '   <note type="string" length="100" vary="Y"/>'
      '</table>')
    Left = 128
    Top = 15
    DOMVendorDesc = 'MSXML'
  end
  object qryFact: TUniQuery
    Connection = DmoCnMain.cnDB
    Left = 128
    Top = 88
  end
  object qryFtyp: TUniQuery
    Connection = DmoCnMain.cnDB
    Left = 216
    Top = 88
  end
end
