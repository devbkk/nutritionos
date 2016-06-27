inherited DmoFoodRep: TDmoFoodRep
  OldCreateOrder = True
  Height = 430
  Width = 468
  object qryFoodRep: TSQLQuery
    Params = <>
    Left = 114
    Top = 80
  end
  object dspFoodReq: TDataSetProvider
    Left = 114
    Top = 208
  end
  object cdsRep: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'PATNAME'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'HTS'
        DataType = ftFloat
      end
      item
        Name = 'WTS'
        DataType = ftFloat
      end
      item
        Name = 'DIAG'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'FOODTYPE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'AMOUNTAM'
        DataType = ftInteger
      end
      item
        Name = 'AMOUNTPM'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 40
    Top = 208
    Data = {
      A60000009619E0BD010000001800000007000000000003000000A60007504154
      4E414D4501004900000001000557494454480200020046000348545308000400
      0000000003575453080004000000000004444941470100490000000100055749
      44544802000200320008464F4F44545950450100490000000100055749445448
      02000200320008414D4F554E54414D040001000000000008414D4F554E54504D
      04000100000000000000}
  end
  object rep: TfrxReport
    Version = '5.1.9'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42247.754535127300000000
    ReportOptions.LastChange = 42362.794189571800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 40
    Top = 152
    Datasets = <
      item
        DataSet = rds
        DataSetName = 'dat'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 132.283550000000000000
        Width = 718.110700000000000000
        DataSet = rds
        DataSetName = 'dat'
        RowCount = 0
        object Memo2: TfrxMemoView
          Left = 11.338590000000000000
          Top = 1.118120000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DataField = 'PATNAME'
          DataSet = rds
          DataSetName = 'dat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[dat."PATNAME"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 132.283550000000000000
          Top = 1.118120000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDBDataset1."HTS"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 238.110390000000000000
          Top = 1.118120000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDBDataset1."WTS"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 351.496290000000000000
          Top = 1.118120000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDBDataset1."FOODTYPE"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 464.882190000000000000
          Top = 1.118120000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDBDataset1."AMOUNTAM"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 570.709030000000000000
          Top = 1.118120000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDBDataset1."AMOUNTPM"]')
          ParentFont = False
        end
      end
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
      end
      object Memo1: TfrxMemoView
        Left = 173.858380000000000000
        Top = 15.118120000000000000
        Width = 332.598640000000000000
        Height = 41.574830000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Tahoma'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8 = (
          #3648#3609#131#3648#3608#154#3648#3609#8364#3648#3608#154#3648#3608#3604#3648#3608#129#3648#3608#3597#3648#3608#3602#3648#3608#3595#3648#3608#3602#3648#3608#3587#3648#3608#3595#3648#3608#3597#3648#3608#156#3648#3608#3609#3648#3609#137#3648#3608#155#3648#3609#136#3648#3608#3591#3648#3608#3586)
        ParentFont = False
      end
    end
  end
  object rds: TfrxDBDataset
    UserName = 'dat'
    CloseDataSource = False
    DataSet = cdsRep
    BCDToCurrency = False
    Left = 114
    Top = 152
  end
  object qryFeedCol: TSQLQuery
    Params = <>
    Left = 194
    Top = 80
  end
  object cdsC19_1: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'C01'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'C02'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C03'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C04'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C05'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C06'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C07'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C08'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C09'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C10'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C11'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C12'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C13'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C14'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C15'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C16'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C17'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C18'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C19'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 346
    Top = 152
    Data = {
      E20100009619E0BD010000001800000013000000000003000000E20103433031
      0100490000000100055749445448020002001400034330320100490000000100
      055749445448020002000A000343303301004900000001000557494454480200
      02000A00034330340100490000000100055749445448020002000A0003433035
      0100490000000100055749445448020002000A00034330360100490000000100
      055749445448020002000A000343303701004900000001000557494454480200
      02000A00034330380100490000000100055749445448020002000A0003433039
      0100490000000100055749445448020002000A00034331300100490000000100
      055749445448020002000A000343313101004900000001000557494454480200
      02000A00034331320100490000000100055749445448020002000A0003433133
      0100490000000100055749445448020002000A00034331340100490000000100
      055749445448020002000A000343313501004900000001000557494454480200
      02000A00034331360100490000000100055749445448020002000A0003433137
      0100490000000100055749445448020002000A00034331380100490000000100
      055749445448020002000A000343313901004900000001000557494454480200
      02000A000000}
  end
  object rdsC19_1: TfrxDBDataset
    UserName = 'datC19_1'
    CloseDataSource = False
    DataSet = cdsC19_1
    BCDToCurrency = False
    Left = 274
    Top = 152
  end
  object qryFeedRowHead: TSQLQuery
    Params = <>
    Left = 274
    Top = 80
  end
  object qryFeedTot: TSQLQuery
    Params = <>
    Left = 354
    Top = 80
  end
  object repC19: TfrxReport
    Version = '5.1.9'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42404.777976516200000000
    ReportOptions.LastChange = 42413.262574722220000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnGetValue = repC19GetValue
    Left = 200
    Top = 152
    Datasets = <
      item
        DataSet = rdsC19_1
        DataSetName = 'datC19_1'
      end
      item
        DataSet = rdsC19_2
        DataSetName = 'datC19_2'
      end>
    Variables = <
      item
        Name = ' Feed Variables'
        Value = Null
      end
      item
        Name = 'CurDate'
        Value = ''
      end
      item
        Name = 'Meal'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object pgMain: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object msdFeed1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Height = 18.897637800000000000
        ParentFont = False
        Top = 117.165430000000000000
        Width = 1046.929810000000000000
        DataSet = rdsC19_1
        DataSetName = 'datC19_1'
        RowCount = 0
        object datC19C01: TfrxMemoView
          Left = 6.559060000000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          DataField = 'C01'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C01"]')
          ParentFont = False
        end
        object datC19C02: TfrxMemoView
          Left = 153.756030000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C02'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C02"]')
          ParentFont = False
        end
        object datC19C03: TfrxMemoView
          Left = 202.551330000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C03'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C03"]')
          ParentFont = False
        end
        object datC19C04: TfrxMemoView
          Left = 251.567100000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C04'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C04"]')
          ParentFont = False
        end
        object datC19C05: TfrxMemoView
          Left = 300.700990000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C05'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C05"]')
          ParentFont = False
        end
        object datC19C06: TfrxMemoView
          Left = 349.834880000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C06'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C06"]')
          ParentFont = False
        end
        object datC19C07: TfrxMemoView
          Left = 398.968770000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C07'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C07"]')
          ParentFont = False
        end
        object datC19C08: TfrxMemoView
          Left = 448.102660000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C08'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C08"]')
          ParentFont = False
        end
        object datC19C09: TfrxMemoView
          Left = 497.236550000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C09'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C09"]')
          ParentFont = False
        end
        object datC19C10: TfrxMemoView
          Left = 546.370440000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C10'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C10"]')
          ParentFont = False
        end
        object datC19C11: TfrxMemoView
          Left = 595.504330000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C11'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C11"]')
          ParentFont = False
        end
        object datC19C12: TfrxMemoView
          Left = 644.638220000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C12'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C12"]')
          ParentFont = False
        end
        object datC19C13: TfrxMemoView
          Left = 693.772110000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C13'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C13"]')
          ParentFont = False
        end
        object datC19C14: TfrxMemoView
          Left = 742.906000000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C14'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C14"]')
          ParentFont = False
        end
        object datC19C15: TfrxMemoView
          Left = 792.039890000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C15'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C15"]')
          ParentFont = False
        end
        object datC19C16: TfrxMemoView
          Left = 841.173780000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C16'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C16"]')
          ParentFont = False
        end
        object datC19C17: TfrxMemoView
          Left = 890.307670000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C17'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C17"]')
          ParentFont = False
        end
        object datC19C18: TfrxMemoView
          Left = 939.441560000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C18'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C18"]')
          ParentFont = False
        end
        object datC19C19: TfrxMemoView
          Left = 988.575450000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataField = 'C19'
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_1."C19"]')
          ParentFont = False
        end
      end
      object hdFeed1: TfrxHeader
        FillType = ftBrush
        Height = 75.414022110000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object hDate: TfrxMemoView
          Align = baCenter
          Left = 331.220780000000000000
          Top = 5.102350000000000000
          Width = 384.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[CurDate]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 405.168148420000000000
          Top = 36.365507890000000000
          Width = 236.593513160000000000
          Height = 24.160807890000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            
              #3648#3608#3597#3648#3608#3602#3648#3608#3595#3648#3608#3602#3648#3608#3587#3648#3608#3594#3648#3608#3602#3648#3608#3586#3648#3608#3586#3648#3608#3602#3648#3608#135#3648#3608#3594#3648#3608#3609#3648#3608#8226#3648#3608#3587#3648#3608#155#3648#3608#129#3648#3608#8226#3648#3608#3604'([Meal]' +
              ')')
          ParentFont = False
        end
      end
      object msdFeed2: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637795275590000
        Top = 257.008040000000000000
        Width = 1046.929810000000000000
        DataSet = rdsC19_2
        DataSetName = 'datC19_2'
        RowCount = 0
        object Memo3: TfrxMemoView
          Left = 7.000000000000000000
          Top = 0.991960000000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C01"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 154.196970000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C02"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 202.992270000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C03"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 252.008040000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C04"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 301.141930000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C05"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 350.275820000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C06"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 399.409710000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C07"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 448.543600000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C08"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 497.677490000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C09"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 546.811380000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C10"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 595.945270000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C11"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 645.079160000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C12"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 694.213050000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C13"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 743.346940000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C14"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 792.480830000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C15"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 841.614720000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C16"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 890.748610000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C17"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 939.882500000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C18"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 989.016390000000000000
          Top = 0.991960000000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = rdsC19_1
          DataSetName = 'datC19_1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[datC19_2."C19"]')
          ParentFont = False
        end
      end
      object hdFeed2: TfrxHeader
        FillType = ftBrush
        Height = 76.677180000000000000
        Top = 158.740260000000000000
        Width = 1046.929810000000000000
        object Memo2: TfrxMemoView
          Align = baCenter
          Left = 388.720780000000000000
          Top = 30.259740000000000000
          Width = 269.488250000000000000
          Height = 24.160807890000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            
              #3648#3608#3597#3648#3608#3602#3648#3608#3595#3648#3608#3602#3648#3608#3587#3648#3608#3594#3648#3608#3602#3648#3608#3586#3648#3608#3586#3648#3608#3602#3648#3608#135#3648#3608#3594#3648#3608#3609#3648#3608#8226#3648#3608#3587#3648#3609#8364#3648#3608#154#3648#3608#3602#3648#3608#3595#3648#3608#3591#3648#3608#3602#3648 +
              #3608#153'([Meal])')
          ParentFont = False
        end
      end
    end
  end
  object rdsC19_2: TfrxDBDataset
    UserName = 'datC19_2'
    CloseDataSource = False
    DataSet = cdsC19_2
    BCDToCurrency = False
    Left = 274
    Top = 216
  end
  object cdsC19_2: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'C01'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'C02'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C03'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C04'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C05'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C06'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C07'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C08'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C09'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C10'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C11'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C12'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C13'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C14'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C15'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C16'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C17'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C18'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C19'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 346
    Top = 216
    Data = {
      E20100009619E0BD010000001800000013000000000003000000E20103433031
      0100490000000100055749445448020002001400034330320100490000000100
      055749445448020002000A000343303301004900000001000557494454480200
      02000A00034330340100490000000100055749445448020002000A0003433035
      0100490000000100055749445448020002000A00034330360100490000000100
      055749445448020002000A000343303701004900000001000557494454480200
      02000A00034330380100490000000100055749445448020002000A0003433039
      0100490000000100055749445448020002000A00034331300100490000000100
      055749445448020002000A000343313101004900000001000557494454480200
      02000A00034331320100490000000100055749445448020002000A0003433133
      0100490000000100055749445448020002000A00034331340100490000000100
      055749445448020002000A000343313501004900000001000557494454480200
      02000A00034331360100490000000100055749445448020002000A0003433137
      0100490000000100055749445448020002000A00034331380100490000000100
      055749445448020002000A000343313901004900000001000557494454480200
      02000A000000}
  end
  object repFoodReq: TfrxReport
    Version = '5.1.9'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42450.823805983800000000
    ReportOptions.LastChange = 42450.869514398150000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 184
    Top = 280
    Datasets = <
      item
        DataSet = rdsFoodReq
        DataSetName = 'datFoodReq'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 105.677180000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 51.311225000000000000
          Top = 4.102350000000000000
          Width = 615.488250000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #3648#3608#3587#3648#3608#3602#3648#3608#3586#3648#3608#129#3648#3608#3602#3648#3608#3587#3648#3609#8364#3648#3608#154#3648#3608#3604#3648#3608#129#3648#3608#3597#3648#3608#3602#3648#3608#3595#3648#3608#3602#3648#3608#3587#3648#3608#156#3648#3608#3609#3648#3609#137#3648#3608#155#3648#3609#136#3648#3608#3591#3648 +
              #3608#3586#3648#3609#131#3648#3608#153' '#3648#3609#130#3648#3608#3587#3648#3608#135#3648#3608#158#3648#3608#3586#3648#3608#3602#3648#3608#154#3648#3608#3602#3648#3608#3589#3648#3608#158#3648#3608#3587#3648#3608#3600#3648#3608#153#3648#3608#132#3648#3608#3587#3648#3608#3592#3648#3608#3587#3648#3608#3605#3648 +
              #3608#3597#3648#3608#3586#3648#3608#3608#3648#3608#152#3648#3608#3586#3648#3608#3602' '#3648#3608#136#3648#3608#3601#3648#3608#135#3648#3608#3595#3648#3608#3591#3648#3608#3601#3648#3608#8221#3648#3608#158#3648#3608#3587#3648#3608#3600#3648#3608#153#3648#3608#132#3648#3608#3587#3648#3608#3592#3648#3608#3587#3648 +
              #3608#3605#3648#3608#3597#3648#3608#3586#3648#3608#3608#3648#3608#152#3648#3608#3586#3648#3608#3602)
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baCenter
          Left = 158.811225000000000000
          Top = 39.102350000000000000
          Width = 400.488250000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            
              #3648#3608#138#3648#3608#3607#3648#3609#136#3648#3608#3597#3648#3608#8226#3648#3608#3606#3648#3608#129' '#3648#3608#3597#3648#3608#3602#3648#3608#3586#3648#3608#3608#3648#3608#3587#3648#3608#129#3648#3608#3587#3648#3608#3587#3648#3608#3585#3648#3608#138#3648#3608#3602#3648#3608#3586'   '#3648#3608#155 +
              #3648#3608#3587#3648#3608#3600#3648#3609#8364#3648#3608#160#3648#3608#8212#3648#3608#3585#3648#3608#3607#3648#3609#137#3648#3608#3597' '#3648#3609#8364#3648#3608#8212#3648#3608#3605#3648#3609#136#3648#3608#3586#3648#3608#135)
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baCenter
          Left = 160.811225000000000000
          Top = 70.102350000000000000
          Width = 396.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            
              #3648#3608#155#3648#3608#3587#3648#3608#3600#3648#3608#136#3648#3608#3603#3648#3608#3591#3648#3608#3601#3648#3608#153#3648#3608#8212#3648#3608#3605#3648#3609#136' 22 '#3648#3609#8364#3648#3608#8221#3648#3608#3607#3648#3608#3597#3648#3608#153' '#3648#3608#3585#3648#3608#3605#3648#3608#153#3648#3608 +
              #3602#3648#3608#132#3648#3608#3585' '#3648#3608#158'.'#3648#3608#3592'. 2559')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 147.401670000000000000
        Width = 718.110700000000000000
        object Memo4: TfrxMemoView
          Align = baLeft
          Top = 1.840540470000000000
          Width = 49.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#3589#3648#3608#3603#3648#3608#8221#3648#3608#3601#3648#3608#154)
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Left = 49.488250000000000000
          Top = 1.709699350000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#3595#3648#3609#137#3648#3608#3597#3648#3608#135'/'#3648#3609#8364#3648#3608#8226#3648#3608#3605#3648#3608#3586#3648#3608#135)
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Left = 251.548862150000000000
          Top = 1.840540470000000000
          Width = 143.086380840000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#3597#3648#3608#3602#3648#3608#3595#3648#3608#3602#3648#3608#3587)
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Align = baLeft
          Left = 394.635242990000000000
          Top = 1.840540470000000000
          Width = 43.086380840000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#136#3648#3608#3603#3648#3608#153#3648#3608#3591#3648#3608#153)
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Left = 143.976500000000000000
          Top = 1.840540460000000000
          Width = 107.572362150000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#138#3648#3608#3607#3648#3609#136#3648#3608#3597'-'#3648#3608#3594#3648#3608#129#3648#3608#3608#3648#3608#3589)
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Align = baLeft
          Left = 437.721623830000000000
          Top = 2.000199160000000000
          Width = 32.806007010000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#3597#3648#3608#3602#3648#3608#3586#3648#3608#3608)
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Align = baLeft
          Left = 470.527630840000000000
          Top = 2.065619720000000000
          Width = 48.693857470000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#153#3648#3609#137#3648#3608#3603#3648#3608#3595#3648#3608#153#3648#3608#3601#3648#3608#129)
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baLeft
          Left = 519.221488310000000000
          Top = 2.065619720000000000
          Width = 54.301334110000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#3594#3648#3609#136#3648#3608#3591#3648#3608#153#3648#3608#3594#3648#3608#3609#3648#3608#135)
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Align = baLeft
          Left = 573.522822420000000000
          Top = 2.131040280000000000
          Width = 128.133109810000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3609#130#3648#3608#3587#3648#3608#132)
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 275.905690000000000000
        Width = 718.110700000000000000
        DataSet = rdsFoodReq
        DataSetName = 'datFoodReq'
        RowCount = 0
        object datFoodReqNO: TfrxMemoView
          Align = baLeft
          Top = 3.093529810000000000
          Width = 49.511811020000000000
          Height = 18.897650000000000000
          DataField = 'NO'
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '[datFoodReq."NO"]')
          ParentFont = False
        end
        object datFoodReqBED: TfrxMemoView
          Align = baLeft
          Left = 49.511811020000000000
          Top = 3.028109250000000000
          Width = 94.488188980000000000
          Height = 18.897650000000000000
          DataField = 'BED'
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '[datFoodReq."BED"]')
          ParentFont = False
        end
        object datFoodReqPATNAME: TfrxMemoView
          Align = baLeft
          Left = 144.000000000000000000
          Top = 3.962688690000000000
          Width = 107.716535430000000000
          Height = 18.897650000000000000
          DataField = 'PATNAME'
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '[datFoodReq."PATNAME"]')
          ParentFont = False
        end
        object datFoodReqFOOD: TfrxMemoView
          Align = baLeft
          Left = 251.716535430000000000
          Top = 3.962688690000000000
          Width = 143.244094490000000000
          Height = 18.897650000000000000
          DataField = 'FOOD'
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '[datFoodReq."FOOD"]')
          ParentFont = False
        end
        object datFoodReqAMOUNT: TfrxMemoView
          Align = baLeft
          Left = 394.960629920000000000
          Top = 3.028109250000000000
          Width = 43.086614170000000000
          Height = 18.897650000000000000
          DataField = 'AMOUNT'
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '[datFoodReq."AMOUNT"]')
          ParentFont = False
        end
        object datFoodReqAGE: TfrxMemoView
          Align = baLeft
          Left = 438.047244090000000000
          Top = 2.598982900000000000
          Width = 32.881889760000000000
          Height = 18.897650000000000000
          DataField = 'AGE'
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Memo.UTF8 = (
            '[datFoodReq."AGE"]')
        end
        object datFoodReqWID: TfrxMemoView
          Align = baLeft
          Left = 470.929133850000000000
          Top = 2.598982900000000000
          Width = 48.755905510000000000
          Height = 18.897650000000000000
          DataField = 'WID'
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Memo.UTF8 = (
            '[datFoodReq."WID"]')
        end
        object datFoodReqHIGH: TfrxMemoView
          Align = baLeft
          Left = 519.685039360000000000
          Top = 2.598982900000000000
          Width = 54.425196850000000000
          Height = 18.897650000000000000
          DataField = 'HIGH'
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Memo.UTF8 = (
            '[datFoodReq."HIGH"]')
        end
        object datFoodReqDIESEASE: TfrxMemoView
          Align = baLeft
          Left = 574.110236210000000000
          Top = 2.598982900000000000
          Width = 128.125984250000000000
          Height = 18.897650000000000000
          DataField = 'DIESEASE'
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Memo.UTF8 = (
            '[datFoodReq."DIESEASE"]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 230.551330000000000000
        Width = 718.110700000000000000
        Condition = 'datFoodReq."WARD"'
        object datFoodReqWARD: TfrxMemoView
          Align = baLeft
          Top = 1.224370930000000000
          Width = 187.712222620000000000
          Height = 18.897650000000000000
          DataField = 'WARD'
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '[datFoodReq."WARD"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 321.260050000000000000
        Width = 718.110700000000000000
      end
      object Memo13: TfrxMemoView
        Left = 358.878504670000000000
        Top = 319.626168220000000000
        Width = 94.488250000000000000
        Height = 18.897650000000000000
        Memo.UTF8 = (
          '[COUNT(<datFoodReq."NO">,0)]')
      end
    end
  end
  object rdsFoodReq: TfrxDBDataset
    UserName = 'datFoodReq'
    CloseDataSource = False
    DataSet = cdsFoodReq
    BCDToCurrency = False
    Left = 112
    Top = 280
  end
  object cdsFoodReq: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'NO'
        DataType = ftInteger
      end
      item
        Name = 'BED'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PATNAME'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'FOOD'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AMOUNT'
        DataType = ftInteger
      end
      item
        Name = 'NOTE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'WARD'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AGE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'WID'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'HIGH'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DIESEASE'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 40
    Top = 281
    Data = {
      190100009619E0BD01000000180000000B0000000000030000001901024E4F04
      0001000000000003424544010049000000010005574944544802000200140007
      5041544E414D45010049000000010005574944544802000200320004464F4F44
      010049000000010005574944544802000200140006414D4F554E540400010000
      000000044E4F5445010049000000010005574944544802000200640004574152
      4401004900000001000557494454480200020014000341474501004900000001
      0005574944544802000200140003574944010049000000010005574944544802
      0002001400044849474801004900000001000557494454480200020014000844
      4945534541534501004900000001000557494454480200020014000000}
  end
  object cdsRep1: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'REQID'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'HN'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'MEALORD'
        DataType = ftInteger
      end
      item
        Name = 'FOODREQDESC'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'REQDATE'
        DataType = ftDateTime
      end
      item
        Name = 'HTS'
        DataType = ftFloat
      end
      item
        Name = 'WTS'
        DataType = ftFloat
      end
      item
        Name = 'TNAME'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'FNAME'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'LNAME'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'AGE'
        DataType = ftInteger
      end
      item
        Name = 'WARDID'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'WARDNAME'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ROOMNO'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'BEDNO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'FGRC'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'FGRP'
        DataType = ftString
        Size = 30
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 40
    Top = 352
    Data = {
      9C0100009619E0BD0100000018000000110000000000030000009C0105524551
      4944010049000000010005574944544802000200050002484E01004900000001
      00055749445448020002000700074D45414C4F524404000100000000000B464F
      4F44524551444553430100490000000100055749445448020002006400075245
      5144415445080008000000000003485453080004000000000003575453080004
      000000000005544E414D45010049000000010005574944544802000200140005
      464E414D450100490000000100055749445448020002003200054C4E414D4501
      0049000000010005574944544802000200320003414745040001000000000006
      574152444944010049000000010005574944544802000200030008574152444E
      414D45010049000000010005574944544802000200140006524F4F4D4E4F0100
      490000000100055749445448020002000500054245444E4F0100490000000100
      055749445448020002000A000446475243010049000000010005574944544802
      000200080004464752500100490000000100055749445448020002001E000000}
  end
  object rdsRep1: TfrxDBDataset
    UserName = 'datRep1'
    CloseDataSource = False
    DataSet = cdsRep1
    BCDToCurrency = False
    Left = 112
    Top = 352
  end
  object rdgRep1: TfrxReport
    Version = '5.1.9'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42450.823805983800000000
    ReportOptions.LastChange = 42547.675485266210000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 184
    Top = 352
    Datasets = <
      item
        DataSet = rdsRep1
        DataSetName = 'datRep1'
      end>
    Variables = <
      item
        Name = ' Report1'
        Value = Null
      end
      item
        Name = 'DATESTR'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 105.677180000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 51.311225000000000000
          Top = 4.102350000000000000
          Width = 615.488250000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #3648#3608#3587#3648#3608#3602#3648#3608#3586#3648#3608#129#3648#3608#3602#3648#3608#3587#3648#3609#8364#3648#3608#154#3648#3608#3604#3648#3608#129#3648#3608#3597#3648#3608#3602#3648#3608#3595#3648#3608#3602#3648#3608#3587#3648#3608#156#3648#3608#3609#3648#3609#137#3648#3608#155#3648#3609#136#3648#3608#3591#3648 +
              #3608#3586#3648#3609#131#3648#3608#153' '#3648#3609#130#3648#3608#3587#3648#3608#135#3648#3608#158#3648#3608#3586#3648#3608#3602#3648#3608#154#3648#3608#3602#3648#3608#3589#3648#3608#158#3648#3608#3587#3648#3608#3600#3648#3608#153#3648#3608#132#3648#3608#3587#3648#3608#3592#3648#3608#3587#3648#3608#3605#3648 +
              #3608#3597#3648#3608#3586#3648#3608#3608#3648#3608#152#3648#3608#3586#3648#3608#3602' '#3648#3608#136#3648#3608#3601#3648#3608#135#3648#3608#3595#3648#3608#3591#3648#3608#3601#3648#3608#8221#3648#3608#158#3648#3608#3587#3648#3608#3600#3648#3608#153#3648#3608#132#3648#3608#3587#3648#3608#3592#3648#3608#3587#3648 +
              #3608#3605#3648#3608#3597#3648#3608#3586#3648#3608#3608#3648#3608#152#3648#3608#3586#3648#3608#3602)
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baCenter
          Left = 158.811225000000000000
          Top = 39.102350000000000000
          Width = 400.488250000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            
              #3648#3608#138#3648#3608#3607#3648#3609#136#3648#3608#3597#3648#3608#8226#3648#3608#3606#3648#3608#129' '#3648#3608#3597#3648#3608#3602#3648#3608#3586#3648#3608#3608#3648#3608#3587#3648#3608#129#3648#3608#3587#3648#3608#3587#3648#3608#3585#3648#3608#138#3648#3608#3602#3648#3608#3586'   '#3648#3608#155 +
              #3648#3608#3587#3648#3608#3600#3648#3609#8364#3648#3608#160#3648#3608#8212#3648#3608#3585#3648#3608#3607#3648#3609#137#3648#3608#3597' '#3648#3609#8364#3648#3608#8212#3648#3608#3605#3648#3609#136#3648#3608#3586#3648#3608#135)
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baCenter
          Left = 160.811225000000000000
          Top = 70.102350000000000000
          Width = 396.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            #3648#3608#155#3648#3608#3587#3648#3608#3600#3648#3608#136#3648#3608#3603#3648#3608#3591#3648#3608#3601#3648#3608#153#3648#3608#8212#3648#3608#3605#3648#3609#136' [DATESTR]')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 147.401670000000000000
        Width = 718.110700000000000000
        object Memo4: TfrxMemoView
          Align = baLeft
          Top = 1.840540470000000000
          Width = 49.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#3589#3648#3608#3603#3648#3608#8221#3648#3608#3601#3648#3608#154)
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Left = 49.488250000000000000
          Top = 1.709699350000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#3595#3648#3609#137#3648#3608#3597#3648#3608#135'/'#3648#3609#8364#3648#3608#8226#3648#3608#3605#3648#3608#3586#3648#3608#135)
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Left = 251.548862150000000000
          Top = 1.840540470000000000
          Width = 143.086380840000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#3597#3648#3608#3602#3648#3608#3595#3648#3608#3602#3648#3608#3587)
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Align = baLeft
          Left = 394.635242990000000000
          Top = 1.840540470000000000
          Width = 43.086380840000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#136#3648#3608#3603#3648#3608#153#3648#3608#3591#3648#3608#153)
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Left = 143.976500000000000000
          Top = 1.840540460000000000
          Width = 107.572362150000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#138#3648#3608#3607#3648#3609#136#3648#3608#3597'-'#3648#3608#3594#3648#3608#129#3648#3608#3608#3648#3608#3589)
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Align = baLeft
          Left = 437.721623830000000000
          Top = 2.000199160000000000
          Width = 32.806007010000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#3597#3648#3608#3602#3648#3608#3586#3648#3608#3608)
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Align = baLeft
          Left = 470.527630840000000000
          Top = 2.065619720000000000
          Width = 48.693857470000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#153#3648#3609#137#3648#3608#3603#3648#3608#3595#3648#3608#153#3648#3608#3601#3648#3608#129)
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baLeft
          Left = 519.221488310000000000
          Top = 2.065619720000000000
          Width = 54.301334110000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3608#3594#3648#3609#136#3648#3608#3591#3648#3608#153#3648#3608#3594#3648#3608#3609#3648#3608#135)
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Align = baLeft
          Left = 573.522822420000000000
          Top = 2.131040280000000000
          Width = 128.133109810000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8 = (
            #3648#3609#130#3648#3608#3587#3648#3608#132)
          ParentFont = False
        end
      end
      object mdMain: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 230.551330000000000000
        Width = 718.110700000000000000
        DataSet = rdsRep1
        DataSetName = 'datRep1'
        RowCount = 0
        object datFoodReqNO: TfrxMemoView
          Align = baLeft
          Top = 3.093529810000000000
          Width = 49.511811020000000000
          Height = 18.897650000000000000
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '1')
          ParentFont = False
        end
        object datFoodReqBED: TfrxMemoView
          Align = baLeft
          Left = 49.511811020000000000
          Top = 3.028109250000000000
          Width = 94.488188980000000000
          Height = 18.897650000000000000
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '[datRep1."ROOMNO"]/[datRep1."BEDNO"]')
          ParentFont = False
        end
        object datFoodReqPATNAME: TfrxMemoView
          Align = baLeft
          Left = 144.000000000000000000
          Top = 3.962688690000000000
          Width = 107.716535430000000000
          Height = 18.897650000000000000
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '[datRep1."TNAME"][datRep1."FNAME"] [datRep1."LNAME"]')
          ParentFont = False
        end
        object datFoodReqFOOD: TfrxMemoView
          Align = baLeft
          Left = 251.716535430000000000
          Top = 3.962688690000000000
          Width = 143.244094490000000000
          Height = 18.897650000000000000
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '[datRep1."FGRP"]')
          ParentFont = False
        end
        object datFoodReqAMOUNT: TfrxMemoView
          Align = baLeft
          Left = 394.960629920000000000
          Top = 3.028109250000000000
          Width = 43.086614170000000000
          Height = 18.897650000000000000
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '1')
          ParentFont = False
        end
        object datFoodReqAGE: TfrxMemoView
          Align = baLeft
          Left = 438.047244090000000000
          Top = 2.598982900000000000
          Width = 32.881889760000000000
          Height = 18.897650000000000000
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Memo.UTF8 = (
            '[datRep1."AGE"]')
        end
        object datFoodReqWID: TfrxMemoView
          Align = baLeft
          Left = 470.929133850000000000
          Top = 2.598982900000000000
          Width = 48.755905510000000000
          Height = 18.897650000000000000
          DataField = 'WTS'
          DataSet = rdsRep1
          DataSetName = 'datRep1'
          Memo.UTF8 = (
            '[datRep1."WTS"]')
        end
        object datFoodReqHIGH: TfrxMemoView
          Align = baLeft
          Left = 519.685039360000000000
          Top = 2.598982900000000000
          Width = 54.425196850000000000
          Height = 18.897650000000000000
          DataField = 'HTS'
          DataSet = rdsRep1
          DataSetName = 'datRep1'
          Memo.UTF8 = (
            '[datRep1."HTS"]')
        end
        object datFoodReqDIESEASE: TfrxMemoView
          Align = baLeft
          Left = 574.110236210000000000
          Top = 2.598982900000000000
          Width = 128.125984250000000000
          Height = 18.897650000000000000
          DataSet = rdsFoodReq
          DataSetName = 'datFoodReq'
          Memo.UTF8 = (
            '')
        end
      end
    end
  end
end
