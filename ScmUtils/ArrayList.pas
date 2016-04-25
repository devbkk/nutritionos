unit ArrayList;

interface

uses SysUtils, Classes, StrUtils;

type
  TArrayItems = Array of WideString;
  //
  TArrayList = class
  private
    FDelimeter     :String;
    FDelimetedText :String;
    FArrStr        :TArrayItems;
    FArrPos        :Array of Integer;
    FCountPos      :Integer;
    function GetDelimetedText :WideString;
    procedure SetDelimetedText(const Value :WideString);
    //
    procedure DoSplitDataToArray;
    procedure DoConcatArrayToData;
  public
    constructor Create;
    destructor Destroy; override;
    function Values(key :String; default:String='0') :WideString;
    property Count :Integer read FCountPos;
    property Delimeter :String read FDelimeter write FDelimeter;
    property DelimetedText :WideString read GetDelimetedText write SetDelimetedText;
    property Items :TArrayItems read FArrStr;
  end;

implementation

{ TArrayList }

{ private }
constructor TArrayList.Create;
begin
  FDelimeter     := '';
  FDelimetedText := '';
  FCountPos      := 0;
  //
end;

destructor TArrayList.Destroy;
begin
  inherited;
end;

procedure TArrayList.DoConcatArrayToData;
var i :Integer;
begin
  if(FDelimetedText='')or(FDelimeter='')or(FCountPos=0)then
    Exit;
  FDelimetedText := '';
  for i := 0 to FCountPos-1 do begin
    if i=0 then
      FDelimetedText := FArrStr[i]
    else if i=FCountPos-1 then
      FDelimetedText := FDelimetedText+FArrStr[i]
    else FDelimetedText := FDelimetedText+FArrStr[i]+FDelimeter;
  end;
end;

procedure TArrayList.DoSplitDataToArray;
var i,p :Integer;
begin
  if(FDelimetedText='')or(FDelimeter='')then
    Exit;
  //
  for i := 0 to Length(FDelimetedText) do begin
    if FDelimetedText[i] = FDelimeter then
      FCountPos := FCountPos+1;
  end;
  //
  if FCountPos=0 then
    Exit;
  //keep position
  SetLength(FArrPos, FCountPos);
  for i := 0 to FCountPos-1 do begin
    if i = 0 then
      p := 1
    else p := FArrPos[i-1]+1;
    FArrPos[i] := PosEx(FDelimeter,FDelimetedText,p);
  end;
  //
  SetLength(FArrStr,FCountPos+2);
  for i := 0 to FCountPos-1 do begin
    if i=0 then
      FArrStr[i] := Copy(FDelimetedText,1,FArrPos[i]-1)
    else FArrStr[i] := Copy(FDelimetedText,FArrPos[i-1]+1,FArrPos[i]-FArrPos[i-1]-1);
  end;
end;

function TArrayList.GetDelimetedText: WideString;
begin
  DoConcatArrayToData;
  Result := FDelimetedText;
end;

procedure TArrayList.SetDelimetedText(const Value: WideString);
begin
  FDelimetedText := Value;
  DoSplitDataToArray;
end;

function TArrayList.Values(key: String; default:String): WideString;
var i :Integer; sKey, sVal :WideString;
begin
  Result := default;
  for i := 0 to Length(FArrStr)-1 do begin
    if Pos('=',FArrStr[i])>0 then begin
      sKey := Copy(FArrStr[i],1,Pos('=',FArrStr[i])-1);
      sVal := Copy(FArrStr[i],Pos('=',FArrStr[i])+1,Length(FArrStr[i]));
      if sKey = key then begin
        Result := sVal;
        Break;
      end;
    end;
  end;
end;

end.
