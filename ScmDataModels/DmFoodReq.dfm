inherited DmoFoodReq: TDmoFoodReq
  OldCreateOrder = True
  Height = 457
  Width = 671
  inherited crDbObj: TSQLQuery
    Left = 128
  end
  object schemaFoodReq: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '  <table name="NUTR_FOOD_REQS">'
      #9'   <reqid type="string" length="5" pk="Y"/>'
      #9'   <hn type="string" length="7" vary="N"/>'
      #9'   <an type="string" length="7" vary="N"/>'
      #9'   <diag type="string" length="50" vary="Y"/>'
      #9'   <foodtypc type="string" length="8" vary="N"/>'
      #9'   <foodtype type="string" length="50" vary="Y"/>'
      #9'   <reqfr type="datetime"/>'
      #9'   <reqto type="datetime"/>'
      #9'   <mlfr type="string" length="10" vary="N"/>'
      #9'   <mlto type="string" length="10" vary="N"/>'
      #9'   <feed type ="string" length="10" vary="Y"/>'#9'   '
      #9'   <amountam type ="integer" length="1"/>'
      #9'   <amountpm type ="integer" length="1"/>'
      #9'   <wts type ="float"/>'
      #9'   <hts type ="float"/>'
      #9'   <printed type ="string" length="1" vary="N"/>'
      #9'   <saltwt type = "float"/>'
      '  </table>')
    Left = 128
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
  object qryFoodReq: TSQLQuery
    Params = <>
    Left = 496
    Top = 80
  end
  object schemaPatient: TXMLDocument
    Tag = 1
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
    Tag = 1
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '  <table name="NUTR_PATN_ADMT">'
      #9'   <hn type="string" length="7" pk="Y"/>'
      #9'   <an type="string" length="7" vary="N"/>'
      #9'   <wardid type="string" length="3" vary="N"/>'
      #9'   <wardname type="string" length="20" vary="Y"/>'
      #9'   <admitdate type="datetime"/>'
      #9'   <dischdate type="datetime"/>'
      #9'   <roomno type="string" length="5" vary="N"/>'
      #9'   <bedno type="string" length="10" vary="N"/>'
      '  </table>')
    Left = 312
    Top = 18
    DOMVendorDesc = 'MSXML'
  end
  object qryHcDatByParam: TSQLQuery
    Params = <>
    SQL.Strings = (
      'SELECT'
      '     --PATIENT'
      '     p.hn               AS HN,'
      '     s.CardID           AS PID,'
      #9'   RTRIM(t.titleName) AS TNAME,'
      #9'   RTRIM(p.firstName) AS FNAME,'
      #9'   RTRIM(p.lastName)  AS LNAME,'
      #9'   CASE WHEN p.sex = '#39#3594#39' THEN '#39'M'#39' ELSE '#39'F'#39' END AS GENDER,'
      #9'   CASE WHEN (p.birthDay = null)'
      #9'        THEN '#39'24000101'#39
      
        #9'        ELSE CASE WHEN (SUBSTRING(p.birthDay,5,2)='#39'00'#39')OR(SUBST' +
        'RING(p.birthDay,7,2)='#39'00'#39')'
      #9#9#9'              THEN SUBSTRING(p.birthDay,1,4)+'#39'0101'#39
      #9#9#9#9'            ELSE p.birthDay'
      #9#9#9#9'       END'
      '     END AS BIRTH,'
      '     --ADMISSIION'
      #9'   ih.ladmit_n        AS AN,'
      #9'   ih.ward_id         AS WARDID,'
      #9'   w.ward_name        AS WARDNAME,'
      
        #9'   ISNULL(ih.admit_date,'#39#39')+ISNULL(admit_time,'#39#39')             A' +
        'S ADMITDATE,'
      
        #9'   ISNULL(ih.discharge_date,'#39#39')+ISNULL(ih.discharge_time,'#39#39')  A' +
        'S DISCHDATE,'
      '     --VITALSIGN'
      #9'   ISNULL(v.[Weight],0) AS WTS,'
      '     ISNULL(v.Height,0)   AS HTS,'
      '     --ROOM'
      '     ih.current_room AS ROOMNO,'
      '     ih.bed_no       AS BEDNO,'
      '     --CONCAT'
      '     RTRIM(t.titleName)+p.firstName+'#39' '#39'+p.lastName as PATNAME,'
      #9'   g.REGCODE, g.REGDES,'
      #9'   ih.regist_flag'
      'FROM Ipd_h ih'
      'LEFT JOIN Ward w ON w.ward_id = ih.ward_id'
      'LEFT JOIN PATIENT p ON p.hn = ih.hn'
      'LEFT JOIN PatSS s on s.hn = ih.hn'
      'LEFT JOIN PTITLE t ON t.titleCode = p.titleCode'
      'LEFT JOIN (SELECT TOP 1 hn, RegNo, [Weight], Height, VitalSignNo'
      '           FROM VitalSign'
      '           ORDER BY VitalSignNo DESC) v ON v.hn = ih.hn'
      
        '                                       AND v.RegNo = ih.regist_f' +
        'lag'
      'LEFT JOIN Room r ON r.room_no = ih.current_room'
      'LEFT JOIN Religion g on g.REGCODE = p.religion'
      'WHERE ISNULL(ih.discharge_date,'#39#39') = '#39#39
      'AND '
      '('
      ' ((p.firstName LIKE :TXT)AND(1=:SEL))OR'
      ' ((p.hn LIKE :TXT)AND(2=:SEL))OR'
      ' ((w.ward_name LIKE :TXT)AND(3=:SEL))'
      ')')
    Left = 224
    Top = 80
  end
  object qryAdmit: TSQLQuery
    Params = <>
    Left = 312
    Top = 80
  end
  object qryGetHcDat: TSQLQuery
    Params = <>
    Left = 40
    Top = 144
  end
  object qryFoodTypeList: TSQLQuery
    Params = <>
    Left = 40
    Top = 216
  end
  object qryDiagList: TSQLQuery
    Params = <>
    Left = 128
    Top = 216
  end
  object qryPatAdm: TSQLQuery
    Params = <>
    Left = 224
    Top = 216
  end
  object qryChkPat: TSQLQuery
    Params = <>
    Left = 312
    Top = 216
  end
  object qryChkAdmit: TSQLQuery
    Params = <>
    Left = 40
    Top = 296
  end
  object schemaPatAdm: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '  <table name="NUTR_PADM">'
      #9'   <hn type="string" length="7" pk="Y"/>'
      #9'   <pid type="string" length="13" vary="N"/>'
      #9'   <tname type="string" length="20" vary="Y"/>'
      #9'   <fname type="string" length="50" vary="Y"/>'
      #9'   <lname type="string" length="50" vary="Y"/>'
      #9'   <gender type="string" length="1" vary="N"/>'
      #9'   <birth type="datetime"/>'
      #9'   <an type="string" length="7" vary="N"/>'
      #9'   <wardid type="string" length="3" vary="N"/>'
      #9'   <wardname type="string" length="20" vary="Y"/>'
      #9'   <admitdate type="datetime"/>'
      #9'   <dischdate type="datetime"/>'
      #9'   <roomno type="string" length="5" vary="N"/>'
      #9'   <bedno type="string" length="10" vary="N"/>'
      '  </table>')
    Left = 393
    Top = 18
    DOMVendorDesc = 'MSXML'
  end
  object qryHcDatByFormat: TSQLQuery
    Params = <>
    SQL.Strings = (
      'SELECT'
      '     --PATIENT'
      '     p.hn               AS HN,'
      '     s.CardID           AS PID,'
      #9'   RTRIM(t.titleName) AS TNAME,'
      #9'   RTRIM(p.firstName) AS FNAME,'
      #9'   RTRIM(p.lastName)  AS LNAME,'
      #9'   CASE WHEN p.sex = '#39#3594#39' THEN '#39'M'#39' ELSE '#39'F'#39' END AS GENDER,'
      #9'   CASE WHEN (p.birthDay = null)'
      #9'        THEN '#39'24000101'#39
      
        #9'        ELSE CASE WHEN (SUBSTRING(p.birthDay,5,2)='#39'00'#39')OR(SUBST' +
        'RING(p.birthDay,7,2)='#39'00'#39')'
      #9#9#9'              THEN SUBSTRING(p.birthDay,1,4)+'#39'0101'#39
      #9#9#9#9'            ELSE p.birthDay'
      #9#9#9#9'       END'
      '     END AS BIRTH,'
      '     --ADMISSIION'
      #9'   ih.ladmit_n        AS AN,'
      #9'   ih.ward_id         AS WARDID,'
      #9'   w.ward_name        AS WARDNAME,'
      
        #9'   ISNULL(ih.admit_date,'#39#39')+ISNULL(admit_time,'#39#39')             A' +
        'S ADMITDATE,'
      
        #9'   ISNULL(ih.discharge_date,'#39#39')+ISNULL(ih.discharge_time,'#39#39')  A' +
        'S DISCHDATE,'
      '     --VITALSIGN'
      #9'   ISNULL(v.[Weight],0) AS WTS,'
      '     ISNULL(v.Height,0)   AS HTS,'
      '     --ROOM'
      '     ih.current_room AS ROOMNO,'
      '     ih.bed_no       AS BEDNO,'
      '     --CONCAT'
      '     RTRIM(t.titleName)+p.firstName+'#39' '#39'+p.lastName as PATNAME,'
      #9'   g.REGCODE, g.REGDES,'
      #9'   ih.regist_flag'
      'FROM Ipd_h ih  (NOLOCK)'
      'LEFT JOIN Ward w (NOLOCK) ON w.ward_id = ih.ward_id'
      'LEFT JOIN PATIENT p (NOLOCK) ON p.hn = ih.hn'
      'LEFT JOIN PatSS s (NOLOCK) on s.hn = ih.hn'
      'LEFT JOIN PTITLE t (NOLOCK) ON t.titleCode = p.titleCode'
      'LEFT JOIN (SELECT TOP 1 hn, RegNo, [Weight], Height, VitalSignNo'
      '           FROM VitalSign (NOLOCK)'
      '           ORDER BY VitalSignNo DESC) v ON v.hn = ih.hn'
      
        '                                       AND v.RegNo = ih.regist_f' +
        'lag'
      'LEFT JOIN Room r (NOLOCK) ON r.room_no = ih.current_room'
      'LEFT JOIN Religion g (NOLOCK) on g.REGCODE = p.religion'
      'WHERE ISNULL(ih.discharge_date,'#39#39') = '#39#39
      'AND '
      '('
      ' ((p.firstName LIKE %S)AND(1=%S))OR'
      ' ((p.hn LIKE %S)AND(2=%S))OR'
      ' ((w.ward_name LIKE %S)AND(3=%S))'
      ')'
      'AND ih.ladmit_n NOT IN (%S)')
    Left = 128
    Top = 144
  end
  object qryFoodReqDet: TSQLQuery
    Params = <>
    Left = 400
    Top = 80
  end
  object qryHcDiag: TSQLQuery
    Params = <>
    SQL.Strings = (
      'SELECT'
      '  CODE AS ACODE, '
      ' [DES]  AS ADESC,'
      '  RTRIM(CODE)+'#39':'#39'+[DES] AS FULLDES'
      'FROM ICD101 (NOLOCK)'
      'WHERE CODE BETWEEN '#39'E110'#39' AND '#39'E119'#39
      'OR CODE = '#39'I10'#39
      'OR CODE BETWEEN '#39'E780'#39' AND '#39'E789'#39
      'OR CODE = '#39'N179'#39
      'OR CODE = '#39'N19'#39
      'OR CODE BETWEEN '#39'N181'#39' AND '#39'N185'#39
      'OR CODE BETWEEN '#39'M100'#39' AND '#39'M109'#39
      'OR CODE BETWEEN '#39'I20.0'#39' AND '#39'I25.9'#39
      'OR CODE LIKE '#39'C%'#39
      'OR CODE BETWEEN '#39'E660'#39' AND '#39'E669'#39
      'OR CODE BETWEEN '#39'I630'#39' AND '#39'I639'#39
      'OR CODE = '#39'I64'#39
      'UNION'
      'SELECT '
      '  '#39'ZZZZ'#39' AS ACODE,'
      '  '#39#3652#3617#3656#3619#3632#3610#3640#39' AS ADESC,'
      '  '#39'ZZZZ:'#3652#3617#3656#3619#3632#3610#3640#39' AS FULLDES')
    Left = 224
    Top = 144
  end
  object qryFoodProp: TSQLQuery
    Params = <>
    Left = 128
    Top = 295
  end
  object qryDiagHist: TSQLQuery
    Params = <>
    Left = 224
    Top = 295
  end
  object qryHcWard: TSQLQuery
    Params = <>
    SQL.Strings = (
      'select  rtrim(ward_id)+'#39': '#39'+rtrim(ward_name) as ward, *'
      'from Ward')
    Left = 312
    Top = 144
  end
  object qryMisc: TSQLQuery
    Params = <>
    Left = 312
    Top = 294
  end
  object qryFactInGroup: TSQLQuery
    Params = <>
    Left = 400
    Top = 142
  end
  object crProcChkDish: TSQLQuery
    Params = <>
    SQL.Strings = (
      'CREATE PROCEDURE dbo.PROC_CHKDISCH_TOENDREQ'
      'AS'
      'BEGIN'
      'UPDATE NUTR_FOOD_REQS'
      'SET REQEND     = '#39'Y'#39', '
      '    REQENDDATE = GETDATE(),'
      #9'  REQENDTYPE = '#39#39
      'FROM NUTR_FOOD_REQS R'
      'WHERE ISNULL(R.REQEND,'#39#39') = '#39#39
      'AND ISNULL(R.REQENDTYPE,'#39#39')= '#39#39
      'AND EXISTS (SELECT 1 '
      '            FROM DEVHC.dbo.Ipd_h '
      '            WHERE (ISNULL(discharge_date,'#39#39') <> '#39#39')'
      #9#9#9'      AND ladmit_n = R.AN)'
      'END')
    Left = 40
    Top = 368
  end
end
