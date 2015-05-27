unit DmFactDat;

interface

uses
  SysUtils, Classes, xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TDmoFact = class(TDataModule)
    schemaFact: TXMLDocument;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmoFact: TDmoFact;

implementation

{$R *.dfm}

end.
