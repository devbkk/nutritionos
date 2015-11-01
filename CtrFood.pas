unit CtrFood;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls,
     ShareInterface, FaFood, DmFood;

type
  TControllerFood = class
  private
    FfraFood :TfraFood;
    FFood    :IDataSetX;
    FManFood :TClientDataSet;
    function CreateModelFood :IDataSetX;
    procedure DoAddWrite;
    procedure DoCancelDel;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
    procedure OnCommandInput(Sender :TObject);
    function View :TFrame;
  end;

implementation

const
  CMP_ACTAW = 'actAddWrite';
  CMP_ACTDC = 'actDelCanc';
  //
  CFM_DEL   = 'ลบข้อมูลนี้?';

{ TControllerFood }
constructor TControllerFood.Create;
begin
  Start;
end;

destructor TControllerFood.Destroy;
begin
  FfraFood.Free;
  inherited;
end;

procedure TControllerFood.OnCommandInput(Sender: TObject);
begin
  if TCustomAction(Sender).Name=CMP_ACTAW then
    DoAddWrite
  else if TCustomAction(Sender).Name=CMP_ACTDC then
    DoCancelDel;
end;

procedure TControllerFood.Start;
begin
  FfraFood := TfraFood.Create(nil);
  FFraFood.DataInterFace(CreateModelFood);
  FFraFood.SetActionEvents(OnCommandInput);
  FfraFood.Contact;
  //
  FManFood := FFraFood.DataManage;
end;

function TControllerFood.View: TFrame;
begin
  Result := FfraFood;
end;

function TControllerFood.CreateModelFood: IDataSetX;
var p :TRecDataXSearch;
begin
  FFood := TDmoFood.Create(nil);
  FFood.SearchKey := p;
  Result := FFood;
end;

procedure TControllerFood.DoAddWrite;
begin
  if FManFood.State = dsBrowse then begin
    FManFood.Append;
    FfraFood.FocusFirst;
  end else if FManFood.State in [dsInsert,dsEdit] then begin
    FManFood.Post;
    FManFood.ApplyUpdates(-1);
    //
  end;
end;

procedure TControllerFood.DoCancelDel;
begin
  if FManFood.State = dsBrowse then begin
    if MessageDlg(CFM_DEL,mtWarning,[mbYes,mbNo],0) = mrYes then begin
      FManFood.Delete;
      FManFood.ApplyUpdates(-1);
    end;
  end else if FManFood.State in [dsInsert,dsEdit] then begin
    FManFood.Cancel;
  end;
end;

end.
