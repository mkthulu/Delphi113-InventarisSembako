unit dbs;

interface

uses
  SysUtils, Classes, Variants,
  Dialogs, Controls, StdCtrls, ADODB, DB;

type
  TDataModule1 = class(TDataModule)
    ADOConnection1: TADOConnection;
    DataSourceAdmin: TDataSource;
    DataSourceBarang: TDataSource;
    ADOQueryAdmin: TADOQuery;
    ADOQueryBarang: TADOQuery;
    ADOQueryPembelian: TADOQuery;
    DataSourcePembelian: TDataSource;
    ADOQueryPembelianKeranjang: TADOQuery;
    DataSourcePembelianKeranjang: TDataSource;
    ADOQueryPenjualan: TADOQuery;
    DataSourcePenjualan: TDataSource;
    ADOQueryPenjualanKeranjang: TADOQuery;
    DataSourcePenjualanKeranjang: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;
  adminId: Integer;

function ExecQuery(const ASQL: String; const AParamNames: array of string;
    const AParamValues: array of Variant): Integer;
function RandomString(const ALength: Integer;
    const ACharSequence: String =
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'): String;
function EmptyString(const val: string): Boolean;
function DoCheckInput(Ed: TEdit; const msg: String): Boolean;
function ConfirmDlg(const msg: String): Boolean;
function InfoDlg(const msg: String): Boolean;
function ErrorDlg(const msg: String): Boolean;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function RandomString(const ALength: Integer;
  const ACharSequence: String =
  'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'): String;
var
  i, len: Integer;
begin
  len := Length(ACharSequence);
  SetLength(result, ALength);

  for i := 1 to ALength do
    Result[i] := ACharSequence[Random(len) + 1];
end;

function EmptyString(const val: String): Boolean;
begin
  Result := False;
  if (Trim(val) = '') then
    Result := True;
end;

function DoCheckInput(Ed: TEdit; const msg: String): Boolean;
begin
  Result := True;
  if EmptyString(Ed.Text) then
  begin
    ErrorDlg(msg);
    Ed.SetFocus;
    Result := False;
  end
end;

function ConfirmDlg(const msg: String): Boolean;
begin
  Result := False;
  if (MessageDlg(msg, mtConfirmation, mbOKCancel, 0) = mrOK) then
    Result := True;
end;

function InfoDlg(const msg: String): Boolean;
begin
  Result := False;
  if (MessageDlg(msg, mtInformation, [mbOK], 0) = mrOK) then
    Result := True;
end;

function ErrorDlg(const msg: String): Boolean;
begin
  Result := False;
  if (MessageDlg(msg, mtError, [mbOK], 0) = mrOK) then
    Result := True;
end;

function GetQuery(const ASQL: String): TDataSet;
var
  que: TADOQuery;
begin
    que := TADOQuery.Create(DataModule1);
    que.DisableControls;
    try
      que.CommandTimeout := 0;
      que.Connection := DataModule1.ADOConnection1;
      que.SQL.Append(ASQL);
    except
    end;
    Result := que;
end;

procedure SetParamValue(AQuery: TDataSet; const AName: string;
  const AValue: Variant);
var
    i: Integer;
    q: TADOQuery;
begin
    q := AQuery as TADOQuery;
    for i := 0 to q.Parameters.Count - 1 do
        if AnsiSameText(AName, q.Parameters[i].Name) then
        begin
            case VarType(AValue) of
                varString:
                    q.Parameters[i].DataType := ftString;
                varInteger:
                    q.Parameters[i].DataType := ftInteger;
                varInt64:
                    q.Parameters[i].DataType := ftLargeint;
                varDouble:
                    q.Parameters[i].DataType := ftFloat;
            end;

            q.Parameters[i].Value := AValue;
        end;
end;

function ExecQuery(const ASQL: String; const AParamNames: array of string;
    const AParamValues: array of Variant): Integer;
var
    q: TADOQuery;
    i: Integer;
begin
    if Length(AParamNames) <> Length(AParamValues) then
      raise Exception.Create('There are different number of parameter'+
        ' names and values.');

    q := GetQuery(ASQL) as TADOQuery;
    try
      for i := Low(AParamNames) to High(AParamNames) do
        SetParamValue(q, AParamNames[i], AParamValues[i]);
      q.ExecSQL;
      Result := q.RowsAffected;
    finally
      q.Free;
    end;
end;

end.
