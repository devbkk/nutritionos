object frmFactselect: TfrmFactselect
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 335
  ClientWidth = 305
  Color = clBtnFace
  Font.Charset = THAI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object btnOK: TBitBtn
    Left = 0
    Top = 310
    Width = 305
    Height = 25
    Align = alBottom
    Caption = 'OK'
    TabOrder = 4
    ExplicitTop = 287
  end
  object gbPatType: TGroupBox
    Left = 0
    Top = 0
    Width = 305
    Height = 50
    Align = alTop
    Caption = #3611#3619#3632#3648#3616#3607#3612#3641#3657#3611#3656#3623#3618
    TabOrder = 0
    object cboPatType: TComboBox
      Left = 2
      Top = 16
      Width = 301
      Height = 22
      Align = alTop
      ItemHeight = 14
      TabOrder = 0
    end
  end
  object gbFoodType: TGroupBox
    Left = 0
    Top = 50
    Width = 305
    Height = 159
    Align = alTop
    Caption = #3594#3609#3636#3604#3629#3634#3627#3634#3619
    TabOrder = 1
    object cboFoodTypeL1: TComboBox
      Tag = 1
      Left = 2
      Top = 16
      Width = 301
      Height = 22
      Align = alTop
      ItemHeight = 14
      TabOrder = 0
    end
    object cboFoodTypeL2: TComboBox
      Tag = 2
      Left = 2
      Top = 38
      Width = 301
      Height = 22
      Align = alTop
      ItemHeight = 14
      TabOrder = 1
    end
    object cboFoodTypeL3: TComboBox
      Tag = 3
      Left = 2
      Top = 60
      Width = 301
      Height = 22
      Align = alTop
      ItemHeight = 14
      TabOrder = 2
    end
    object cboFoodTypeL4: TComboBox
      Tag = 4
      Left = 2
      Top = 82
      Width = 301
      Height = 22
      Align = alTop
      ItemHeight = 14
      TabOrder = 3
    end
    object cboFoodTypeL5: TComboBox
      Tag = 5
      Left = 2
      Top = 104
      Width = 301
      Height = 22
      Align = alTop
      ItemHeight = 14
      TabOrder = 4
    end
    object cboFoodTypeL6: TComboBox
      Tag = 5
      Left = 2
      Top = 126
      Width = 301
      Height = 22
      Align = alTop
      ItemHeight = 14
      TabOrder = 5
      ExplicitLeft = 1
      ExplicitTop = 151
    end
  end
  object gbFoodRestrict: TGroupBox
    Left = 0
    Top = 209
    Width = 305
    Height = 50
    Align = alTop
    Caption = #3586#3657#3629#3592#3635#3585#3633#3604
    TabOrder = 2
    ExplicitTop = 191
    object cboRestrict: TComboBox
      Tag = 5
      Left = 2
      Top = 16
      Width = 301
      Height = 22
      Align = alTop
      ItemHeight = 14
      TabOrder = 0
    end
  end
  object gbNote: TGroupBox
    Left = 0
    Top = 259
    Width = 305
    Height = 51
    Align = alClient
    Caption = #3648#3614#3636#3656#3617#3648#3605#3636#3617
    TabOrder = 3
    ExplicitHeight = 71
    object edNote: TEdit
      Left = 2
      Top = 16
      Width = 301
      Height = 22
      Align = alTop
      TabOrder = 0
    end
  end
end
