object frmFoodRep: TfrmFoodRep
  Left = 0
  Top = 0
  Caption = #3619#3634#3618#3591#3634#3609#3629#3634#3627#3634#3619
  ClientHeight = 398
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = THAI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object grSearch: TGroupBox
    Left = 0
    Top = 0
    Width = 575
    Height = 49
    Align = alTop
    Caption = #3588#3657#3609#3627#3634
    TabOrder = 0
    object edSearch: TEdit
      Left = 2
      Top = 18
      Width = 571
      Height = 24
      Align = alTop
      TabOrder = 0
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 49
    Width = 575
    Height = 32
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 1
    object lbFactDataType: TLabel
      Left = 4
      Top = 6
      Width = 85
      Height = 16
      Caption = #3586#3657#3629#3617#3641#3621' : '#3619#3634#3618#3591#3634#3609
    end
  end
  object lstRep: TListBox
    Left = 0
    Top = 81
    Width = 575
    Height = 143
    Align = alClient
    ItemHeight = 16
    Items.Strings = (
      #3619#3634#3618#3585#3634#3619#3648#3605#3619#3637#3618#3617#3629#3634#3627#3634#3619
      #3619#3634#3618#3591#3634#3609#3649#3626#3604#3591#3619#3634#3618#3594#3639#3656#3629#3612#3641#3657#3611#3656#3623#3618' '#3629#3634#3627#3634#3619#3607#3637#3656#3626#3633#3656#3591' '#3619#3632#3610#3640#3605#3634#3617#3623#3629#3619#3660#3604
      #3619#3634#3618#3591#3634#3609#3649#3626#3604#3591#3619#3634#3618#3594#3639#3656#3629#3612#3641#3657#3611#3656#3623#3618' '#3649#3618#3585#3605#3634#3617#3629#3634#3627#3634#3619#3607#3637#3656#3626#3633#3656#3591#3649#3605#3656#3621#3632#3617#3639#3657#3629
      #3619#3634#3618#3591#3634#3609#3626#3606#3636#3605#3636#3592#3635#3609#3623#3609#3629#3634#3627#3634#3619#3612#3641#3657#3611#3656#3623#3618' '#3649#3605#3656#3621#3632#3611#3619#3632#3648#3616#3607
      #3619#3634#3618#3591#3634#3609#3611#3619#3632#3623#3633#3605#3636#3629#3634#3627#3634#3619#3607#3637#3656#3612#3641#3657#3611#3656#3623#3618#3652#3604#3657#3619#3633#3610#3619#3634#3618#3610#3640#3588#3588#3621
      #3651#3610#3592#3633#3604#3629#3634#3627#3634#3619#3649#3618#3585#3605#3634#3617#3612#3641#3657#3611#3656#3623#3618)
    TabOrder = 2
    ExplicitHeight = 159
  end
  object bbtPrint: TBitBtn
    Left = 0
    Top = 348
    Width = 575
    Height = 50
    Align = alBottom
    Caption = #3614#3636#3617#3614#3660#3619#3634#3618#3591#3634#3609
    TabOrder = 3
    Glyph.Data = {
      36100000424D3610000000000000360000002800000020000000200000000100
      2000000000000010000000000000000000000000000000000000000000000000
      00000000000200000005000000080000000B0000000E000000370000005D0000
      005F000000610000006200000064000000650000006600000067000000670000
      0066000000650000006400000062000000610000005F0000005D000000370000
      000E0000000B0000000800000005000000020000000000000000000000010000
      00050000000B00000010000000160000001C0000002100000063E7E7E7F7FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E7E7F7000000630000
      00210000001C00000016000000100000000B0000000500000001000000000000
      000000000000000000000000000000000002797979FF606060FFD1D0D0FFFEFE
      FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFD1D0D0FF606060FF7979
      79FF000000020000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000808080FFB6B6B6FFC5C4C4FFF8F7
      F7FFFCFBFBFFFEFEFEFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFEFEFEFFFEFEFEFFFCFBFBFFF8F7F7FFC5C4C4FFB6B6B6FF8080
      80FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B3B3B3FF707070FF9B9A9AFFEDEB
      EBFFF2F1F1FFF6F5F5FFF9F9F9FFFBFBFBFFFCFCFCFFFDFCFCFFFDFCFCFFFCFC
      FCFFFBFBFBFFF9F9F9FFF6F5F5FFF2F1F1FFEDEBEBFF9B9A9AFF707070FFB3B3
      B3FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DFDFDFFF2F2F2FFF686767FFE0DD
      DDFFE5E3E3FFE9E7E7FFEDEBEBFFF0EEEEFFF1F0F0FFF2F1F1FFF2F1F1FFF1F0
      F0FFF0EEEEFFEDEBEBFFE9E7E7FFE5E3E3FFE0DDDDFF686767FF2F2F2FFFDFDF
      DFFF00000000000000000000000000000000000000000000000000000000716C
      6CBEA3A2A2FCA3A2A2FCA3A2A2FC8E8E8EFDE9E9E9FF202020FF3A3939FFCFCB
      CBFFD5D1D1FFDAD7D7FFDEDBDBFFE1DEDEFFE2E0E0FFE3E1E1FFE3E1E1FFE2E0
      E0FFE0DEDEFFDEDBDBFFDAD7D7FFD5D1D1FFCFCBCBFF3A3939FF202020FFE9E9
      E9FF8E8E8EFDA3A2A2FCA3A2A2FCA3A2A2FC716D6DBE00000000000000008B86
      86D4C4C4C4FFC4C4C4FFC4C4C4FFABABABFFF7F7F7FF1B1B1BFF1D1C1CFFB1AC
      ACFFB6B1B1FFBBB6B6FFBEBABAFFC1BDBDFFC3BFBFFFC4C0C0FFC4C0C0FFC3BF
      BFFFC1BDBDFFBEBABAFFBBB6B6FFB6B1B1FFB1ACACFF1D1C1CFF1B1B1BFFF7F7
      F7FFACACACFFC4C4C4FFC4C4C4FFC4C4C4FF8B8686D40000000000000000A8A4
      A4E5D3D3D3FFD3D3D3FFD3D3D3FFBCBCBCFFFFFFFFFF0B0B0BFF090909FF0808
      08FF080808FF080808FF080808FF080808FF080808FF080808FF080808FF0808
      08FF080808FF080808FF080808FF080808FF080808FF090909FF0B0B0BFFFFFF
      FFFFBDBDBDFFD3D3D3FFC8C8C8FFD0D1D1FFA8A4A4E50000000000000000C3C0
      C0F1E0E0E0FFE0E0E0FFE0E0E0FFDEDEDEFF3C3C3CFF0A0A0AFF0A0A0AFF0A0A
      0AFF0A0A0AFF0A0A0AFF0A0A0AFF0A0A0AFF090909FF090909FF090909FF0909
      09FF0A0A0AFF0A0A0AFF0A0A0AFF0A0A0AFF0A0A0AFF0A0A0AFF0A0A0AFF3C3C
      3CFFDEDEDEFFE0E0E0FFD2D3D3FFD4D4D4FFC3C0C0F10000000000000000D9D7
      D7F8EAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFE2E2E2FFDEDEDEFFDEDEDEFFDDDD
      DDFFDCDCDCFFDBDBDBFFDADADAFFD9D9D9FFD8D8D8FFD7D7D7FFD7D7D7FFD8D8
      D8FFD9D9D9FFDADADAFFDADADAFFDBDBDBFFDCDCDCFFDDDDDDFFDEDEDEFFE2E2
      E2FFEAEAEAFFEAEAEAFFD5D5D5FFDFDFDFFFD9D7D7F80000000000000000E5E4
      E4FDF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4
      F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4
      F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4
      F4FFF4F4F4FFF4F4F4FFE0E0E0FFE8E8E8FFE5E4E4FD0000000000000000B6B6
      B6F8A0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0
      A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0
      A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0
      A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFB6B6B6F80000000000000000D7D8
      D7F1FAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFD9D9D9FF3E3E3EFF3C3C3CFF3C3C
      3CFF3C3C3CFF3C3C3CFF494949FF717171FF717171FF717171FF717171FF7171
      71FF717171FF494949FF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3F3F3FFFD9D9
      D9FFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFD7D8D8F10000000000000000C9CB
      CAE6F6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFDDDDDDFF525252FF505050FF5050
      50FF505050FF505050FF505050FF666666FF696969FF696969FF696969FF6969
      69FF666666FF505050FF505050FF505050FF505050FF505050FF535353FFDDDD
      DDFFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFC9CBCAE60000000000000000B5B8
      B6D5F2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFDCDCDCFF575757FF555555FF5555
      55FF555555FF555555FF555555FF555555FF555555FF555555FF555555FF5555
      55FF555555FF555555FF555555FF555555FF555555FF555555FF585858FFDCDC
      DCFFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFB5B8B7D500000000000000009EA1
      A0C4F2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFE2E2E2FFD6D6D6FFD8D8D8FFD8D8
      D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8
      D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD7D7D7FFE2E2
      E2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FF9FA2A1C400000000000000006262
      62A19F9F9FFAAAAAAAFAB4B4B4FABBBBBBFAB7B8B8FB3C3C3CFE3C3C3CFE3C3C
      3CFE3C3C3CFE3C3C3CFE3C3C3CFE3C3C3CFE3C3C3CFE3C3C3CFE3C3C3CFE3C3C
      3CFE3C3C3CFE3C3C3CFE3C3C3CFE3C3C3CFE3C3C3CFE3C3C3CFE3D3D3DFEB8B8
      B8FBBBBBBBFAB4B4B4FAAAAAAAFA9F9F9FFA626262A100000000000000004242
      4276979797FFA2A2A2FFADADADFFB8B8B8FFAFAFAFFF424242FF363636FF3535
      35FF353535FF343434FF343434FF333333FF333333FF323232FF323232FF3333
      33FF333333FF343434FF343434FF353535FF353535FF363636FF424242FFAFAF
      AFFFB8B8B8FFADADADFFA2A2A2FF979797FF4242427600000000000000002626
      2646909090FF9B9B9BFFA5A5A5FFB0B0B0FFA5A5A5FF2E2E2EFFA9A3A3FFAFAA
      AAFFB4AFAFFFB9B4B4FFBCB8B8FFBFBBBBFFC1BDBDFFC2BEBEFFC2BEBEFFC1BD
      BDFFBFBBBBFFBCB8B8FFB9B4B4FFB4AFAFFFAFAAAAFFA9A3A3FF2F2F2FFFA5A5
      A5FFB0B0B0FFA5A5A5FF9B9B9BFF909090FF2626264600000000000000000C0C
      0C17898989FF939393FF9D9D9DFFA7A7A7FF9C9C9CFF545454FFBEB9B9FFC5C0
      C0FFCBC7C7FFD0CCCCFFD4D0D0FFD7D4D4FFD9D6D6FFDAD7D7FFDAD7D7FFD9D6
      D6FFD7D4D4FFD4D0D0FFD0CCCCFFCBC7C7FFC5C0C0FFBEB9B9FF545454FF9B9B
      9BFFA7A7A7FF9D9D9DFF939393FF898989FF0C0C0C1700000000000000000000
      0000010101010101010101010101010101011010101B5F5F5FFFCAC5C5FFD1CD
      CDFFD7D3D3FFDCD9D9FFE0DDDDFFE2E0E0FFE4E1E1FFE5E2E2FFE5E2E2FFE4E1
      E1FFE2E0E0FFE0DDDDFFDCD9D9FFD7D3D3FFD1CDCDFFCAC5C5FF5F5F5FFF1010
      101B010101010101010101010101010101010000000000000000000000000000
      0000000000000000000000000000000000001010101B626262FFD5D1D1FFDCD9
      D9FFE1DFDFFFE6E3E3FFE9E7E7FFECEAEAFFEDECECFFEEEDEDFFEEEDEDFFEDEC
      ECFFECEAEAFFE9E7E7FFE6E3E3FFE1DFDFFFDCD9D9FFD5D1D1FF626262FF0F0F
      0F1B000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000F0F0F1B656565FFDFDCDCFFE5E2
      E2FFEAE8E8FFEEEDEDFFF2F1F1FFF5F4F4FFF6F5F5FFF7F6F6FFF7F6F6FFF6F5
      F5FFF5F4F4FFF2F1F1FFEEEDEDFFEAE8E8FFE5E2E2FFDFDCDCFF656565FF0F0F
      0F1B000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000009090913636363F6E7E4E4FFEDEB
      EBFFF2F1F1FFF6F6F6FFF9F9F9FFFBFBFBFFFCFCFCFFFDFDFDFFFDFDFDFFFCFC
      FCFFFBFBFBFFF9F9F9FFF6F6F6FFF2F1F1FFEDEBEBFFE7E4E4FF636363F60808
      0813000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000050EEEDEDFFF5F3
      F3FFF9F8F8FFFCFCFCFFFEFEFEFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFEFEFEFFFEFEFEFFFCFCFCFFF9F8F8FFF5F3F3FFEEEDEDFF000000500000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000050F5F4F4FFFAF9
      F9FFFDFDFDFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFDFDFFFAF9F9FFF5F4F4FF000000500000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000050FAF9F9FFFEFE
      FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFAF9F9FF000000500000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000050FDFDFDFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFF000000500000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000050FEFEFEFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFF000000500000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000002D080808600808
      0860080808600808086008080860080808600808086008080860080808600808
      08600808086008080860080808600808086008080860080808600101012E0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000}
    ExplicitLeft = 226
    ExplicitTop = 375
    ExplicitWidth = 135
  end
  object vlRepParams: TValueListEditor
    Left = 0
    Top = 224
    Width = 575
    Height = 124
    Align = alBottom
    DisplayOptions = [doAutoColResize, doKeyColFixed]
    TabOrder = 4
    Visible = False
    ColWidths = (
      128
      441)
  end
  object cdsRep: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 512
    Top = 152
  end
end
