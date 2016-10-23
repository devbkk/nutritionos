object frmFood: TfrmFood
  Left = 0
  Top = 0
  Caption = #3586#3657#3629#3617#3641#3621#3629#3634#3627#3634#3619
  ClientHeight = 450
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 597
    Height = 450
    ActivePage = tsFood
    Align = alClient
    Font.Charset = THAI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object tsFood: TTabSheet
      Caption = #3629#3634#3627#3634#3619
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object tsFdMnu: TTabSheet
      Caption = #3648#3617#3609#3641#3629#3634#3627#3634#3619
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object tsFdMeal: TTabSheet
      Caption = #3617#3639#3657#3629#3629#3634#3627#3634#3619
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
end
