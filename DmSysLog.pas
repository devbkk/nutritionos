unit DmSysLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  ShareInterface, MemDS, DBAccess, Uni;

type
  TDmoSysLog = class(TDmoBase, ISysLog)
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
  end;

var
  DmoSysLog: TDmoSysLog;

implementation

const
  QRY_SEL_SLOG = 'SELECT * FROM NUTR_SLOG '+
                 'WHERE ISNULL(LOGDS,'''') LIKE :LDES '+
                 'AND ISNULL(LOGTY,'''') LIKE :LTYP';

  QRY_SEL_LTYP = 'SELECT LOGTY FROM NUTR_SLOG GROUP BY LOGTY';

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
      qrySysLog.ParamByName('LOGDS').AsString := '%'
    else qrySysLog.ParamByName('LOGDS').AsString := p.desc;

    if p.typ='' then
      qrySysLog.ParamByName('LOGTY').AsString  := '%'
    else qrySysLog.ParamByName('LOGTY').AsString  := p.typ;
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

end.
