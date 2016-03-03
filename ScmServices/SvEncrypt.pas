unit SvEncrypt;

{ encode / decode strings }

interface

uses windows;

function encodestring(s : string) : string;
function decodestring(s : string) : string;

implementation

var ii : byte;
    encstring : string[64];

function encodestring(s : string) : string;
//encode string s
var j,k,n,i : byte;
    dd,ee : DWORD;
    cc : char;
begin
 result := ''; //n := 0;
 for i := 1 to (length(s)+3) div 4 do
  begin
   dd := 0; ee := 0;
   j := 0;
   while (4*(i-1) + j <= length(s)) and (j < 4) do
    begin
     n := (i-1)*4 + j+1;
     cc := s[n];
     dd := dd or ((ord(cc) shl (j*8)));
     inc(j);
    end;                                      //dd gemaakt
    for k := 0 to 31 do                       //ee permutatie
     ee := ee or ((dd shr (((k+1)*11) mod 32) and 1) shl k);
    for k := 0 to 5 do
     begin                                    //maak char code
      n := ((ee shr (k*6)) and $3f)+1;
      cc := char(encString[n]);
      result := result + cc;
     end;
  end;
end;

function decodestring(s : string) : string;
//decode string s
var dd,ee : dword;
    j,{k,} {n,} bb,i : byte;
    {cc : char;}
begin
 result := ''; //n := 0;
 for i := 1 to (length(s) + 5) div 6 do
  begin
   dd := 0; j := 0;
   while (j < 6) and ((i-1)*6 + j < length(s)) do
    begin
     bb := pos(s[6*(i-1) + j + 1],encString) - 1;//0..63
     if j = 5 then bb := bb and $3;
     dd := dd or (bb shl (j*6));
     inc(j);
    end;
   ee := 0;
   for j := 0 to 31 do
    ee := ee or (((dd shr j) and 1) shl (((j+1)*11) mod 32));
   j := 0;
   repeat
     //inc(n);
     inc(j);
     bb := (ee and $ff);
     ee := ee shr 8;
     if bb <> 0 then result := result + chr(bb);
   until (bb = 0) or (j = 4);
  end;
end;

initialization

 encString := '';
 for ii := ord('.') to ord('9') do encString := encString + chr(ii);
 for ii := ord('A') to ord('Z') do encString := encString + chr(ii);
 for ii := ord('a') to ord('z') do encString := encString + chr(ii);

end.
 