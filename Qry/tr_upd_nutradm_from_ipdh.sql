USE [DEVHC]
GO

/****** Object:  Trigger [dbo].[trUpdNutrFrIpdH]    Script Date: 22/6/2560 8:47:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE trigger [dbo].[trUpdNutrAdmFrIpdH] on [dbo].[Ipd_h]
after update
as
begin
   declare @an char(7)
   declare @oldward char(3), @oldroom char(5), @oldbed char(2)
   declare @newward char(3), @newroom char(5), @newbed char(2)

   select @oldward = [ward_id], @oldroom = [current_room], @oldbed = [current_bed] 
   from deleted

   select @newward = [ward_id], @newroom = [current_room], @newbed = [current_bed], @an = [ladmit_n]
   from inserted 
   
   if(@oldward<>@newward)or(@oldroom<>@newroom)or(@oldbed<>@newbed)
   begin
     update AYHNUTR.dbo.NUTR_PADM set WARDID = @newward, ROOMNO = @newroom, BEDNO = @newbed
	 where AN = @an
   end
end
GO

ALTER TABLE [dbo].[Ipd_h] ENABLE TRIGGER [trUpdNutrFrIpdH]
GO


