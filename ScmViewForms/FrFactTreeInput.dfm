object frmFactTreeInput: TfrmFactTreeInput
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 141
  ClientWidth = 350
  Color = clBtnFace
  Font.Charset = THAI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object gbMain: TGroupBox
    Left = 0
    Top = 0
    Width = 350
    Height = 141
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 406
    ExplicitHeight = 110
    object lbCode: TLabel
      Left = 16
      Top = 27
      Width = 22
      Height = 16
      Caption = #3619#3627#3633#3626
    end
    object lbDesc: TLabel
      Left = 16
      Top = 67
      Width = 51
      Height = 16
      Caption = #3588#3635#3629#3608#3636#3610#3634#3618
    end
    object sbOK: TSpeedButton
      Left = 125
      Top = 94
      Width = 88
      Height = 28
      Caption = #3618#3629#3617#3619#3633#3610
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000001D10006738008C4B00
        8B4A008B4A008C4B006738001D10000000000000000000000000000000000000
        000000005E3300905001A16901AB7601AC7901AC7901AB7601A1690090500053
        2D00000000000000000000000000000000532D00915202AC7700C38C00D79B00
        DA9C00DA9C00D79C01C38C01AB7600925300532D000000000000000000001C10
        0090510FB48300D29800D59800D19200CF9000D09100D39600D69B00D19801AB
        76009050001D1000000000000000673616AB7810C99600D39700CD8CFFFFFFFF
        FFFFFFFFFF00CC8C00D19500D59B01C18C01A169006838000000000000008A48
        39C49D00D19800CB8CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00CA8C00CF9600D2
        9B01AB76008C4B00000000000000894652D2B000CC92FFFFFFFFFFFFFFFFFF00
        C484FFFFFFFFFFFFFFFFFF00C88D00D09A00AD79008B4A000000000000008845
        68DDBE00C991FFFFFFFFFFFF00C68C00C89100C58BFFFFFFFFFFFFFFFFFF00CC
        9600AD78008B4A00000000000000884676E0C600CB9800C59000C69100C89500
        C99700C89400C38CFFFFFFFFFFFF00C79200AB75008C4B000000000000006534
        59C9A449DEBC00C79400C89700C99800C99900C99800C79400C38EFFFFFF00BD
        8A00A067006838000000000000001C0F0A9458ADF8E918D0A700C49500C69700
        C69800C79800C79800C69700C59612B585008F50001C0F000000000000000000
        005C30199C63BCFFF75EE4C900C59A00C39600C49700C59A22CAA22FC1960293
        5500522C00000000000000000000000000000000512A0E965974D5B6A0F4E194
        EFDC7CE6CC5ED6B52EB587039152005D33000000000000000000000000000000
        000000000000001C0F006433008744008743008744008946006636001C0F0000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      OnClick = sbOKClick
    end
    object sbCancel: TSpeedButton
      Left = 219
      Top = 94
      Width = 88
      Height = 28
      Caption = #3618#3585#3648#3621#3636#3585
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000001116452C3CC02B3BBE2B3ABE2B
        3ABE2B3ABE2B3BBE2C3CC0111645000000000000000000000000000000000000
        1015432F3EC35F71F9697DFF697CFF697CFF697CFF697DFF5F71F92F3EC31015
        430000000000000000000000001015432F3EC2586BF65F74FF5D72FE5E72FD5E
        73FD5E72FD5D72FE5F74FF586BF62F3EC2101543000000000000111645303FC2
        5568F3586CFC4E64F94D63F85468F9576BF95468F94D63F84E64F9586CFC5568
        F3303FC21116450000002D3DC05367F2556BFA4960F7FFFFFFFFFFFF3E56F647
        5EF63E56F6FFFFFFFFFFFF4960F7556BFA5166F22D3DC00000002B3BBF6276FC
        4D64F64259F4FFFFFFFFFFFFFFFFFF2C46F3FFFFFFFFFFFFFFFFFF4259F44E64
        F65F75FC2C3BBF0000002A3ABF7386FA495FF3435AF36E80F6FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF6E80F6435AF3495FF36E81FA2B3ABF0000002939BF8696FB
        425AF14259F1354EF05B70F2FFFFFFFFFFFFFFFFFF5B70F2354EF04259F1435B
        F17D90F92A39BF0000002737BF9AA8FB3A55EF3953EE2844EDFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF2844ED3953EE3B55EF8E9DFA2838BF0000002637BF9FABF1
        314CED2B47EBFFFFFFFFFFFFFFFFFF5369EFFFFFFFFFFFFFFFFFFF2C47EB314C
        ED9FABF12737BF0000002838C19FABF18091F4213EE8FFFFFFFFFFFF5D72EE23
        40E85D72EEFFFFFFFFFFFF213EE88091F49FABF12838C10000001016452E3EC3
        97A5EF778AF25B71EE6074EE2643E62C48E72643E66074EE5B71EE778AF297A5
        EF2E3EC31016450000000000000F15432E3EC295A2EE7688F01E3BE42340E525
        41E52340E51E3BE47688F095A2EE2E3EC20F1543000000000000000000000000
        0F15432F3DC394A0EFADB9F8ADB8F7ADB9F7ADB8F7ADB9F894A0EF2F3DC30F15
        43000000000000000000000000000000000000101545303FC44555CE4454CD43
        54CD4454CD4555CE303FC4101545000000000000000000000000}
      OnClick = sbCancelClick
    end
    object edCode: TEdit
      Left = 87
      Top = 24
      Width = 121
      Height = 25
      TabOrder = 0
    end
    object edDesc: TEdit
      Left = 87
      Top = 64
      Width = 220
      Height = 24
      TabOrder = 1
    end
  end
end
