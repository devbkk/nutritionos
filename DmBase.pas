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
     FMainDB  :IDmNutrCn;
  protected
    { Protected declarations }
     procedure CheckTables;
     procedure Initialize;
     function Schema :TXMLDocument; virtual;
     procedure SetConnection;
  public
    { Public declarations }
     function MainDB :IDmNutrCn;
     function MainDBConnected :Boolean;
     function MainConnection :TSQLConnection;
  end;

var
  DmoBase: TDmoBase;

implementation

{$R *.dfm}

procedure TDmoBase.DataModuleCreate(Sender: TObject);
begin
  FMainDB :=  TDmoCnMain.Create(nil);
  CheckTables;
  SetConnection;
end;

procedure TDmoBase.DataModuleDestroy(Sender: TObject);
begin
//
end;

{ protected }
procedure TDmoBase.CheckTables;
var sTblName,sTblCrCmd :String;
begin
  sTblName := XmlGetTableName(Schema);
  if(FMainDB.IsTableExist(sTblName)=0)then begin
    sTblCrCmd := XmlToSqlCreateCommand(Schema);
    FMainDB.ExecCmd(sTblCrCmd);
  end;
end;

procedure TDmoBase.Initialize;
begin
//stub
end;

function TDmoBase.MainConnection: TSQLConnection;
begin
  Result := FMainDB.Connection;
end;

function TDmoBase.MainDB: IDmNutrCn;
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
    if cmp is TSQLQuery then
      TSQLQuery(cmp).SQLConnection := FMainDB.Connection;
  end;
end;

end.


