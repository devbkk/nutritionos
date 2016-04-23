inherited DmoFoodPrep: TDmoFoodPrep
  OldCreateOrder = True
  Height = 326
  object qryFoodPrep: TSQLQuery
    Params = <>
    Left = 120
    Top = 80
  end
  object repSlipDietAm: TfrxReport
    Version = '5.1.9'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42367.829744699080000000
    ReportOptions.LastChange = 42451.384085034720000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 40
    Top = 144
    Datasets = <
      item
        DataSet = rdsSlipDiet
        DataSetName = 'SlipDietData'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PageMain: TfrxReportPage
      PaperWidth = 80.000000000000000000
      PaperHeight = 50.000000000000000000
      PaperSize = 256
      object DataMaster: TfrxMasterData
        FillType = ftBrush
        Height = 487.559370000000000000
        Top = 18.897650000000000000
        Width = 302.362400000000000000
        DataSet = rdsSlipDiet
        DataSetName = 'SlipDietData'
        RowCount = 0
        object SlipDietDataPATNAME: TfrxMemoView
          Left = 10.354360000000000000
          Top = 60.960730000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
          DataSet = rdsSlipDiet
          DataSetName = 'SlipDietData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #3648#3608#138#3648#3608#3607#3648#3609#136#3648#3608#3597' [SlipDietData."PATNAME"]')
          ParentFont = False
        end
        object Meal: TfrxMemoView
          Left = 227.496135000000000000
          Top = 92.094620000000000000
          Width = 61.488250000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #3648#3608#3585#3648#3608#3607#3648#3609#137#3648#3608#3597#3648#3608#8212#3648#3608#3605#3648#3609#136)
          ParentFont = False
        end
        object SlipDietDataAMOUNTAM: TfrxMemoView
          Left = 17.464595000000000000
          Top = 117.126160000000000000
          Width = 215.433210000000000000
          Height = 18.897650000000000000
          DataSet = rdsSlipDiet
          DataSetName = 'SlipDietData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #3648#3608#136#3648#3608#3603#3648#3608#153#3648#3608#3591#3648#3608#153' [SlipDietData."AMOUNTAM"] '#3648#3608#139#3648#3608#3605#3648#3608#139#3648#3608#3605)
          ParentFont = False
        end
        object SlipDietDataROOMNO: TfrxMemoView
          Left = 5.897650000000000000
          Top = 33.732530000000000000
          Width = 279.685220000000000000
          Height = 18.897650000000000000
          DataSet = rdsSlipDiet
          DataSetName = 'SlipDietData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            
              #3648#3608#3595#3648#3609#137#3648#3608#3597#3648#3608#135' [SlipDietData."ROOMNO"] / '#3648#3609#8364#3648#3608#8226#3648#3608#3605#3648#3608#3586#3648#3608#135' [SlipDiet' +
              'Data."BEDNO"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Feed: TfrxMemoView
          Left = 12.897650000000000000
          Top = 89.889920000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          Memo.UTF8 = (
            #3648#3608#3594#3648#3608#3609#3648#3608#8226#3648#3608#3587#3648#3608#3597#3648#3608#3602#3648#3608#3595#3648#3608#3602#3648#3608#3587)
          ParentFont = False
        end
        object SlipDietDataPRNDATE: TfrxMemoView
          Left = 8.000000000000000000
          Top = 10.944960000000000000
          Width = 137.551330000000000000
          Height = 18.897650000000000000
          DataSet = rdsSlipDiet
          DataSetName = 'SlipDietData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #3648#3608#3591#3648#3608#3601#3648#3608#153#3648#3608#8212#3648#3608#3605#3648#3609#136' [FormatDateTime('#39'd/M/yyyy'#39',Now)]'
            '')
          ParentFont = False
        end
        object SlipDietDataSALTWS: TfrxMemoView
          Left = 128.523655000000000000
          Top = 90.803340000000000000
          Width = 102.433210000000000000
          Height = 18.897650000000000000
          DataSet = rdsSlipDiet
          DataSetName = 'SlipDietData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #3648#3609#8364#3648#3608#129#3648#3608#3589#3648#3608#3607#3648#3608#3597' [SlipDietData."SALTWT"] '#3648#3608#129#3648#3608#3587#3648#3608#3601#3648#3608#3585)
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 205.000000000000000000
          Top = 14.102350000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            'Hn')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 11.000000000000000000
          Top = 145.102350000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #3648#3609#130#3648#3608#3587#3648#3608#132)
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 196.000000000000000000
          Top = 145.102350000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #3648#3608#3597#3648#3608#3602#3648#3608#3595#3648#3608#3602#3648#3608#3587)
          ParentFont = False
        end
      end
    end
  end
  object rdsSlipDiet: TfrxDBDataset
    UserName = 'SlipDietData'
    CloseDataSource = False
    DataSet = cdsFoodPrep
    BCDToCurrency = False
    Left = 120
    Top = 144
  end
  object cdsFoodPrep: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
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
        Name = 'PATNAME'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'AMOUNTAM'
        DataType = ftInteger
      end
      item
        Name = 'AMOUNTPM'
        DataType = ftInteger
      end
      item
        Name = 'SALTWT'
        DataType = ftFloat
      end
      item
        Name = 'PRNDATE'
        DataType = ftDateTime
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 120
    Top = 208
    Data = {
      E40000009619E0BD010000001800000009000000000003000000E40006574152
      444944010049000000010005574944544802000200030008574152444E414D45
      010049000000010005574944544802000200140006524F4F4D4E4F0100490000
      000100055749445448020002000500054245444E4F0100490000000100055749
      445448020002000A00075041544E414D45010049000000010005574944544802
      000200460008414D4F554E54414D040001000000000008414D4F554E54504D04
      000100000000000653414C54575408000400000000000750524E444154450800
      0800000000000000}
  end
  object repSlipDietPm: TfrxReport
    Version = '5.1.9'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42367.829744699100000000
    ReportOptions.LastChange = 42375.873021562500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 40
    Top = 208
    Datasets = <
      item
        DataSet = rdsSlipDiet
        DataSetName = 'SlipDietData'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PageMain: TfrxReportPage
      PaperWidth = 84.000000000000000000
      PaperHeight = 134.000000000000000000
      PaperSize = 256
      object DataMaster: TfrxMasterData
        FillType = ftBrush
        Height = 487.559370000000000000
        Top = 18.897650000000000000
        Width = 317.480520000000000000
        DataSet = rdsSlipDiet
        DataSetName = 'SlipDietData'
        RowCount = 0
        object Hospital: TfrxMemoView
          Align = baCenter
          Left = 24.566945000000000000
          Top = 60.149660000000000000
          Width = 268.346630000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #3648#3609#130#3648#3608#3587#3648#3608#135#3648#3608#158#3648#3608#3586#3648#3608#3602#3648#3608#154#3648#3608#3602#3648#3608#3589#3648#3608#158#3648#3608#3587#3648#3608#3600#3648#3608#153#3648#3608#132#3648#3608#3587#3648#3608#3592#3648#3608#3587#3648#3608#3605#3648#3608#3597#3648#3608#3586#3648#3608#3608#3648 +
              #3608#152#3648#3608#3586#3648#3608#3602
            #3648#3608#157#3648#3609#136#3648#3608#3602#3648#3608#3586#3648#3609#130#3648#3608#160#3648#3608#138#3648#3608#153#3648#3608#3602#3648#3608#129#3648#3608#3602#3648#3608#3587)
          ParentFont = False
        end
        object Ward: TfrxMemoView
          Align = baRight
          Left = 226.771800000000000000
          Top = 15.118120000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #3648#3608#3591#3648#3608#3597#3648#3608#3587#3648#3609#140#3648#3608#8221' [SlipDietData."WARDID"]')
          ParentFont = False
        end
        object SlipDietDataPATNAME: TfrxMemoView
          Align = baCenter
          Left = 45.354360000000000000
          Top = 154.960730000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
          DataSet = rdsSlipDiet
          DataSetName = 'SlipDietData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #3648#3608#138#3648#3608#3607#3648#3609#136#3648#3608#3597' [SlipDietData."PATNAME"]')
          ParentFont = False
        end
        object Meal: TfrxMemoView
          Align = baCenter
          Left = 111.496135000000000000
          Top = 204.094620000000000000
          Width = 94.488250000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            #3648#3608#3585#3648#3608#3607#3648#3609#137#3648#3608#3597#3648#3609#8364#3648#3608#3586#3648#3609#135#3648#3608#153)
          ParentFont = False
        end
        object SlipDietDataAMOUNTAM: TfrxMemoView
          Align = baCenter
          Left = 51.023655000000000000
          Top = 272.126160000000000000
          Width = 215.433210000000000000
          Height = 18.897650000000000000
          DataSet = rdsSlipDiet
          DataSetName = 'SlipDietData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #3648#3608#136#3648#3608#3603#3648#3608#153#3648#3608#3591#3648#3608#153' [SlipDietData."AMOUNTPM"] '#3648#3608#139#3648#3608#3605#3648#3608#139#3648#3608#3605)
          ParentFont = False
        end
        object Usage: TfrxMemoView
          Left = 18.897650000000000000
          Top = 335.921460000000000000
          Width = 196.535560000000000000
          Height = 41.574830000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '- '#3648#3609#8364#3648#3608#129#3648#3609#135#3648#3608#154#3648#3608#3597#3648#3608#3602#3648#3608#3595#3648#3608#3602#3648#3608#3587#3648#3609#131#3648#3608#153#3648#3608#8226#3648#3608#3609#3648#3609#137#3648#3609#8364#3648#3608#3586#3648#3609#135#3648#3608#153
            
              '- '#3648#3609#131#3648#3608#3594#3648#3609#136#3648#3608#153#3648#3609#137#3648#3608#3603#3648#3609#129#3648#3608#138#3648#3609#136#3648#3608#130#3648#3608#3591#3648#3608#8221#3648#3608#3595#3648#3608#3589#3648#3608#3601#3648#3608#135#3648#3608#129#3648#3608#3602#3648#3608#3587#3648#3609#131#3648#3608 +
              #138#3648#3609#137)
          ParentFont = False
        end
        object SlipDietDataROOMNO: TfrxMemoView
          Left = 18.897650000000000000
          Top = 397.732530000000000000
          Width = 279.685220000000000000
          Height = 18.897650000000000000
          DataSet = rdsSlipDiet
          DataSetName = 'SlipDietData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            
              #3648#3608#3595#3648#3609#137#3648#3608#3597#3648#3608#135' [SlipDietData."ROOMNO"] / '#3648#3609#8364#3648#3608#8226#3648#3608#3605#3648#3608#3586#3648#3608#135' [SlipDiet' +
              'Data."BEDNO"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object CODE: TfrxMemoView
          Left = 18.897650000000000000
          Top = 439.748300000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'PH 0001')
          ParentFont = False
        end
        object Feed: TfrxMemoView
          Left = 18.897650000000000000
          Top = 241.889920000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          Memo.UTF8 = (
            #3648#3608#3597#3648#3608#3602#3648#3608#3595#3648#3608#3602#3648#3608#3587#3648#3608#3594#3648#3608#3602#3648#3608#3586#3648#3608#3586#3648#3608#3602#3648#3608#135)
          ParentFont = False
        end
        object SlipDietDataPRNDATE: TfrxMemoView
          Align = baCenter
          Left = 43.464595000000000000
          Top = 120.944960000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataSet = rdsSlipDiet
          DataSetName = 'SlipDietData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #3648#3608#3591#3648#3608#3601#3648#3608#153#3648#3608#8212#3648#3608#3605#3648#3609#136' [FormatDateTime('#39'd/M/yyyy'#39',Now)]')
          ParentFont = False
        end
        object SlipDietDataSALTWS: TfrxMemoView
          Align = baCenter
          Left = 51.023655000000000000
          Top = 294.803340000000000000
          Width = 215.433210000000000000
          Height = 18.897650000000000000
          DataSet = rdsSlipDiet
          DataSetName = 'SlipDietData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #3648#3609#8364#3648#3608#129#3648#3608#3589#3648#3608#3607#3648#3608#3597' [SlipDietData."SALTWT"] '#3648#3608#129#3648#3608#3587#3648#3608#3601#3648#3608#3585)
          ParentFont = False
        end
      end
    end
  end
end