unit ppenjualan_detail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormDetailPenjualan = class(TForm)
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    EditJumlahPenjualan: TEdit;
    EditCreatedAt: TEdit;
    EditUpdatedAt: TEdit;
    EditNamaPenjualan: TEdit;
    EditKodePenjualan: TEdit;
    EditHargaPenjualan: TEdit;
    EditTotalPenjualan: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDetailPenjualan: TFormDetailPenjualan;

implementation

{$R *.dfm}

end.
