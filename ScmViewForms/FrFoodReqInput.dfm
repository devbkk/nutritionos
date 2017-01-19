object frmFoodReqInputter: TfrmFoodReqInputter
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 298
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = THAI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object grSearch: TGroupBox
    Left = 0
    Top = 0
    Width = 526
    Height = 50
    Align = alTop
    Caption = #3588#3657#3609#3627#3634
    TabOrder = 0
    ExplicitWidth = 569
    object radByCode: TRadioButton
      Tag = 1
      Left = 2
      Top = 18
      Width = 95
      Height = 30
      Align = alLeft
      Caption = #3588#3657#3609#3604#3657#3623#3618#3619#3627#3633#3626
      TabOrder = 0
      ExplicitLeft = 99
      ExplicitHeight = 31
    end
    object radByFName: TRadioButton
      Left = 97
      Top = 18
      Width = 79
      Height = 30
      Align = alLeft
      Caption = #3588#3657#3609#3604#3657#3623#3618#3594#3639#3656#3629
      Checked = True
      TabOrder = 1
      TabStop = True
      ExplicitLeft = 20
      ExplicitHeight = 31
    end
    object edSearch: TEdit
      Left = 182
      Top = 17
      Width = 347
      Height = 24
      TabOrder = 2
    end
  end
  object grd: TDBGrid
    Left = 0
    Top = 50
    Width = 526
    Height = 223
    Align = alClient
    DataSource = src
    TabOrder = 1
    TitleFont.Charset = THAI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ACODE'
        Title.Caption = #3619#3627#3633#3626
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ADESC'
        Title.Caption = #3594#3639#3656#3629
        Visible = True
      end>
  end
  object btnOK: TBitBtn
    Left = 0
    Top = 273
    Width = 526
    Height = 25
    Align = alBottom
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
    ExplicitWidth = 309
  end
  object src: TDataSource
    DataSet = cds
    Left = 24
    Top = 192
  end
  object cds: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ACODE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ADESC'
        DataType = ftString
        Size = 200
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 72
    Top = 192
    Data = {
      4E0000009619E0BD0100000018000000020000000000030000004E000541434F
      4445010049000000010005574944544802000200140005414445534301004900
      0000010005574944544802000200C8000000}
  end
  object dsp: TDataSetProvider
    Left = 120
    Top = 192
  end
  object tmr: TTimer
    Left = 176
    Top = 192
  end
end
