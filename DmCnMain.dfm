object DmoCnMain: TDmoCnMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 242
  Width = 259
  object cnParams: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '<database>'
      '  <server>X</server>'
      '  <name>X</name>'
      '  <user>X</user>'
      '  <password>X</password>'
      '  <demo>Y</demo>'
      '</database>')
    Left = 32
    Top = 32
    DOMVendorDesc = 'MSXML'
  end
  object schemaCtrl: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '  <table name="NUTR_CTRL">'
      '       <id type="string" length="3" pk="Y"/>'
      '       <des type="string" length="50" vary="Y"/>'
      '       <runno type="integer"/>'
      '  </table>')
    Left = 112
    Top = 34
    DOMVendorDesc = 'MSXML'
  end
  object cnDB: TSQLConnection
    Left = 32
    Top = 96
  end
end
