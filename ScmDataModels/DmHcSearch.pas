unit DmHcSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,

  ShareInterface;

type
  TDmoHcSearch = class(TDmoBase, IHcSearchDataX)
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function GetSearchKey :TRecDataXSearch;
    procedure SetSearchKey(const Value :TRecDataXSearch);
  public
    { Public declarations }
    property SearchKey :TRecDataXSearch
      read GetSearchKey write SetSearchKey;
    //
    function XDataSet :TDataSet; overload;
    function XDataSet(const p :TRecDataXSearch):TDataSet; overload;
  end;

var
  DmoHcSearch: TDmoHcSearch;

implementation

{$R *.dfm}

{ TDmoHcSearch }

procedure TDmoHcSearch.DataModuleCreate(Sender: TObject);
begin
  inherited;
//
end;

procedure TDmoHcSearch.DataModuleDestroy(Sender: TObject);
begin
  inherited;
//
end;

{public}
function TDmoHcSearch.XDataSet: TDataSet;
begin
//
end;

function TDmoHcSearch.XDataSet(const p: TRecDataXSearch): TDataSet;
begin
//
end;

{private}
function TDmoHcSearch.GetSearchKey: TRecDataXSearch;
begin
//
end;

procedure TDmoHcSearch.SetSearchKey(const Value: TRecDataXSearch);
begin
//
end;

end.
