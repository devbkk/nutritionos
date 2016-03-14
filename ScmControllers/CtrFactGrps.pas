unit CtrFactGrps;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, DBGrids, SysUtils,
     //
     ShareInterface, ShareMethod, FaFactGroup, DmFactGroups;
type

  TControllerFactGroups = class
  private
    FFactGrps :IFoodGroupsDataX;
    FFraFaTypInp :TfraFactGroup;
    function CreateModelFactGroups :IFoodGroupsDataX;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
    procedure DoAddWrite;
    procedure DoCancelDel;
    //
    procedure OnCommandInput(Sender :TObject);
    //
    function View :TFrame;
  end;

implementation

const
  CMP_ACTAW = 'actAddWrite';
  CMP_ACTDC = 'actDelCanc';
  CMP_ACTNX = 'actNext';
  CMP_ACTPV = 'actPrev';

{ TControllerFactGroups }

constructor TControllerFactGroups.Create;
begin
  Start;
end;

destructor TControllerFactGroups.Destroy;
begin

  inherited;
end;

procedure TControllerFactGroups.DoAddWrite;
begin
//
end;

procedure TControllerFactGroups.DoCancelDel;
begin
//
end;

procedure TControllerFactGroups.OnCommandInput(Sender: TObject);
begin
  if TCustomAction(Sender).Name=CMP_ACTAW then
    DoAddWrite
  else if TCustomAction(Sender).Name=CMP_ACTDC then
    DoCancelDel;
end;

procedure TControllerFactGroups.Start;
begin
  FFraFaTypInp := TfraFactGroup.Create(nil);
  FFraFaTypInp.DataInterface(CreateModelFactGroups);
  FFraFaTypInp.SetActionEvents(OnCommandInput);
  FFraFaTypInp.Contact;
end;

function TControllerFactGroups.View: TFrame;
begin
  Result := FFraFaTypInp;
end;

{private}
function TControllerFactGroups.CreateModelFactGroups: IFoodGroupsDataX;
var p :TRecDataXSearch;
begin
  FFactGrps := TDmoFactGroups.Create(nil);
  FFactGrps.SearchKey := p;
  Result := FFactGrps;
end;

end.
