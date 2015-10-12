inherited DmoFood: TDmoFood
  OldCreateOrder = True
  object schemaFood: TXMLDocument
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
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
end
