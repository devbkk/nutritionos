object DmoBase: TDmoBase
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object schemaBase: TXMLDocument
    Left = 40
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
  object qryBase: TUniQuery
    Connection = DmoCnMain.cnDB
    Left = 40
    Top = 88
  end
end
