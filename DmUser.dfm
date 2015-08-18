inherited DmoUser: TDmoUser
  OldCreateOrder = True
  Height = 186
  Width = 336
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
      '    <password type="string" length="30" vary="Y"/>'
      '    <unused type="string" length="1" vary="N"/>'
      '    <utype type="string" length="1" vary="N"/>'
      '</table>')
    Left = 128
    Top = 15
    DOMVendorDesc = 'MSXML'
  end
  object schemaUserLog: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '  <table name="NUTR_LOG">'
      '    <id type="string" length="10" pk="Y"/> '
      '    <fname type="string" length="30" vary="Y"/>'
      '    <lname type="string" length="50" vary="Y"/>'
      '    <aname type="string" length="100" vary="Y"/>'
      '    <gender type="string" length="1" vary="N"/>'
      '    <email type="string" length="30" vary="Y"/>'
      '    <login type="string" length="12" vary="Y"/>'
      '    <password type="string" length="30" vary="Y"/>'
      '    <unused type="string" length="1" vary="N"/>'
      '    <utype type="string" length="1" vary="N"/>'
      '</table>')
    Left = 224
    Top = 15
    DOMVendorDesc = 'MSXML'
  end
  object qryAuthen: TUniQuery
    Connection = DmoCnMain.cnDB
    Left = 128
    Top = 88
  end
  object qryUser: TUniQuery
    Connection = DmoCnMain.cnDB
    Left = 224
    Top = 88
  end
end
