unit DmBase;

interface

uses
  SysUtils, Classes, DmCnMain, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom,
  XMLDoc, ShareMethod;

type
  TDmoBase = class(TDataModule)
    schemaBase: TXMLDocument;
    qryBase: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
     FMainDB  :IDbConnect;
  protected
    { Protected declarations }
     procedure CheckTables;
     procedure CheckFields;
     function GetMaxDataStr(const sQry :String) :String;
     procedure Initialize;
     function Schema :TXMLDocument; virtual;
     procedure SetConnection;
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
  FMainDB :=  TDmoCnMain.Create(nil);
  //
  CheckTables;
  //CheckFields; //wait for this feature
  //
  SetConnection;
end;

procedure TDmoBase.DataModuleDestroy(Sender: TObject);
begin
  //TDmoCnMain(FMainDB).Free;
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

function TDmoBase.GetMaxDataStr(const sQry: String): String;
var qry :TSQLQuery;
begin
  qry := TSQLQuery.Create(nil);
  try
    //
    qry.SQLConnection := MainDB.Connection;
    qry.SQL.Text      := sQry;
    qry.Open;
    Result := qry.Fields[0].AsString;
  finally
    qry.Free;
  end;
end;

procedure TDmoBase.Initialize;
begin
//stub
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

end.


