inherited DmoFood: TDmoFood
  OldCreateOrder = True
  object schemaFood: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '  <table name="NUTR_FOOD">'
      '  <fdid type="string" length="10" pk="Y"/>'
      '  <fdname type="string" length="30" vary="Y"/>'
      '  <fdtype type="string" length="8" vary="N"/>'
      '</table>')
    Left = 128
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
  object qryFood: TSQLQuery
    Params = <>
    Left = 128
    Top = 80
  end
end
