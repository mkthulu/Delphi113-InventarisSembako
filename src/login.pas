unit login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, System.UITypes, System.Hash;

type
  TFormLogin = class(TForm)
    Image1: TImage;
    EditPassword: TEdit;
    ButtonLogin: TButton;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    procedure ButtonLoginClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

uses main, db;

{$R *.dfm}

procedure TFormLogin.ButtonLoginClick(Sender: TObject);
var
  password, salt: String;
begin
  with DataModule1.ADOQueryAdmin do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM admin WHERE id_admin=1');
    Active := True;
    if FieldValues['id_admin'] = 1 then
    begin
      salt := FieldValues['salt'];
      password := FieldValues['password'];
      adminId := FieldValues['id_admin'];
//      if THashSHA2.GetHashString(EditPassword.Text+salt) = password then
      if EditPassword.Text+salt = password then
      begin
        FormMain.Show;
        FormLogin.Hide;
        EditPassword.Clear;
        FormMain.Button1Click(Sender);
      end
      else
        ErrorDlg('Gagal! Password salah.');
    end
    else
      ErrorDlg('Gagal! Data admin tidak ditemukan.');
  end;
end;

procedure TFormLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ConfirmDlg('Keluar dari aplikasi?') then
  begin
    Application.Terminate;
  end;
  Action := caNone;
end;

end.
