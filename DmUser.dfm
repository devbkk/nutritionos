object DmoUser: TDmoUser
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object schemaUser: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '  <table name="NUTR_USER">'
      '    <id type="string" length="10" pk="Y"/> '
      '    <fname type="string" length="30" vary="Y"/>'
      '    <lname type="string" length="50" vary="Y"/>'
      '    <aname type="string" length="100" vary="Y"/>'
      '    <gender type="string" length="1" vary="N"/>'
      '    <email type="string" length="30" vary="Y"/>'
      '    <login type="string" length="12" vary="Y"/>'
      #9'<password type="string" length="30" vary="Y"/>'
      '</table>')
    Left = 40
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
  object qryAuthen: TSQLQuery
    Params = <>
    Left = 40
    Top = 80
  end
  object qryUser: TSQLQuery
    Params = <>
    Left = 136
    Top = 80
  end
end
