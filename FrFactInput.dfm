object frmFactInputter: TfrmFactInputter
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #3610#3633#3609#3607#3638#3585#3586#3657#3629#3617#3641#3621
  ClientHeight = 274
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
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 305
    Height = 249
    ActivePage = tsPlainText
    Align = alClient
    TabOrder = 0
    object tsPlainText: TTabSheet
      Caption = #3651#3626#3656#3586#3657#3629#3617#3641#3621
      object mmNotes: TMemo
        Left = 0
        Top = 0
        Width = 297
        Height = 220
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
        Width = 297
        Height = 220
        Align = alClient
        TabOrder = 0
        ColWidths = (
          128
          163)
      end
    end
    object tsDateTime: TTabSheet
      Caption = #3623#3633#3609#3607#3637#3656#3648#3623#3621#3634
      ImageIndex = 2
      object mcSelDate: TMonthCalendar
        Left = 43
        Top = 31
        Width = 190
        Height = 182
        Date = 42395.358001678240000000
        TabOrder = 0
      end
      object edSelDate: TEdit
        Left = 55
        Top = 11
        Width = 166
        Height = 22
        TabOrder = 1
      end
    end
  end
  object btnOK: TBitBtn
    Left = 0
    Top = 249
    Width = 305
    Height = 25
    Align = alBottom
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOKClick
  end
end
