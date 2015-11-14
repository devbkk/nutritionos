inherited DmoFoodMenu: TDmoFoodMenu
  OldCreateOrder = True
  Width = 345
  object qryFoodMenu: TSQLQuery
    Params = <>
    Left = 144
    Top = 80
  end
  object schemaFoodMenu: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '  <table name="NUTR_FMNU">'
      '  <mnuid type="string" length="10" pk="Y"/>'
      '  <mnuname type="string" length="30" vary="Y"/>'
      '  <fdid type="string" length="10" vary="N"/>'
      '</table>')
    Left = 144
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
  object qryFoodList: TSQLQuery
    Params = <>
    Left = 240
    Top = 80
  end
end
