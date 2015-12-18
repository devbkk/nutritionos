unit CtrFoodReq;

interface

uses Classes, DB, DBClient, ActnList, StdCtrls, Forms,
     Dialogs, Controls, StrUtils, SysUtils,
     //
     ShareInterface, DmFoodReq, FrFoodReq;

type
  TControllerFoodReq = class
  private
    //
    FFrFoodReq  :TfrmFoodReq;
    FFoodReq    :IFoodReqDataX;
    FManFoodReq :TClientDataSet;
    //
    function CreateModelFoodReq :IDataSetX;
    procedure DoAddWrite;
    procedure DoCancelDel;
    procedure DoHcSearch;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    //
    procedure OnCommandInput(Sender :TObject);
    function View :TForm;
  end;

implementation

const
  CMP_ACTAW = 'actAddWrite';
  CMP_ACTDC = 'actDelCanc';
  CMP_ACTNX = 'actNext';
  CMP_ACTPV = 'actPrev';
  CMP_ACTSC = 'actHcSearch';
  //
  CFM_DEL   = 'ลบข้อมูลนี้?';

{ TControllerFoodReq }
constructor TControllerFoodReq.Create;
begin
  Start;
end;

destructor TControllerFoodReq.Destroy;
begin

  inherited;
end;

{public}
procedure TControllerFoodReq.OnCommandInput(Sender: TObject);
begin
  if TCustomAction(Sender).Name=CMP_ACTAW then
    DoAddWrite
  else if TCustomAction(Sender).Name=CMP_ACTDC then
    DoCancelDel
  else if TCustomAction(Sender).Name=CMP_ACTSC then
    DoHcSearch;     
end;

procedure TControllerFoodReq.Start;
begin
  FFrFoodReq := TfrmFoodReq.Create(nil);
  FFrFoodReq.DataInterface(CreateModelFoodReq);
  FFrFoodReq.SetActionEvents(OnCommandInput);
  //
  FManFoodReq := FFrFoodReq.DataManFoodReq;
end;

function TControllerFoodReq.View: TForm;
begin
  Result := FFrFoodReq;
end;

{private}
function TControllerFoodReq.CreateModelFoodReq: IDataSetX;
var p :TRecDataXSearch;
begin
  FFoodReq := TDmoFoodReq.Create(nil);
  FFoodReq.SearchKey := p;
  Result   := FFoodReq;
end;

procedure TControllerFoodReq.DoAddWrite;
begin
  if FManFoodReq.State = dsBrowse then begin
    FManFoodReq.Append;
    FFrFoodReq.FocusFirst;
  end else if FManFoodReq.State in [dsInsert,dsEdit] then begin
    FManFoodReq.Post;
    FManFoodReq.ApplyUpdates(-1);
    //
    if  FFrFoodReq.IsSqeuenceAppend then
      DoAddWrite;
  end;
end;

procedure TControllerFoodReq.DoCancelDel;
begin
  if FManFoodReq.State = dsBrowse then begin
    if MessageDlg(CFM_DEL,mtWarning,[mbYes,mbNo],0) = mrYes then begin
      FManFoodReq.Delete;
      FManFoodReq.ApplyUpdates(-1);
    end;
  end else if FManFoodReq.State in [dsInsert,dsEdit] then begin
    FManFoodReq.Cancel;
  end;
end;

procedure TControllerFoodReq.DoHcSearch;
begin
  ShowMessage('Yes');
end;

end.
