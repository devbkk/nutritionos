inherited DmoSysLog: TDmoSysLog
  OldCreateOrder = True
  Width = 286
  object schemaLog: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      ' <table name="NUTR_SLOG">'
      '   <logid type="integer" length="3" pk="Y" identity="Y"/>'
      '   <logds type="string" length="50" vary="Y"/>'
      '   <logty type="string" length="10" vary="Y"/>'
      '   <logdt type="datetime" length="100" vary="Y"/>'
      '</table>')
    Left = 128
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
  object qryLogTyp: TSQLQuery
    Params = <>
    Left = 128
    Top = 80
  end
  object qrySysLog: TSQLQuery
    Params = <>
    Left = 216
    Top = 80
  end
end
