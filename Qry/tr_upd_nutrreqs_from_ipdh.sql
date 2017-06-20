create trigger trUpdNutrFrIpdH on Ipd_h
after update
as
begin
   declare @dischdate char(8) 
   declare @an char(7)

   select @dischdate = [discharge_date], @an = [ladmit_n]
   from inserted 
   
   if(@dischdate<>'')
   begin
     update DEVNUT.dbo.NUTR_FOOD_REQS set REQEND = 'Y', REQENDDATE = GETDATE(), REQENDTYPE = ''
	 where AN = @an
   end
end