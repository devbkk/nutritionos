unit CtrBase;

interface

uses
  SysUtils, Classes, DB;

type
  TContrBase = class(TDataModule)
    srcBase: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function DataSet(s :String) :TDataSet; virtual;
  end;

var
  ContrBase: TContrBase;

implementation

{$R *.dfm}

procedure TContrBase.DataModuleCreate(Sender: TObject);
begin
 //
end;

procedure TContrBase.DataModuleDestroy(Sender: TObject);
begin
 //
end;

function TContrBase.DataSet(s: String): TDataSet;
begin
//
end;

end.
