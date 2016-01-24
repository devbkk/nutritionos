object frmFactInputter: TfrmFactInputter
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #3610#3633#3609#3607#3638#3585#3586#3657#3629#3617#3641#3621
  ClientHeight = 274
  ClientWidth = 390
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
    Width = 390
    Height = 249
    ActivePage = tsFoodFormula
    Align = alClient
    TabOrder = 0
    object tsPlainText: TTabSheet
      Caption = #3651#3626#3656#3586#3657#3629#3617#3641#3621
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object mmNotes: TMemo
        Left = 0
        Top = 0
        Width = 382
        Height = 220
        Align = alClient
        TabOrder = 0
      end
    end
    object tsFoodFormula: TTabSheet
      Caption = #3626#3641#3605#3619#3629#3634#3627#3634#3619
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object vlToNotes: TValueListEditor
        Left = 0
        Top = 0
        Width = 382
        Height = 220
        Align = alClient
        TabOrder = 0
        ColWidths = (
          150
          226)
      end
    end
  end
  object btnOK: TBitBtn
    Left = 0
    Top = 249
    Width = 390
    Height = 25
    Align = alBottom
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOKClick
  end
end
