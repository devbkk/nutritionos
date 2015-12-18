inherited DmoFoodReq: TDmoFoodReq
  OldCreateOrder = True
  Height = 206
  Width = 425
  object schemaFoodReq: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '  <table name="NUTR_FOOD_REQS">'
      #9'   <reqid type="string" length="20" pk="Y"/>'
      #9'   <hn type="string" length="7" vary="N"/>'
      #9'   <an type="string" length="7" vary="N"/>'
      #9'   <diag type="string" length="50" vary="Y"/>'
      #9'   <foodtype type="string" length="50" vary="Y"/>'
      #9'   <reqfr type="datetime"/>'
      #9'   <reqto type="datetime"/>'
      #9'   <mlfr type="string" length="10" vary="N"/>'
      #9'   <mlto type="string" length="10" vary="N"/>'
      #9'   <amountam type ="integer" length="1"/>'
      #9'   <amountpm type ="integer" length="1"/>'
      '  </table>')
    Left = 128
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
  object qryFoodReq: TSQLQuery
    Params = <>
    Left = 128
    Top = 80
  end
  object schemaPatient: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '  <table name="NUTR_PATN">'
      #9'   <hn type="string" length="7" pk="Y"/>'
      #9'   <pid type="string" length="13" vary="N"/>'
      #9'   <tname type="string" length="20" vary="Y"/>'
      #9'   <fname type="string" length="50" vary="Y"/>'
      #9'   <lname type="string" length="50" vary="Y"/>'
      #9'   <gender type="string" length="1" vary="N"/>'
      #9'   <birth type="datetime"/>'
      '  </table>')
    Left = 224
    Top = 18
    DOMVendorDesc = 'MSXML'
  end
  object schemaAdmit: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '  <table name="NUTR_PATN_ADMT">'
      #9'   <hn type="string" length="7" pk="Y"/>'
      #9'   <an type="string" length="7" vary="N"/>'
      #9'   <wardid type="string" length="3" vary="N"/>'
      #9'   <wardname type="string" length="20" vary="Y"/>'
      #9'   <admitdate type="datetime"/>'
      #9'   <dischdate type="datetime"/>'
      '  </table>')
    Left = 312
    Top = 18
    DOMVendorDesc = 'MSXML'
  end
  object qryPatient: TSQLQuery
    Params = <>
    Left = 224
    Top = 80
  end
  object qryAdmit: TSQLQuery
    Params = <>
    Left = 312
    Top = 80
  end
end
