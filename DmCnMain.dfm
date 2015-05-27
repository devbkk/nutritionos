object DmoCnMain: TDmoCnMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 177
  Width = 259
  object cnDB: TSQLConnection
    Left = 32
    Top = 24
  end
  object cnParams: TXMLDocument
    XML.Strings = (
      '<? xml version ="1.0" encoding ="UTF-8" ?>'
      '<table name = "USER">'
      '  <server>Server</server>'
      '  <database>Database</database>'
      '  <user>User</user>'
      '  <password>Password</password>'
      '</table>')
    Left = 32
    Top = 88
    DOMVendorDesc = 'MSXML'
  end
end
