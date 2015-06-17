unit SvCnMain;

interface

uses
  SysUtils, Classes, DmCnMain;

type

  ICtrlCnMain = Interface(IInterface)
  ['{502E8CA7-4879-46C4-9557-B3709B67882D}']
    procedure CheckConfigFile;
    procedure CheckDataBase;
  end;

  TCtrlCnMain = Class(TInterfacedObject, ICtrlCnMain, IDmoCheckDB)
  private
    FSvCnMainDat :TDmoCnMain;
    function CnData :IDmoCheckDB;
  public
    procedure CheckConfigFile;
    procedure CheckDataBase;
    property DatM :IDmoCheckDB read CnData implements IDmoCheckDB;
  end;

var
  iCtrCn :ICtrlCnMain;

function CtrlCnMain :ICtrlCnMain;

implementation

const
  FILE_CONFIG = 'config.xml';
  
{ TCtrlCnMain }

function CtrlCnMain :ICtrlCnMain;
begin
  if not assigned(iCtrCn) then
    iCtrCn := TCtrlCnMain.Create;
  Result := iCtrCn;
end;

procedure TCtrlCnMain.CheckConfigFile;
begin
//
end;

procedure TCtrlCnMain.CheckDataBase;
begin
//
end;

{private}
function TCtrlCnMain.CnData: IDmoCheckDB;
begin
  if not Assigned(FSvCnMainDat) then
    FSvCnMainDat := TDmoCnMain.Create(nil);
  Result := FSvCnMainDat;
end;

end.
