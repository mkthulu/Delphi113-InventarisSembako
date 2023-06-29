unit ppembelian_detail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls;

type
  TFormDetailPembelian = class(TForm)
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    EditJumlahPembelian: TEdit;
    EditCreatedAt: TEdit;
    EditUpdatedAt: TEdit;
    EditNamaPembelian: TEdit;
    EditKodePembelian: TEdit;
    EditHargaPembelian: TEdit;
    Label2: TLabel;
    EditTotalPembelian: TEdit;
    Label7: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDetailPembelian: TFormDetailPembelian;

implementation

{$R *.dfm}

end.
