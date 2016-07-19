unit ShareCommon;

interface

//connection
type
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
    IsFrDate, IsToDate :Boolean;
  end;


implementation

end.
