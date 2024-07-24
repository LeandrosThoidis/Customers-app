object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 702
  ClientWidth = 927
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 929
    Height = 57
    Align = alCustom
    Caption = 'Panel1'
    TabOrder = 0
    object BtnAdd: TButton
      Left = 32
      Top = 10
      Width = 83
      Height = 25
      Caption = 'Add'
      TabOrder = 0
      OnClick = BtnAddClick
    end
    object BtnList: TButton
      Left = 416
      Top = 10
      Width = 75
      Height = 25
      Caption = 'List'
      TabOrder = 1
      OnClick = BtnListClick
    end
    object BtnUpdate: TButton
      Left = 672
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Update'
      TabOrder = 2
      OnClick = BtnUpdateClick
    end
    object BtnDelete: TButton
      Left = 176
      Top = 10
      Width = 77
      Height = 25
      Caption = 'Delete'
      TabOrder = 3
      OnClick = BtnDeleteClick
    end
    object BtnExit: TButton
      Left = 854
      Top = 0
      Width = 75
      Height = 25
      Caption = 'Exit'
      TabOrder = 4
      OnClick = BtnExitClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 55
    Width = 933
    Height = 653
    Align = alCustom
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Users\admin\Desktop\customer.db'
      'DriverID=SQLite')
    Left = 136
    Top = 288
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 408
    Top = 288
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 704
    Top = 288
  end
end
