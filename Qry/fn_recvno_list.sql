ALTER function [dbo].[RECVNO_LIST] (
  @RECVNO varchar(max)
)
RETURNS @T TABLE
(
  RecvNo varchar(50) primary key not null
)
AS
begin
  declare @ln bigint, @idx bigint, @start bigint, @get varchar(50) 
  declare @gr bigint

  set @ln    = len(@RECVNO)
  set @start = 0
  set @idx   = 0

  while (@idx < @ln)
  begin
    set @start = @idx + 1 
	set @idx   = charindex(',',@RECVNO,@start)  
	--
	if(@idx=0)
	begin
	  set @idx=@ln+1
	end  
	set @get   = substring(@RECVNO,@start,@idx-@start)
	--
	set @gr = @gr+1
	--
	insert @T
    select @get 
	
  end

  return
end