object frmFactInputter: TfrmFactInputter
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #3610#3633#3609#3607#3638#3585#3586#3657#3629#3617#3641#3621
  ClientHeight = 315
  ClientWidth = 309
  Color = clBtnShadow
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
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 309
    Height = 290
    ActivePage = tsPlainText
    Align = alClient
    TabOrder = 0
    object tsPlainText: TTabSheet
      Caption = #3651#3626#3656#3586#3657#3629#3617#3641#3621
      object mmNotes: TMemo
        Left = 0
        Top = 0
        Width = 301
        Height = 261
        Align = alClient
        TabOrder = 0
      end
    end
    object tsFoodFormula: TTabSheet
      Caption = #3626#3641#3605#3619#3629#3634#3627#3634#3619
      ImageIndex = 1
      object vlToNotes: TValueListEditor
        Left = 0
        Top = 0
        Width = 301
        Height = 261
        Align = alClient
        TabOrder = 0
        ColWidths = (
          128
          167)
      end
    end
    object tsDateTime: TTabSheet
      Caption = #3623#3633#3609#3607#3637#3656#3648#3623#3621#3634
      ImageIndex = 2
      object mcSelDate: TMonthCalendar
        Left = -4
        Top = 3
        Width = 209
        Height = 213
        BiDiMode = bdLeftToRight
        Date = 42395.360660370370000000
        Font.Charset = THAI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
      end
    end
    object tsDiagHist: TTabSheet
      Caption = #3611#3619#3632#3623#3633#3605#3636#3650#3619#3588
      ImageIndex = 3
      object edPatName: TDBText
        Left = 0
        Top = 0
        Width = 301
        Height = 17
        Align = alTop
        Color = clBtnFace
        DataField = 'PATNAME'
        DataSource = srcDiagHist
        ParentColor = False
        ExplicitLeft = 72
        ExplicitTop = 40
        ExplicitWidth = 65
      end
      object grdDiagHist: TDBGrid
        Left = 0
        Top = 17
        Width = 301
        Height = 244
        Align = alClient
        DataSource = srcDiagHist
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = THAI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'DIAGCODE'
            Title.Caption = #3619#3627#3633#3626#3650#3619#3588
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DIAGDESC'
            Title.Caption = #3588#3635#3629#3608#3636#3610#3634#3618
            Visible = True
          end>
      end
    end
  end
  object btnOK: TBitBtn
    Left = 0
    Top = 290
    Width = 309
    Height = 25
    Align = alBottom
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOKClick
  end
  object cdsDiagHist: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'DIAGCODE'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'DIAGDESC'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PATNAME'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'dspDiagHist'
    StoreDefs = True
    Left = 232
    Top = 232
  end
  object srcDiagHist: TDataSource
    DataSet = cdsDiagHist
    Left = 192
    Top = 232
  end
  object dspDiagHist: TDataSetProvider
    Left = 272
    Top = 232
  end
end
