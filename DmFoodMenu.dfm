inherited DmoFoodMenu: TDmoFoodMenu
  OldCreateOrder = True
  Height = 228
  Width = 351
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
  object schemaMenuItems: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '  <table name="NUTR_FMNU_ITMS">'
      '  <mnuid type="string" length="10" pk="Y"/>'
      '  <fdid type="string" length="10" vary="N"/>'
      '</table>')
    Left = 240
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
  object qryFoodMenuItems: TSQLQuery
    Params = <>
    Left = 40
    Top = 144
  end
end
