unit DmSysLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  ShareInterface;

type
  TDmoSysLog = class(TDmoBase)
    schemaLog: TXMLDocument;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    function Schema :TXMLDocument; override;        
  public
    { Public declarations }
  end;

var
  DmoSysLog: TDmoSysLog;

implementation

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

function TDmoSysLog.Schema: TXMLDocument;
begin
  Result := schemaLog;
end;

end.
