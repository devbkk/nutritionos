unit DmUser;

interface

uses
  SysUtils, Classes, xmldom, XMLIntf, msxmldom, XMLDoc, ClUser, FMTBcd, DB,
  SqlExpr, InfSvAuth, Dialogs, DmCnMain, SvAux;

type

  TDmoUser = class(TDataModule, IUser, IDModAuthen)
    schemaUser: TXMLDocument;
    qryAuthen: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
     function GetData :TUserRec;
     procedure SetData(const Value :TUserRec);
     //
     function GetKey :TUserSearchKey;
     procedure SetKey(const Value :TUserSearchKey);
  public
    { Public declarations }
     //IDModAuthen
     function IsAuthentiCated(login,pwd :String):Boolean;
     //IUser
     property Data :TUserRec read GetData write SetData;
     property Key :TUserSearchKey read GetKey write SetKey;
  end;

var
  DmoUser: TDmoUser;

implementation

{$R *.dfm}

procedure TDmoUser.DataModuleCreate(Sender: TObject);
begin
//
end;

procedure TDmoUser.DataModuleDestroy(Sender: TObject);
begin
//
end;

{public}
function TDmoUser.GetData: TUserRec;
begin
//
end;

function TDmoUser.GetKey: TUserSearchKey;
begin
//
end;

function TDmoUser.IsAuthentiCated(login, pwd: String): Boolean;
var inf :IDmNutrCn;
    sTblCrCmd :String;
begin
  Result := False;
  //ShowMessage('Data Module '+login+' '+pwd);
  inf := TDmoCnMain.Create(nil);
  qryAuthen.SQLConnection := inf.Connection;
  //
  if not inf.IsTableExist('APPUSER') then begin
    sTblCrCmd := XmlToSqlCreateCommand(schemaUser);
    inf.ExecCmd(sTblCrCmd);
  end;
  //
  Result := True;
end;

procedure TDmoUser.SetData(const Value: TUserRec);
begin
//
end;

procedure TDmoUser.SetKey(const Value: TUserSearchKey);
begin
//
end;

end.
