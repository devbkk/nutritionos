object frmFactGroupsInput: TfrmFactGroupsInput
  Left = 0
  Top = 0
  ClientHeight = 308
  ClientWidth = 295
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
    Top = 283
    Width = 295
    Height = 25
    Align = alBottom
    Caption = 'OK'
    TabOrder = 0
    ExplicitTop = 227
    ExplicitWidth = 305
  end
  object vlToNotes: TValueListEditor
    Left = 0
    Top = 0
    Width = 295
    Height = 283
    Align = alClient
    TabOrder = 1
    TitleCaptions.Strings = (
      #3588#3640#3603#3626#3617#3610#3633#3605#3636
      #3648#3621#3639#3629#3585#3588#3656#3634)
    ExplicitTop = -9
    ExplicitWidth = 297
    ExplicitHeight = 261
    ColWidths = (
      128
      161)
  end
end
