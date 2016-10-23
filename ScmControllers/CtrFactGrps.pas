unit CtrFactGrps;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, DBGrids, SysUtils,
     //
     ShareCommon, ShareInterface, ShareMethod, FaFactGroup, DmFactGroups;
type

  TControllerFactGroups = class
  private
    FFactGrps    :IFoodGroupsDataX;
    FFraFaTypInp :TfraFactGroup;
    FManFaGrps   :TClientDataSet;
    function CreateModelFactGroups :IFoodGroupsDataX;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
    procedure DoAddWrite;
    procedure DoCancelDel;
    procedure DoMoveNext;
    procedure DoMovePrev;
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
  //
  CFM_DEL   = 'ลบข้อมูลนี้?';
  IFM_SAVED = 'บันทึกข้อมูลแล้ว';

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
  if (FManFaGrps.State=dsBrowse) then begin
    FManFaGrps.Append;
  end else if(FManFaGrps.State in [dsInsert,dsEdit])then begin
    FManFaGrps.Post;
    FManFaGrps.ApplyUpdates(-1);
    MessageDlg(IFM_SAVED,mtInformation,[mbOK],0);
  end;
end;

procedure TControllerFactGroups.DoCancelDel;
begin
  if FManFaGrps.State = dsBrowse then begin
    if MessageDlg(CFM_DEL,mtWarning,[mbYes,mbNo],0) = mrYes then begin
      FManFaGrps.Delete;
      FManFaGrps.ApplyUpdates(-1);
    end;
  end else if FManFaGrps.State in [dsInsert,dsEdit] then begin
    FManFaGrps.Cancel;
    FManFaGrps.First;
  end;
end;

procedure TControllerFactGroups.DoMoveNext;
begin
  if FManFaGrps.Eof then
    FManFaGrps.Last
  else FManFaGrps.Next;
end;

procedure TControllerFactGroups.DoMovePrev;
begin
  if FManFaGrps.Bof then
    FManFaGrps.First
  else FManFaGrps.Prior;
end;

procedure TControllerFactGroups.OnCommandInput(Sender: TObject);
begin
  if TCustomAction(Sender).Name=CMP_ACTAW then
    DoAddWrite
  else if TCustomAction(Sender).Name=CMP_ACTDC then
    DoCancelDel
  else If TCustomAction(Sender).Name=CMP_ACTNX then
    DoMoveNext
  else if TCustomAction(Sender).Name=CMP_ACTPV then
    DoMovePrev;     
end;

procedure TControllerFactGroups.Start;
begin
  FFraFaTypInp := TfraFactGroup.Create(nil);
  FFraFaTypInp.DataInterface(CreateModelFactGroups);
  FFraFaTypInp.SetActionEvents(OnCommandInput);
  FFraFaTypInp.Contact;
  //
  FManFaGrps := FFraFaTypInp.DataManFactGroups;
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
