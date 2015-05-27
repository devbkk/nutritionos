object DmoFact: TDmoFact
  OldCreateOrder = False
  Height = 150
  Width = 215
  object schemaFact: TXMLDocument
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
      '    <password type="string" length="12" vary="Y"/>'
      '</table>')
    Left = 40
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
end
