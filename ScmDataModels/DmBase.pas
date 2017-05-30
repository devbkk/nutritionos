unit DmBase;

interface

uses
  SysUtils, Classes, DmCnMain, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom,
  XMLDoc, ShareMethod, ShareIntfModel;

type
  TDmoBase = class(TDataModule)
    schemaBase: TXMLDocument;
    qryBase: TSQLQuery;
    crProc: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
     FMainDB  :IDbConnect;
     FLstQry  :TStrings;
  protected
    { Protected declarations }
     procedure CheckTables;
     procedure CheckFields;
     procedure CreateMainDB; virtual;
     function  GenerateDataSet(const sQry, sQnm :String) :TDataSet;
     function  GetDataSet(const sQnm :String) :TDataSet;
     function  GetMaxDataStr(const sQry :String; var fldSz :Integer) :String;
     procedure Initialize;
     function  RegisterQuery(qry :TSQLQuery; name :String) :TSQLQuery;
     function  Schema :TXMLDocument; virtual;
     procedure RunSQLCommand(sQry :String);
     procedure SetConnection;
     procedure UnRegisterAllQuery;
  public
    { Public declarations }
     function MainDB :IDbConnect;
     function MainDBConnected :Boolean;
     function MainConnection :TSqlConnection;
  end;

var
  DmoBase: TDmoBase;

implementation


{$R *.dfm}

procedure TDmoBase.DataModuleCreate(Sender: TObject);
begin
  CreateMainDB;

  CheckTables;
  //CheckFields; //wait for this feature

  SetConnection;

  Initialize;
end;

procedure TDmoBase.DataModuleDestroy(Sender: TObject);
begin
  //
  UnRegisterAllQuery;
  //
  if Assigned(FLstQry) then
    FLstQry.Free;
end;

{ protected }
procedure TDmoBase.CheckFields;
var sTblName {, sTblAltCmd} :String;
    cmp :TComponent; i :Integer;
    schm :TXMLDocument;
begin
  for i := 0 to ComponentCount - 1 do begin
    cmp := Components[i];
    if cmp is TXMLDocument then begin
      schm := TXMLDocument(cmp);
      //
      sTblName := XmlGetTableName(schm);
      if sTblName<>'' then begin
        if(FMainDB.IsTableExist(sTblName)=1)then begin
          //sTablAltCmd := XmlToSqlCreateCommand(schm);
          //FMainDB.ExecCmd(sTablAltCmd);
        end;
      end;
    end;
  end;
end;

procedure TDmoBase.CheckTables;
var sTblName,sTblCrCmd :String;
    cmp :TComponent; i :Integer;
    schm :TXMLDocument;
begin
  //
  for i := 0 to ComponentCount - 1 do begin
    cmp := Components[i];
    if cmp is TXMLDocument then begin
      schm := TXMLDocument(cmp);
      //
      if schm.Tag=0 then begin
        sTblName := XmlGetTableName(schm);
        if sTblName<>'' then begin
          if(FMainDB.IsTableExist(sTblName)=0)then begin
            sTblCrCmd := XmlToSqlCreateCommand(schm);
            FMainDB.ExecCmd(sTblCrCmd);
          end;
        end;
      end;
    end;
  end;
end;

procedure TDmoBase.CreateMainDB;
begin
  FMainDB := TDmoCnMain.Create(Self);
end;

function TDmoBase.GenerateDataSet(const sQry, sQnm: String): TDataSet;
var qry :TSQLQuery;
begin
  if not MainDB.IsConnected then begin
    Result := nil;
    Exit;
  end;
  //
  qry := nil;
  qry := RegisterQuery(qry, sQnm);
  with qry do begin
    DisableControls;

    try
      if Active then
        Close;
      SQLConnection := MainDB.Connection;
      SQL.Text      := sQry;
      Open;
    finally
      EnableControls;
    end;
    Result := qry;
  end;
end;

function TDmoBase.GetDataSet(const sQnm: String): TDataSet;
var qry :TSQLQuery; idx :Integer;
begin
  if not MainDB.IsConnected then begin
    Result := nil;
    Exit;
  end;
  //
  qry := nil;
  idx := FLstQry.IndexOf(sQnm);
  if(idx>-1)then
    qry := TSQLQuery(FlstQry.Objects[idx]);
  //
  Result := qry;
end;

function TDmoBase.GetMaxDataStr(const sQry: String; var fldSz :Integer): String;
var qry :TSQLQuery;
begin
  qry := TSQLQuery.Create(nil);
  try
    //
    qry.SQLConnection := MainDB.Connection;
    qry.SQL.Text      := sQry;
    qry.Open;
    //
    fldSz  := qry.Fields[0].Size;
    Result := qry.Fields[0].AsString;
  finally
    qry.Free;
  end;
end;

procedure TDmoBase.Initialize;
begin
  FLstQry := TStringList.Create;
end;

function TDmoBase.MainConnection: TSqlConnection;
begin
  Result := FMainDB.Connection;
end;

function TDmoBase.MainDB: IDbConnect;
begin
  Result := FMainDB;
end;

function TDmoBase.MainDBConnected: Boolean;
begin
  Result := FMainDB.IsConnected;
end;

function TDmoBase.RegisterQuery(qry: TSQLQuery; name :String):TSQLQuery;
var idx :Integer;
begin

  idx := FLstQry.IndexOf(name);
  if(idx>-1)then
    qry := TSQLQuery(FlstQry.Objects[idx])
  else begin
    qry := TSQLQuery.Create(nil);
    FLstQry.AddObject(name,qry);
  end;

  Result := qry;
end;

procedure TDmoBase.RunSQLCommand(sQry: String);
var qry :TSQLQuery;
begin
  if not MainDB.IsConnected then begin
    Exit;
  end;
  //
  qry := TSQLQuery.Create(nil);
  try
    qry.SQLConnection := FMainDB.Connection;
    qry.SQL.Text := sQry;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

function TDmoBase.Schema: TXMLDocument;
begin
  Result := schemaBase;
end;

procedure TDmoBase.SetConnection;
var cmp :TComponent; i :Integer;
begin
  for i := 0 to Self.ComponentCount - 1 do begin
    cmp := Self.Components[i];
    if cmp is TSqlQuery then
      TSqlQuery(cmp).SqlConnection := FMainDB.Connection;
  end;
end;

procedure TDmoBase.UnRegisterAllQuery;
var
  i: Integer;
begin
  if not Assigned(FLstQry) then
    Exit;

  for i := 0 to pred(FLstQry.Count) do
    FLstQry.Objects[i].Free;
  FLstQry.Clear;
end;

end.


