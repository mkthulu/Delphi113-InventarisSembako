program InventarisSembako;

uses
  Forms,
  login in 'login.pas' {FormLogin},
  main in 'main.pas' {FormMain},
  dbs in 'dbs.pas' {DataModule1: TDataModule},
  pbarang_tambah in 'pbarang_tambah.pas' {FormTambahBarang},
  pbarang_detail in 'pbarang_detail.pas' {FormDetailBarang},
  ppembelian_tambah in 'ppembelian_tambah.pas' {FormTambahPembelian},
  ppembelian_detail in 'ppembelian_detail.pas' {FormDetailPembelian},
  ppenjualan_tambah in 'ppenjualan_tambah.pas' {FormTambahPenjualan},
  ppenjualan_detail in 'ppenjualan_detail.pas' {FormDetailPenjualan};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFormTambahBarang, FormTambahBarang);
  Application.CreateForm(TFormDetailBarang, FormDetailBarang);
  Application.CreateForm(TFormTambahPembelian, FormTambahPembelian);
  Application.CreateForm(TFormDetailPembelian, FormDetailPembelian);
  Application.CreateForm(TFormTambahPenjualan, FormTambahPenjualan);
  Application.CreateForm(TFormDetailPenjualan, FormDetailPenjualan);
  Application.Run;
end.
