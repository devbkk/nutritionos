unit SvCnMain;

interface

uses
  SysUtils, Classes, DmCnMain, DmCnHomc, ShareIntfModel;

type

  ICtrlCnMain = Interface(IInterface)
  ['{502E8CA7-4879-46C4-9557-B3709B67882D}']
    procedure CheckConfigFile;
    procedure CheckDataBase;
  end;

  TCtrlCnMain = Class(TInterfacedObject, ICtrlCnMain, IDmoCheckDB)
  private
    FSvCnMainDat :TDmoCnMain;
    procedure CheckConfigFile;
  protected
    function CnData :IDmoCheckDB; virtual;
    function ConfigFile :String; virtual;
  public
    procedure CheckDataBase;
    property DatM :IDmoCheckDB read CnData implements IDmoCheckDB;
  end;

  TCtrlCnHomc = Class(TCtrlCnMain)
    FSvCnHomcDat :TDmoCnHomc;
  protected
    function CnData :IDmoCheckDB; override;
    function ConfigFile :String; override;
  public
  End;

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

procedure TCtrlCnMain.CheckDataBase;
begin
//
  CheckConfigFile;
end;

{private}
procedure TCtrlCnMain.CheckConfigFile;
var sCurDir, sFile :String;
    sSaveFile :TStrings;
begin
  sCurDir := GetCurrentDir;
  sFile   := sCurDir+'\'+ConfigFile;
  if not FileExists(sFile) then begin
    sSaveFile := TStringList.Create;
    try
      sSaveFile := DatM.RequestConfig;
      sSaveFile.SaveToFile(sFile);
    finally
      sSaveFile.Free;
    end;
  end;
end;

function TCtrlCnMain.CnData: IDmoCheckDB;
begin
  if not Assigned(FSvCnMainDat) then
    FSvCnMainDat := TDmoCnMain.Create(nil);
  Result := FSvCnMainDat;
end;

function TCtrlCnMain.ConfigFile: String;
begin
  Result := FILE_CONFIG;
end;

{ TCtrlCnHomc }

function TCtrlCnHomc.CnData: IDmoCheckDB;
begin
  if not Assigned(FSvCnHomcDat) then
    FSvCnHomcDat := TDmoCnHomc.Create(nil);
  Result := FSvCnHomcDat;
end;

function TCtrlCnHomc.ConfigFile: String;
begin
  Result :=  FILE_CONFIG;
end;

end.
