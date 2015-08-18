object fraDBConfig: TfraDBConfig
  Left = 0
  Top = 0
  Width = 442
  Height = 298
  Font.Charset = THAI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object grSave: TGroupBox
    Left = 0
    Top = 32
    Width = 442
    Height = 121
    Align = alTop
    Caption = #3610#3633#3609#3607#3638#3585
    TabOrder = 0
    object lbServer: TLabel
      Left = 16
      Top = 26
      Width = 38
      Height = 16
      Caption = 'Server'
    end
    object lbDatabase: TLabel
      Left = 16
      Top = 55
      Width = 53
      Height = 16
      Caption = 'Database'
    end
    object lbLogin: TLabel
      Left = 16
      Top = 83
      Width = 26
      Height = 16
      Caption = 'User'
    end
    object lbPassword: TLabel
      Left = 228
      Top = 83
      Width = 55
      Height = 16
      Caption = 'Password'
    end
    object edServer: TEdit
      Left = 89
      Top = 22
      Width = 209
      Height = 24
      TabOrder = 0
    end
    object edDatabase: TEdit
      Left = 89
      Top = 52
      Width = 207
      Height = 24
      TabOrder = 1
    end
    object edUser: TEdit
      Left = 89
      Top = 80
      Width = 121
      Height = 24
      TabOrder = 2
    end
    object edPassword: TEdit
      Left = 297
      Top = 80
      Width = 121
      Height = 24
      PasswordChar = '*'
      TabOrder = 3
    end
  end
  object grCmd: TPanel
    Left = 0
    Top = 0
    Width = 442
    Height = 32
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 1
    object sbAddWrite: TSpeedButton
      Left = 340
      Top = 2
      Width = 100
      Height = 28
      Action = actAddWrite
      Align = alRight
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00AC731400AD751900AC731600AC721400AB72
        1400AA711300AA701300AA701300AA711300AC741900B07A2300563E0D00B782
        1600B37A0600D7D0D400D8D1D300A96D0B00F7EFE300FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AC741900B7821800F6CC
        8A00F0C17200F9F7FC00FFFFFF00A6690500F5EBDA00979A9F00535456009596
        9700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AA711400B6811600F3CA
        8600EBB66000F8F5F800FFFFFF00A5680300F5EAD900FFFFFF0057575700FFFF
        FF00FBFBFA00F6F6F500F5F5F400F5F7F700FFFFFF00AA711300B6811600F1CA
        8900E8B15500F9F8FD00FAF8FB00A6690500F6ECDB008C8E9200545556008B8B
        8C00E3E2E300DFDEDE00DEDEDE00DDDEE000FFFFFF00AA711400B6811500F3CB
        8F00E6AD4D00FDFFFF00EEE7E500A76B0900F6EFE300FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AC741900B6811500F3D0
        9500E4AA4600E8CBA500FFFFFF00A66D1000A76F1300A76D1000A66D0E00A66C
        0E00A56C0E00A56B0E00A66C0E00A96F1200AC741900B07A2300B6811500F3D3
        9C00E3A53E00E2A23700E4A13200E6A43700E7A53A00E7A63A00E7A63A00E7A6
        3C00E7A84000E8AA4300F6D69E00B8821200FF00FF00FF00FF00B6811400F4D5
        A400E09E3100F4E0B700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00F4E1B800E19F3200F5D6A400B6811400FF00FF00FF00FF00B6801400F5DA
        AE00DF982200FCFFFF00797C8000A1A3A500FEFBF200797A7C00A3A4A600A0A3
        A700FBFEFF00DF972200F5DAAE00B6801400FF00FF00FF00FF00B6801300F7DF
        B900DD921500FCFCFC00FDF8EC00FFF8EA00FDF6E800FCF6E800FBF4E700F9F4
        E800FAFAFA00DC911500F7DFB900B6801300FF00FF00FF00FF00B67F1200FAE5
        C500DA8C0900FEFEFF00787879007A797900A2A1A1009F9E9E00F5EBE0009B9B
        9D00FCFCFF00DA8C0900FAE5C500B67F1200FF00FF00FF00FF00B67F1200FBEC
        D200D8840000FFFFFF00F1E5DA00F2E6DA00F2E6DA00F0E4D800EEE2D700EEE2
        D800FEFFFF00D8830000FBECD200B67F1200FF00FF00FF00FF00B7811400FFEC
        CD00FCE6C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FCE6C300FFECCD00B7811400FF00FF00FF00FF00563E0D00B781
        1400B57E0F00B57C0B00B57C0900B57C0900B57C0900B57C0900B57C0900B57C
        0900B57C0B00B57E0F00B7811400563E0D00FF00FF00FF00FF00}
      ExplicitLeft = 197
    end
    object lbFactDataType: TLabel
      Left = 4
      Top = 6
      Width = 126
      Height = 16
      Caption = #3586#3657#3629#3617#3641#3621' : '#3605#3633#3657#3591#3588#3656#3634#3600#3634#3609#3586#3657#3629#3617#3641#3621
    end
  end
  object acList: TActionList
    Images = imgList
    Left = 24
    Top = 205
    object actAddWrite: TAction
      Caption = #3610#3633#3609#3607#3638#3585
      ImageIndex = 4
      OnExecute = actAddWriteExecute
    end
    object actDelCanc: TAction
      Caption = #3621#3610'/'#3648#3621#3636#3585#3610#3633#3609#3607#3638#3585
      ImageIndex = 0
    end
    object actPrev: TAction
      Caption = 'actPrev'
      ImageIndex = 3
    end
    object actNext: TAction
      Caption = 'actNext'
      ImageIndex = 2
    end
  end
  object imgList: TImageList
    Left = 72
    Top = 205
    Bitmap = {
      494C010105000900080010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AC731400AD751900AC731600AC721400AB721400AA711300AA70
      1300AA701300AA711300AC741900B07A23000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000563E0D00B7821600B37A0600D7D0
      D400D8D1D300A96D0B00F7EFE300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00AC7419000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B7821800F6CC8A00F0C17200F9F7
      FC00FFFFFF00A6690500F5EBDA00979A9F005354560095969700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00AA7114000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B6811600F3CA8600EBB66000F8F5
      F800FFFFFF00A5680300F5EAD900FFFFFF0057575700FFFFFF00FBFBFA00F6F6
      F500F5F5F400F5F7F700FFFFFF00AA7113000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B6811600F1CA8900E8B15500F9F8
      FD00FAF8FB00A6690500F6ECDB008C8E9200545556008B8B8C00E3E2E300DFDE
      DE00DEDEDE00DDDEE000FFFFFF00AA7114000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B6811500F3CB8F00E6AD4D00FDFF
      FF00EEE7E500A76B0900F6EFE300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00AC7419000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B6811500F3D09500E4AA4600E8CB
      A500FFFFFF00A66D1000A76F1300A76D1000A66D0E00A66C0E00A56C0E00A56B
      0E00A66C0E00A96F1200AC741900B07A23000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B6811500F3D39C00E3A53E00E2A2
      3700E4A13200E6A43700E7A53A00E7A63A00E7A63A00E7A63C00E7A84000E8AA
      4300F6D69E00B882120000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B6811400F4D5A400E09E3100F4E0
      B700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4E1B800E19F
      3200F5D6A400B681140000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B6801400F5DAAE00DF982200FCFF
      FF00797C8000A1A3A500FEFBF200797A7C00A3A4A600A0A3A700FBFEFF00DF97
      2200F5DAAE00B680140000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B6801300F7DFB900DD921500FCFC
      FC00FDF8EC00FFF8EA00FDF6E800FCF6E800FBF4E700F9F4E800FAFAFA00DC91
      1500F7DFB900B680130000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B67F1200FAE5C500DA8C0900FEFE
      FF00787879007A797900A2A1A1009F9E9E00F5EBE0009B9B9D00FCFCFF00DA8C
      0900FAE5C500B67F120000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B67F1200FBECD200D8840000FFFF
      FF00F1E5DA00F2E6DA00F2E6DA00F0E4D800EEE2D700EEE2D800FEFFFF00D883
      0000FBECD200B67F120000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B7811400FFECCD00FCE6C300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCE6
      C300FFECCD00B781140000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000563E0D00B7811400B57E0F00B57C
      0B00B57C0900B57C0900B57C0900B57C0900B57C0900B57C0900B57C0B00B57E
      0F00B7811400563E0D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001C2A7900374D
      CC00384DCB00384DCC00212F7900000000000000000000000000000000000000
      000000000000000000007B550900B7821600B6811400B8801000B9810F00B87F
      0E00B67E0F00B6801300B7821800AE7C1B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000023222000837E7500B0AA
      9E00AFA99D00AEA89C00AEA89C00B0AA9C00B9B199006C76B800324ED900375C
      F900375DFA00385DF9003852D700202E79000000000023222000837E7500B0AA
      9E00AFAA9F00AEADAA00B77D0900F6CC8900F3C27500F9FCFF008B8D9100F9F9
      F900F4F8FC00F2C17400F6CD8B00B78218000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B676000B4AEA200C5BEB300D4CA
      C200E1D7CF00E8DED600EFE4DD00EDE2D800F0E3CE00213CCE003E62FC003B60
      FA003A5DF8003C60FA004165FB00344BCC006B676000B4AEA200C5BEB300D4CA
      C200E1D8D100EBE4E700B37A0400F3CB8800EBB65C00F2EDED007F797800F1E9
      E200EEE9E900EAB55B00F3CC8B00B68116000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B1AB9F00C8C1B600CFC7BF00D6CC
      C500DCD3CA00E4D9D200EBE0D900E8DED400EEE0CA001F39CB00A6B8FF00FFFF
      FF00FFFFFF00FFFFFF00A9BAFF003148CA00B1AB9F00C8C1B600CFC7BF00D6CC
      C500DDD5CD00E8E1E300B2780300F2CD9000E6AD4F00EACFA900FFFFFF00FDFF
      FF00E8CEA700E6AD4E00F3CE9300B68115000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000045
      2600008C4B00000000000000000000000000000000000000000000000000008C
      4B00006D3B000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B0AB9E00C7C0B600CDC4BB00D3CA
      C200DAD1C800E2D7CF00ECE1DA00E7DBD100EBDDC9001C37CA005875FE005775
      FE005473FD005776FE005D79FF00334ACB00B0AB9E00C7C0B600CDC4BB00D3CA
      C200DBD2CB00E6E0E100B1770100F4D39B00E4A64100E3A43A00E3A13300E2A1
      3200E3A43A00E3A64100F4D49E00B68114000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000088
      470054DAB00000874600000000000000000000000000000000000087460054DA
      B000008847000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B0AA9E00CAC3B900EAE5DD00F7F3
      EB00FFFBF400FDFAF300FDF9F200FFFAF300FFFFF3008993DD003954DE006C86
      FF00728AFF006F89FF00465EDD001F2D7900B0AA9E00CAC3B900EAE5DD00F7F3
      EB00FFFCF700FFFFFF00B1770000F5D7A900E19E2F00E7CAA100EBE2E000EBE2
      E000E7CAA100E19E2F00F6D9AD00B680140000552E00008A4900008947000089
      47000089470000894700008947000089470000894700008846000086440000B9
      7F0000D8A00065D7B3000087440000000000000000000087440065D7B30000D8
      A00000B97F000086440000884600008947000089470000894700008947000089
      47000089470000894700008A4900006135006F6B6400F9F3ED00D8D1C900C2B8
      B000BFB6AE00C5BAB200C8BEB500C6BCB300C4BAAF00D1C5B2006771BA00233E
      D0002942CE002F47CD001F2D7900000000006F6B6400F9F3ED00D8D1C900C2B8
      B000C0B7B000C7C1C200B2770000F8E0B900DD941900EEE9E900EFE6DE00EFE6
      DE00EEE9E900DD941900F8E2BC00B6801200008A490000D5A70000D1A10000D0
      A00000D0A00000D0A00000D0A00000D0A00000D0A00000D0A00000CF9F0000CD
      9C0000CB9A0000CD9C0074DABD00008A4800008A480074DABD0000CD9C0000CB
      9A0000CD9C0000CF9F0000D0A00000D0A00000D0A00000D0A00000D0A00000D0
      A00000D0A00000D1A10000D5A700008A4900706C6400A39A8F00BAB2A700CAC1
      B800DED5CC00E5DBD300ECE1DA00E8DED500E1D7CE00D1C6BB00C6BBAA00B4A7
      9000746D5A00000000000000000000000000706C6400A39A8F00BAB2A700CAC1
      B800DED6CF00E8E2E300B2770000FAE9CE00DA880200F0EEEC00B2ADA700B2AD
      A700F0EEEC00DA880200FBEAD100B67F1200008A480065E6D10061E2CB0061E1
      CA0061E1CA0061E1CA0061E1CA0061E1CA0061E1CA0061E1CA0061E0C80064DF
      C70000C49A0000C59C0086DEC800008A4800008A480086DEC80000C59C0000C4
      9A0064DFC70061E0C80061E1CA0061E1CA0061E1CA0061E1CA0061E1CA0061E1
      CA0061E1CA0061E2CB0065E6D100008A4800B1AB9F00C9C2B900CFC7BF00D5CC
      C400DCD3CA00E3D9D100EADFD800E5DCD300DED4CC00D8CFC500D3CBC100CEC6
      BA00B7B09D00000000000000000000000000B1AB9F00C9C2B900CFC7BF00D5CC
      C400DDD5CD00E7E0E100B1760000FDE8C700FBE4C100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FCE6C400FFECCE00B781140000613400008A4700008845000088
      44000088440000884400008844000088440000884400008744000086410000AB
      7D0000C09E009BE0D000008743000000000000000000008743009BE0D00000C0
      9E0000AB7D000086410000874400008844000088440000884400008844000088
      44000088440000884500008A470000613400B0AB9E00C7C0B600CCC4BB00D3C9
      C100DAD0C700E1D7CF00EBE1DA00E4D9D100DCD1C900D5CCC200CEC6BD00CAC1
      B900B1AB9E00000000000000000000000000B0AB9E00C7C0B600CCC4BB00D3C9
      C100DAD1C900E4DCD900C9A15500B0740000B0730000B0720000B1730000B375
      0000B5790000B67D0A00B7811300AD7D19000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000089
      4500A4E4D900008743000000000000000000000000000000000000874300A4E4
      D900008945000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AFAA9D00C8C1B700E8E3DB00F5F0
      E800FDF8F200FCF8F100FBF7F000FCF7F100FCF8F100F6F0EA00E9E2DB00CAC2
      BA00AFA99D00000000000000000000000000AFAA9D00C8C1B700E8E3DB00F5F0
      E800FDF9F300FDF9F400FEFCFB00FFFEFF00FFFFFF00F8F6F800EBE7E800C9C7
      C700AEAEAF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000055
      2E00008C4900000000000000000000000000000000000000000000000000008C
      4900007941000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AEA89C00FBF5EF00EEE7DE00E0D8
      CE00DDD5CC00DDD4CB00DDD4CB00DDD4CB00DDD5CC00E0D7CE00EDE6DE00FBF6
      EF00AEA89C00000000000000000000000000AEA89C00FBF5EF00EEE7DE00E0D8
      CE00DDD5CC00DDD5CC00DDD5CD00DDD5CE00DDD6CE00E0D9D100EEE8E000FBF7
      F200AEAAA3000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AFA99D00E1D8CE00E1D7CE00DFD6
      CC00DFD5CB00DFD5CB00DFD5CB00DFD5CB00DFD5CB00DFD6CC00E1D7CE00E1D8
      CE00AFA99D00000000000000000000000000AFA99D00E1D8CE00E1D7CE00DFD6
      CC00DFD5CB00DFD5CB00DFD5CB00DFD5CB00DFD5CB00DFD6CC00E1D7CE00E1D8
      CE00AFAA9E000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006A675F00B6B0A400D6CFC400E6DE
      D500EFE7DD00EEE6DC00EEE6DC00EEE6DC00EFE7DD00E6DED500D6CFC400B6B0
      A4006A675F000000000000000000000000006A675F00B6B0A400D6CFC400E6DE
      D500EFE7DD00EEE6DC00EEE6DC00EEE6DC00EFE7DD00E6DED500D6CFC400B6B0
      A4006A675F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000023222000827D7400AEA9
      9C00AEA89C00AEA89C00AEA89C00AEA89C00AEA89C00AEA99C00827D74002322
      2000000000000000000000000000000000000000000023222000827D7400AEA9
      9C00AEA89C00AEA89C00AEA89C00AEA89C00AEA89C00AEA99C00827D74002322
      2000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000F800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000030000000000000003000000000000
      0003000000000000000300000000000000030000000000000003000000000000
      00030000000000000003000000000000FFFFFFFFFFFFFFFFFFC1FC00FFFFFFFF
      80008000FFFFFFFF00000000FFFFFFFF00000000FFE7E7FF00000000FFE3C7FF
      0000000000018000000100000000000000070000000000000007000000018000
      00070000FFE3C7FF00070007FFE7E7FF00070007FFFFFFFF00070007FFFFFFFF
      00070007FFFFFFFF800F800FFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end
