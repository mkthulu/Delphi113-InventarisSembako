unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls, Grids, DBGrids,
  DB;

type
  TFormMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ButtonKeluar: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    EditPasswordOld: TEdit;
    ButtonPengaturanAkunSimpan: TButton;
    Label4: TLabel;
    EditPassword: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    EditHargaBarang: TEdit;
    ButtonTambahBarang: TButton;
    EditNamaBarang: TEdit;
    ButtonUbahBarang: TButton;
    ButtonHapusBarang: TButton;
    DBGridBarang: TDBGrid;
    Label8: TLabel;
    EditStokBarang: TEdit;
    EditCariBarang: TEdit;
    Label9: TLabel;
    ButtonNextBarang: TButton;
    ButtonPrevBarang: TButton;
    ButtonPageBarang: TButton;
    ButtonSegarkanBarang: TButton;
    GroupBox4: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    EditJumlahPembelian: TEdit;
    ButtonTambahPembelian: TButton;
    EditNamaPembelian: TEdit;
    ButtonUbahPembelian: TButton;
    ButtonHapusPembelian: TButton;
    EditTotalPembelian: TEdit;
    EditHargaPembelian: TEdit;
    Label13: TLabel;
    ButtonNextPembelian: TButton;
    ButtonPagePembelian: TButton;
    ButtonPrevPembelian: TButton;
    DBGridPembelian: TDBGrid;
    Label14: TLabel;
    EditCariPembelian: TEdit;
    ButtonSegarkanPembelian: TButton;
    GroupBox5: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    EditJumlahPenjualan: TEdit;
    ButtonTambahPenjualan: TButton;
    EditNamaPenjualan: TEdit;
    ButtonUbahPenjualan: TButton;
    ButtonHapusPenjualan: TButton;
    EditTotalPenjualan: TEdit;
    EditHargaPenjualan: TEdit;
    DBGridPenjualan: TDBGrid;
    Label17: TLabel;
    EditCariPenjualan: TEdit;
    ButtonSegarkanPenjualan: TButton;
    ButtonNextPenjualan: TButton;
    ButtonPagePenjualan: TButton;
    ButtonPrevPenjualan: TButton;
    procedure ButtonKeluarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ButtonPengaturanAkunSimpanClick(Sender: TObject);
    procedure ButtonTambahBarangClick(Sender: TObject);
    procedure ButtonUbahBarangClick(Sender: TObject);
    procedure ButtonHapusBarangClick(Sender: TObject);
    procedure DBGridBarangCellClick(Column: TColumn);
    procedure ButtonSegarkanBarangClick(Sender: TObject);
    procedure ButtonNextBarangClick(Sender: TObject);
    procedure ButtonPrevBarangClick(Sender: TObject);
    procedure EditCariBarangChange(Sender: TObject);
    procedure ButtonTambahPembelianClick(Sender: TObject);
    procedure DBGridPembelianCellClick(Column: TColumn);
    procedure ButtonNextPembelianClick(Sender: TObject);
    procedure ButtonPrevPembelianClick(Sender: TObject);
    procedure ButtonSegarkanPembelianClick(Sender: TObject);
    procedure EditCariPembelianChange(Sender: TObject);
    procedure ButtonUbahPembelianClick(Sender: TObject);
    procedure ButtonHapusPembelianClick(Sender: TObject);
    procedure DBGridPenjualanCellClick(Column: TColumn);
    procedure ButtonNextPenjualanClick(Sender: TObject);
    procedure ButtonPrevPenjualanClick(Sender: TObject);
    procedure ButtonTambahPenjualanClick(Sender: TObject);
    procedure ButtonHapusPenjualanClick(Sender: TObject);
    procedure ButtonUbahPenjualanClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;
  launched: Boolean;

implementation

uses dbs, login,
  pbarang_tambah, pbarang_detail, ppembelian_tambah, ppembelian_detail,
  ppenjualan_tambah, ppenjualan_detail;

{$R *.dfm}

function ActivateMenus(): boolean;
begin
  FormMain.Button1.Enabled := True;
  FormMain.Button2.Enabled := True;
  FormMain.Button3.Enabled := True;
  FormMain.Button4.Enabled := True;
  FormMain.Button5.Enabled := True;
  Result := True;
end;

function DisableMenus(): boolean;
begin
  FormMain.Button1.Enabled := False;
  FormMain.Button2.Enabled := False;
  FormMain.Button3.Enabled := False;
  FormMain.Button4.Enabled := False;
  FormMain.Button5.Enabled := False;
  Result := True;
end;

procedure TFormMain.Button1Click(Sender: TObject);
begin
  ActivateMenus;
  PageControl1.ActivePage := TabSheet1;
  Button1.Enabled := false;
  if not launched then
    launched := True
  else
    with DataModule1.ADOQueryPenjualan do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT sales.*, goods.kd_goods, goods.id_goods, goods.goods_name FROM sales ' +
        'INNER JOIN goods ON sales.goods_id=goods.id_goods WHERE sales.deleted_at IS NULL ORDER BY id_sale DESC LIMIT 10;');
      Active := True;
      EditNamaPenjualan.Clear; EditJumlahPenjualan.Clear; EditHargaPenjualan.Clear; EditTotalPenjualan.Clear;
      if not (FieldValues['goods_name'] = Null) then EditNamaPenjualan.Text := FieldValues['goods_name'] + ' (' +
        FieldValues['kd_goods'] + String(FieldValues['goods_id']) + ')';
      if not (FieldValues['sale_qty'] = Null) then EditJumlahPenjualan.Text := String(FieldValues['sale_qty']);
      if not (FieldValues['sale_price'] = Null) then EditHargaPenjualan.Text := 'Rp ' + String(FieldValues['sale_price']);
      if not (FieldValues['sale_price'] = Null) and not (FieldValues['sale_price'] = Null) then
        EditTotalPenjualan.Text := 'Rp ' + String(FieldValues['sale_qty'] * FieldValues['sale_price']);
    end;
  ButtonPagePenjualan.Caption := '1';
end;

procedure TFormMain.Button2Click(Sender: TObject);
begin
  ActivateMenus;
  PageControl1.ActivePage := TabSheet2;
  Button2.Enabled := false;
  with DataModule1.ADOQueryPembelian do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT supplies.*, goods.kd_goods, goods.id_goods, goods.goods_name FROM supplies ' +
      'INNER JOIN goods ON supplies.goods_id=goods.id_goods WHERE supplies.deleted_at IS NULL ORDER BY id_supply DESC LIMIT 10;');
    Active := True;
    EditNamaPembelian.Clear; EditJumlahPembelian.Clear; EditHargaPembelian.Clear; EditTotalPembelian.Clear;
    if not (FieldValues['goods_name'] = Null) then EditNamaPembelian.Text := FieldValues['goods_name'] + ' (' +
      FieldValues['kd_goods'] + String(FieldValues['goods_id']) + ')';
    if not (FieldValues['supply_qty'] = Null) then EditJumlahPembelian.Text := String(FieldValues['supply_qty']);
    if not (FieldValues['supply_price'] = Null) then EditHargaPembelian.Text := 'Rp ' + String(FieldValues['supply_price']);
    if not (FieldValues['supply_price'] = Null) and not (FieldValues['supply_price'] = Null) then
      EditTotalPembelian.Text := 'Rp ' + String(FieldValues['supply_qty'] * FieldValues['supply_price']);
  end;
  ButtonPagePembelian.Caption := '1';
end;

procedure TFormMain.Button3Click(Sender: TObject);
begin
  ActivateMenus;
  PageControl1.ActivePage := TabSheet3;
  Button3.Enabled := false;
end;

procedure TFormMain.Button4Click(Sender: TObject);
begin
  ActivateMenus;
  PageControl1.ActivePage := TabSheet4;
  Button4.Enabled := false;
  with DataModule1.ADOQueryBarang do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM goods WHERE deleted_at IS NULL ORDER BY id_goods DESC LIMIT 10');
    Active := True;
    EditNamaBarang.Clear; EditHargaBarang.Clear; EditStokBarang.Clear;
    if not (FieldValues['goods_name'] = Null) then EditNamaBarang.Text := FieldValues['goods_name'] + ' (' +
      FieldValues['kd_goods'] + String(FieldValues['id_goods']) + ')';
    if not (FieldValues['goods_price'] = Null) then EditHargaBarang.Text := 'Rp ' + String(FieldValues['goods_price']);
    if not (FieldValues['goods_stock'] = Null) then EditStokBarang.Text := FieldValues['goods_stock'];
  end;
  ButtonPageBarang.Caption := '1';
end;

procedure TFormMain.Button5Click(Sender: TObject);
begin
  ActivateMenus;
  PageControl1.ActivePage := TabSheet5;
  Button5.Enabled := false;
end;

procedure TFormMain.ButtonKeluarClick(Sender: TObject);
begin
  if ConfirmDlg('Keluar dari aplikasi?') then
  begin
    FormLogin.Show;
    FormMain.Hide;
  end;
end;

procedure TFormMain.ButtonPengaturanAkunSimpanClick(Sender: TObject);
var
  username, password, salt, date: String;
begin
  if not DoCheckInput(EditPassword, 'Password baru tidak boleh kosong!') or
    not DoCheckInput(EditPasswordOld, 'Password lama dibutuhkan!') then
  begin end
  else if not ConfirmDlg('Yakin ubah data?') then
  begin end
  else
  begin
    with DataModule1.ADOQueryAdmin do
      if Locate('id_admin', 1, []) then
      begin
        salt := FieldValues['salt'];
        password := FieldValues['password'];
        
        if EditPasswordOld.Text+salt = password then
        begin
          salt := RandomString(15);
          password := EditPassword.Text+salt;
          date := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);

          try
          begin
            ExecQuery('UPDATE admin ' +
              'SET username=:1, password=:2, salt=:3, updated_at=:4 ' +
              'WHERE id_admin=:5;' , [
              '1', '2', '3', '4', '5' ], [
              username, password, salt, date, adminId ]);

            InfoDlg('Update data berhasil!');
            Active := false;
            Active := true;
            EditPassword.Clear;
            EditPasswordOld.Clear;
          end;
          
          except on E: Exception do
            ErrorDlg('Gagal! '+sLineBreak+E.Message);
          end;
        end
        else
          ErrorDlg('Gagal! Password lama salah.');
      end
      else
        ErrorDlg('Gagal! Data admin tidak ditemukan.');
  end;
end;

procedure TFormMain.DBGridBarangCellClick(Column: TColumn);
begin
  with DataModule1.ADOQueryBarang do
  begin
    if not (FieldValues['id_goods'] = null) then
    begin
      EditNamaBarang.Clear; EditHargaBarang.Clear; EditStokBarang.Clear;
      with FormTambahPembelian do
      begin
        EditKodeBarang.Clear; EditNamaBarang.Clear; EditHargaBarang.Clear; EditJumlahBarang.Clear;
      end;
      with FormTambahPenjualan do
      begin
        EditKodeBarang.Clear; EditNamaBarang.Clear; EditHargaBarang.Clear; EditJumlahBarang.Clear;
      end;
      if not (FieldValues['goods_name'] = Null) then
      begin
        EditNamaBarang.Text := FieldValues['goods_name'] + ' (' +
          FieldValues['kd_goods'] + String(FieldValues['id_goods']) + ')';
        FormTambahPembelian.EditNamaBarang.Text := FieldValues['goods_name'];
        FormTambahPembelian.EditKodeBarang.Text := FieldValues['kd_goods'] + String(FieldValues['id_goods']);
        FormTambahPenjualan.EditNamaBarang.Text := FieldValues['goods_name'];
        FormTambahPenjualan.EditKodeBarang.Text := FieldValues['kd_goods'] + String(FieldValues['id_goods']);
      end;
      if not (FieldValues['goods_price'] = Null) then
      begin
        EditHargaBarang.Text := 'Rp ' + String(FieldValues['goods_price']);
        FormTambahPenjualan.EditHargaBarang.Text := String(FieldValues['goods_price']);
      end;
      if not (FieldValues['goods_stock'] = Null) then EditStokBarang.Text := FieldValues['goods_stock'];
    end;
  end;
end;

procedure TFormMain.DBGridPembelianCellClick(Column: TColumn);
begin
  with DataModule1.ADOQueryPembelian do
  begin
    if not (FieldValues['id_supply'] = null) then
    begin
      EditNamaPembelian.Clear; EditJumlahPembelian.Clear; EditHargaPembelian.Clear; EditTotalPembelian.Clear;
      if not (FieldValues['goods_name'] = Null) then EditNamaPembelian.Text := FieldValues['goods_name'] + ' (' +
        FieldValues['kd_goods'] + String(FieldValues['goods_id']) + ')';
      if not (FieldValues['supply_qty'] = Null) then EditJumlahPembelian.Text := String(FieldValues['supply_qty']);
      if not (FieldValues['supply_price'] = Null) then EditHargaPembelian.Text := 'Rp ' + String(FieldValues['supply_price']);
      if not (FieldValues['supply_price'] = Null) and not (FieldValues['supply_price'] = Null) then
        EditTotalPembelian.Text := 'Rp ' + String(FieldValues['supply_qty'] * FieldValues['supply_price']);
    end;
  end;
end;

procedure TFormMain.DBGridPenjualanCellClick(Column: TColumn);
begin
  with DataModule1.ADOQueryPenjualan do
  begin
    if not (FieldValues['id_sale'] = null) then
    begin
      EditNamaPenjualan.Clear; EditJumlahPenjualan.Clear; EditHargaPenjualan.Clear; EditTotalPenjualan.Clear;
      if not (FieldValues['goods_name'] = Null) then EditNamaPenjualan.Text := FieldValues['goods_name'] + ' (' +
        FieldValues['kd_goods'] + String(FieldValues['goods_id']) + ')';
      if not (FieldValues['sale_qty'] = Null) then EditJumlahPenjualan.Text := String(FieldValues['sale_qty']);
      if not (FieldValues['sale_price'] = Null) then EditHargaPenjualan.Text := 'Rp ' + String(FieldValues['sale_price']);
      if not (FieldValues['sale_price'] = Null) and not (FieldValues['sale_price'] = Null) then
        EditTotalPenjualan.Text := 'Rp ' + String(FieldValues['sale_qty'] * FieldValues['sale_price']);
    end;
  end;
end;

procedure TFormMain.ButtonTambahBarangClick(Sender: TObject);
begin
  FormTambahBarang.Show;
end;

procedure TFormMain.ButtonUbahBarangClick(Sender: TObject);
begin
  with FormDetailBarang do
  begin
    with DataModule1 do
    if ADOQueryBarang['id_goods'] = null then
    begin
      InfoDlg('Tidak ada data yang dipilih.');
    end
    else
    begin
      EditKodeBarang.Text := ADOQueryBarang['kd_goods'] +
        String(ADOQueryBarang['id_goods']);
      EditNamaBarang.Text := ADOQueryBarang['goods_name'];
      EditHargaBarang.Text := ADOQueryBarang['goods_price'];
      EditStok.Text := ADOQueryBarang['goods_stock'];
      EditCreatedAt.Text := ADOQueryBarang['created_at'];
      EditUpdatedAt.Text := ADOQueryBarang['updated_at'];
      Show;
    end;
  end;
end;

procedure TFormMain.ButtonUbahPembelianClick(Sender: TObject);
begin
  with FormDetailPembelian do
  begin
    with DataModule1 do
    if ADOQueryPembelian['goods_id'] = null then
    begin
      InfoDlg('Tidak ada data yang dipilih.');
    end
    else
    begin
      EditKodePembelian.Text := ADOQueryPembelian['kd_supply'] +
        String(ADOQueryPembelian['id_supply']);
      EditNamaPembelian.Text := ADOQueryPembelian['goods_name'] + ' (' + ADOQueryPembelian['kd_goods'] +
        String(ADOQueryPembelian['goods_id']) + ')';
      EditHargaPembelian.Text := 'Rp ' + String(ADOQueryPembelian['supply_price']);
      EditJumlahPembelian.Text := ADOQueryPembelian['supply_qty'];
      EditTotalPembelian.Text := 'Rp ' + String(ADOQueryPembelian['supply_qty'] * ADOQueryPembelian['supply_price']);
      EditCreatedAt.Text := ADOQueryPembelian['created_at'];
      EditUpdatedAt.Text := ADOQueryPembelian['updated_at'];
      Show;
    end;
  end;
end;

procedure TFormMain.ButtonUbahPenjualanClick(Sender: TObject);
begin
  with FormDetailPenjualan do
  begin
    with DataModule1 do
    if ADOQueryPenjualan['goods_id'] = null then
    begin
      InfoDlg('Tidak ada data yang dipilih.');
    end
    else
    begin
      EditKodePenjualan.Text := ADOQueryPenjualan['kd_sale'] +
        String(ADOQueryPenjualan['id_sale']);
      EditNamaPenjualan.Text := ADOQueryPenjualan['goods_name'] + ' (' + ADOQueryPenjualan['kd_goods'] +
        String(ADOQueryPenjualan['goods_id']) + ')';
      EditHargaPenjualan.Text := 'Rp ' + String(ADOQueryPenjualan['sale_price']);
      EditJumlahPenjualan.Text := ADOQueryPenjualan['sale_qty'];
      EditTotalPenjualan.Text := 'Rp ' + String(ADOQueryPenjualan['sale_qty'] * ADOQueryPenjualan['sale_price']);
      EditCreatedAt.Text := ADOQueryPenjualan['created_at'];
      EditUpdatedAt.Text := ADOQueryPenjualan['updated_at'];
      Show;
    end;
  end;
end;

procedure TFormMain.ButtonHapusBarangClick(Sender: TObject);
var
  date: String;
begin
  with DataModule1 do
  begin
    if ADOQueryBarang['id_goods'] = null then
    begin
      InfoDlg('Tidak ada data yang dipilih.');
    end
    else if ConfirmDlg('Yakin hapus data berikut?' + sLineBreak + sLineBreak +
      'Kode Sembako: ' + ADOQueryBarang['kd_goods'] + String(ADOQueryBarang['id_goods']) +
      sLineBreak + 'Nama Sembako: ' + ADOQueryBarang['goods_name']) then
      try
        date := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
        ExecQuery('UPDATE goods ' +
          'SET deleted_at=:1 WHERE id_goods=:2;' , [
          '1', '2' ], [
          date, ADOQueryBarang['id_goods'] ]);
        InfoDlg('Data berhasil dihapus.');
        Button4Click(Sender)
      except on E: Exception do
        ErrorDlg('Gagal! ' + sLineBreak + E.Message);
      end;
  end;
end;

procedure TFormMain.ButtonHapusPembelianClick(Sender: TObject);
var
  date: String;
begin
  with DataModule1 do
  begin
    if ADOQueryPembelian['id_supply'] = null then
    begin
      InfoDlg('Tidak ada data yang dipilih.');
    end
    else if ConfirmDlg('Yakin hapus data berikut?' + sLineBreak + sLineBreak +
      'Kode Pembelian: ' + ADOQueryPembelian['kd_supply'] + String(ADOQueryPembelian['id_supply']) +
      sLineBreak + 'Nama Pembelian: ' + ADOQueryPembelian['goods_name'] + ' (' +
      ADOQueryPembelian['kd_goods'] + String(ADOQueryPembelian['goods_id']) + ')') then
      try
        date := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
        ExecQuery('INSERT INTO goods(id_goods, goods_stock) SELECT goods_id, supply_qty FROM supplies WHERE id_supply=:1 ' +
        'ON DUPLICATE KEY UPDATE goods_stock=goods_stock-supply_qty;', [
          '1' ], [
          ADOQueryPembelian['id_supply'] ]);
        ExecQuery('UPDATE supplies ' +
          'SET deleted_at=:1 WHERE id_supply=:2;' , [
          '1', '2' ], [
          date, ADOQueryPembelian['id_supply'] ]);
        InfoDlg('Data berhasil dihapus.');
        Button2Click(Sender)
      except on E: Exception do
        ErrorDlg('Gagal! ' + sLineBreak + E.Message);
      end;
  end;
end;

procedure TFormMain.ButtonHapusPenjualanClick(Sender: TObject);
var
  date: String;
begin
  with DataModule1 do
  begin
    if ADOQueryPenjualan['id_sale'] = null then
    begin
      InfoDlg('Tidak ada data yang dipilih.');
    end
    else if ConfirmDlg('Yakin hapus data berikut?' + sLineBreak + sLineBreak +
      'Kode Penjualan: ' + ADOQueryPenjualan['kd_sale'] + String(ADOQueryPenjualan['id_sale']) +
      sLineBreak + 'Nama Penjualan: ' + ADOQueryPenjualan['goods_name'] + ' (' +
      ADOQueryPenjualan['kd_goods'] + String(ADOQueryPenjualan['goods_id']) + ')') then
      try
        date := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
        ExecQuery('INSERT INTO goods(id_goods, goods_stock) SELECT goods_id, sale_qty FROM sales WHERE id_sale=:1 ' +
        'ON DUPLICATE KEY UPDATE goods_stock=goods_stock+sale_qty;', [
          '1' ], [
          ADOQueryPenjualan['id_sale'] ]);
        ExecQuery('UPDATE sales ' +
          'SET deleted_at=:1 WHERE id_sale=:2;' , [
          '1', '2' ], [
          date, ADOQueryPenjualan['id_sale'] ]);
        InfoDlg('Data berhasil dihapus.');
        Button1Click(Sender)
      except on E: Exception do
        ErrorDlg('Gagal! ' + sLineBreak + E.Message);
      end;
  end;
end;

procedure TFormMain.ButtonSegarkanBarangClick(Sender: TObject);
begin
  Button4Click(Sender);
end;

procedure TFormMain.ButtonSegarkanPembelianClick(Sender: TObject);
begin
  Button2Click(Sender);
end;

procedure TFormMain.ButtonNextBarangClick(Sender: TObject);
var
  offset, page, position, i: Integer;
  kueriBuilder: string;
begin
  with DataModule1.ADOQueryBarang do
  begin
    kueriBuilder := SQL.GetText;
    kueriBuilder := StringReplace(kueriBuilder, ';', '', [rfReplaceAll, rfIgnoreCase]);
    i := 0;
    repeat
      kueriBuilder := StringReplace(kueriBuilder, 'OFFSET ' + IntToStr(i), '', [rfReplaceAll, rfIgnoreCase]);
      i := i + 10;
    until (i > 999);
    kueriBuilder := StringReplace(kueriBuilder, 'LIMIT 10', '', [rfReplaceAll, rfIgnoreCase]);
    page := StrToInt(ButtonPageBarang.Caption);
    page := page - 1;
    offset := (page + 1) * 10;
    kueriBuilder := kueriBuilder + ' LIMIT 10 OFFSET ' + IntToStr(offset);
    Active := False;
    SQL.Clear;
    SQL.Add(kueriBuilder);
    ButtonPageBarang.Caption := IntToStr(page + 2);
    Active := True;
    EditNamaBarang.Clear; EditHargaBarang.Clear; EditStokBarang.Clear;
    if not (FieldValues['goods_name'] = Null) then EditNamaBarang.Text := FieldValues['goods_name'] + ' (' +
      FieldValues['kd_goods'] + String(FieldValues['id_goods']) + ')';
    if not (FieldValues['goods_price'] = Null) then EditHargaBarang.Text := 'Rp ' + String(FieldValues['goods_price']);
    if not (FieldValues['goods_stock'] = Null) then EditStokBarang.Text := FieldValues['goods_stock'];
  end;
end;

procedure TFormMain.ButtonNextPembelianClick(Sender: TObject);
var
  offset, page, position, i: Integer;
  kueriBuilder: string;
begin
    with DataModule1.ADOQueryPembelian do
    begin
      kueriBuilder := SQL.GetText;
      kueriBuilder := StringReplace(kueriBuilder, ';', '', [rfReplaceAll, rfIgnoreCase]);
      i := 0;
      repeat
       kueriBuilder := StringReplace(kueriBuilder, 'OFFSET ' + IntToStr(i), '', [rfReplaceAll, rfIgnoreCase]);
        i := i + 10;
      until (i > 999);
      kueriBuilder := StringReplace(kueriBuilder, 'LIMIT 10', '', [rfReplaceAll, rfIgnoreCase]);
      page := StrToInt(ButtonPagePembelian.Caption);
      page := page - 1;
      offset := (page + 1) * 10;
      kueriBuilder := kueriBuilder + ' LIMIT 10 OFFSET ' + IntToStr(offset);
      Active := False;
      SQL.Clear;
      SQL.Add(kueriBuilder);
      ButtonPagePembelian.Caption := IntToStr(page + 2);
      Active := True;
      EditNamaPembelian.Clear; EditJumlahPembelian.Clear; EditHargaPembelian.Clear; EditTotalPembelian.Clear;
      if not (FieldValues['goods_name'] = Null) then EditNamaPembelian.Text := FieldValues['goods_name'] + ' (' +
        FieldValues['kd_goods'] + String(FieldValues['goods_id']) + ')';
      if not (FieldValues['supply_qty'] = Null) then EditJumlahPembelian.Text := String(FieldValues['supply_qty']);
      if not (FieldValues['supply_price'] = Null) then EditHargaPembelian.Text := 'Rp ' + String(FieldValues['supply_price']);
      if not (FieldValues['supply_price'] = Null) and not (FieldValues['supply_price'] = Null) then
        EditTotalPembelian.Text := 'Rp ' + String(FieldValues['supply_qty'] * FieldValues['supply_price']);
    end;
end;

procedure TFormMain.ButtonNextPenjualanClick(Sender: TObject);
var
  offset, page, position, i: Integer;
  kueriBuilder: string;
begin
    with DataModule1.ADOQueryPenjualan do
    begin
      kueriBuilder := SQL.GetText;
      kueriBuilder := StringReplace(kueriBuilder, ';', '', [rfReplaceAll, rfIgnoreCase]);
      i := 0;
      repeat
       kueriBuilder := StringReplace(kueriBuilder, 'OFFSET ' + IntToStr(i), '', [rfReplaceAll, rfIgnoreCase]);
        i := i + 10;
      until (i > 999);
      kueriBuilder := StringReplace(kueriBuilder, 'LIMIT 10', '', [rfReplaceAll, rfIgnoreCase]);
      page := StrToInt(ButtonPagePenjualan.Caption);
      page := page - 1;
      offset := (page + 1) * 10;
      kueriBuilder := kueriBuilder + ' LIMIT 10 OFFSET ' + IntToStr(offset);
      Active := False;
      SQL.Clear;
      SQL.Add(kueriBuilder);
      ButtonPagePenjualan.Caption := IntToStr(page + 2);
      Active := True;
      EditNamaPenjualan.Clear; EditJumlahPenjualan.Clear; EditHargaPenjualan.Clear; EditTotalPenjualan.Clear;
      if not (FieldValues['goods_name'] = Null) then EditNamaPenjualan.Text := FieldValues['goods_name'] + ' (' +
        FieldValues['kd_goods'] + String(FieldValues['goods_id']) + ')';
      if not (FieldValues['sale_qty'] = Null) then EditJumlahPenjualan.Text := String(FieldValues['sale_qty']);
      if not (FieldValues['sale_price'] = Null) then EditHargaPenjualan.Text := 'Rp ' + String(FieldValues['sale_price']);
      if not (FieldValues['sale_price'] = Null) and not (FieldValues['sale_price'] = Null) then
        EditTotalPenjualan.Text := 'Rp ' + String(FieldValues['sale_qty'] * FieldValues['sale_price']);
    end;
end;

procedure TFormMain.ButtonPrevBarangClick(Sender: TObject);
var
  offset, page, position, i: Integer;
  kueriBuilder: string;
begin
  page := StrToInt(ButtonPageBarang.Caption);
  if Page < 2 then Exit;

    with DataModule1.ADOQueryBarang do
    begin
      kueriBuilder := SQL.GetText;
      kueriBuilder := StringReplace(kueriBuilder, ';', '', [rfReplaceAll, rfIgnoreCase]);
      i := 0;
      repeat
       kueriBuilder := StringReplace(kueriBuilder, 'OFFSET ' + IntToStr(i), '', [rfReplaceAll, rfIgnoreCase]);
        i := i + 10;
      until (i > 999);
      kueriBuilder := StringReplace(kueriBuilder, 'LIMIT 10', '', [rfReplaceAll, rfIgnoreCase]);
      page := page - 2;
      offset := page * 10;
      kueriBuilder := kueriBuilder + ' LIMIT 10 OFFSET ' + IntToStr(offset);
      Active := False;
      SQL.Clear;
      SQL.Add(kueriBuilder);
      ButtonPageBarang.Caption := IntToStr(page + 1);
      Active := True;
      EditNamaBarang.Clear; EditHargaBarang.Clear; EditStokBarang.Clear;
      if not (FieldValues['goods_name'] = Null) then EditNamaBarang.Text := FieldValues['goods_name'] + ' (' +
        FieldValues['kd_goods'] + String(FieldValues['id_goods']) + ')';
      if not (FieldValues['goods_price'] = Null) then EditHargaBarang.Text := 'Rp ' + String(FieldValues['goods_price']);
      if not (FieldValues['goods_stock'] = Null) then EditStokBarang.Text := FieldValues['goods_stock'];
    end;
end;

procedure TFormMain.ButtonPrevPembelianClick(Sender: TObject);
var
  offset, page, position, i: Integer;
  kueriBuilder: string;
begin
  page := StrToInt(ButtonPagePembelian.Caption);
  if Page < 2 then Exit;

    with DataModule1.ADOQueryPembelian do
    begin
      kueriBuilder := SQL.GetText;
      kueriBuilder := StringReplace(kueriBuilder, ';', '', [rfReplaceAll, rfIgnoreCase]);
      i := 0;
      repeat
       kueriBuilder := StringReplace(kueriBuilder, 'OFFSET ' + IntToStr(i), '', [rfReplaceAll, rfIgnoreCase]);
        i := i + 10;
      until (i > 999);
      kueriBuilder := StringReplace(kueriBuilder, 'LIMIT 10', '', [rfReplaceAll, rfIgnoreCase]);
      page := page - 2;
      offset := page * 10;
      kueriBuilder := kueriBuilder + ' LIMIT 10 OFFSET ' + IntToStr(offset);
      Active := False;
      SQL.Clear;
      SQL.Add(kueriBuilder);
      ButtonPagePembelian.Caption := IntToStr(page + 1);
      Active := True;
      EditNamaPembelian.Clear; EditJumlahPembelian.Clear; EditHargaPembelian.Clear; EditTotalPembelian.Clear;
      if not (FieldValues['goods_name'] = Null) then EditNamaPembelian.Text := FieldValues['goods_name'] + ' (' +
        FieldValues['kd_goods'] + String(FieldValues['goods_id']) + ')';
      if not (FieldValues['supply_qty'] = Null) then EditJumlahPembelian.Text := String(FieldValues['supply_qty']);
      if not (FieldValues['supply_price'] = Null) then EditHargaPembelian.Text := 'Rp ' + String(FieldValues['supply_price']);
      if not (FieldValues['supply_price'] = Null) and not (FieldValues['supply_price'] = Null) then
        EditTotalPembelian.Text := 'Rp ' + String(FieldValues['supply_qty'] * FieldValues['supply_price']);
    end;
end;

procedure TFormMain.ButtonPrevPenjualanClick(Sender: TObject);
var
  offset, page, position, i: Integer;
  kueriBuilder: string;
begin
  page := StrToInt(ButtonPagePenjualan.Caption);
  if Page < 2 then Exit;

    with DataModule1.ADOQueryPenjualan do
    begin
      kueriBuilder := SQL.GetText;
      kueriBuilder := StringReplace(kueriBuilder, ';', '', [rfReplaceAll, rfIgnoreCase]);
      i := 0;
      repeat
       kueriBuilder := StringReplace(kueriBuilder, 'OFFSET ' + IntToStr(i), '', [rfReplaceAll, rfIgnoreCase]);
        i := i + 10;
      until (i > 999);
      kueriBuilder := StringReplace(kueriBuilder, 'LIMIT 10', '', [rfReplaceAll, rfIgnoreCase]);
      page := page - 2;
      offset := page * 10;
      kueriBuilder := kueriBuilder + ' LIMIT 10 OFFSET ' + IntToStr(offset);
      Active := False;
      SQL.Clear;
      SQL.Add(kueriBuilder);
      ButtonPagePenjualan.Caption := IntToStr(page + 1);
      Active := True;
      EditNamaPenjualan.Clear; EditJumlahPenjualan.Clear; EditHargaPenjualan.Clear; EditTotalPenjualan.Clear;
      if not (FieldValues['goods_name'] = Null) then EditNamaPenjualan.Text := FieldValues['goods_name'] + ' (' +
        FieldValues['kd_goods'] + String(FieldValues['goods_id']) + ')';
      if not (FieldValues['sale_qty'] = Null) then EditJumlahPenjualan.Text := String(FieldValues['sale_qty']);
      if not (FieldValues['sale_price'] = Null) then EditHargaPenjualan.Text := 'Rp ' + String(FieldValues['sale_price']);
      if not (FieldValues['sale_price'] = Null) and not (FieldValues['sale_price'] = Null) then
        EditTotalPenjualan.Text := 'Rp ' + String(FieldValues['sale_qty'] * FieldValues['sale_price']);
    end;
end;

procedure TFormMain.EditCariBarangChange(Sender: TObject);
begin
  Button4Click(Sender);
  if EmptyString(EditCariBarang.Text) then
    Exit;

  with DataModule1.ADOQueryBarang do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM goods WHERE goods_name LIKE "%' + EditCariBarang.Text + '%" AND deleted_at IS NULL ORDER BY id_goods DESC LIMIT 10');
    Active := True;
    EditNamaBarang.Clear; EditHargaBarang.Clear; EditStokBarang.Clear;
    if not (FieldValues['goods_name'] = Null) then EditNamaBarang.Text := FieldValues['goods_name'] + ' (' +
      FieldValues['kd_goods'] + String(FieldValues['id_goods']) + ')';
    if not (FieldValues['goods_price'] = Null) then EditHargaBarang.Text := 'Rp ' + String(FieldValues['goods_price']);
    if not (FieldValues['goods_stock'] = Null) then EditStokBarang.Text := FieldValues['goods_stock'];
  end;
end;

procedure TFormMain.EditCariPembelianChange(Sender: TObject);
begin
  Button2Click(Sender);
  if EmptyString(EditCariPembelian.Text) then
    Exit;

  with DataModule1.ADOQueryPembelian do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT supplies.*, goods.kd_goods, goods.id_goods, goods.goods_name FROM supplies ' +
      'INNER JOIN goods ON supplies.goods_id=goods.id_goods WHERE goods_name LIKE "%' + EditCariPembelian.Text + '%" AND supplies.deleted_at IS NULL ORDER BY id_supply DESC LIMIT 10;');
    Active := True;
    EditNamaPembelian.Clear; EditJumlahPembelian.Clear; EditHargaPembelian.Clear; EditTotalPembelian.Clear;
    if not (FieldValues['goods_name'] = Null) then EditNamaPembelian.Text := FieldValues['goods_name'] + ' (' +
      FieldValues['kd_goods'] + String(FieldValues['goods_id']) + ')';
    if not (FieldValues['supply_qty'] = Null) then EditJumlahPembelian.Text := String(FieldValues['supply_qty']);
    if not (FieldValues['supply_price'] = Null) then EditHargaPembelian.Text := 'Rp ' + String(FieldValues['supply_price']);
    if not (FieldValues['supply_price'] = Null) and not (FieldValues['supply_price'] = Null) then
      EditTotalPembelian.Text := 'Rp ' + String(FieldValues['supply_qty'] * FieldValues['supply_price']);
  end;
end;

procedure TFormMain.ButtonTambahPembelianClick(Sender: TObject);
begin
  with FormTambahPembelian do
  begin
    EditNamaBarang.Clear; EditKodeBarang.Clear;
    EditHargaBarang.Clear; EditJumlahBarang.Clear;
    Show;
  end;
  Button4Click(Sender);
  DisableMenus;
end;

procedure TFormMain.ButtonTambahPenjualanClick(Sender: TObject);
begin
  with FormTambahPenjualan do
  begin
    EditNamaBarang.Clear; EditKodeBarang.Clear;
    EditHargaBarang.Clear; EditJumlahBarang.Clear;
    Show;
  end;
  Button4Click(Sender);
  DisableMenus;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ConfirmDlg('Keluar dari aplikasi?') then
  begin
    Application.Terminate;
  end
  else Action := caNone;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Button1Click(Sender);
end;

procedure TFormMain.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

end.
