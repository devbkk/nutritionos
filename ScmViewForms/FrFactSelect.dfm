object frmFactselect: TfrmFactselect
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 288
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
    Top = 263
    Width = 305
    Height = 25
    Align = alBottom
    Caption = 'OK'
    TabOrder = 0
  end
  object vlFacts: TValueListEditor
    Left = 0
    Top = 0
    Width = 305
    Height = 263
    Align = alClient
    TabOrder = 1
    TitleCaptions.Strings = (
      #3588#3640#3603#3626#3617#3610#3633#3605#3636
      #3648#3621#3639#3629#3585#3588#3656#3634)
    OnStringsChange = vlFactsStringsChange
    ColWidths = (
      128
      171)
  end
end
