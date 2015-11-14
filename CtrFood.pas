unit CtrFood;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls,
     ShareInterface, FaFood, DmFood, DmLookUp,
     FaFoodMenu, DmFoodMenu;

type
  TControllerFood = class
  private
    FfraFood :TfraFood;
    FFood    :IDataSetX;
    FManFood :TClientDataSet;
    //
    FDmLup   :TDmoLup;
    function CreateModelFood :IDataSetX;
    procedure CreateLookup;
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

  TControllerFoodMenu = class
  private
    FFoodList    :TStrings;
    //
    FFoodMenu    :IFoodDataX;
    FfraFoodMenu :TfraFoodMenu;
    FManFoodMenu :TClientDataSet;
    function  CreateModelFoodMenu :IDataSetX;
    procedure DoAddWrite;
    procedure DoCancelDel;
    procedure DoGenerateFoodList;
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
  FDmLup.Free;
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
  //
  FfraFood := TfraFood.Create(nil);
  FFraFood.DataInterFace(CreateModelFood);
  FFraFood.SetActionEvents(OnCommandInput);
  FfraFood.Contact;
  //
  FManFood := FFraFood.DataManage;
  //
  FDmLup   := TDmoLup.Create(nil);
  CreateLookup;
end;

function TControllerFood.View: TFrame;
begin
  Result := FfraFood;
end;

procedure TControllerFood.CreateLookup;
begin
  FfraFood.SetFoodTypeLookup(FDmLup.LDataSet(eluFoodType));
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
    if  FfraFood.IsSqeuenceAppend then
      DoAddWrite;
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

{ TControllerFoodMenu }

constructor TControllerFoodMenu.Create;
begin
  Start;
end;

destructor TControllerFoodMenu.Destroy;
begin
  FFoodList.Free;
  inherited;
end;

procedure TControllerFoodMenu.OnCommandInput(Sender: TObject);
begin
  if TCustomAction(Sender).Name=CMP_ACTAW then
    DoAddWrite
  else if TCustomAction(Sender).Name=CMP_ACTDC then
    DoCancelDel;
end;

procedure TControllerFoodMenu.Start;
begin
  FFoodList    := TStringList.Create;
  //
  FfraFoodMenu := TfraFoodMenu.Create(nil);
  FfraFoodMenu.DataInterFace(CreateModelFoodMenu);
  FfraFoodMenu.SetActionEvents(OnCommandInput);
  FfraFoodMenu.Contact;
  //
  FManFoodMenu := FFraFoodMenu.DataManage;
  //
  DoGenerateFoodList;
end;

function TControllerFoodMenu.View: TFrame;
begin
  Result := FfraFoodMenu;
end;

{private}
function TControllerFoodMenu.CreateModelFoodMenu: IDataSetX;
var p :TRecDataXSearch;
begin
  FFoodMenu := TDmoFoodMenu.Create(nil);
  FFoodMenu.SearchKey := p;
  Result := FFoodMenu;
end;

procedure TControllerFoodMenu.DoAddWrite;
const I_MSG = 'บันทึกข้อมูลแล้ว';
begin
  if FManFoodMenu.State = dsBrowse then begin
    FManFoodMenu.Append;
    FfraFoodMenu.FocusFirst;
  end else if FManFoodMenu.State in [dsInsert,dsEdit] then begin
    FManFoodMenu.Post;
    FManFoodMenu.ApplyUpdates(-1);
    MessageDlg(I_MSG,mtInformation,[mbOK],0);
    //
    if  FfraFoodMenu.IsSqeuenceAppend then
      DoAddWrite;
  end;
end;

procedure TControllerFoodMenu.DoCancelDel;
begin
  if FManFoodMenu.State = dsBrowse then begin
    if MessageDlg(CFM_DEL,mtWarning,[mbYes,mbNo],0) = mrYes then begin
      FManFoodMenu.Delete;
      FManFoodMenu.ApplyUpdates(-1);
    end;
  end else if FManFoodMenu.State in [dsInsert,dsEdit] then begin
    FManFoodMenu.Cancel;
  end;
end;

procedure TControllerFoodMenu.DoGenerateFoodList;
var ds :TDataSet;
begin
  ds :=  FFoodMenu.FoodList;
  if not ds.IsEmpty then begin
    FFoodList.Clear;
    ds.First;
    repeat
      FFoodList.Append(ds.Fields[2].AsString);
      ds.Next;
    until ds.Eof;
    FfraFoodMenu.SetFoodList(FFoodList);
  end;
end;

end.
