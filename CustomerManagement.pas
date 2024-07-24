unit CustomerManagement;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Grids, Vcl.DBGrids, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.UI.Intf,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    BtnAdd: TButton;
    BtnList: TButton;
    BtnUpdate: TButton;
    BtnDelete: TButton;
    BtnExit: TButton;
    procedure BtnAddClick(Sender: TObject);
    procedure BtnListClick(Sender: TObject);
    procedure BtnUpdateClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure AddCustomer;
    procedure ListCustomers;
    procedure UpdateCustomer;
    procedure DeleteCustomer;
    procedure SetupDatabase;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.SetupDatabase;
begin
  try
    // Set up the connection parameters
    FDConnection1.Params.DriverID := 'SQLite';
    FDConnection1.Params.Database := 'C:\Users\admin\Desktop\customer.db';

    // Connect to the database
    FDConnection1.Connected := True;

    if FDConnection1.Connected then
    begin

      // Create the table if it doesn't exist
      FDQuery1.SQL.Text := 'CREATE TABLE IF NOT EXISTS customers (' +
                           'id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
                           'Listname TEXT NOT NULL, ' +
                           'email TEXT NOT NULL, ' +
                           'date_added DATE NOT NULL)';
      try
        FDQuery1.ExecSQL;
      except
        on E: Exception do
          ShowMessage('Error executing table creation query: ' + E.Message);
      end;
    end
    else
    begin
      ShowMessage('Failed to establish database connection.');
    end;
  except
    on E: Exception do
      ShowMessage('Error setting up database: ' + E.Message);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SetupDatabase;
  DataSource1.DataSet := FDQuery1; // Link the DataSource to FDQuery1
end;


procedure TForm1.BtnAddClick(Sender: TObject);
begin
  AddCustomer;
end;

procedure TForm1.BtnListClick(Sender: TObject);
begin
  ListCustomers;
end;

procedure TForm1.BtnUpdateClick(Sender: TObject);
begin
  UpdateCustomer;
end;

procedure TForm1.BtnDeleteClick(Sender: TObject);
begin
  DeleteCustomer;
end;

procedure TForm1.BtnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.AddCustomer;
var
  Name, Email: string;
  DateAdded: TDate;
begin
  Name := InputBox('Add Customer', 'Enter customer name:', '');
  if Name = '' then
  begin
    ShowMessage('Name cannot be empty.');
    Exit;
  end;

  Email := InputBox('Add Customer', 'Enter customer email:', '');
  if Email = '' then
  begin
    ShowMessage('Email cannot be empty.');
    Exit;
  end;

  DateAdded := Date;
  try
    FDQuery1.SQL.Text := 'INSERT INTO customers (name, email, date_added) VALUES (:name, :email, :date_added)';
    FDQuery1.ParamByName('name').AsString := Name;
    FDQuery1.ParamByName('email').AsString := Email;
    FDQuery1.ParamByName('date_added').AsDate := DateAdded;
    FDQuery1.ExecSQL;
    ShowMessage('Customer added successfully!');
  except
    on E: Exception do
      ShowMessage('Error adding customer: ' + E.Message);
  end;
end;

procedure TForm1.ListCustomers;
var
  Column: TColumn;
begin
  FDQuery1.Close;
  FDQuery1.SQL.Text := 'SELECT * FROM customers';
  FDQuery1.Open;

  DBGrid1.DataSource := DataSource1;

  // Clear existing columns to set new widths
  DBGrid1.Columns.Clear;

  // Define the columns manually and set their widths
  Column := DBGrid1.Columns.Add;
  Column.FieldName := 'id';
  Column.Title.Caption := 'ID';
  Column.Width := 40;

  Column := DBGrid1.Columns.Add;
  Column.FieldName := 'name';
  Column.Title.Caption := 'Name';
  Column.Width := 100;

  Column := DBGrid1.Columns.Add;
  Column.FieldName := 'email';
  Column.Title.Caption := 'Email';
  Column.Width := 250;

  Column := DBGrid1.Columns.Add;
  Column.FieldName := 'date_added';
  Column.Title.Caption := 'Date Added';
  Column.Width := 150;
end;


procedure TForm1.UpdateCustomer;
var
  CustomerID: string;
  Name, Email: string;
  ID: Integer;
begin
  CustomerID := InputBox('Update Customer', 'Enter customer ID to update:', '');

  if not TryStrToInt(CustomerID, ID) then
  begin
    ShowMessage('Invalid customer ID.');
    Exit;
  end;

  FDQuery1.SQL.Text := 'SELECT * FROM customers WHERE id=:id';
  FDQuery1.ParamByName('id').AsInteger := ID;
  FDQuery1.Open;

  if not FDQuery1.IsEmpty then
  begin
    Name := InputBox('Update Customers', 'Enter new name (' + FDQuery1.FieldByName('name').AsString + '):', FDQuery1.FieldByName('name').AsString);
    Email := InputBox('Update Customers', 'Enter new email (' + FDQuery1.FieldByName('email').AsString + '):', FDQuery1.FieldByName('email').AsString);

    if (Name = '') or (Email = '') then
    begin
      ShowMessage('Name and email cannot be empty.');
      Exit;
    end;

    FDQuery1.Edit;
    FDQuery1.FieldByName('name').AsString := Name;
    FDQuery1.FieldByName('email').AsString := Email;
    FDQuery1.Post;
    ShowMessage('Customer updated successfully!');
  end
  else
    ShowMessage('Customer not found.');
end;



procedure TForm1.DeleteCustomer;
var
  CustomerID: string;
begin
  CustomerID := InputBox('Delete Customer', 'Enter customer ID to delete:', '');
  FDQuery1.SQL.Text := 'DELETE FROM customers WHERE id=:id';
  FDQuery1.ParamByName('id').AsInteger := StrToInt(CustomerID);
  FDQuery1.ExecSQL;
  ShowMessage('Customer deleted successfully!');
end;

end.

