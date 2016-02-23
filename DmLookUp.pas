unit DmLookUp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DmBase, xmldom, XMLIntf, FMTBcd, DB, SqlExpr, msxmldom, XMLDoc,
  ShareInterface;

type

  TDmoLup = class(TDmoBase, IDataLookupX)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations } 
    FKeyField, FListField :String;
    function GetKeyField :String;
    procedure SetKeyField(const Value :String);
    //
    function GetListField :String;
    procedure SetListField(const Value :String);
  public
    { Public declarations }
    property KeyField :String read GetKeyField write SetKeyField;
    //
    property ListField :String read GetListField write SetListField;
    //
    function LDataSet(const typ:TEnumLup):TDataSet;
  end;

var
  DmoLup: TDmoLup;

implementation

const
QRY_SEL_FOODTYPE = 'SELECT CODE, CODE+'' ''+FDES AS LIST '+
                   'FROM NUTR_FACT '+
                   'WHERE FGRC = ''01''';                   

{$R *.dfm}

procedure TDmoLup.DataModuleCreate(Sender: TObject);
begin
  inherited;
//
end;

procedure TDmoLup.DataModuleDestroy(Sender: TObject);
begin
  //
  inherited;
end;


function TDmoLup.LDataSet(const typ:TEnumLup): TDataSet;
begin
  if not MainDB.IsConnected then begin
    Result := nil;
    Exit;
  end;
  //
  qryBase.DisableControls;
  try
    qryBase.Close;
    case typ of
      eluFoodType : begin
        qryBase.SQL.Text := QRY_SEL_FOODTYPE;
        FKeyField  := 'CODE';
        FListField := 'LIST';
      end;
    end;

    qryBase.Open;
  finally
    qryBase.EnableControls;
  end;
  //
  Result := qryBase;
end;
//
function TDmoLup.GetKeyField: String;
begin
  Result := FKeyField;
end;

function TDmoLup.GetListField: String;
begin
  Result := FListField;
end;

procedure TDmoLup.SetKeyField(const Value: String);
begin
  FKeyField := Value;
end;

procedure TDmoLup.SetListField(const Value: String);
begin
  FListField := Value;
end;

end.
