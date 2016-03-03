inherited DmoMeal: TDmoMeal
  OldCreateOrder = True
  Height = 223
  Width = 394
  object schemaMeal: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '  <table name="NUTR_MEAL">'
      '  <mlid type="string" length="10" pk="Y"/>'
      '  <mlname type="string" length="30" vary="Y"/>'
      '</table>')
    Left = 144
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
  object schemaMealItems: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '  <table name="NUTR_MEAL_ITMS">'
      '  <mlid type="string" length="10" pk="Y"/>'
      '  <mnuid type="string" length="10" vary="N"/>'
      '</table>')
    Left = 240
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
  object qryMeal: TSQLQuery
    Params = <>
    Left = 144
    Top = 80
  end
  object qryMealList: TSQLQuery
    Params = <>
    Left = 240
    Top = 80
  end
  object qryMealItems: TSQLQuery
    Params = <>
    Left = 40
    Top = 144
  end
end
