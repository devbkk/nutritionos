object fraSrchPat: TfraSrchPat
  Left = 0
  Top = 0
  Width = 547
  Height = 54
  Font.Charset = THAI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object grSearch: TGroupBox
    Left = 0
    Top = 0
    Width = 547
    Height = 51
    Align = alTop
    Caption = #3588#3657#3609#3627#3634
    TabOrder = 0
    object lbMarginLeft: TLabel
      Left = 2
      Top = 18
      Width = 18
      Height = 31
      Align = alLeft
      AutoSize = False
      ExplicitTop = 16
      ExplicitHeight = 14
    end
    object radByFName: TRadioButton
      Left = 20
      Top = 18
      Width = 79
      Height = 31
      Align = alLeft
      Caption = #3588#3657#3609#3604#3657#3623#3618#3594#3639#3656#3629
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object radByHn: TRadioButton
      Tag = 1
      Left = 99
      Top = 18
      Width = 95
      Height = 31
      Align = alLeft
      Caption = #3588#3657#3609#3604#3657#3623#3618' hn'
      TabOrder = 1
    end
    object radByWard: TRadioButton
      Tag = 2
      Left = 194
      Top = 18
      Width = 113
      Height = 31
      Align = alLeft
      Caption = #3588#3657#3609#3604#3657#3623#3618' ward'
      TabOrder = 2
    end
    object edSearch: TComboBox
      Left = 307
      Top = 18
      Width = 238
      Height = 24
      Align = alClient
      ItemHeight = 16
      TabOrder = 3
      OnCloseUp = edSearchCloseUp
      OnKeyDown = edSearchKeyDown
    end
  end
  object tmrSearch: TTimer
    Enabled = False
    OnTimer = tmrSearchTimer
    Left = 304
    Top = 16
  end
  object src: TDataSource
    Left = 336
    Top = 16
  end
  object cdsWard: TClientDataSet
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
      end>
    IndexDefs = <
      item
        Name = 'cdsWardIdx'
        Fields = 'WARDID'
      end>
    IndexFieldNames = 'WARDID'
    Params = <>
    ProviderName = 'dspWard'
    StoreDefs = True
    Left = 376
    Top = 16
  end
  object dspWard: TDataSetProvider
    Left = 416
    Top = 16
  end
end
