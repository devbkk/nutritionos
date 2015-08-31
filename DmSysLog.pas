unit DmSysLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  ShareInterface, ShareMethod, MemDS, DBAccess, Uni;

type
  IDmoSysLog = Interface(IInterface)
  ['{2E5625C6-F9F0-43CD-A476-0EBBB3000F15}']
    procedure WriteSysLog(p :TRecSysLog);
  End;

  TDmoSysLog = class(TDmoBase, ISysLog, IDmoSysLog)
    schemaLog: TXMLDocument;
    qryLogTyp: TUniQuery;
    qrySysLog: TUniQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FSysLog :TRecSysLog;
    FSearch :TRecSysLogSearch;
    function GetData :TRecSysLog;
    procedure SetData(const Value :TRecSysLog);
    //
    function GetSearchKey :TRecSysLogSearch;
    procedure SetSearchKey(const Value :TRecSysLogSearch);
    //
  protected
    { Protected declarations }
    function Schema :TXMLDocument; override;
  public
    { Public declarations }
    //ISysLog
    property Data :TRecSysLog read GetData write SetData;
    //
    property SearchKey :TRecSysLogSearch
      read GetSearchKey write SetSearchKey;
    //
    function SysLogDataSet :TDataSet; overload;
    function SysLogDataSet(p :TRecSysLogSearch) :TDataSet; overload;
    function SysLogTypeDataSet :TDataSet;
    //IDmoSysLog
    procedure WriteSysLog(p :TRecSysLog);
  end;

var
  DmoSysLog: TDmoSysLog;

implementation

const
  QRY_SEL_SLOG = 'SELECT * FROM NUTR_SLOG '+
                 'WHERE ISNULL(LOGDS,'''') LIKE :LDES '+
                 'AND ISNULL(LOGTY,'''') LIKE :LTYP';

  QRY_SEL_LTYP = 'SELECT LOGTY FROM NUTR_SLOG GROUP BY LOGTY';

  QRY_INS_SLOG = 'INSERT INTO NUTR_SLOG(LOGDS,LOGTY,LOGDT) '+
                 'VALUES( %s, %s, %s)';


{$R *.dfm}

procedure TDmoSysLog.DataModuleCreate(Sender: TObject);
begin
  inherited;
//
end;

procedure TDmoSysLog.DataModuleDestroy(Sender: TObject);
begin
  inherited;
//
end;

function TDmoSysLog.GetData: TRecSysLog;
begin
  Result := FSysLog;
end;

function TDmoSysLog.GetSearchKey: TRecSysLogSearch;
begin
  Result := FSearch;
end;

function TDmoSysLog.Schema: TXMLDocument;
begin
  Result := schemaLog;
end;

procedure TDmoSysLog.SetData(const Value: TRecSysLog);
begin
  FSysLog := Value;
end;

procedure TDmoSysLog.SetSearchKey(const Value: TRecSysLogSearch);
begin
  FSearch := Value;
end;

function TDmoSysLog.SysLogDataSet: TDataSet;
begin
  Result := SysLogDataSet(FSearch);
end;

function TDmoSysLog.SysLogDataSet(p: TRecSysLogSearch): TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qrySysLog;
    Exit;
  end;
  //
  qrySysLog.DisableControls;
  try
    qrySysLog.Close;
    //
    qrySysLog.SQL.Text   := QRY_SEL_SLOG;
    //
    if p.desc='' then
      qrySysLog.ParamByName('LDES').AsString := '%'
    else qrySysLog.ParamByName('LDES').AsString := p.desc;

    if p.typ='' then
      qrySysLog.ParamByName('LTYP').AsString  := '%'
    else qrySysLog.ParamByName('LTYP').AsString  := p.typ;
    //
    qrySysLog.Open;
  finally
    qrySysLog.EnableControls;
  end;

  Result := qrySysLog;
end;

function TDmoSysLog.SysLogTypeDataSet: TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := qryLogTyp;
    Exit;
  end;
  //
  qryLogTyp.DisableControls;
  try
    qryLogTyp.Close;
    qryLogTyp.SQL.Text := QRY_SEL_LTYP;
    qryLogTyp.Open;
  finally
    qryLogTyp.EnableControls;
  end;
  //
  Result := qryLogTyp;
end;

procedure TDmoSysLog.WriteSysLog(p: TRecSysLog);
var sDt,sCmd :String;
begin
  if not MainDB.IsConnected then
    Exit;
  sDt :=  QuotedStr(DateTimeToSqlServerDateTimeString(p.dt));
  sCmd := Format(QRY_INS_SLOG,[p.desc,p.typ,sDt]);
  MainDB.ExecCmd(sCmd);
//
end;

end.
