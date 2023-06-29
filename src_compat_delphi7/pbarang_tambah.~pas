unit pbarang_tambah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls;

type
  TFormTambahBarang = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EditNamaBarang: TEdit;
    EditHargaBarang: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTambahBarang: TFormTambahBarang;

implementation

uses dbs, main;

{$R *.dfm}

procedure TFormTambahBarang.Button1Click(Sender: TObject);
var
  date: String;
begin
  if not DoCheckInput(EditNamaBarang, 'Nama barang kosong!') or
    not DoCheckInput(EditHargaBarang, 'Harga barang kosong!') then
  begin end
  else
  begin
    date := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
    try
      ExecQuery('INSERT INTO goods(goods_name, goods_price, admin_id, created_at, updated_at)' +
        'VALUES (:1, :2, :3, :4, :5);' , [
        '1', '2', '3', '4', '5' ], [
        EditNamaBarang.Text,  StrToFloat(EditHargaBarang.Text), adminId, date, date]);
      InfoDlg('Data berhasil disimpan!');
      EditNamaBarang.Clear;
      EditHargaBarang.Clear;
      FormMain.Button4Click(Sender);
      FormTambahBarang.Hide;
    except on E: Exception do
      ErrorDlg('Gagal! ' + sLineBreak + E.Message);
    end;
  end;
end;

end.
