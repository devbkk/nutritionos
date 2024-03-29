unit DmBase;

interface

uses
  SysUtils, Classes, DmCnMain, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom,
  XMLDoc, ShareMethod, ShareIntfModel, RegExpr, StrUtils;

type
  TEnumObjDB = (eoView=Ord('V'),eoFunc=Ord('F'),eoProc=Ord('P'));

  TRecObjDB = record
    ObjName, CrObjQry :String;
    ObjType :TEnumObjDB;
  end;

  TDmoBase = class(TDataModule)
    schemaBase: TXMLDocument;
    qryBase: TSQLQuery;
    crDbObj: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
     FMainDB  :IDbConnect;
     FLstQry  :TStrings;
     function GetSchemaName(qry :TSQLQuery) :String;
  protected
    { Protected declarations }
     procedure CheckDbObject(const p :TRecObjDB);
     procedure CheckTables;
     procedure CheckFields;
     procedure CheckViews;
     //
     procedure CreateMainDB; virtual;
     //
     function  DbObjectExist(objName :String; objType:TEnumObjDB):Boolean;
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
  //
  CheckTables;
  CheckViews;
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

function TDmoBase.DbObjectExist(objName: String; objType:TEnumObjDB): Boolean;

const
c_qry  = 'SELECT * FROM dbo.sysobjects '+
         'WHERE xtype in (%S) '+
         'AND id = OBJECT_ID(%S)';

c_view = 'V'; c_proc = 'P'; c_func = '''FN'',''IF'',''TF''';

c_obj  = 'objDB';

var
sTyp, sQry :String;

begin
  case objType of
    eoView: sTyp := c_view;
    eoFunc: sTyp := c_func;
    eoProc: sTyp := c_proc;
  end;
  //
  sQry := Format(c_qry,[QuotedStr(sTyp), QuotedStr(objName)]);
  Result := not GenerateDataSet(sQry,c_obj).IsEmpty;
end;

{ protected }
procedure TDmoBase.CheckDbObject(const p: TRecObjDB);
begin
  if DbObjectExist(p.ObjName,p.ObjType)then
    Exit;

  if not Assigned(crDbObj.SQLConnection) then
    crDbObj.SQLConnection := MainDB.Connection;

  crDbObj.SQL.Text := p.CrObjQry;
  crDbObj.ExecSQL();
end;

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

procedure TDmoBase.CheckViews;
var sVwName, sVwCrCmd :String;
    cmp :TComponent; i :Integer;
    qry :TSQLQuery;
begin
  for i := 0 to ComponentCount - 1 do begin
    cmp := Components[i];
    if cmp is TSQLQuery then begin
      qry := TSQLQuery(cmp);
      //
      if qry.Tag=1 then begin
        sVwName := GetSchemaName(qry);
        if sVwName<>'' then begin
          if(FMainDB.IsViewExist(sVwName)=0)then begin
            sVwCrCmd := qry.SQL.Text;
            FMainDB.ExecCmd(sVwCrCmd);
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

function TDmoBase.GetSchemaName(qry: TSQLQuery): String;
var r :TRegExpr; sExpr, sInput :String;

const
c_expr_telno = '(\+\d *)?(\(\d+\) *)?\d+(-\d*)*';
c_expr_email = '[_a-zA-Z\d\-\.]+@[_a-zA-Z\d\-]+(\.[_a-zA-Z\d\-]+)+';
c_dbo_view   = '\[dbo\].+?]';

begin
  Result := '';
  if not Assigned(qry) then
    Exit;

  sExpr  := c_dbo_view;
  sInput := qry.SQL.Text;

  r := TRegExpr.Create;
  try
    r.Expression := sExpr;

    if r.Exec (sInput)
    then Result := r.Match[0];

  finally r.Free end;

  Result := ReplaceStr(Result,'[dbo].[','');
  Result := ReplaceStr(Result,']','');
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


