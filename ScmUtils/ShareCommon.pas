unit ShareCommon;

interface

//connection
type
  TRecFactGroup = record
    FGRC,FGRP :String;
    FLEV : Integer;
    NOTE, FPRP, PCOD, SLIPPRN :String;
  end;

  TRecConnectParams = record
    Server,Database,User,Password :String;
  end;
  //
  TRecGetReport = record
    FrDate, ToDate :TDateTime;
    Index :Integer;
  end;
  //
  TRecSetReportParamInputter = record
    IsFrDate, IsGrDate, IsToDate :Boolean;
    function ResetDate :TRecSetReportParamInputter;
    function SetFrDate :TRecSetReportParamInputter;
    function SetRangeDate :TRecSetReportParamInputter;
  end;


implementation

{ TRecSetReportParamInputter }

function TRecSetReportParamInputter.ResetDate: TRecSetReportParamInputter;
begin
  IsFrDate := False;
  IsGrDate := False;
  IsToDate := False;
  Result   := Self;
end;

function TRecSetReportParamInputter.SetFrDate: TRecSetReportParamInputter;
begin
  IsFrDate := True;
  IsGrDate := True;
  IsToDate := False;
  Result   := Self;
end;

function TRecSetReportParamInputter.SetRangeDate: TRecSetReportParamInputter;
begin
  IsFrDate := True;
  IsGrDate := True;
  IsToDate := True;
  Result   := Self;
end;

end.
