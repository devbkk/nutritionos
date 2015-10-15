unit CtrFood;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     ShareInterface, FaFood, DmFood;

type
  TControllerFood = class
  private
    FfraFood :TfraFood;
    FFood    :IDataSetX;
    FManFood :TClientDataSet;
    function CreateModelFood :IDataSetX;
    procedure DoFactAddWrite;
    procedure DoFactCancelDel;
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
    DoFactAddWrite
  else if TCustomAction(Sender).Name=CMP_ACTDC then
    DoFactCancelDel;
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

procedure TControllerFood.DoFactAddWrite;
begin
//
end;

procedure TControllerFood.DoFactCancelDel;
begin
//
end;

end.
