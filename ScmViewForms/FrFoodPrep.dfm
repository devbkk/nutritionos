object frmFoodPrep: TfrmFoodPrep
  Left = 0
  Top = 0
  Caption = #3585#3634#3619#3648#3605#3619#3637#3618#3617#3629#3634#3627#3634#3619
  ClientHeight = 330
  ClientWidth = 709
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
  object pnlButtons: TPanel
    Left = 0
    Top = 49
    Width = 709
    Height = 32
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object sbPrintAll: TSpeedButton
      Left = 607
      Top = 2
      Width = 100
      Height = 28
      Action = actPrintAll
      Align = alRight
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00805E3900B5844E00B3824B00B3814B00B3814B00B382
        4B00B5844E00805E3900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00BA854B00FFFFFC00FFFFF500FFFFF400FFFFF400FFFF
        F500FFFFFC00BA854B00FF00FF00FF00FF00FF00FF00FF00FF005B5B5B008181
        8100818182007F838600BD854600FFFFF700FFF3DA00FFF2D900FFF2D900FFF3
        DA00FFFFF700BD8546007F83860081818200818181005B5B5B0081818100D5D2
        D100CBC9C9007D7C7C0067676800A8A6A800A4A2A400A3A2A300A3A2A300A4A2
        A400A8A6A800676768007D7C7C00CBC9C900D5D2D100818181007F7F7F00DAD7
        D600C2BFBE00C8C5C400AFACAC00AFACAB00ADAAAA00ADAAAA00ADAAAA00ADAA
        AA00AFACAB00AFACAC00C8C5C400C2BFBE00DAD7D6007F7F7F007E7E7E00E1E0
        DF00BDBBB90092908E007B7977007D7B78007D7B78007D7B78007D7B78007D7B
        78007D7B78007B79770092908E00BDBBB900E1E0DF007E7E7E007D7D7D00EDEB
        EB00B8B5B300646261006B6968006C6A69006C6A69006C6A69006C6A69006C6A
        69006C6A69006B69680064626100B8B5B300EDEBEB007D7D7D007C7C7D00F9F8
        F800F3F4F200949190009B9897009C9998009C9998009C9998009C9998009C99
        98009C9998009B98970094919000F3F4F200F9F8F8007C7C7D007C7C7D00F4F3
        F200D3D1D000827F7E0088868500898686008986850089868500898685008986
        85008986860088868500827F7E00D3D1D000F4F3F2007C7C7D007E7E7E00FFFF
        FF00FFFFFF006D6B6A00706F6F006C6B6B006A6867006A6867006A6867006A68
        67006C6B6B00706F6F006D6B6A00FFFFFF00FFFFFF007E7E7E005A5A5A007F7F
        7F007F7F800080838700BF864800FFFFF800FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFF800BF864800808387007F7F80007F7F7F005A5A5A00FF00FF00FF00
        FF00FF00FF0075777A00BA834700FFFFF300FFF0DD00FFEFDC00FFEFDC00FFF0
        DD00FFFFF300BA83470075777A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00B7834900FFFFF400FFE1C000FFE0BF00FFE0BF00FFE1
        C000FFFFF400B7834900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00B7854E00FFFFFD00FFFFF500FFFEF400FFFEF400FFFF
        F500FFFFFD00B7854E00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF007F5F3B00B5844F00B3824B00B3814B00B3814B00B382
        4B00B5844F007F5F3B00FF00FF00FF00FF00FF00FF00FF00FF00}
      ExplicitLeft = 296
    end
    object sbSelPrint: TSpeedButton
      Left = 507
      Top = 2
      Width = 100
      Height = 28
      Action = actSelPrint
      Align = alRight
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00805E3900B5844E00B3824B00B4824B00B9834E00CB86
        5300548B5000008D4C00008B4A00008C4C0000552F00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00BA854B00FFFFFC00FFFFF500FFFFF500FFFFFB006EBF
        96000097570000BB850077E0C60000BB860000995C0000552F005B5B5B008181
        8100818182007F838600BD854600FFFFF700FFF3DA00FFF3DB00FFF8E4000083
        3D0000BF8A0000BC8300FFFFFF0000BC830000C18D00008C4C0081818100D5D2
        D100CBC9C9007D7C7C0067676800A8A6A800A4A2A400A6A2A400B6A5AB000086
        3E0073E6CC00FFFFFF00FFFFFF00FFFFFF0077E7CE00008B49007F7F7F00DAD7
        D600C2BFBE00C8C5C400AFACAC00AFACAB00ADAAAA00AFABAB00BCABB000008B
        420000CD970000C99000FFFFFF0000C9900000CD9800008C49007E7E7E00E1E0
        DF00BDBBB90092908E007B7977007D7B78007D7B78007E7B7900857A7C003185
        5E0000A5640000D59E0074EFD40000D39C0000A261003C8765007D7D7D00EDEB
        EB00B8B5B300646261006B6968006C6A69006C6A69006D6A6A006F6A6A007868
        6C00297C5500008C430000873F0000843B0064B69000908086007C7C7D00F9F8
        F800F3F4F200949190009B9897009C9998009C9998009C9998009D9998009F99
        9900A4979A00A6959900A18F9400FFF5F900FFFAFE00817D7F007C7C7D00F4F3
        F200D3D1D000827F7E0088868500898686008986850089868500898685008986
        85008A8686008A858600847F7F00D5D1D100F6F4F3007D7D7D007E7E7E00FFFF
        FF00FFFFFF006D6B6A00706F6F006C6B6B006A6867006A6867006A6867006A68
        67006C6B6B00706F6F006D6B6A00FFFFFF00FFFFFF007E7E7E005A5A5A007F7F
        7F007F7F800080838700BF864800FFFFF800FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFF800BF864800808387007F7F80007F7F7F005A5A5A00FF00FF00FF00
        FF00FF00FF0075777A00BA834700FFFFF300FFF0DD00FFEFDC00FFEFDC00FFF0
        DD00FFFFF300BA83470075777A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00B7834900FFFFF400FFE1C000FFE0BF00FFE0BF00FFE1
        C000FFFFF400B7834900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00B7854E00FFFFFD00FFFFF500FFFEF400FFFEF400FFFF
        F500FFFFFD00B7854E00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF007F5F3B00B5844F00B3824B00B3814B00B3814B00B382
        4B00B5844F007F5F3B00FF00FF00FF00FF00FF00FF00FF00FF00}
      ExplicitLeft = 197
    end
    object lbFactDataType: TLabel
      Left = 2
      Top = 6
      Width = 182
      Height = 20
      Align = alCustom
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = #3586#3657#3629#3617#3641#3621' : '#3586#3657#3629#3617#3641#3621#3585#3634#3619#3648#3605#3619#3637#3618#3617#3629#3634#3627#3634#3619
      ParentBiDiMode = False
    end
    object rdoPrnAm: TRadioButton
      Left = 376
      Top = 2
      Width = 65
      Height = 28
      Action = actPrnAm
      Align = alRight
      Checked = True
      TabOrder = 0
      TabStop = True
      Visible = False
    end
    object rdoPrnPm: TRadioButton
      Left = 441
      Top = 2
      Width = 66
      Height = 28
      Action = actPrnPm
      Align = alRight
      TabOrder = 1
      Visible = False
    end
  end
  object grdFdPrep: TDBGrid
    Left = 0
    Top = 81
    Width = 709
    Height = 249
    Align = alClient
    DataSource = srcFdPrep
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    TabOrder = 1
    TitleFont.Charset = THAI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'WARDID'
        Title.Caption = #3619#3627#3633#3626#3623#3629#3619#3660#3604
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WARDNAME'
        Title.Caption = #3594#3639#3656#3629#3623#3629#3619#3660#3604
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ROOMNO'
        Title.Caption = #3627#3657#3629#3591
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BEDNO'
        Title.Caption = #3648#3605#3637#3618#3591
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HN'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PATNAME'
        Title.Caption = #3594#3639#3656#3629#3612#3641#3657#3611#3656#3623#3618
        Width = 265
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REQID'
        Title.Caption = #3648#3621#3586#3607#3637#3656#3588#3635#3626#3633#3656#3591
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRNDATE'
        Title.Caption = #3623#3633#3609#3607#3637#3656#3614#3636#3617#3614#3660
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'FOODREQDESC'
        Title.Caption = #3619#3634#3618#3621#3632#3648#3629#3637#3618#3604#3588#3635#3626#3633#3656#3591
        Visible = False
      end>
  end
  object grSearch: TGroupBox
    Left = 0
    Top = 0
    Width = 709
    Height = 49
    Align = alTop
    Caption = #3588#3657#3609#3627#3634
    TabOrder = 2
    object edSearch: TEdit
      Left = 2
      Top = 18
      Width = 705
      Height = 24
      Align = alTop
      TabOrder = 0
    end
  end
  object cdsFoodPrep: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'WARDID'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'WARDNAME'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ROOMNO'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'BEDNO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'PATNAME'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'REQID'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'PRNDATE'
        DataType = ftDateTime
      end
      item
        Name = 'FOODREQDESC'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'HN'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'DIAG'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'MEALORD'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 93
    Top = 160
    Data = {
      040100009619E0BD010000001800000009000000000003000000040106574152
      444944010049000000010005574944544802000200030008574152444E414D45
      010049000000010005574944544802000200140006524F4F4D4E4F0100490000
      000100055749445448020002000500054245444E4F0100490000000100055749
      445448020002000A00075041544E414D45010049000000010005574944544802
      0002004600055245514944010049000000010005574944544802000200050007
      50524E4441544508000800000000000B464F4F44524551444553430100490000
      00010005574944544802000200C80002484E0100490000000100055749445448
      0200020007000000}
  end
  object srcFdPrep: TDataSource
    DataSet = cdsFoodPrep
    Left = 157
    Top = 160
  end
  object dspFoodPrep: TDataSetProvider
    Left = 229
    Top = 160
  end
  object imgList: TImageList
    Left = 293
    Top = 160
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
      0000805E3900B5844E00B3824B00B3814B00B3814B00B3824B00B5844E00805E
      3900000000000000000000000000000000000000000000000000000000000000
      0000805E3900B5844E00B3824B00B4824B00B9834E00CB865300548B5000008D
      4C00008B4A00008C4C0000552F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BA854B00FFFFFC00FFFFF500FFFFF400FFFFF400FFFFF500FFFFFC00BA85
      4B00000000000000000000000000000000000000000000000000000000000000
      0000BA854B00FFFFFC00FFFFF500FFFFF500FFFFFB006EBF96000097570000BB
      850077E0C60000BB860000995C0000552F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005B5B5B0081818100818182007F83
      8600BD854600FFFFF700FFF3DA00FFF2D900FFF2D900FFF3DA00FFFFF700BD85
      46007F83860081818200818181005B5B5B005B5B5B0081818100818182007F83
      8600BD854600FFFFF700FFF3DA00FFF3DB00FFF8E40000833D0000BF8A0000BC
      8300FFFFFF0000BC830000C18D00008C4C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000081818100D5D2D100CBC9C9007D7C
      7C0067676800A8A6A800A4A2A400A3A2A300A3A2A300A4A2A400A8A6A8006767
      68007D7C7C00CBC9C900D5D2D1008181810081818100D5D2D100CBC9C9007D7C
      7C0067676800A8A6A800A4A2A400A6A2A400B6A5AB0000863E0073E6CC00FFFF
      FF00FFFFFF00FFFFFF0077E7CE00008B49000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F00DAD7D600C2BFBE00C8C5
      C400AFACAC00AFACAB00ADAAAA00ADAAAA00ADAAAA00ADAAAA00AFACAB00AFAC
      AC00C8C5C400C2BFBE00DAD7D6007F7F7F007F7F7F00DAD7D600C2BFBE00C8C5
      C400AFACAC00AFACAB00ADAAAA00AFABAB00BCABB000008B420000CD970000C9
      9000FFFFFF0000C9900000CD9800008C49000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007E7E7E00E1E0DF00BDBBB9009290
      8E007B7977007D7B78007D7B78007D7B78007D7B78007D7B78007D7B78007B79
      770092908E00BDBBB900E1E0DF007E7E7E007E7E7E00E1E0DF00BDBBB9009290
      8E007B7977007D7B78007D7B78007E7B7900857A7C0031855E0000A5640000D5
      9E0074EFD40000D39C0000A261003C8765000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007D7D7D00EDEBEB00B8B5B3006462
      61006B6968006C6A69006C6A69006C6A69006C6A69006C6A69006C6A69006B69
      680064626100B8B5B300EDEBEB007D7D7D007D7D7D00EDEBEB00B8B5B3006462
      61006B6968006C6A69006C6A69006D6A6A006F6A6A0078686C00297C5500008C
      430000873F0000843B0064B69000908086000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007C7C7D00F9F8F800F3F4F2009491
      90009B9897009C9998009C9998009C9998009C9998009C9998009C9998009B98
      970094919000F3F4F200F9F8F8007C7C7D007C7C7D00F9F8F800F3F4F2009491
      90009B9897009C9998009C9998009C9998009D9998009F999900A4979A00A695
      9900A18F9400FFF5F900FFFAFE00817D7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007C7C7D00F4F3F200D3D1D000827F
      7E00888685008986860089868500898685008986850089868500898686008886
      8500827F7E00D3D1D000F4F3F2007C7C7D007C7C7D00F4F3F200D3D1D000827F
      7E008886850089868600898685008986850089868500898685008A8686008A85
      8600847F7F00D5D1D100F6F4F3007D7D7D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007E7E7E00FFFFFF00FFFFFF006D6B
      6A00706F6F006C6B6B006A6867006A6867006A6867006A6867006C6B6B00706F
      6F006D6B6A00FFFFFF00FFFFFF007E7E7E007E7E7E00FFFFFF00FFFFFF006D6B
      6A00706F6F006C6B6B006A6867006A6867006A6867006A6867006C6B6B00706F
      6F006D6B6A00FFFFFF00FFFFFF007E7E7E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A5A5A007F7F7F007F7F80008083
      8700BF864800FFFFF800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF800BF86
      4800808387007F7F80007F7F7F005A5A5A005A5A5A007F7F7F007F7F80008083
      8700BF864800FFFFF800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF800BF86
      4800808387007F7F80007F7F7F005A5A5A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007577
      7A00BA834700FFFFF300FFF0DD00FFEFDC00FFEFDC00FFF0DD00FFFFF300BA83
      470075777A000000000000000000000000000000000000000000000000007577
      7A00BA834700FFFFF300FFF0DD00FFEFDC00FFEFDC00FFF0DD00FFFFF300BA83
      470075777A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B7834900FFFFF400FFE1C000FFE0BF00FFE0BF00FFE1C000FFFFF400B783
      4900000000000000000000000000000000000000000000000000000000000000
      0000B7834900FFFFF400FFE1C000FFE0BF00FFE0BF00FFE1C000FFFFF400B783
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B7854E00FFFFFD00FFFFF500FFFEF400FFFEF400FFFFF500FFFFFD00B785
      4E00000000000000000000000000000000000000000000000000000000000000
      0000B7854E00FFFFFD00FFFFF500FFFEF400FFFEF400FFFFF500FFFFFD00B785
      4E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F5F3B00B5844F00B3824B00B3814B00B3814B00B3824B00B5844F007F5F
      3B00000000000000000000000000000000000000000000000000000000000000
      00007F5F3B00B5844F00B3824B00B3814B00B3814B00B3824B00B5844F007F5F
      3B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000F00FF00100000000
      F00FF00000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000E007E00700000000F00FF00F00000000
      F00FF00F00000000F00FF00F0000000000000000000000000000000000000000
      000000000000}
  end
  object actList: TActionList
    Images = imgList
    Left = 365
    Top = 160
    object actSelPrint: TAction
      Category = 'Print'
      Caption = #3614#3636#3617#3614#3660#3607#3637#3656#3648#3621#3639#3629#3585
      ImageIndex = 1
    end
    object actPrintAll: TAction
      Category = 'Print'
      Caption = #3614#3636#3617#3614#3660#3607#3633#3657#3591#3627#3617#3604
      ImageIndex = 0
    end
    object actPrnAm: TAction
      Category = 'Meal'
      Caption = #3617#3639#3657#3629#3648#3594#3657#3634
    end
    object actPrnPm: TAction
      Category = 'Meal'
      Caption = #3617#3639#3657#3629#3648#3618#3655#3609
    end
  end
  object cdsSelPrn: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'WARDID'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'WARDNAME'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ROOMNO'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'BEDNO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'PATNAME'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'REQID'
        DataType = ftString
        Size = 5
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 37
    Top = 160
    Data = {
      BD0000009619E0BD010000001800000006000000000003000000BD0006574152
      444944010049000000010005574944544802000200030008574152444E414D45
      010049000000010005574944544802000200140006524F4F4D4E4F0100490000
      000100055749445448020002000500054245444E4F0100490000000100055749
      445448020002000A00075041544E414D45010049000000010005574944544802
      0002004600055245514944010049000000010005574944544802000200050000
      00}
  end
  object cdsSlipDiet: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'PRNDATE'
        DataType = ftDateTime
      end
      item
        Name = 'HN'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'PATLOCATE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PATNAME'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'DIAGDESC'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'FOODDETAIL'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'MEALORD'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 40
    Top = 216
    Data = {
      C70000009619E0BD010000001800000007000000000003000000C7000750524E
      44415445080008000000000002484E0100490000000100055749445448020002
      000700095041544C4F4341544501004900000001000557494454480200020032
      00075041544E414D450100490000000100055749445448020002006400084449
      41474445534301004900000001000557494454480200020032000A464F4F4444
      455441494C0100490000000100055749445448020002001E00074D45414C4F52
      4404000100000000000000}
  end
end
