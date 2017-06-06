object DmoBase: TDmoBase
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 156
  Width = 215
  object schemaBase: TXMLDocument
    Left = 40
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
  object qryBase: TSQLQuery
    Params = <>
    Left = 40
    Top = 80
  end
  object crDbObj: TSQLQuery
    Params = <>
    Left = 112
    Top = 80
  end
end
