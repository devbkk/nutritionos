object frmFactData: TfrmFactData
  Left = 0
  Top = 0
  ClientHeight = 500
  ClientWidth = 673
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
  PixelsPerInch = 96
  TextHeight = 13
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 673
    Height = 500
    ActivePage = tsFact
    Align = alClient
    TabOrder = 0
    OnChange = pcMainChange
    ExplicitWidth = 641
    ExplicitHeight = 455
    object tsFact: TTabSheet
      Caption = #3586#3657#3629#3617#3641#3621#3614#3639#3657#3609#3600#3634#3609
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 633
      ExplicitHeight = 427
    end
    object tsUser: TTabSheet
      Caption = #3586#3657#3629#3617#3641#3621#3612#3641#3657#3651#3594#3657#3591#3634#3609
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  object acList: TActionList
    Images = imgList
    Left = 464
    Top = 32
    object actFdMatType: TAction
      Category = 'FoodMaterial'
      Caption = #3594#3609#3636#3604#3623#3633#3605#3606#3640#3604#3636#3610
      ImageIndex = 0
    end
    object actUser: TAction
      Category = 'System'
      Caption = #3612#3641#3657#3651#3594#3657#3591#3634#3609
      ImageIndex = 1
    end
  end
  object imgList: TImageList
    Left = 512
    Top = 32
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
      000000082E000014830000159500001487000014870000159500001483000008
      2E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000000B
      3A00001F9C00001F9C00001F9C00001F9C00001F9C00001F9C00001F9C00001F
      9C00000B3A000000000000000000000000006D6D6D00B7B7B700FBFBFB00FBFB
      FB00B5B5B500F2F2F200FBFBFB0073737300B7B7B700FBFBFB00E2E2E200C9C9
      C900FBFBFB00B7B7B7006D6D6D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000061A000029
      A200002CA500002CA500002CA500002CA500002CA500002CA500002CA500002C
      A5000029A20000061A00000000000000000086868600D0D0D000FFFFFF00D0D0
      D000FDFDFD00C8C8C800FFFFFF00ABABAB00D0D0D000FCFCFC009B9B9B00E9E9
      E900F4F4F400D0D0D00086868600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000001F6F00023A
      AE001347B4000C42B100033BAF000039AD000039AD000039AD000039AD000039
      AD000039AD00001F6F0000000000000000005C5C5C00D0D0D000E8E8E800DFDF
      DF00C1C1C100EDEDED00F3F3F300AAAAAA00D0D0D000B7B7B700EAEAEB00FFFF
      FF00C6C6C600D0D0D0005D5D5D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000051000003EB0001A58
      BE002D65C300235FC0001655BC00064AB8000046B6000046B6000046B6000046
      B6000046B600003EB000000510000000000037373700D3D3D300D4D4D400FFFF
      FF009D8D7500FFFFFF00ECECEC00B3B3B300D2D2D200F2F2F2009F9BB900EDEC
      EF00E6E6E600D6D6D60037373700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000184800004FBD00417E
      D0004581D0003A79CD002A6EC9001662C4000455C0000052BF000052BF000052
      BF000052BF000050BD00001848000000000017171700F8F8F800B7B7B700F1F0
      EE00D6C0A100FFFFFF00B6B6B600E3E3E300CFCFCF00DDDDDD009991CA007A73
      A600F4F4F400D6D6D60017171700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000001F56000663CA00659E
      DE005D99DC004E90D9003A83D5002376D0000C67CB00005FC800005FC800005F
      C800005FC8000463CA00022057000000000000000000929292009A9A9A00A595
      7F00C6B091009B8D7A00A6A6A60092929200898E9100FDFDFD009D95CE009D95
      CE00ECEEF000798289000A0D1000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000215700197AD6007FB5
      E80072AEE5005DA1E1004594DD002D86D9001377D400016DD100006CD100006C
      D100006CD100197BD60002235800000000000000000000000000010102008591
      C5009CA8DB007C88BF000101010000000000889CAE00708497009AA6D90098A4
      D8003746680094A8BA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000001C4300358EDC006BB2
      EA007CBAEC0062ADE800499FE4002C90E0001382DC00017ADA000079DA000079
      DA000079DA00368FDC00001C43000000000000000000000000003F476800A3AF
      DF00808CC40097A3D700363E6300000000007B8C9B006C7C9B00A9B5E300A3AF
      E0007985B7008699A90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000204002467AE004AA9
      EB0046A7EA0041A5E9002F9BE700369FE900309CE8000D8AE3000D8AE300138D
      E40047A7EB002467AE00000204000000000000000000000000004D516D00B1BD
      E600B7C3EC00A9B5E3003C3E580000000000606C770097A5C500BBC7EE00B1BD
      E8009EAADA008293A10000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000A14001048
      85003C86D2004089D8004089D700267DC1002674B900408CD600408CD6003C87
      D10010488500000A14000000000000000000000000000000000037384D00C9D5
      F700C2CEF300B2BEE90046465A00000000004750590094A2C000BBC7EC00AFBB
      E400717E9D005165770000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000151100009B820000C7AD0000BEA600003D310000000000000000000000
      0000000000000000000000000000000000000000000000000000535367005757
      6B00C6D2F5007A809D005E5E71000000000021262B0096A8B7007A8DA3007788
      9E009CAFC0003846510000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000005C4E0000CAB50000B5A00020BFAF00034A3E0000000000000000000000
      00000000000000000000000000000000000000000000000000000B0B0E007878
      8A003F3F52008E8E9D001D1D270000000000000000006C7B88006C7F8F00A6B6
      C3007E8E9D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000001907C001FB6A3004DC9BC003AAE9D000028210000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000129B840032938500074C4000000D0B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000F00FFFFF00000000
      E007000100000000C003000100000000C0030001000000008001000100000000
      800100010000000080018001000000008001C103000000008001C10300000000
      8001C10300000000C003C10300000000F07FC10300000000F07FC18700000000
      F07FFFFF00000000F0FFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
