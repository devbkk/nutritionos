object FrmLogin: TFrmLogin
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsDialog
  Caption = #3648#3586#3657#3634#3626#3641#3656#3619#3632#3610#3610
  ClientHeight = 167
  ClientWidth = 257
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbHeader: TLabel
    Left = 0
    Top = 0
    Width = 257
    Height = 16
    Align = alTop
    Caption = '  '#3648#3586#3657#3634#3626#3641#3656#3619#3632#3610#3610
    Color = clMedGray
    Font.Charset = THAI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    ExplicitWidth = 67
  end
  object sbtOK: TSpeedButton
    Left = 174
    Top = 133
    Width = 75
    Height = 30
    Caption = 'OK'
    Flat = True
    Glyph.Data = {
      360C0000424D360C000000000000360000002800000020000000200000000100
      180000000000000C000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000000000000000000000001C
      0F006637008A49008949008949008A49006637001C0F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000522C0091
      5200B77900CD9100D29500D29500CD9100B77900915200522C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000522C00965600CB
      8F00CD9000CB8E00CA8E00CA8E00CB8E00CD9000CB8F00965600522C00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001C0F00925100C98D00CA
      8C00C88A00C78900C78900C78900C78900C88A00CA8C00C98D009251001C0F00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000673700B37400C88A00C6
      8800C58700C58700C58700C58700C58700C58700C68800C88A00B37400673700
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008A4A00C58700C58600C3
      8500C38500C38500C38500C38500C38500C38500C38500C58600C587008A4A00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000089491ECD9700C18300C1
      8300C18300C18300C18300C18300C18300C18300C18300C1831ECD9700894900
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000089483CD4A300C07F00C0
      8100C08100C08100C08100C08100C08100C08100C08100C07F3CD4A300894800
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000894770DCBA00BD7C00BD
      7E00BE7F00BE7F00BE7F00BE7F00BE7F00BE7F00BD7E00BD7C70DCBA00894700
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000653663C7A02BC99500BA
      7A00BC7C00BC7D00BC7D00BC7D00BC7D00BC7C00BA7A2BC99563C7A000663600
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001C0F0C94578DE2C61DC4
      8B00B87500B97700B97800B97800B97700B8751DC48B8DE2C60C9457001C0F00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000005D31149A5F98E4
      C95ED5AC12BE8200B57200B57212BE825ED5AC98E4C9149A5F00512B00000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000512B0A94
      565FC49C96E2C7A1E8D0A1E8D096E2C75FC49C0A945600512B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000001C
      0F006535008946008845008845008946006535001C0F00000000000000000000
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
      0000000000000000000000000000000000000000000000000000}
    OnClick = sbtOKClick
  end
  object sbtCancel: TSpeedButton
    Left = 93
    Top = 133
    Width = 75
    Height = 30
    Caption = 'Cancel'
    Flat = True
    Glyph.Data = {
      360C0000424D360C000000000000360000002800000020000000200000000100
      180000000000000C000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000000000000000000000090C
      27212D8D2B3BBF2B3BBE2B3BBE2B3BBF212D8D090C2700000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000001B23713344
      C75164EB6578FF697CFF697CFF6578FF5164EB3344C71B237100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000001B24713546CA6072
      FE6174FE6073FD5F72FC5F72FC6073FD6174FE6072FE3546CA1B247100000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000090C273242C75B6FFC5B6F
      FC596EFA596DF9596DF9596DF9596DF9596EFA5B6FFC5B6FFC3242C7090C2700
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000222D8E485BE6576CFA5469
      F85469F75469F75469F75469F75469F75469F75469F8576CFA485BE6222D8E00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000002D3CBF5065F65066F64F65
      F44F65F44F65F44F65F44F65F44F65F44F65F44F65F45066F65065F62D3CBF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000002C3BBF6175F8485FF34960
      F24960F24960F24960F24960F24960F24960F24960F2485FF36175F82C3BBF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000002A3ABF7285F94159F1435B
      F0445CF0445CF0445CF0445CF0445CF0445CF0435BF04159F17285F92A3ABF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000002A3AC094A2F73953ED3D56
      ED3F58ED3F58ED3F58ED3F58ED3F58ED3F58ED3D56ED3953ED94A2F72A3AC000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000001F2A8D848FE65B72F0344F
      EB3852EB3A54EB3A54EB3A54EB3A54EB3852EB344FEB5B72F0848FE61F2B8E00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000090C273948C7A6B2F64D64
      EE2D48E9314BE9334DE9334DE9314BE92D48E94D64EEA6B2F63948C7090C2700
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000001C28813F4FCAAAB5
      F67D8EF13E57E92542E52542E53E57E97D8EF1AAB5F63F4FCA19227200000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000001923713747
      C77B89E3A7B2F5B0BCF8B0BCF8A7B2F57B89E33747C719237100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000090C
      271F2B8E2838C02737BF2737BF2838C01F2B8E090C2700000000000000000000
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
      0000000000000000000000000000000000000000000000000000}
    OnClick = sbtCancelClick
  end
  object imgKey: TImage
    Left = 16
    Top = 132
    Width = 32
    Height = 32
    AutoSize = True
    Center = True
    Picture.Data = {
      0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000002000
      0000200806000000737A7AF40000001974455874536F6674776172650041646F
      626520496D616765526561647971C9653C000004BF494441547801B5576D4C53
      57187EEE6D110A43652B1F666000316AA3A29923641859306E503EF4C7F6670B
      4B966566896C997373C960581016B3AF1813E3B6C41FCE84C4488241DBB11093
      75AE11998C6D2C2C63553A05A1202D946F5BEEDD738A24C08030B825EF73CFE1
      DC73DFF739EFC739A71200FDD395B62B0149CE575515A0704C7B91004992A057
      156B77B9F9100D04087018D1F1950DBEAAC20C4C290A643122DE680C850BD3C9
      32CAAE36C35D9EBB96EA87892081586385ADEFECCB5978C7EA825E270507C54B
      AD40DB084CA938939F8C23971D7878C21C47DDFD44D056DC93169BBBA6381B15
      F62E84D10514F14E3388D5FBF938919D88572EDAE1B198E3A9BC8F9826B0AEDC
      EAAE7F633F4E37B9A193C5B0F69852807733E35174FE3A862AF3E712882CB3BA
      474F9AB5B7BA80C6A88F6D18AB9A4720A2D4EA1EAF32A3BDBD9D45C01CD03811
      457149D46C32996028B361A27A11024EE7DF50A5D0C4405215A4A56D5E8CC035
      7A201F2E978BC51A1A022081E4E46412B0D20305737320A2749A4057D7FD907A
      203131696902BD3DBD242021147F1213216143C2D204061EF6430956A6F61464
      26E153C6D845087CC41054E76368D01B5202EBD6C7C050CA1CF8645E0E849300
      4B03A32323E086A5D1F2194A4994345B6A14A91D19654044D97798AC9EB713CE
      10989C1807B76C4E5FA508C3B21EB24E0F49C7C2A23A41805D48E576E0E4F373
      AB6086C0943F4002E2E8E0172B151A97695C476B1D8D5FA3FBD6658C0FF6F028
      068C1B9271763803DF5A2C0B1310970165353110C609C1FDC7CF8B6008F3C2F4
      5C1A22D71A20F184F38F4DC2D9D28DDEFBC3BD3916C746CEF34B7CC4CD78807D
      4DC479FD1B78DA2E624FDE6EA8AA8461CF303A5A3AA123B96D999BE06CEB43E7
      9D812F0F553B8E878440A3251B7B0F9AB026323298002DB6166C7BB526D8FFEB
      523176E5A4E387DA5F70A0DCFE444808588F6D86F970014B3A3C18FB66EB4D64
      1EB507BDDB7C260719857BD078A1092F54DC889538AA7908AE1DDB82FCD70F40
      0D8FA17A15BE8141FCD9F407646E72A6BD3B111D2DE3FB9ADBC8ADFC293E2404
      EA4A5271B0781F24632A7340A1597A5FD4A13869591EE377DB71C37E0F2F5A1E
      1330F030E225816CB5912B259B50F4662E1E79BC084B480458962216B23A0565
      E0017E6DBE87DB1DBE0B6F9D6B7D3FE881B5E536F750459E26D6DB2E95C1DFEF
      C0AEFDBB11F00D626AC03DBD21D1D2846F14CE7F26F0C0AB780BAB6FEEA3C14E
      0E2336EEC39ABA89F0F5597E5EDC96BF0D484C3209016E752AD65057388E8C9D
      C3E1642776E66CE7D123A3EBAE07BF3B3AE9001DE3AFA2571707D7B0ECB09CAE
      7F8F1F74121E41209A9D8D8491D0132B11DDF9D792DECE7836A9607B562A1C8D
      2E1A9531D83F0EF3A99F856BFD8F9506D80E113D8487086E44C2A881FF441082
      109BFF25FADA92AD5FA56D3116EEC848E0CA8186DA3B28F8AC358F5ABC84B8FF
      8FB015A2F031498C13824C3041D95FB1E8EB8FEEA84B4A892E303D63C42D3BAF
      F53C037CDE00F24EB56CA5D63E629478442C282B59F16C45D1D60FD27DB92FA5
      409C210DB52E147EF19B58B9302C622C3C307BFE7FFAAB25106B3B9EDEA78833
      9CFBBCF8ED97F769EBB2563EC364B50462A82885102D1B88152F6BE562B28024
      1EAB80A8BF287E1F460811D9BE64CCC5A4D9F817F843E8A01EF2209300000000
      49454E44AE426082}
    Transparent = True
  end
  object grpLogin: TGroupBox
    Left = 16
    Top = 22
    Width = 233
    Height = 105
    TabOrder = 0
    object lbLogin: TLabel
      Left = 16
      Top = 27
      Width = 50
      Height = 13
      Caption = #3594#3639#3656#3629#3612#3641#3657#3651#3594#3657#3591#3634#3609
    end
    object lbPassword: TLabel
      Left = 16
      Top = 65
      Width = 38
      Height = 13
      Caption = #3619#3627#3633#3626#3612#3656#3634#3609
    end
    object edLogin: TEdit
      Left = 72
      Top = 24
      Width = 121
      Height = 21
      BorderStyle = bsNone
      TabOrder = 0
    end
    object edPassword: TEdit
      Left = 72
      Top = 64
      Width = 121
      Height = 21
      BorderStyle = bsNone
      PasswordChar = '*'
      TabOrder = 1
    end
  end
end
