object frmFoodPrep: TfrmFoodPrep
  Left = 0
  Top = 0
  Caption = #3585#3634#3619#3648#3605#3619#3637#3618#3617#3629#3634#3627#3634#3619
  ClientHeight = 330
  ClientWidth = 697
  Color = clBtnFace
  Font.Charset = THAI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object pnlButtons: TPanel
    Left = 0
    Top = 0
    Width = 697
    Height = 32
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object sbDelCanc: TSpeedButton
      Left = 595
      Top = 2
      Width = 100
      Height = 28
      Align = alRight
      Flat = True
      ExplicitLeft = 296
    end
    object sbAddWrite: TSpeedButton
      Left = 495
      Top = 2
      Width = 100
      Height = 28
      Align = alRight
      Flat = True
      ExplicitLeft = 197
    end
    object lbFactDataType: TLabel
      Left = 4
      Top = 6
      Width = 165
      Height = 16
      Caption = #3586#3657#3629#3617#3641#3621' : '#3586#3657#3629#3617#3641#3621#3585#3634#3619#3648#3605#3619#3637#3618#3617#3629#3634#3627#3634#3619
    end
    object chkSeqAdd: TCheckBox
      Left = 255
      Top = 2
      Width = 103
      Height = 28
      Align = alRight
      Caption = #3610#3633#3609#3607#3638#3585#3605#3656#3629#3648#3609#3639#3656#3629#3591
      TabOrder = 0
      Visible = False
    end
    object cboFactDataType: TComboBox
      Left = 358
      Top = 2
      Width = 137
      Height = 24
      Align = alRight
      ItemHeight = 16
      TabOrder = 1
      Visible = False
    end
  end
  object grdFdPrep: TDBGrid
    Left = 0
    Top = 32
    Width = 697
    Height = 113
    Align = alTop
    DataSource = srcFdPrep
    TabOrder = 1
    TitleFont.Charset = THAI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'HN'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PATNAME'
        Title.Caption = #3594#3639#3656#3629'-'#3609#3634#3617#3626#3585#3640#3621
        Width = 149
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AGE'
        Title.Caption = #3629#3634#3618#3640
        Width = 73
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HT'
        Title.Caption = #3626#3656#3623#3609#3626#3641#3591
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WT'
        Title.Caption = #3609#3657#3635#3627#3609#3633#3585
        Width = 67
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SICK'
        Title.Caption = #3650#3619#3588
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MEAL_BF'
        Title.Caption = #3592#3635#3609#3623#3609#3648#3594#3657#3634
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MEAL_EV'
        Title.Caption = #3592#3635#3609#3623#3609#3648#3618#3655#3609
        Width = 92
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 145
    Width = 697
    Height = 32
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 2
    object SpeedButton1: TSpeedButton
      Left = 595
      Top = 2
      Width = 100
      Height = 28
      Align = alRight
      Flat = True
      ExplicitLeft = 296
    end
    object SpeedButton2: TSpeedButton
      Left = 495
      Top = 2
      Width = 100
      Height = 28
      Align = alRight
      Flat = True
      ExplicitLeft = 197
    end
    object Label1: TLabel
      Left = 4
      Top = 6
      Width = 195
      Height = 16
      Caption = #3586#3657#3629#3617#3641#3621' : '#3619#3634#3618#3621#3632#3648#3629#3637#3618#3604#3585#3634#3619#3648#3605#3619#3637#3618#3617#3629#3634#3627#3634#3619
    end
    object CheckBox1: TCheckBox
      Left = 255
      Top = 2
      Width = 103
      Height = 28
      Align = alRight
      Caption = #3610#3633#3609#3607#3638#3585#3605#3656#3629#3648#3609#3639#3656#3629#3591
      TabOrder = 0
      Visible = False
    end
    object ComboBox1: TComboBox
      Left = 358
      Top = 2
      Width = 137
      Height = 24
      Align = alRight
      ItemHeight = 16
      TabOrder = 1
      Visible = False
    end
  end
  object grdFdPrepDet: TDBGrid
    Left = 0
    Top = 177
    Width = 697
    Height = 153
    Align = alClient
    DataSource = srcFdPrepDet
    PopupMenu = pmuFdPrepDet
    TabOrder = 3
    TitleFont.Charset = THAI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'REQDATE'
        Title.Caption = #3623#3633#3609#3607#3637#3656
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REQMEAL'
        Title.Caption = #3617#3639#3657#3629#3629#3634#3627#3634#3619
        Width = 183
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REQMENU'
        Title.Caption = #3648#3617#3609#3641#3629#3634#3627#3634#3619
        Width = 206
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REQQTY'
        Title.Caption = #3592#3635#3609#3623#3609
        Visible = True
      end>
  end
  object cdsFdPrep: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'HN'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PATNAME'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AGE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'HT'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'WT'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SICK'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'MEAL_BF'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'MEAL_EV'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 48
    Top = 88
  end
  object srcFdPrep: TDataSource
    DataSet = cdsFdPrep
    Left = 136
    Top = 88
  end
  object srcFdPrepDet: TDataSource
    DataSet = cdsFdPrepDet
    Left = 136
    Top = 256
  end
  object cdsFdPrepDet: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'REQDATE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'REQMEAL'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'REQMENU'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'REQQTY'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 48
    Top = 256
  end
  object pmuFdPrepDet: TPopupMenu
    Left = 232
    Top = 256
    object mnuFdPrepDetDchg: TMenuItem
      Caption = #3618#3585#3648#3621#3636#3585#3619#3634#3618#3585#3634#3619
    end
    object mnuSlipDiet: TMenuItem
      Caption = #3614#3636#3617#3614#3660' Slip Diet'
    end
  end
end
