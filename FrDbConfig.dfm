object frmDbConfig: TfrmDbConfig
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #3605#3633#3657#3591#3588#3656#3634#3585#3634#3619#3648#3594#3639#3656#3629#3617#3605#3656#3629#3600#3634#3609#3586#3657#3629#3617#3641#3621
  ClientHeight = 297
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inline fraDbCfg: TfraDBConfig
    Left = 0
    Top = 0
    Width = 457
    Height = 297
    Align = alClient
    Font.Charset = THAI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 457
    ExplicitHeight = 297
    inherited img: TImage
      Left = 331
      Height = 144
      ExplicitLeft = 331
      ExplicitHeight = 144
    end
    inherited grSave: TGroupBox
      Width = 457
      ExplicitWidth = 457
    end
    inherited grCmd: TPanel
      Width = 457
      ExplicitWidth = 457
      inherited sbAddWrite: TSpeedButton
        Left = 355
        ExplicitLeft = 355
      end
    end
  end
end
