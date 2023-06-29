object DataModule1: TDataModule1
  OldCreateOrder = True
  Left = 567
  Top = 303
  Height = 480
  Width = 767
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;User ID=root;Data' +
      ' Source=MySQL ODBC - Inventaris Sembako;Initial Catalog=db_inv_s' +
      'embako'
    LoginPrompt = False
    Left = 32
    Top = 24
  end
  object DataSourceAdmin: TDataSource
    DataSet = ADOQueryAdmin
    Left = 80
    Top = 168
  end
  object DataSourceBarang: TDataSource
    DataSet = ADOQueryBarang
    Left = 184
    Top = 168
  end
  object ADOQueryAdmin: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM admin LIMIT 10')
    Left = 80
    Top = 112
  end
  object ADOQueryBarang: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT * FROM goods WHERE deleted_at IS NULL ORDER BY id_goods D' +
        'ESC LIMIT 10')
    Left = 184
    Top = 112
  end
  object ADOQueryPembelian: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT supplies.*, goods.kd_goods, goods.id_goods, goods.goods_n' +
        'ame FROM supplies INNER JOIN goods ON supplies.goods_id=goods.id' +
        '_goods WHERE supplies.deleted_at IS NULL ORDER BY id_supply DESC' +
        ' LIMIT 10;')
    Left = 376
    Top = 112
  end
  object DataSourcePembelian: TDataSource
    DataSet = ADOQueryPembelian
    Left = 376
    Top = 168
  end
  object ADOQueryPembelianKeranjang: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    Left = 376
    Top = 240
  end
  object DataSourcePembelianKeranjang: TDataSource
    DataSet = ADOQueryPembelianKeranjang
    Left = 376
    Top = 296
  end
  object ADOQueryPenjualan: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT sales.*, goods.kd_goods, goods.id_goods, goods.goods_name' +
        ' FROM sales INNER JOIN goods ON sales.goods_id=goods.id_goods WH' +
        'ERE sales.deleted_at IS NULL ORDER BY id_sale DESC LIMIT 10;')
    Left = 584
    Top = 112
  end
  object DataSourcePenjualan: TDataSource
    DataSet = ADOQueryPenjualan
    Left = 584
    Top = 168
  end
  object ADOQueryPenjualanKeranjang: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 584
    Top = 240
  end
  object DataSourcePenjualanKeranjang: TDataSource
    DataSet = ADOQueryPenjualanKeranjang
    Left = 584
    Top = 296
  end
end
