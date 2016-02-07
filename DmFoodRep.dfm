inherited DmoFoodRep: TDmoFoodRep
  OldCreateOrder = True
  Height = 338
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
  object cdsC19: TClientDataSet
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
    Left = 194
    Top = 208
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
  object rdsC19: TfrxDBDataset
    UserName = 'datC19'
    CloseDataSource = False
    DataSet = cdsC19
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
    ReportOptions.LastChange = 42405.371865821760000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 200
    Top = 152
    Datasets = <
      item
        DataSet = rdsC19
        DataSetName = 'datC19'
      end>
    Variables = <>
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
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        DataSet = rdsC19
        DataSetName = 'datC19'
        RowCount = 0
        object datC19C01: TfrxMemoView
          Left = 7.559060000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          DataField = 'C01'
          DataSet = rdsC19
          DataSetName = 'datC19'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '[datC19."C01"]')
          ParentFont = False
        end
        object datC19C02: TfrxMemoView
          Left = 192.756030000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          DataField = 'C02'
          DataSet = rdsC19
          DataSetName = 'datC19'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '[datC19."C02"]')
          ParentFont = False
        end
        object datC19C14: TfrxMemoView
          Left = 393.071120000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DataField = 'C14'
          DataSet = rdsC19
          DataSetName = 'datC19'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '[datC19."C14"]')
          ParentFont = False
        end
      end
    end
  end
end
