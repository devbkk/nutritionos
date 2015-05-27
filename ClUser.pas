unit ClUser;

interface

uses
  Classes, SysUtils ;

type
   TUserSearchKey = record
     id,fname :String;
   end;

   TUserRec = record
     id,fname,lname,aname,gender,email,login,password :String;
   end;

   TSendUserRecEvent = procedure(pUsr :TUserRec) of Object;

   IUser = Interface(IInterface)
   ['{DFCD226E-6AD6-4B16-AC16-74FE88B1B5C2}']
     //
     function GetData :TUserRec;
     procedure SetData(const Value :TUserRec);
     property Data :TUserRec read GetData write SetData;
     //
     function GetKey :TUserSearchKey;
     procedure SetKey(const Value :TUserSearchKey);
     property Key :TUserSearchKey read GetKey write SetKey;
   End;

   TUser = Class(TInterfacedObject, IUser)
   private

   protected
     //
     function GetData :TUserRec; virtual; abstract;
     procedure SetData(const Value :TUserRec); virtual; abstract;
     //
     function GetKey :TUserSearchKey; virtual; abstract;
     procedure SetKey(const Value :TUserSearchKey); virtual; abstract;
   public
     property Data :TUserRec read GetData write SetData;
     property Key :TUserSearchKey read GetKey write SetKey;
   End;


implementation


end.
