unit ppembelian_tambah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, DB, Grids,
  DBGrids;

type
  TFormTambahPembelian = class(TForm)
    Label2: TLabel;
    EditHargaBarang: TEdit;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    EditNamaBarang: TEdit;
    EditKodeBarang: TEdit;
    DBGrid1: TDBGrid;
    ButtonHapusPembelian: TButton;
    Label1: TLabel;
    EditJumlahBarang: TEdit;
    ButtonTambahPembelian: TButton;
    ButtonSimpanPembelian: TButton;
    ButtonKosongkanPembelian: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ButtonTambahPembelianClick(Sender: TObject);
    procedure ButtonHapusPembelianClick(Sender: TObject);
    procedure ButtonKosongkanPembelianClick(Sender: TObject);
    procedure ButtonSimpanPembelianClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTambahPembelian: TFormTambahPembelian;

implementation

uses main, dbs;

{$R *.dfm}

procedure TFormTambahPembelian.ButtonHapusPembelianClick(Sender: TObject);
begin
  if not DoCheckInput(EditKodeBarang, 'Pilih item untuk dihapus') then
    Exit;
  with DataModule1 do
  begin
    if not ConfirmDlg('Yakin hapus data dipilih?' + sLineBreak + sLineBreak +
      'Kode: ' + ADOQueryPembelianKeranjang['kd_goods'] + String(ADOQueryPembelianKeranjang['id_goods']) + sLineBreak +
      'Nama: ' + ADOQueryPembelianKeranjang['goods_name'] + sLineBreak +
      'Harga: ' + String(ADOQueryPembelianKeranjang['supply_price']) + sLineBreak +
      'Jumlah: ' + String(ADOQueryPembelianKeranjang['supply_qty'])) then
      Exit;
    try
      ExecQuery('DELETE FROM supplies_cart WHERE id_supply=:1',
        ['1'],
        [ADOQueryPembelianKeranjang['id_supply']]);
      InfoDlg('Data berhasil dihapus');
      FormShow(Sender);
    except on E: Exception do
      ErrorDlg('Gagal! ' + sLineBreak + E.Message);
    end;
  end;
end;

procedure TFormTambahPembelian.ButtonKosongkanPembelianClick(Sender: TObject);
begin
  if not ConfirmDlg('Kosongkan batch pembelian?') then
    Exit;
  try
    with DataModule1 do
    begin
      ExecQuery('DELETE FROM supplies_cart WHERE admin_id=:1',
        ['1'],
        [adminId]);
    end;
    InfoDlg('Batch pembelian berhasil dikosongkan');
    FormShow(Sender);
  except on E: Exception do
    ErrorDlg('Gagal! ' + sLineBreak + E.Message);
  end;
end;

procedure TFormTambahPembelian.ButtonSimpanPembelianClick(Sender: TObject);
begin
  if not ConfirmDlg('Data siap untuk disimpan, lanjutkan?') then
    Exit;
  try
    with DataModule1 do
    begin
      ExecQuery('INSERT INTO supplies(goods_id, supply_price, supply_qty, admin_id, created_at, updated_at) ' +
        'SELECT goods_id, supply_price, supply_qty, admin_id, created_at, updated_at FROM supplies_cart WHERE admin_id=:1;',
        ['1'],
        [adminId]);
      ExecQuery('INSERT INTO goods(id_goods, goods_stock) SELECT goods_id, supply_qty FROM supplies_cart WHERE admin_id=:1 ' +
        'ON DUPLICATE KEY UPDATE goods_stock = goods_stock + supply_qty;',
        ['1'],
        [adminId]);
      ExecQuery('DELETE FROM supplies_cart WHERE admin_id=:1;',
        ['1'],
        [adminId]);
      InfoDlg('Batch pembelian berhasil disimpan');
      FormShow(Sender);
      FormTambahPembelian.Hide;
      FormMain.Button2Click(Sender);
    end;
  except on E: Exception do
    ErrorDlg('Gagal! ' + sLineBreak + E.Message);
  end;
end;

procedure TFormTambahPembelian.ButtonTambahPembelianClick(Sender: TObject);
var
  date: String;
begin
  if not DoCheckInput(EditKodeBarang, 'Pilih item untuk ditambahkan') or
    not DoCheckInput(EditJumlahBarang, 'Jumlah produk kosong') or
    not DoCheckInput(EditHargaBarang, 'Harga produk kosong') then
      Exit;
  try
    with DataModule1 do
    begin
      date := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
      ExecQuery('INSERT INTO supplies_cart(goods_id, supply_price, supply_qty, admin_id, created_at, updated_at) ' +
        'VALUES (:1, :2, :3, :4, :5, :6)',
        ['1', '2', '3', '4', '5', '6'],
        [ADOQueryBarang['id_goods'], EditHargaBarang.Text, EditJumlahBarang.Text, adminId, date, date]);
    end;
    InfoDlg('Data berhasil ditambahkan');
    FormShow(Sender);
  except on E: Exception do
    ErrorDlg('Gagal! ' + sLineBreak + E.Message);
  end;
end;

procedure TFormTambahPembelian.DBGrid1CellClick(Column: TColumn);
begin
  with DataModule1 do
  begin
    if not (ADOQueryPembelianKeranjang['goods_id'] = Null) then
      EditKodeBarang.Text := ADOQueryPembelianKeranjang['kd_goods'] + IntToStr(ADOQueryPembelianKeranjang['goods_id']);
    if not (ADOQueryPembelianKeranjang['goods_name'] = Null) then
      EditNamaBarang.Text := ADOQueryPembelianKeranjang['goods_name'];
    if not (ADOQueryPembelianKeranjang['supply_price'] = Null) then
      EditHargaBarang.Text := FloatToStr(ADOQueryPembelianKeranjang['supply_price']);
    if not (ADOQueryPembelianKeranjang['supply_qty'] = Null) then
      EditJumlahBarang.Text := IntToStr(ADOQueryPembelianKeranjang['supply_qty']);
  end;
end;

procedure TFormTambahPembelian.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormTambahPembelian.Hide;
  FormMain.Button2Click(Sender);
end;

procedure TFormTambahPembelian.FormShow(Sender: TObject);
begin
  with DataModule1.ADOQueryPembelianKeranjang do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM supplies_cart INNER JOIN goods ON supplies_cart.goods_id=goods.id_goods WHERE supplies_cart.admin_id=' + IntToStr(adminId));
    Active := True;
    EditKodeBarang.Clear;
    EditNamaBarang.Clear;
    EditHargaBarang.Clear;
    EditJumlahBarang.Clear;
  end;
end;

end.
