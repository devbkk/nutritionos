object fraFactData: TfraFactData
  Left = 0
  Top = 0
  Width = 610
  Height = 276
  Font.Charset = THAI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object grSearch: TGroupBox
    Left = 0
    Top = 0
    Width = 610
    Height = 49
    Align = alTop
    Caption = #3588#3657#3609#3627#3634
    TabOrder = 0
    object edSearch: TEdit
      Left = 2
      Top = 18
      Width = 606
      Height = 24
      Align = alTop
      TabOrder = 0
    end
  end
  object grdFact: TDBGrid
    Left = 0
    Top = 81
    Width = 610
    Height = 195
    Align = alClient
    DataSource = srcFact
    TabOrder = 1
    TitleFont.Charset = THAI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODE'
        Title.Caption = #3619#3627#3633#3626
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FDES'
        Title.Caption = #3588#3635#3629#3608#3636#3610#3634#3618
        Width = 194
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FTYP'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'NOTE'
        Title.Caption = #3627#3617#3634#3618#3648#3627#3605#3640
        Width = 300
        Visible = True
      end>
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 49
    Width = 610
    Height = 32
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 2
    object sbDelCanc: TSpeedButton
      Left = 508
      Top = 2
      Width = 100
      Height = 28
      Action = actDelCanc
      Align = alRight
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF001C2A7900374DCC00384DCB00384DCC00212F7900FF00FF00FF00FF002322
        2000837E7500B0AA9E00AFA99D00AEA89C00AEA89C00B0AA9C00B9B199006C76
        B800324ED900375CF900375DFA00385DF9003852D700202E79006B676000B4AE
        A200C5BEB300D4CAC200E1D7CF00E8DED600EFE4DD00EDE2D800F0E3CE00213C
        CE003E62FC003B60FA003A5DF8003C60FA004165FB00344BCC00B1AB9F00C8C1
        B600CFC7BF00D6CCC500DCD3CA00E4D9D200EBE0D900E8DED400EEE0CA001F39
        CB00A6B8FF00FFFFFF00FFFFFF00FFFFFF00A9BAFF003148CA00B0AB9E00C7C0
        B600CDC4BB00D3CAC200DAD1C800E2D7CF00ECE1DA00E7DBD100EBDDC9001C37
        CA005875FE005775FE005473FD005776FE005D79FF00334ACB00B0AA9E00CAC3
        B900EAE5DD00F7F3EB00FFFBF400FDFAF300FDF9F200FFFAF300FFFFF3008993
        DD003954DE006C86FF00728AFF006F89FF00465EDD001F2D79006F6B6400F9F3
        ED00D8D1C900C2B8B000BFB6AE00C5BAB200C8BEB500C6BCB300C4BAAF00D1C5
        B2006771BA00233ED0002942CE002F47CD001F2D7900FF00FF00706C6400A39A
        8F00BAB2A700CAC1B800DED5CC00E5DBD300ECE1DA00E8DED500E1D7CE00D1C6
        BB00C6BBAA00B4A79000746D5A00FF00FF00FF00FF00FF00FF00B1AB9F00C9C2
        B900CFC7BF00D5CCC400DCD3CA00E3D9D100EADFD800E5DCD300DED4CC00D8CF
        C500D3CBC100CEC6BA00B7B09D00FF00FF00FF00FF00FF00FF00B0AB9E00C7C0
        B600CCC4BB00D3C9C100DAD0C700E1D7CF00EBE1DA00E4D9D100DCD1C900D5CC
        C200CEC6BD00CAC1B900B1AB9E00FF00FF00FF00FF00FF00FF00AFAA9D00C8C1
        B700E8E3DB00F5F0E800FDF8F200FCF8F100FBF7F000FCF7F100FCF8F100F6F0
        EA00E9E2DB00CAC2BA00AFA99D00FF00FF00FF00FF00FF00FF00AEA89C00FBF5
        EF00EEE7DE00E0D8CE00DDD5CC00DDD4CB00DDD4CB00DDD4CB00DDD5CC00E0D7
        CE00EDE6DE00FBF6EF00AEA89C00FF00FF00FF00FF00FF00FF00AFA99D00E1D8
        CE00E1D7CE00DFD6CC00DFD5CB00DFD5CB00DFD5CB00DFD5CB00DFD5CB00DFD6
        CC00E1D7CE00E1D8CE00AFA99D00FF00FF00FF00FF00FF00FF006A675F00B6B0
        A400D6CFC400E6DED500EFE7DD00EEE6DC00EEE6DC00EEE6DC00EFE7DD00E6DE
        D500D6CFC400B6B0A4006A675F00FF00FF00FF00FF00FF00FF00FF00FF002322
        2000827D7400AEA99C00AEA89C00AEA89C00AEA89C00AEA89C00AEA89C00AEA9
        9C00827D740023222000FF00FF00FF00FF00FF00FF00FF00FF00}
      ExplicitLeft = 296
    end
    object sbAddWrite: TSpeedButton
      Left = 408
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
        FF00FF00FF00FF00FF00FF00FF00FF00FF007B550900B7821600B6811400B880
        1000B9810F00B87F0E00B67E0F00B6801300B7821800AE7C1B00FF00FF002322
        2000837E7500B0AA9E00AFAA9F00AEADAA00B77D0900F6CC8900F3C27500F9FC
        FF008B8D9100F9F9F900F4F8FC00F2C17400F6CD8B00B78218006B676000B4AE
        A200C5BEB300D4CAC200E1D8D100EBE4E700B37A0400F3CB8800EBB65C00F2ED
        ED007F797800F1E9E200EEE9E900EAB55B00F3CC8B00B6811600B1AB9F00C8C1
        B600CFC7BF00D6CCC500DDD5CD00E8E1E300B2780300F2CD9000E6AD4F00EACF
        A900FFFFFF00FDFFFF00E8CEA700E6AD4E00F3CE9300B6811500B0AB9E00C7C0
        B600CDC4BB00D3CAC200DBD2CB00E6E0E100B1770100F4D39B00E4A64100E3A4
        3A00E3A13300E2A13200E3A43A00E3A64100F4D49E00B6811400B0AA9E00CAC3
        B900EAE5DD00F7F3EB00FFFCF700FFFFFF00B1770000F5D7A900E19E2F00E7CA
        A100EBE2E000EBE2E000E7CAA100E19E2F00F6D9AD00B68014006F6B6400F9F3
        ED00D8D1C900C2B8B000C0B7B000C7C1C200B2770000F8E0B900DD941900EEE9
        E900EFE6DE00EFE6DE00EEE9E900DD941900F8E2BC00B6801200706C6400A39A
        8F00BAB2A700CAC1B800DED6CF00E8E2E300B2770000FAE9CE00DA880200F0EE
        EC00B2ADA700B2ADA700F0EEEC00DA880200FBEAD100B67F1200B1AB9F00C9C2
        B900CFC7BF00D5CCC400DDD5CD00E7E0E100B1760000FDE8C700FBE4C100FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FCE6C400FFECCE00B7811400B0AB9E00C7C0
        B600CCC4BB00D3C9C100DAD1C900E4DCD900C9A15500B0740000B0730000B072
        0000B1730000B3750000B5790000B67D0A00B7811300AD7D1900AFAA9D00C8C1
        B700E8E3DB00F5F0E800FDF9F300FDF9F400FEFCFB00FFFEFF00FFFFFF00F8F6
        F800EBE7E800C9C7C700AEAEAF00FF00FF00FF00FF00FF00FF00AEA89C00FBF5
        EF00EEE7DE00E0D8CE00DDD5CC00DDD5CC00DDD5CD00DDD5CE00DDD6CE00E0D9
        D100EEE8E000FBF7F200AEAAA300FF00FF00FF00FF00FF00FF00AFA99D00E1D8
        CE00E1D7CE00DFD6CC00DFD5CB00DFD5CB00DFD5CB00DFD5CB00DFD5CB00DFD6
        CC00E1D7CE00E1D8CE00AFAA9E00FF00FF00FF00FF00FF00FF006A675F00B6B0
        A400D6CFC400E6DED500EFE7DD00EEE6DC00EEE6DC00EEE6DC00EFE7DD00E6DE
        D500D6CFC400B6B0A4006A675F00FF00FF00FF00FF00FF00FF00FF00FF002322
        2000827D7400AEA99C00AEA89C00AEA89C00AEA89C00AEA89C00AEA89C00AEA9
        9C00827D740023222000FF00FF00FF00FF00FF00FF00FF00FF00}
      ExplicitLeft = 197
    end
    object lbFactDataType: TLabel
      Left = 4
      Top = 6
      Width = 115
      Height = 16
      Caption = #3586#3657#3629#3617#3641#3621' : '#3586#3657#3629#3617#3641#3621#3614#3639#3657#3657#3609#3600#3634#3609
    end
    object chkSeqAdd: TCheckBox
      Left = 160
      Top = 2
      Width = 103
      Height = 28
      Align = alRight
      Caption = #3610#3633#3609#3607#3638#3585#3605#3656#3629#3648#3609#3639#3656#3629#3591
      TabOrder = 0
    end
    object cboFactDataType: TComboBox
      Left = 263
      Top = 2
      Width = 145
      Height = 24
      Align = alRight
      ItemHeight = 16
      TabOrder = 1
    end
  end
  object cdsFact: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'FDES'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'FTYP'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'NOTE'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 64
    Top = 136
    Data = {
      7E0000009619E0BD0100000018000000040000000000030000007E0004434F44
      4501004900000001000557494454480200020005000446444553010049000000
      0100055749445448020002003200044654595001004900000001000557494454
      48020002001400044E4F54450100490000000100055749445448020002006400
      0000}
  end
  object srcFact: TDataSource
    DataSet = cdsFact
    Left = 16
    Top = 136
  end
  object acList: TActionList
    Images = imgList
    Left = 16
    Top = 176
    object actAddWrite: TAction
      Caption = #3648#3614#3636#3656#3617'/'#3610#3633#3609#3607#3638#3585
      ImageIndex = 1
    end
    object actDelCanc: TAction
      Caption = #3621#3610'/'#3648#3621#3636#3585#3610#3633#3609#3607#3638#3585
      ImageIndex = 0
    end
  end
  object tmrSearch: TTimer
    Left = 16
    Top = 217
  end
  object imgList: TImageList
    Left = 64
    Top = 176
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B0AB9E00C7C0B600CDC4BB00D3CA
      C200DAD1C800E2D7CF00ECE1DA00E7DBD100EBDDC9001C37CA005875FE005775
      FE005473FD005776FE005D79FF00334ACB00B0AB9E00C7C0B600CDC4BB00D3CA
      C200DBD2CB00E6E0E100B1770100F4D39B00E4A64100E3A43A00E3A13300E2A1
      3200E3A43A00E3A64100F4D49E00B68114000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B0AA9E00CAC3B900EAE5DD00F7F3
      EB00FFFBF400FDFAF300FDF9F200FFFAF300FFFFF3008993DD003954DE006C86
      FF00728AFF006F89FF00465EDD001F2D7900B0AA9E00CAC3B900EAE5DD00F7F3
      EB00FFFCF700FFFFFF00B1770000F5D7A900E19E2F00E7CAA100EBE2E000EBE2
      E000E7CAA100E19E2F00F6D9AD00B68014000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006F6B6400F9F3ED00D8D1C900C2B8
      B000BFB6AE00C5BAB200C8BEB500C6BCB300C4BAAF00D1C5B2006771BA00233E
      D0002942CE002F47CD001F2D7900000000006F6B6400F9F3ED00D8D1C900C2B8
      B000C0B7B000C7C1C200B2770000F8E0B900DD941900EEE9E900EFE6DE00EFE6
      DE00EEE9E900DD941900F8E2BC00B68012000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000706C6400A39A8F00BAB2A700CAC1
      B800DED5CC00E5DBD300ECE1DA00E8DED500E1D7CE00D1C6BB00C6BBAA00B4A7
      9000746D5A00000000000000000000000000706C6400A39A8F00BAB2A700CAC1
      B800DED6CF00E8E2E300B2770000FAE9CE00DA880200F0EEEC00B2ADA700B2AD
      A700F0EEEC00DA880200FBEAD100B67F12000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B1AB9F00C9C2B900CFC7BF00D5CC
      C400DCD3CA00E3D9D100EADFD800E5DCD300DED4CC00D8CFC500D3CBC100CEC6
      BA00B7B09D00000000000000000000000000B1AB9F00C9C2B900CFC7BF00D5CC
      C400DDD5CD00E7E0E100B1760000FDE8C700FBE4C100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FCE6C400FFECCE00B78114000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B0AB9E00C7C0B600CCC4BB00D3C9
      C100DAD0C700E1D7CF00EBE1DA00E4D9D100DCD1C900D5CCC200CEC6BD00CAC1
      B900B1AB9E00000000000000000000000000B0AB9E00C7C0B600CCC4BB00D3C9
      C100DAD1C900E4DCD900C9A15500B0740000B0730000B0720000B1730000B375
      0000B5790000B67D0A00B7811300AD7D19000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AFAA9D00C8C1B700E8E3DB00F5F0
      E800FDF8F200FCF8F100FBF7F000FCF7F100FCF8F100F6F0EA00E9E2DB00CAC2
      BA00AFA99D00000000000000000000000000AFAA9D00C8C1B700E8E3DB00F5F0
      E800FDF9F300FDF9F400FEFCFB00FFFEFF00FFFFFF00F8F6F800EBE7E800C9C7
      C700AEAEAF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFC1FC0000000000
      8000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000100000000000000070000000000000007000000000000
      0007000000000000000700070000000000070007000000000007000700000000
      0007000700000000800F800F0000000000000000000000000000000000000000
      000000000000}
  end
  object dspFact: TDataSetProvider
    Left = 64
    Top = 216
  end
end
