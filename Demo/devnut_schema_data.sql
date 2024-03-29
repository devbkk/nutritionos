USE [DEVNUT]
GO
/****** Object:  UserDefinedFunction [dbo].[ParGrpLev]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ParGrpLev]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ParGrpLev](@fgrc char(4), @lev int)
RETURNS char(4)
AS 
BEGIN
declare @ret char(4)
;WITH GRP_TREE AS (
   SELECT  FGRC,FGRP,FLEV,PCOD FROM NUTR_FACT_GRPS
   WHERE FGRC = @fgrc

   UNION ALL
   SELECT  C.FGRC, C.FGRP, C.FLEV, C.PCOD FROM NUTR_FACT_GRPS C
     JOIN GRP_TREE P ON P.PCOD = C.FGRC  
) 
SELECT @ret = FGRC
FROM GRP_TREE
WHERE FGRC <> @lev
AND FLEV = @lev
return @ret
END' 
END

GO
ALTER AUTHORIZATION ON [dbo].[ParGrpLev] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_CTRL]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_CTRL]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_CTRL](
	[ID] [char](3) COLLATE Thai_CI_AS NOT NULL,
	[DES] [varchar](50) COLLATE Thai_CI_AS NULL,
	[RUNNO] [int] NULL,
 CONSTRAINT [PK_NUTR_CTRL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_CTRL] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_DIAG]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_DIAG]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_DIAG](
	[CODE] [char](7) COLLATE Thai_BIN NOT NULL,
	[DES] [varchar](100) COLLATE Thai_BIN NULL,
	[TEXTS] [text] COLLATE Thai_BIN NULL,
	[DISEASE] [char](1) COLLATE Thai_BIN NULL,
	[STARTS] [varchar](3) COLLATE Thai_BIN NULL,
	[HIDESELECT] [char](1) COLLATE Thai_BIN NULL,
	[SECLEVEL] [char](1) COLLATE Thai_BIN NULL,
	[FULLDES] [varchar](108) COLLATE Thai_BIN NULL,
 CONSTRAINT [PK_NUTR_DIAG] PRIMARY KEY CLUSTERED 
(
	[CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_DIAG] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_FACT]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FACT]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_FACT](
	[CODE] [char](8) COLLATE Thai_CI_AS NOT NULL,
	[FDES] [varchar](50) COLLATE Thai_CI_AS NULL,
	[NOTE] [varchar](250) COLLATE Thai_CI_AS NULL,
	[FGRC] [char](4) COLLATE Thai_CI_AS NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_FACT] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_FACT_BK0]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FACT_BK0]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_FACT_BK0](
	[CODE] [char](8) COLLATE Thai_CI_AS NOT NULL,
	[FDES] [varchar](50) COLLATE Thai_CI_AS NULL,
	[FTYP] [varchar](30) COLLATE Thai_CI_AS NULL,
	[NOTE] [varchar](250) COLLATE Thai_CI_AS NULL,
	[FGRP] [varchar](20) COLLATE Thai_CI_AS NULL,
	[FGRC] [char](2) COLLATE Thai_CI_AS NULL,
	[FTYC] [char](3) COLLATE Thai_CI_AS NULL,
	[PCOD] [varchar](8) COLLATE Thai_CI_AS NULL,
	[LEV] [smallint] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_FACT_BK0] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_FACT_GRPS]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FACT_GRPS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_FACT_GRPS](
	[FGRC] [char](4) COLLATE Thai_CI_AS NOT NULL,
	[FGRP] [varchar](50) COLLATE Thai_CI_AS NULL,
	[FLEV] [int] NOT NULL,
	[NOTE] [varchar](100) COLLATE Thai_CI_AS NULL,
	[FPRP] [varchar](2) COLLATE Thai_CI_AS NULL,
	[PCOD] [char](4) COLLATE Thai_CI_AS NULL,
	[SLIPPRN] [char](1) COLLATE Thai_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_FACT_GRPS] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_FACT_GRPS0]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FACT_GRPS0]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_FACT_GRPS0](
	[FGRC] [char](4) COLLATE Thai_CI_AS NOT NULL,
	[FGRP] [varchar](30) COLLATE Thai_CI_AS NULL,
	[FLEV] [int] NOT NULL,
	[NOTE] [varchar](100) COLLATE Thai_CI_AS NULL,
	[FPRP] [varchar](2) COLLATE Thai_CI_AS NULL,
	[PCOD] [char](4) COLLATE Thai_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_FACT_GRPS0] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_FMNU]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FMNU]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_FMNU](
	[MNUID] [char](10) COLLATE Thai_CI_AS NOT NULL,
	[MNUNAME] [varchar](30) COLLATE Thai_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_FMNU] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_FMNU_ITMS]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FMNU_ITMS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_FMNU_ITMS](
	[MNUID] [char](10) COLLATE Thai_CI_AS NOT NULL,
	[FDID] [char](10) COLLATE Thai_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_FMNU_ITMS] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_FOOD]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_FOOD](
	[FDID] [char](10) COLLATE Thai_CI_AS NOT NULL,
	[FDNAME] [varchar](30) COLLATE Thai_CI_AS NULL,
	[FDTYPE] [char](8) COLLATE Thai_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_FOOD] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_FOOD_REQD]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQD]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_FOOD_REQD](
	[REQID] [char](5) COLLATE Thai_CI_AS NOT NULL,
	[REQCODE] [char](8) COLLATE Thai_CI_AS NOT NULL,
	[REQDESC] [varchar](50) COLLATE Thai_CI_AS NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_FOOD_REQD] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_FOOD_REQS]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_FOOD_REQS](
	[REQID] [char](5) COLLATE Thai_CI_AS NOT NULL,
	[HN] [char](7) COLLATE Thai_CI_AS NOT NULL,
	[AN] [char](7) COLLATE Thai_CI_AS NOT NULL,
	[DIAG] [char](7) COLLATE Thai_BIN NOT NULL,
	[WTS] [float] NULL,
	[HTS] [float] NULL,
	[PRINTED] [char](1) COLLATE Thai_CI_AS NULL,
	[REQDATE] [datetime] NULL,
	[PATTYPE] [char](8) COLLATE Thai_CI_AS NULL,
	[FOODPROP1] [char](8) COLLATE Thai_CI_AS NULL,
	[FOODPROP2] [char](8) COLLATE Thai_CI_AS NULL,
	[FOODRESTR] [char](8) COLLATE Thai_CI_AS NULL,
	[FOODREQDESC] [varchar](200) COLLATE Thai_CI_AS NULL,
	[NOTE] [varchar](50) COLLATE Thai_CI_AS NULL,
	[COMDIS] [char](1) COLLATE Thai_CI_AS NULL,
	[MEALORD] [int] NULL,
	[REQEND] [char](1) COLLATE Thai_CI_AS NULL,
	[REQENDDATE] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_FOOD_REQS] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_FOOD_REQS0]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQS0]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_FOOD_REQS0](
	[REQID] [char](5) COLLATE Thai_CI_AS NOT NULL,
	[HN] [char](7) COLLATE Thai_CI_AS NOT NULL,
	[AN] [char](7) COLLATE Thai_CI_AS NOT NULL,
	[DIAG] [varchar](50) COLLATE Thai_CI_AS NULL,
	[FOODTYPE] [varchar](50) COLLATE Thai_CI_AS NULL,
	[REQFR] [datetime] NULL,
	[REQTO] [datetime] NULL,
	[MLFR] [char](10) COLLATE Thai_CI_AS NULL,
	[MLTO] [char](10) COLLATE Thai_CI_AS NULL,
	[AMOUNTAM] [smallint] NULL,
	[AMOUNTPM] [smallint] NULL,
	[WTS] [float] NULL,
	[HTS] [float] NULL,
	[PRINTED] [char](1) COLLATE Thai_CI_AS NULL,
	[SALTWT] [float] NULL,
	[FOODTYPC] [char](8) COLLATE Thai_CI_AS NULL,
	[FEED] [varchar](8) COLLATE Thai_CI_AS NULL,
	[REQDATE] [datetime] NULL,
	[PATTYPE] [char](8) COLLATE Thai_CI_AS NULL,
	[FOODPROP1] [char](8) COLLATE Thai_CI_AS NULL,
	[FOODPROP2] [char](8) COLLATE Thai_CI_AS NULL,
	[FOODRESTR] [char](8) COLLATE Thai_CI_AS NULL,
	[FOODREQDESC] [varchar](200) COLLATE Thai_CI_AS NULL,
	[FOODPROP3] [char](8) COLLATE Thai_CI_AS NULL,
	[NOTE] [varchar](50) COLLATE Thai_CI_AS NULL,
	[COMDIS] [char](1) COLLATE Thai_CI_AS NULL,
	[MEALORD] [int] NULL,
	[REQEND] [char](1) COLLATE Thai_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_FOOD_REQS0] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_LOG]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_LOG]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_LOG](
	[ID] [char](10) COLLATE Thai_CI_AS NOT NULL,
	[FNAME] [varchar](30) COLLATE Thai_CI_AS NULL,
	[LNAME] [varchar](50) COLLATE Thai_CI_AS NULL,
	[ANAME] [varchar](100) COLLATE Thai_CI_AS NULL,
	[GENDER] [char](1) COLLATE Thai_CI_AS NULL,
	[EMAIL] [varchar](30) COLLATE Thai_CI_AS NULL,
	[LOGIN] [varchar](12) COLLATE Thai_CI_AS NULL,
	[PASSWORD] [varchar](30) COLLATE Thai_CI_AS NULL,
	[UNUSED] [char](1) COLLATE Thai_CI_AS NULL,
	[UTYPE] [char](1) COLLATE Thai_CI_AS NULL,
 CONSTRAINT [PK_NUTR_LOG] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_LOG] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_MEAL]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_MEAL]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_MEAL](
	[MLID] [char](10) COLLATE Thai_CI_AS NOT NULL,
	[MLNAME] [varchar](30) COLLATE Thai_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_MEAL] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_MEAL_ITMS]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_MEAL_ITMS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_MEAL_ITMS](
	[MLID] [char](10) COLLATE Thai_CI_AS NOT NULL,
	[MNUID] [char](10) COLLATE Thai_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_MEAL_ITMS] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_MISC]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_MISC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_MISC](
	[COD] [char](4) COLLATE Thai_CI_AS NOT NULL,
	[VAL] [varchar](100) COLLATE Thai_CI_AS NULL,
 CONSTRAINT [PK_NUTR_MISC] PRIMARY KEY CLUSTERED 
(
	[COD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_MISC] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_PADM]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_PADM]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_PADM](
	[HN] [char](7) COLLATE Thai_CI_AS NOT NULL,
	[PID] [char](13) COLLATE Thai_CI_AS NULL,
	[TNAME] [varchar](20) COLLATE Thai_CI_AS NULL,
	[FNAME] [varchar](50) COLLATE Thai_CI_AS NULL,
	[LNAME] [varchar](50) COLLATE Thai_CI_AS NULL,
	[GENDER] [char](1) COLLATE Thai_CI_AS NULL,
	[BIRTH] [datetime] NULL,
	[AN] [char](7) COLLATE Thai_CI_AS NOT NULL,
	[WARDID] [char](3) COLLATE Thai_CI_AS NULL,
	[WARDNAME] [varchar](20) COLLATE Thai_CI_AS NULL,
	[ADMITDATE] [datetime] NULL,
	[DISCHDATE] [datetime] NULL,
	[ROOMNO] [char](5) COLLATE Thai_CI_AS NULL,
	[BEDNO] [char](10) COLLATE Thai_CI_AS NULL,
	[RELGCODE] [char](2) COLLATE Thai_CI_AS NULL,
	[RELGDESC] [varchar](30) COLLATE Thai_CI_AS NULL,
 CONSTRAINT [PK_NUTR_PADM] PRIMARY KEY CLUSTERED 
(
	[AN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_PADM] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_PATN]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_PATN]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_PATN](
	[HN] [char](7) COLLATE Thai_CI_AS NOT NULL,
	[PID] [char](13) COLLATE Thai_CI_AS NULL,
	[TNAME] [varchar](20) COLLATE Thai_CI_AS NULL,
	[FNAME] [varchar](50) COLLATE Thai_CI_AS NULL,
	[LNAME] [varchar](50) COLLATE Thai_CI_AS NULL,
	[GENDER] [char](1) COLLATE Thai_CI_AS NULL,
	[BIRTH] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_PATN] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_PATN_ADMT]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_PATN_ADMT]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_PATN_ADMT](
	[HN] [char](7) COLLATE Thai_CI_AS NOT NULL,
	[AN] [char](7) COLLATE Thai_CI_AS NULL,
	[WARDID] [char](3) COLLATE Thai_CI_AS NULL,
	[WARDNAME] [varchar](20) COLLATE Thai_CI_AS NULL,
	[ADMITDATE] [datetime] NULL,
	[DISCHDATE] [datetime] NULL,
	[ROOMNO] [char](5) COLLATE Thai_CI_AS NULL,
	[BEDNO] [char](10) COLLATE Thai_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_PATN_ADMT] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_SLOG]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_SLOG]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_SLOG](
	[LOGID] [bigint] IDENTITY(1,1) NOT NULL,
	[LOGDS] [varchar](50) COLLATE Thai_CI_AS NULL,
	[LOGTY] [varchar](10) COLLATE Thai_CI_AS NULL,
	[LOGDT] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_SLOG] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[NUTR_USER]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_USER]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NUTR_USER](
	[ID] [char](10) COLLATE Thai_CI_AS NOT NULL,
	[FNAME] [varchar](30) COLLATE Thai_CI_AS NULL,
	[LNAME] [varchar](50) COLLATE Thai_CI_AS NULL,
	[ANAME] [varchar](100) COLLATE Thai_CI_AS NULL,
	[GENDER] [char](1) COLLATE Thai_CI_AS NULL,
	[EMAIL] [varchar](30) COLLATE Thai_CI_AS NULL,
	[LOGIN] [varchar](12) COLLATE Thai_CI_AS NULL,
	[PASSWORD] [varchar](30) COLLATE Thai_CI_AS NULL,
	[UNUSED] [char](1) COLLATE Thai_CI_AS NULL,
	[UTYPE] [char](1) COLLATE Thai_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[NUTR_USER] TO  SCHEMA OWNER 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_REPORT1]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FN_REPORT1]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[FN_REPORT1](@RQDATE DATETIME)
RETURNS TABLE
AS
RETURN
(
SELECT RQ.REQID, RQ.HN, RQ.MEALORD, RQ.FOODREQDESC,
       RQ.REQDATE, RQ.HTS, RQ.WTS,
       PA.TNAME, PA.FNAME, PA.LNAME,
       DATEDIFF(YYYY,PA.BIRTH,GETDATE()) AS AGE,
       PA.WARDID, PA.WARDNAME, PA.ROOMNO, PA.BEDNO,
       B.FGRC, B.FGRP,
       D.[DES] AS DIAGDESC
FROM NUTR_FOOD_REQS RQ 
LEFT JOIN NUTR_PADM PA ON PA.AN = RQ.AN 
LEFT JOIN (SELECT DISTINCT A.REQID, A.FGRC1 AS FGRC, G.FGRP 
           FROM (SELECT *,
                        dbo.ParGrpLev(F.FGRC,1) AS FGRC1,
                        dbo.ParGrpLev(F.FGRC,0) AS FGRC0 
                 FROM NUTR_FOOD_REQD R 
                 LEFT JOIN NUTR_FACT F ON F.CODE = R.REQCODE 
                 WHERE REQCODE <> ''freetext'') A 
           LEFT JOIN NUTR_FACT_GRPS G ON G.FGRC = A.FGRC1 
           WHERE A.FGRC0= ''0002'') B ON B.REQID = RQ.REQID 
LEFT JOIN NUTR_DIAG D ON D.CODE = RQ.DIAG 
WHERE ISNULL(RQ.REQEND,'''') = ''Y'' 
AND ISNULL(RQ.FOODREQDESC,'''') <> '''' 
AND CONVERT(DATE,RQ.REQDATE) <= CONVERT(DATE,@RQDATE))' 
END

GO
ALTER AUTHORIZATION ON [dbo].[FN_REPORT1] TO  SCHEMA OWNER 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_REPORT4]    Script Date: 27/7/2559 8:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FN_REPORT4]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[FN_REPORT4](@FRDATE DATETIME, @TODATE DATETIME)
RETURNS TABLE
AS
RETURN
(
--DECLARE @FRDATE DATETIME = ''20160226''
--DECLARE @TODATE DATETIME = ''20160226''
SELECT C.WARDID, C.WARDNAME, C.REQCODE, C.FDES,
      6*SUM(CASE WHEN DAYSCOUNT <=0 THEN 0 ELSE DAYSCOUNT END)+SUM(MEALS) AS MEALS
	  --SUM(CASE WHEN DAYSCOUNT <=0 THEN 0 ELSE MEALS END) AS MEALS
FROM
(
--DECLARE @FRDATE DATETIME = ''20160226''
--DECLARE @TODATE DATETIME = ''20160226''
SELECT *, DATEDIFF(DAY,REQFR,REQTO) AS DAYSCOUNT
FROM
(
--DECLARE @FRDATE DATETIME = ''20160226''
--DECLARE @TODATE DATETIME = ''20160226''
SELECT WARDID, WARDNAME, REQCODE, FDES, REQDATE, REQENDDATE, REQEND, 
       CASE WHEN CONVERT(DATE,@FRDATE) > CONVERT(DATE,REQDATE) THEN CONVERT(DATE,@FRDATE) ELSE CONVERT(DATE,REQDATE) END AS REQFR,
	   --CASE WHEN CONVERT(DATE,@TODATE) >= CONVERT(DATE,ISNULL(REQENDDATE,@TODATE)) THEN   CONVERT(DATE,@TODATE) ELSE CONVERT(DATE,ISNULL(REQENDDATE,@TODATE)) END AS REQTO,
       CASE WHEN CONVERT(DATE,@TODATE) >= CONVERT(DATE,ISNULL(REQENDDATE,@TODATE)) THEN CONVERT(DATE,ISNULL(REQENDDATE,@TODATE)) ELSE CONVERT(DATE,@TODATE) END AS REQTO,
       /*CASE WHEN ISNULL(REQEND,'''')=''''
	        THEN CASE WHEN CONVERT(DATE,REQDATE)>CONVERT(DATE,@TODATE)
			          THEN CONVERT(DATE,REQDATE) ELSE CONVERT(DATE,@TODATE) END
			ELSE CASE WHEN CONVERT(DATE,REQENDDATE)>CONVERT(DATE,@TODATE) 
			          THEN CONVERT(DATE,REQENDDATE) ELSE CONVERT(DATE,@TODATE) END END AS REQTO,*/
	   A.MEALS
FROM
(
SELECT R.AN, R.REQDATE, R.REQEND, R.REQENDDATE, R.REQID, 
       P.WARDID, P.WARDNAME, 
       D.REQCODE, F.FDES, 
	   6-ISNULL(R.MEALORD,1)+1 AS MEALS,
       MIN(R.REQDATE) AS REQFR, MAX(REQENDDATE) AS REQTO
FROM NUTR_FOOD_REQS R
JOIN NUTR_FOOD_REQD D ON D.REQID = R.REQID
JOIN NUTR_FACT F ON F.CODE = D.REQCODE
JOIN NUTR_PADM P ON P.AN = R.AN
WHERE F.FGRC = ''0001'' --AND P.WARDID = ''261''
GROUP BY R.AN, R.REQDATE, R.REQEND, R.REQENDDATE, R.REQID, P.WARDID, P.WARDNAME, D.REQCODE, F.FDES, R.MEALORD) A) B
WHERE ((CONVERT(DATE,B.REQFR)=CONVERT(DATE,@FRDATE))AND(CONVERT(DATE,B.REQTO)=CONVERT(DATE,@TODATE))) ) C
GROUP BY C.WARDID, C.WARDNAME, C.REQCODE, C.FDES
)' 
END

GO
ALTER AUTHORIZATION ON [dbo].[FN_REPORT4] TO  SCHEMA OWNER 
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX0_NUTR_FACT]    Script Date: 27/7/2559 8:46:32 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FACT]') AND name = N'IDX0_NUTR_FACT')
CREATE UNIQUE CLUSTERED INDEX [IDX0_NUTR_FACT] ON [dbo].[NUTR_FACT]
(
	[CODE] ASC,
	[FGRC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX0_NUTR_FACT]    Script Date: 27/7/2559 8:46:32 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FACT_BK0]') AND name = N'IDX0_NUTR_FACT')
CREATE UNIQUE CLUSTERED INDEX [IDX0_NUTR_FACT] ON [dbo].[NUTR_FACT_BK0]
(
	[CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX0_NUTR_FACT_GRPS]    Script Date: 27/7/2559 8:46:32 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FACT_GRPS]') AND name = N'IDX0_NUTR_FACT_GRPS')
CREATE UNIQUE CLUSTERED INDEX [IDX0_NUTR_FACT_GRPS] ON [dbo].[NUTR_FACT_GRPS]
(
	[FGRC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX0_NUTR_FOOD_REQD]    Script Date: 27/7/2559 8:46:32 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQD]') AND name = N'IDX0_NUTR_FOOD_REQD')
CREATE UNIQUE CLUSTERED INDEX [IDX0_NUTR_FOOD_REQD] ON [dbo].[NUTR_FOOD_REQD]
(
	[REQID] ASC,
	[REQCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX0_NUTR_FOOD_REQS]    Script Date: 27/7/2559 8:46:32 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQS]') AND name = N'IDX0_NUTR_FOOD_REQS')
CREATE UNIQUE CLUSTERED INDEX [IDX0_NUTR_FOOD_REQS] ON [dbo].[NUTR_FOOD_REQS]
(
	[REQID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX0_NUTR_PATN]    Script Date: 27/7/2559 8:46:32 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_PATN]') AND name = N'IDX0_NUTR_PATN')
CREATE UNIQUE CLUSTERED INDEX [IDX0_NUTR_PATN] ON [dbo].[NUTR_PATN]
(
	[HN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX0_NUTR_PATN_ADMT]    Script Date: 27/7/2559 8:46:32 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_PATN_ADMT]') AND name = N'IDX0_NUTR_PATN_ADMT')
CREATE UNIQUE CLUSTERED INDEX [IDX0_NUTR_PATN_ADMT] ON [dbo].[NUTR_PATN_ADMT]
(
	[HN] ASC,
	[AN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
INSERT [dbo].[NUTR_CTRL] ([ID], [DES], [RUNNO]) VALUES (N'100', N'user id', 3)
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C00    ', N'Malignant neoplasm of lip malignant neoplasm', N'
Excludes :
 skin of lip (C43.0, C44.0)
', N' ', N'', NULL, NULL, N'C00:Malignant neoplasm of lip malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C000   ', N'External upper lip malignant neoplasm', N'   Upper lip:
   . NOS
   . lipstick area
   . vermilion border
', N' ', N'', NULL, NULL, N'C000:External upper lip malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C001   ', N'External lower lip malignant neoplasm', N'   Lower lip:
   . NOS
   . lipstick area
   . vermilion border
', N' ', N'', NULL, NULL, N'C001:External lower lip malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C002   ', N'External lip, unspecified malignant neoplasm', N'   Vermilion border NOS
', N' ', N'', NULL, NULL, N'C002:External lip, unspecified malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C003   ', N'Upper lip, inner aspect malignant neoplasm', N'   Upper lip:
   . buccal aspect
   . frenulum
   . mucosa
   . oral aspect
', N' ', N'', NULL, NULL, N'C003:Upper lip, inner aspect malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C004   ', N'Lower lip, inner aspect malignant neoplasm', N'   Lower lip:
   . buccal aspect
   . frenulum
   . mucosa
   . oral aspect
', N' ', N'', NULL, NULL, N'C004:Lower lip, inner aspect malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C005   ', N'Lip, unspecified, inner aspect malignant neoplasm', N'   Lip, not specified whether upper or lower:
   . buccal aspect
   . frenulum
   . mucosa
   . oral aspect
', N' ', N'', NULL, NULL, N'C005:Lip, unspecified, inner aspect malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C006   ', N'Commissure of lip malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C006:Commissure of lip malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C008   ', N'Overlapping lesion of lip malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C008:Overlapping lesion of lip malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C009   ', N'Lip malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C009:Lip malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C01    ', N'Malignant neoplasm of base of tongue', N'   Fixed part of tongue NOS
   Posterior third of tongue
', N' ', N'', NULL, NULL, N'C01:Malignant neoplasm of base of tongue')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C02    ', N'Malignant neoplasm of other and unspecified parts of tongue', N'', N' ', N'', NULL, NULL, N'C02:Malignant neoplasm of other and unspecified parts of tongue')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C020   ', N'Dorsal suface of tongue malignant neoplasm', N'   Anterior two-thirds of tongue, dorsal surface

Excludes :
 dorsal surface of base of tongue (C01)
', N' ', N'', NULL, NULL, N'C020:Dorsal suface of tongue malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C021   ', N'Border of tongue malignant neoplasm', N'   Tip of tongue
', N' ', N'', NULL, NULL, N'C021:Border of tongue malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C0210  ', N'MALIGNANT NEOPLASM OF TIP OF TONGUE                                                 ', NULL, NULL, NULL, NULL, NULL, N'C0210:MALIGNANT NEOPLASM OF TIP OF TONGUE                                                 ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C0211  ', N'MALIGNANT NEOPLASM OF LATERAL BORDER OF TONGUE                                      ', NULL, NULL, NULL, NULL, NULL, N'C0211:MALIGNANT NEOPLASM OF LATERAL BORDER OF TONGUE                                      ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C0219  ', N'MALIGNANT NEOPLASM OF BORDER OF TONGUE, UNSPECIFIED                                 ', NULL, NULL, NULL, NULL, NULL, N'C0219:MALIGNANT NEOPLASM OF BORDER OF TONGUE, UNSPECIFIED                                 ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C022   ', N'Ventral suface of tongue malignant neoplasm', N'   Anterior two-thirds of tongue, ventral surface
   Frenulum linguae
', N' ', N'', NULL, NULL, N'C022:Ventral suface of tongue malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C023   ', N'Anterior two-thirds of tongue, part unspecified malignant neoplasm', N'   Middle third of tongue NOS
   Mobile part of tongue NOS
', N' ', N'', NULL, NULL, N'C023:Anterior two-thirds of tongue, part unspecified malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C024   ', N'Lingual tonsil malignant neoplasm', N'
Excludes :
 tonsil NOS (C09.9)
', N' ', N'', NULL, NULL, N'C024:Lingual tonsil malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C028   ', N'Overlapping lesion of tongue malignant neoplasm', N'   Malignant neoplasm of tongue whose point of origin cannot be classified to
     any one of the categories C01-C02.4
', N' ', N'', NULL, NULL, N'C028:Overlapping lesion of tongue malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C029   ', N'Tongue malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C029:Tongue malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C03    ', N'Malignant neoplasm of gum', N'Includes :
 alveolar (ridge) mucosa
 gingiva

Excludes :
 malignant odontogenic neoplasms (C41.0-C41.1)
', N' ', N'', NULL, NULL, N'C03:Malignant neoplasm of gum')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C030   ', N'Upper gum malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C030:Upper gum malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C031   ', N'Lower gum malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C031:Lower gum malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C039   ', N'Gum malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C039:Gum malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C04    ', N'Malignant neoplasm of floor of mouth', N'', N' ', N'', NULL, NULL, N'C04:Malignant neoplasm of floor of mouth')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C040   ', N'Anterior floor of mouth malignant neoplasm', N'   Anterior to the premolar-canine junction
', N' ', N'', NULL, NULL, N'C040:Anterior floor of mouth malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C041   ', N'Lateral floor of mouth malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C041:Lateral floor of mouth malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C048   ', N'Overlapping lesion of floor of mouth malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C048:Overlapping lesion of floor of mouth malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C049   ', N'Floor of mouth malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C049:Floor of mouth malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C05    ', N'Malignant neoplasm of palate', N'', N' ', N'', NULL, NULL, N'C05:Malignant neoplasm of palate')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C050   ', N'Hard palate malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C050:Hard palate malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C051   ', N'Soft palate malignant neoplasm', N'
Excludes :
 nasopharyngeal surface of soft palate (C11.3)
', N' ', N'', NULL, NULL, N'C051:Soft palate malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C052   ', N'Uvula malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C052:Uvula malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C058   ', N'Overlapping lesion of palate malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C058:Overlapping lesion of palate malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C059   ', N'Palate malignant neoplasm, unspecified', N'   Roof of mouth
', N' ', N'', NULL, NULL, N'C059:Palate malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C06    ', N'Malignat neoplasm of other and unspecified parts of mouth', N'', N' ', N'', NULL, NULL, N'C06:Malignat neoplasm of other and unspecified parts of mouth')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C060   ', N'Cheek mucosa malignant neoplasm', N'   Buccal mucosa NOS
   Internal cheek
', N' ', N'', NULL, NULL, N'C060:Cheek mucosa malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C061   ', N'Vesibule of mouth malignant neoplasm', N'   Buccal sulcus (upper)(lower)
   Labial sulcus (upper)(lower)
', N' ', N'', NULL, NULL, N'C061:Vesibule of mouth malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C0610  ', N'MALIGNANT NEOPLASM OF UPPER LABIAL SULCUS                                           ', NULL, NULL, NULL, NULL, NULL, N'C0610:MALIGNANT NEOPLASM OF UPPER LABIAL SULCUS                                           ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C0611  ', N'MALIGNANT NEOPLASM OF UPPER BUCCAL SULCUS                                           ', NULL, NULL, NULL, NULL, NULL, N'C0611:MALIGNANT NEOPLASM OF UPPER BUCCAL SULCUS                                           ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C0612  ', N'MALIGNANT NEOPLASM OF LOWER LABIAL SULCUS                                           ', NULL, NULL, NULL, NULL, NULL, N'C0612:MALIGNANT NEOPLASM OF LOWER LABIAL SULCUS                                           ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C0613  ', N'MALIGNANT NEOPLASM OF LOWER BUCCAL SULCUS                                           ', NULL, NULL, NULL, NULL, NULL, N'C0613:MALIGNANT NEOPLASM OF LOWER BUCCAL SULCUS                                           ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C0614  ', N'MALIGNANT NEOPLASM OF UNSPECIFIED UPPER SULCUS                                      ', NULL, NULL, NULL, NULL, NULL, N'C0614:MALIGNANT NEOPLASM OF UNSPECIFIED UPPER SULCUS                                      ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C0615  ', N'MALIGNANT NEOPLASM OF UNSPECIFIED LOWER SULCUS                                      ', NULL, NULL, NULL, NULL, NULL, N'C0615:MALIGNANT NEOPLASM OF UNSPECIFIED LOWER SULCUS                                      ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C0619  ', N'MALIGNANT NEOPLASM OF MOUTH,UNSPECIFIED                                             ', NULL, NULL, NULL, NULL, NULL, N'C0619:MALIGNANT NEOPLASM OF MOUTH,UNSPECIFIED                                             ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C062   ', N'Retromolar area malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C062:Retromolar area malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C0620  ', N'MALIGNANT NEOPLASM OF MAXILLARY TUBEROSITY                                          ', NULL, NULL, NULL, NULL, NULL, N'C0620:MALIGNANT NEOPLASM OF MAXILLARY TUBEROSITY                                          ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C0621  ', N'MALIGNANT NEOPLASM OF MANDIBULAR RETROMOLAR AREA                                    ', NULL, NULL, NULL, NULL, NULL, N'C0621:MALIGNANT NEOPLASM OF MANDIBULAR RETROMOLAR AREA                                    ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C0629  ', N'MALIGNANT NEOPLASM OF RETROMOLAR AREA,UNSPECIFIED                                   ', NULL, NULL, NULL, NULL, NULL, N'C0629:MALIGNANT NEOPLASM OF RETROMOLAR AREA,UNSPECIFIED                                   ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C068   ', N'Overlapping lesion of other and unspecified parts of mouth malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C068:Overlapping lesion of other and unspecified parts of mouth malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C069   ', N'Mouth malignant neoplasm, unspecified', N'   Minor salivary gland, unspecified site
   Oral cavity NOS
', N' ', N'', NULL, NULL, N'C069:Mouth malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C07    ', N'Malignath neoplasm of paraotid gland', N'', N' ', N'', NULL, NULL, N'C07:Malignath neoplasm of paraotid gland')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C08    ', N'Malignant neoplasm of other and unspecified major salivary glands                   ', N'
Excludes :
 malignant neoplasms of specified minor salivary glands which are classified according to their anatomical location
 malignant neoplasms of minor salivary glands NOS (C06.9)
 parotid gland (C07)
', NULL, NULL, NULL, NULL, N'C08:Malignant neoplasm of other and unspecified major salivary glands                   ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C080   ', N'Submandibular gland malignant neoplasm', N'   Submaxillary gland
', N' ', N'', NULL, NULL, N'C080:Submandibular gland malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C081   ', N'Sublingual gland malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C081:Sublingual gland malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C088   ', N'Overlapping lesion of major salivary glands malignant neoplasm', N'   Malignant neoplasm of major salivary glands whose point of origin cannot be
     classified to any one of the categories C07-C08.1
', N' ', N'', NULL, NULL, N'C088:Overlapping lesion of major salivary glands malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C089   ', N'Major salivary gland malignant neoplasm, unspecified', N'   Salivary gland (major) NOS
', N' ', N'', NULL, NULL, N'C089:Major salivary gland malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C09    ', N'Malignant neoplasm of tonsil', N'
Excludes :
 lingual tonsil (C02.4)
 pharyngeal tonsil (C11.1)
', N' ', N'', NULL, NULL, N'C09:Malignant neoplasm of tonsil')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C090   ', N'Tonsillar fossa malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C090:Tonsillar fossa malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C091   ', N'Tonsillar pillar (anterior) (posterior) malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C091:Tonsillar pillar (anterior) (posterior) malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C098   ', N'Overlapping lesion of tonsil malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C098:Overlapping lesion of tonsil malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C099   ', N'Tonsil malignant neoplasm, unspecified', N'   Tonsil:
   . NOS
   . faucial
   . palatine
', N' ', N'', NULL, NULL, N'C099:Tonsil malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C10    ', N'Malignant neoplasm of orophaeynx', N'
Excludes :
 tonsil (C09.-)
', N' ', N'', NULL, NULL, N'C10:Malignant neoplasm of orophaeynx')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C100   ', N'Vallecula malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C100:Vallecula malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C101   ', N'Anterior surface of epiglottis malignant neoplasm', N'   Epiglottis, free border [margin]
   Glossoepiglottic fold(s)

Excludes :
 epiglottis (suprahyoid portion) NOS (C32.1)
', N' ', N'', NULL, NULL, N'C101:Anterior surface of epiglottis malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C102   ', N'Lateral wall of oropharynx malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C102:Lateral wall of oropharynx malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C103   ', N'Posterior wall of oropharynx malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C103:Posterior wall of oropharynx malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C104   ', N'Branchial cleft malignant neoplasm', N'   Branchial cyst [site of neoplasm]
', N' ', N'', NULL, NULL, N'C104:Branchial cleft malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C108   ', N'Overlapping lesion of of oropharynx malignant neoplasm', N'   Junctional region of oropharynx
', N' ', N'', NULL, NULL, N'C108:Overlapping lesion of of oropharynx malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C109   ', N'Oropharynx malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C109:Oropharynx malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C11    ', N'Malignant neoplasm of naopharynx', N'', N' ', N'', NULL, NULL, N'C11:Malignant neoplasm of naopharynx')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C110   ', N'Superior wall of naopharynx malignant neoplasm', N'   Roof of nasopharynx
', N' ', N'', NULL, NULL, N'C110:Superior wall of naopharynx malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C111   ', N'Posterior wall of naopharynx malignant neoplasm', N'   Adenoid
   Pharyngeal tonsil
', N' ', N'', NULL, NULL, N'C111:Posterior wall of naopharynx malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C112   ', N'Lateral wall of naopharynx malignant neoplasm', N'   Fossa of Rosenmller
   Opening of auditory tube
   Pharyngeal recess
', N' ', N'', NULL, NULL, N'C112:Lateral wall of naopharynx malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C113   ', N'Anterior wall of naopharynx malignant neoplasm', N'   Floor of nasopharynx
   Nasopharyngeal (anterior)(posterior) surface of soft palate
   Posterior margin of nasal:
   . choana
   . septum
', N' ', N'', NULL, NULL, N'C113:Anterior wall of naopharynx malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C118   ', N'Overlapping lesion of naopharynx malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C118:Overlapping lesion of naopharynx malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C119   ', N'Nasopharynx malignant neoplasm, unspecified', N'   Nasopharyngeal wall NOS
', N' ', N'', NULL, NULL, N'C119:Nasopharynx malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C12    ', N'Malignant neoplasm of pypopharynx sinus', N'', N' ', N'', NULL, NULL, N'C12:Malignant neoplasm of pypopharynx sinus')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C13    ', N'Malignant neoplasm of hypopharynx', N'
Excludes :
 pyriform sinus (C12)
', N' ', N'', NULL, NULL, N'C13:Malignant neoplasm of hypopharynx')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C130   ', N'Postcricoid region malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C130:Postcricoid region malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C131   ', N'Aryepiglottic fold malignant neoplasm, hypopharyngeral aspect', N'   Aryepiglottic fold:
   . NOS
   . marginal zone

Excludes :
 aryepiglottic fold, laryngeal aspect (C32.1)
', N' ', N'', NULL, NULL, N'C131:Aryepiglottic fold malignant neoplasm, hypopharyngeral aspect')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C132   ', N'Posterior wall of hypopharynx malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C132:Posterior wall of hypopharynx malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C138   ', N'Overlapping lesion of hypopharynx malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C138:Overlapping lesion of hypopharynx malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C139   ', N'Hypopharynx malignant neoplasm, unspecified', N'   Hypopharyngeal wall NOS
', N' ', N'', NULL, NULL, N'C139:Hypopharynx malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C14    ', N'Malignant neoplasm of other and ill-defined sites in the lip, oral cavity and pharynx', N'
Excludes :
 oral cavity NOS (C06.9)
', N' ', N'', NULL, NULL, N'C14:Malignant neoplasm of other and ill-defined sites in the lip, oral cavity and pharynx')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C140   ', N'Pharynx malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C140:Pharynx malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C141   ', N'Laryngopharynx malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C141:Laryngopharynx malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C142   ', N'Waldeyer''s ring malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C142:Waldeyer''s ring malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C148   ', N'Overlapping lesion of lip, oral cavity and pharynx malignant neoplasm', N'   Malignant neoplasm of lip, oral cavity and pharynx whose point of origin
     cannot be classified to any one of the categories C00-C14.2
', N' ', N'', NULL, NULL, N'C148:Overlapping lesion of lip, oral cavity and pharynx malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C15    ', N'Malignant neoplasm of oesophagus', N'', N' ', N'', NULL, NULL, N'C15:Malignant neoplasm of oesophagus')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C150   ', N'Cervical pats of oesophagus malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C150:Cervical pats of oesophagus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C151   ', N'Thoracic pats of oesophagus malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C151:Thoracic pats of oesophagus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C152   ', N'Abdominal  pats of oesophagus malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C152:Abdominal  pats of oesophagus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C153   ', N'Upper third of oesophagus malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C153:Upper third of oesophagus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C154   ', N'Middle third of oesophagus malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C154:Middle third of oesophagus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C155   ', N'Lower third  of oesophagus malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C155:Lower third  of oesophagus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C158   ', N'Overlapping lesion  of oesophagus malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C158:Overlapping lesion  of oesophagus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C159   ', N'Oesophagus malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C159:Oesophagus malignant neoplasm, unspecified')
GO
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C16    ', N'Malignant neoplasm of stomach', N'', N' ', N'', NULL, NULL, N'C16:Malignant neoplasm of stomach')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C160   ', N'Cardia malignant neoplasm', N'   Cardiac orifice
   Cardio-oesophageal junction
   Gastro-oesophageal junction
   Oesophagus and stomach
', N' ', N'', NULL, NULL, N'C160:Cardia malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C161   ', N'Fundus of stomach malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C161:Fundus of stomach malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C162   ', N'Body of stomach malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C162:Body of stomach malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C163   ', N'Pyloric antrum malignant neoplasm', N'   Gastric antrum
', N' ', N'', NULL, NULL, N'C163:Pyloric antrum malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C164   ', N'Pylorus malignant neoplasm', N'   Prepylorus
   Pyloric canal
', N' ', N'', NULL, NULL, N'C164:Pylorus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C165   ', N'Lesser curcature of stomach malignant neoplasm, unspecified', N'   Lesser curvature of stomach, not classifiable to C16.1-C16.4
', N' ', N'', NULL, NULL, N'C165:Lesser curcature of stomach malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C166   ', N'Greater curvature of stomach malignant neoplasm, unspecified', N'   Greater curvature of stomach, not classifiable to C16.0-C16.4
', N' ', N'', NULL, NULL, N'C166:Greater curvature of stomach malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C168   ', N'Overlapping lesion of stomach malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C168:Overlapping lesion of stomach malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C169   ', N'Stomach malignant neoplasm, unspecified', N'   Gastric cancer NOS
', N' ', N'', NULL, NULL, N'C169:Stomach malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C17    ', N'Malignant neoplasm of small intestine', N'', N' ', N'', NULL, NULL, N'C17:Malignant neoplasm of small intestine')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C170   ', N'Duodenum malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C170:Duodenum malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C171   ', N'Jejunum malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C171:Jejunum malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C172   ', N'IIeum malignant neoplasm', N'
Excludes :
 ileocaecal valve (C18.0)
', N' ', N'', NULL, NULL, N'C172:IIeum malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C173   ', N'Meckel''s diverticulum malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C173:Meckel''s diverticulum malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C178   ', N'Overlapping lesion of small intestine malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C178:Overlapping lesion of small intestine malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C179   ', N'Small intestine malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C179:Small intestine malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C18    ', N'Malignant neoplasm of colon', N'', N' ', N'', NULL, NULL, N'C18:Malignant neoplasm of colon')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C180   ', N'Caecum malignant neoplasm', N'   Ileocaecal valve
', N' ', N'', NULL, NULL, N'C180:Caecum malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C181   ', N'Appendix malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C181:Appendix malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C182   ', N'Ascending colon malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C182:Ascending colon malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C183   ', N'Hepatic flexure malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C183:Hepatic flexure malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C184   ', N'Transverse colon malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C184:Transverse colon malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C185   ', N'Splenic flexure malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C185:Splenic flexure malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C186   ', N'Descending colon malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C186:Descending colon malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C187   ', N'Sigmoid colon malignant neoplasm', N'   Sigmoid (flexure)

Excludes :
 rectosigmoid junction (C19)
', N' ', N'', NULL, NULL, N'C187:Sigmoid colon malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C188   ', N'Overlapping lesion of colon malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C188:Overlapping lesion of colon malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C189   ', N'Colon malignant neoplasm, unspecified', N'   Large intestine NOS
', N' ', N'', NULL, NULL, N'C189:Colon malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C19    ', N'Malignant neoplasm of rectosigmoid junction', N'   Rectosigmoid (colon)
', N' ', N'', NULL, NULL, N'C19:Malignant neoplasm of rectosigmoid junction')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C20    ', N'Malignant neoplasm of rectum', N'', N' ', N'', NULL, NULL, N'C20:Malignant neoplasm of rectum')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C21    ', N'Malignant neoplasm of anus and anal canal', N'', N' ', N'', NULL, NULL, N'C21:Malignant neoplasm of anus and anal canal')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C210   ', N'Anus malignant neoplasm, unspecified', N'
Excludes :
 anal:
 . margin (C43.5, C44.5)
 . skin (C43.5, C44.5)
 perianal skin (C43.5, C44.5)
', N' ', N'', NULL, NULL, N'C210:Anus malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C211   ', N'Anal canal malignant neoplasm', N'   Anal sphincter
', N' ', N'', NULL, NULL, N'C211:Anal canal malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C212   ', N'Cloacogenic zone malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C212:Cloacogenic zone malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C218   ', N'Overlapping lesion of rectum, anus and anal canal malignant neoplasm', N'   Anorectal junction
   Anorectum
   Malignant neoplasm of rectum, anus and anal canal whose point of origin
     cannot be classified to any one of the categories C20-C21.2
', N' ', N'', NULL, NULL, N'C218:Overlapping lesion of rectum, anus and anal canal malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C22    ', N'Malignant neoplasm of liver and intranhepatic bile ducts', N'
Excludes :
 biliary tract NOS (C24.9)
 secondary malignant neoplasm of liver (C78.7)
', N' ', N'', NULL, NULL, N'C22:Malignant neoplasm of liver and intranhepatic bile ducts')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C220   ', N'Liver cell carcinoma', N'   Hepatocellular carcinoma
   Hepatoma
', N' ', N'', NULL, NULL, N'C220:Liver cell carcinoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C221   ', N'Intrahepatic bile duct carcinoma', N'   Cholangiocarcinoma
', N' ', N'', NULL, NULL, N'C221:Intrahepatic bile duct carcinoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C222   ', N'Hepatoblastoma', N'', N' ', N'', NULL, NULL, N'C222:Hepatoblastoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C223   ', N'Angiosarcoma of liver', N'   Kupffer cell sarcoma
', N' ', N'', NULL, NULL, N'C223:Angiosarcoma of liver')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C224   ', N'Other sarcomas of liver', N'', N' ', N'', NULL, NULL, N'C224:Other sarcomas of liver')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C227   ', N'Other specified carcinomas of liver', N'', N' ', N'', NULL, NULL, N'C227:Other specified carcinomas of liver')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C229   ', N'Liver malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C229:Liver malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C23    ', N'Malignant neoplasm of gallbladder', N'', N' ', N'', NULL, NULL, N'C23:Malignant neoplasm of gallbladder')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C24    ', N'Malignant neoplasm of other and unspecified parts of biliary tract', N'
Excludes :
 intrahepatic bile duct (C22.1)
', N' ', N'', NULL, NULL, N'C24:Malignant neoplasm of other and unspecified parts of biliary tract')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C240   ', N'Extrahepatic bile duct malignant neoplasm', N'   Biliary duct or passage NOS
   Common bile duct
   Cystic duct
   Hepatic duct
', N' ', N'', NULL, NULL, N'C240:Extrahepatic bile duct malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C241   ', N'Ampulla of Vater malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C241:Ampulla of Vater malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C248   ', N'Overlapping lesion of biliary tract malignant neoplasm', N'   Malignant neoplasm involving both intrahepatic and extrahepatic bile ducts
   Malignant neoplasm of biliary tract whose point of origin cannot be
     classified to any one of the categories C22.0-C24.1
', N' ', N'', NULL, NULL, N'C248:Overlapping lesion of biliary tract malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C249   ', N'Biliary tract malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C249:Biliary tract malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C25    ', N'Malignant neoplasm of pancreas', N'', N' ', N'', NULL, NULL, N'C25:Malignant neoplasm of pancreas')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C250   ', N'Head of  pancreas malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C250:Head of  pancreas malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C251   ', N'Body of  pancreas malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C251:Body of  pancreas malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C252   ', N'Tail of  pancreas malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C252:Tail of  pancreas malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C253   ', N'Pancreatic duct malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C253:Pancreatic duct malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C254   ', N'Endocrine  pancreas malignant neoplasm', N'   Islets of Langerhans
', N' ', N'', NULL, NULL, N'C254:Endocrine  pancreas malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C257   ', N'Other parts of  pancreas malignant neoplasm', N'   Neck of pancreas
', N' ', N'', NULL, NULL, N'C257:Other parts of  pancreas malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C258   ', N'Overlapping lesion of  pancreas malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C258:Overlapping lesion of  pancreas malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C259   ', N'Pancreas malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C259:Pancreas malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C26    ', N'Malignant neoplasm of other and ill-defined digestive organs', N'
Excludes :
 peritoneum and retroperitoneum (C48.-)
', N' ', N'', NULL, NULL, N'C26:Malignant neoplasm of other and ill-defined digestive organs')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C260   ', N'Intesinal tract malignant neoplasm, part unspecified', N'   Intestine NOS
', N' ', N'', NULL, NULL, N'C260:Intesinal tract malignant neoplasm, part unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C261   ', N'Spleen malignant neoplasm', N'
Excludes :
 Hodgkin''s disease (C81.-)
 non-Hodgkin''s lymphoma (C82-C85)
', N' ', N'', NULL, NULL, N'C261:Spleen malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C268   ', N'Overlapping lesion of digestive system malignant neoplasm', N'   Malignant neoplasm of digestive organs whose point of origin cannot be
     classified to any one of the categories C15-C26.1

Excludes :
 cardio-oesophageal junction (C16.0)
', N' ', N'', NULL, NULL, N'C268:Overlapping lesion of digestive system malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C269   ', N'III-defined sites within the digestive system malignant neoplasm', N'   Alimentary canal or tract NOS
   Gastrointestinal tract NOS
', N' ', N'', NULL, NULL, N'C269:III-defined sites within the digestive system malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C30    ', N'Malignant neoplasm of nasal cavity and middle ear', N'', N' ', N'', NULL, NULL, N'C30:Malignant neoplasm of nasal cavity and middle ear')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C300   ', N'Nasal cavity malignant neoplasm', N'   Cartilage of nose
   Concha, nasal
   Internal nose
   Septum of nose
   Vestibule of nose

Excludes :
 nasal bone (C41.0)
 nose NOS (C76.0)
 olfactory bulb (C72.2)
 posterior margin of nasal septum and choana (C11.3)
 skin of nose (C43.3, C', N' ', N'', NULL, NULL, N'C300:Nasal cavity malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C301   ', N'Middle ear malignant neoplasm', N'   Eustachian tube
   Inner ear
   Mastoid air cells

Excludes :
 auricular canal (external) (C43.2, C44.2)
 bone of ear (meatus) (C41.0)
 cartilage of ear (C49.0)
 skin of (external) ear (C43.2, C44.2)
', N' ', N'', NULL, NULL, N'C301:Middle ear malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C31    ', N'Malignant neoplasm of accessory sinuses', N'', N' ', N'', NULL, NULL, N'C31:Malignant neoplasm of accessory sinuses')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C310   ', N'Maxillary sinus                                                                     ', N'   Antrum (Highmore)(maxillary)
', NULL, NULL, NULL, NULL, N'C310:Maxillary sinus                                                                     ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C311   ', N'Maxillary sinus malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C311:Maxillary sinus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C312   ', N'Ethmoidal sinus malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C312:Ethmoidal sinus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C313   ', N'Frontal sinus malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C313:Frontal sinus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C318   ', N'Overlapping lesion of accessory sinuses malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C318:Overlapping lesion of accessory sinuses malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C319   ', N'Accessory sinus malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C319:Accessory sinus malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C32    ', N'Malignant neoplasm of larynx', N'', N' ', N'', NULL, NULL, N'C32:Malignant neoplasm of larynx')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C320   ', N'Glottis malignant neoplasm', N'   Intrinsic larynx
   Vocal cord (true) NOS
', N' ', N'', NULL, NULL, N'C320:Glottis malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C321   ', N'Supraglottis malignant neoplasm', N'   Aryepiglottic fold, laryngeal aspect
   Epiglottis (suprahyoid portion) NOS
   Extrinsic larynx
   False vocal cord
   Posterior (laryngeal) surface of epiglottis
   Ventricular bands

Excludes :
 anterior surface of epiglottis (C10.1)
 aryepi', N' ', N'', NULL, NULL, N'C321:Supraglottis malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C322   ', N'Subglottis malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C322:Subglottis malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C323   ', N'Laryngeal cartilage malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C323:Laryngeal cartilage malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C328   ', N'Overalapping lesion of larynx malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C328:Overalapping lesion of larynx malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C329   ', N'Larynx malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C329:Larynx malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C33    ', N'Malignant neoplasm of trachea', N'', N' ', N'', NULL, NULL, N'C33:Malignant neoplasm of trachea')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C34    ', N'Malignant neoplasm of bronchus and lung', N'', N' ', N'', NULL, NULL, N'C34:Malignant neoplasm of bronchus and lung')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C340   ', N'Main bronchus malignant neoplasm', N'   Carina
   Hilus (of lung)
', N' ', N'', NULL, NULL, N'C340:Main bronchus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C341   ', N'Upper lobe,  bronchus and lung malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C341:Upper lobe,  bronchus and lung malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C342   ', N'Middle lobe,  bronchus and lung malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C342:Middle lobe,  bronchus and lung malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C343   ', N'Lower lobe, bronchus and lung malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C343:Lower lobe, bronchus and lung malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C348   ', N'Overlapping lesion of  bronchus and lung malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C348:Overlapping lesion of  bronchus and lung malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C349   ', N'Bronchus or lung malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C349:Bronchus or lung malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C37    ', N'Malignant neoplasm of thymus', N'', N' ', N'', NULL, NULL, N'C37:Malignant neoplasm of thymus')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C38    ', N'Malignant neoplasm of heart, mediastinum and pleura', N'
Excludes :
 mesothelioma (C45.-)
', N' ', N'', NULL, NULL, N'C38:Malignant neoplasm of heart, mediastinum and pleura')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C380   ', N'Heart malignant neoplasm', N'   Pericardium

Excludes :
 great vessels (C49.3)
', N' ', N'', NULL, NULL, N'C380:Heart malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C381   ', N'Anterior mediastinum malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C381:Anterior mediastinum malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C382   ', N'Posterior mediastinum malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C382:Posterior mediastinum malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C383   ', N'Mediastinum malignant neoplasm, part unspecified', N'', N' ', N'', NULL, NULL, N'C383:Mediastinum malignant neoplasm, part unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C384   ', N'Pleura malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C384:Pleura malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C388   ', N'Overlapping lesion of heart, mediastinum and pleura malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C388:Overlapping lesion of heart, mediastinum and pleura malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C39    ', N'Malignant neoplasm of other and ill-defined sites in the respiratory system and intrathoracic organs', N'
Excludes :
 intrathoracic NOS (C76.1)
 thoracic NOS (C76.1)
', N' ', N'', NULL, NULL, N'C39:Malignant neoplasm of other and ill-defined sites in the respiratory system and intrathoracic organs')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C390   ', N'Upper respiratory tract malignant neoplasm, part unspecified', N'', N' ', N'', NULL, NULL, N'C390:Upper respiratory tract malignant neoplasm, part unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C398   ', N'Overlapping lesion of respiratory and intrathoracic organs malignant neoplasm', N'   Malignant neoplasm of respiratory and intrathoracic organs whose point of
     origin cannot be classified to any one of the categories C30-C39.0
', N' ', N'', NULL, NULL, N'C398:Overlapping lesion of respiratory and intrathoracic organs malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C399   ', N'III-defined sites within the respiratory system malignant neoplasm', N'   Respiratory tract NOS
', N' ', N'', NULL, NULL, N'C399:III-defined sites within the respiratory system malignant neoplasm')
GO
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C40    ', N'Malignant neoplasm of bone and articular cartilage of limbs', N'', N' ', N'', NULL, NULL, N'C40:Malignant neoplasm of bone and articular cartilage of limbs')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C400   ', N'Scapula and long bones of upper limb malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C400:Scapula and long bones of upper limb malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C401   ', N'Short bones of upper limb malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C401:Short bones of upper limb malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C402   ', N'Long bones of lower limb malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C402:Long bones of lower limb malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C403   ', N'Short bones of lower lomb malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C403:Short bones of lower lomb malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C408   ', N'Overlapping lesion of bone and articular cartilage of limbs malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C408:Overlapping lesion of bone and articular cartilage of limbs malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C409   ', N'Bone and articular cartilage of limb malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C409:Bone and articular cartilage of limb malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C41    ', N'Malignant neoplasm of bone and and articular cartilage of other and unspecified sites', N'
Excludes :
 bones of limbs (C40.-)
 cartilage of:
 . ear (C49.0)
 . larynx (C32.3)
 . limbs (C40.-)
 . nose (C30.0)
', N' ', N'', NULL, NULL, N'C41:Malignant neoplasm of bone and and articular cartilage of other and unspecified sites')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C410   ', N'Bones of skull and face malignant neoplasm', N'   Maxilla (superior)
   Orbital bone

Excludes :
 carcinoma, any type except intraosseous or odontogenic of:
 . maxillary sinus (C31.0)
 . upper jaw (C03.0)
 jaw bone (lower) (C41.1)
', N' ', N'', NULL, NULL, N'C410:Bones of skull and face malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C4100  ', N'MAXILLA SARCOMA EXCLUDE ODONTOGENIC SARCOMA                                         ', NULL, NULL, NULL, NULL, NULL, N'C4100:MAXILLA SARCOMA EXCLUDE ODONTOGENIC SARCOMA                                         ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C4101  ', N'MAXILLA MALIGNANT ODONTOGENIC TUMOR                                                 ', NULL, NULL, NULL, NULL, NULL, N'C4101:MAXILLA MALIGNANT ODONTOGENIC TUMOR                                                 ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C4102  ', N'MAXILLA MALIGNANT INTRAOSSEOUS SALIVARY GLAND                                       ', NULL, NULL, NULL, NULL, NULL, N'C4102:MAXILLA MALIGNANT INTRAOSSEOUS SALIVARY GLAND                                       ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C4108  ', N'MALIGNANT NEOPLASM OF OTHER BONE OFSKULL AND FACE                                   ', NULL, NULL, NULL, NULL, NULL, N'C4108:MALIGNANT NEOPLASM OF OTHER BONE OFSKULL AND FACE                                   ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C4109  ', N'MALIGNANT NEOPLASM OF MAXILLA UNSPECIFIED                                           ', NULL, NULL, NULL, NULL, NULL, N'C4109:MALIGNANT NEOPLASM OF MAXILLA UNSPECIFIED                                           ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C411   ', N'Mandible malignant neoplasm', N'   Lower jaw bone

Excludes :
 carcinoma, any type except intraosseous or odontogenic of:
 . jaw NOS (C03.9)
   . lower (C03.1)
 upper jaw bone (C41.0)
', N' ', N'', NULL, NULL, N'C411:Mandible malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C4110  ', N'SARCOMA MANDIBLE EXCLUDE ODONTOGENIC SARCOMA                                        ', NULL, NULL, NULL, NULL, NULL, N'C4110:SARCOMA MANDIBLE EXCLUDE ODONTOGENIC SARCOMA                                        ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C4111  ', N'MALIGNANT ODONTOGENIC TUMOUR OF MANDIBLE                                            ', NULL, NULL, NULL, NULL, NULL, N'C4111:MALIGNANT ODONTOGENIC TUMOUR OF MANDIBLE                                            ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C4119  ', N'UNSPECIFIED MALIGNANT NEOPLASM OF MANDIBLE                                          ', NULL, NULL, NULL, NULL, NULL, N'C4119:UNSPECIFIED MALIGNANT NEOPLASM OF MANDIBLE                                          ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C412   ', N'Vertebral column malignant neoplasm', N'
Excludes :
 sacrum and coccyx (C41.4)
', N' ', N'', NULL, NULL, N'C412:Vertebral column malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C413   ', N'Ribs, sternum and clavicle malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C413:Ribs, sternum and clavicle malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C414   ', N'Pelvic bones, sacrum and coccyx malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C414:Pelvic bones, sacrum and coccyx malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C418   ', N'Overlapping lesion of bone and articular cartilage malignant neoplasm', N'   Malignant neoplasm of bone and articular cartilage whose point of origin
     cannot be classified to any one of the categories C40-C41.4
', N' ', N'', NULL, NULL, N'C418:Overlapping lesion of bone and articular cartilage malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C419   ', N'Bone and articular cartilage malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C419:Bone and articular cartilage malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C43    ', N'Malignant melanoma of skin', N'Includes :
 morphology codes M872-M879 with behaviour code /3

Excludes :
 malignant melanoma of skin of genital organs (C51-C52, C60.-, C63.-)
', N' ', N'', NULL, NULL, N'C43:Malignant melanoma of skin')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C430   ', N'Malignant melanoma of lip', N'
Excludes :
 vermilion border of lip (C00.0-C00.2)
', N' ', N'', NULL, NULL, N'C430:Malignant melanoma of lip')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C431   ', N'Malignant melanoma of eyelid, including canthus', N'', N' ', N'', NULL, NULL, N'C431:Malignant melanoma of eyelid, including canthus')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C432   ', N'Malignant melanoma of ear and external auricular canal', N'', N' ', N'', NULL, NULL, N'C432:Malignant melanoma of ear and external auricular canal')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C433   ', N'Malignant melanoma of other and unspecified parts of face', N'', N' ', N'', NULL, NULL, N'C433:Malignant melanoma of other and unspecified parts of face')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C434   ', N'Malignant melanoma of scalp and neck', N'', N' ', N'', NULL, NULL, N'C434:Malignant melanoma of scalp and neck')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C435   ', N'Malignant melanoma of trunk', N'   Anal:
   . margin
   . skin
   Perianal skin
   Skin of breast

Excludes :
 anus NOS (C21.0)
', N' ', N'', NULL, NULL, N'C435:Malignant melanoma of trunk')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C436   ', N'Malignant melanoma of upper limb, inculuding shoulder', N'', N' ', N'', NULL, NULL, N'C436:Malignant melanoma of upper limb, inculuding shoulder')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C437   ', N'Malignant melanoma of lower limb, including hip', N'', N' ', N'', NULL, NULL, N'C437:Malignant melanoma of lower limb, including hip')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C438   ', N'Overlapping malignant melanoma of skin', N'', N' ', N'', NULL, NULL, N'C438:Overlapping malignant melanoma of skin')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C439   ', N'Malignant malanoma of skin , unspecified', N'   Melanoma (malignant) NOS
', N' ', N'', NULL, NULL, N'C439:Malignant malanoma of skin , unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C44    ', N'Other malignant neoplasms of skin', N'Includes :
 malignant neoplasm of:
 . sebaceous glands
 . sweat glands

Excludes :
 Kaposi''s sarcoma (C46.-)
 malignant melanoma of skin (C43.-)
 skin of genital organs (C51-C52, C60.-, C63.-)
', N' ', N'', NULL, NULL, N'C44:Other malignant neoplasms of skin')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C440   ', N'Skin of lip malignant neoplasm', N'   Basal cell carcinoma of lip

Excludes :
 malignant neoplasm of lip (C00.-)
', N' ', N'', NULL, NULL, N'C440:Skin of lip malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C441   ', N'Skin of eyelid, including canthus malignant neoplasm', N'
Excludes :
 connective tissue of eyelid (C49.0)
', N' ', N'', NULL, NULL, N'C441:Skin of eyelid, including canthus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C442   ', N'Skin of ear and external auricular canal malignant neoplasm', N'
Excludes :
 connective tissue of ear (C49.0)
', N' ', N'', NULL, NULL, N'C442:Skin of ear and external auricular canal malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C443   ', N'Skin of other and unspecified parts of face malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C443:Skin of other and unspecified parts of face malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C444   ', N'Skin of scalp and neck malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C444:Skin of scalp and neck malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C445   ', N'Skin of trunk malignant neoplasm', N'   Anal:
   . margin
   . skin
   Perianal skin
   Skin of breast

Excludes :
 anus NOS (C21.0)
', N' ', N'', NULL, NULL, N'C445:Skin of trunk malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C446   ', N'Skin of upper limb, including shoulder malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C446:Skin of upper limb, including shoulder malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C447   ', N'Skin of lower limb, including hip malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C447:Skin of lower limb, including hip malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C448   ', N'Overlapping lesion of skin malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C448:Overlapping lesion of skin malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C449   ', N'Malignant neoplasm of skin malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C449:Malignant neoplasm of skin malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C45    ', N'Mesothelioma', N'Includes :
 morphology code M905 with behaviour code /3
', N' ', N'', NULL, NULL, N'C45:Mesothelioma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C450   ', N'Mesothelioma of pleura', N'
Excludes :
 other malignant neoplasms of pleura (C38.4)
', N' ', N'', NULL, NULL, N'C450:Mesothelioma of pleura')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C451   ', N'Mesothelioma of peritoneum', N'   Mesentery
   Mesocolon
   Omentum
   Peritoneum (parietal)(pelvic)

Excludes :
 other malignant neoplasms of peritoneum (C48.-)
', N' ', N'', NULL, NULL, N'C451:Mesothelioma of peritoneum')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C452   ', N'Mesothelioma of pericardium', N'
Excludes :
 other malignant neoplasms of pericardium (C38.0)
', N' ', N'', NULL, NULL, N'C452:Mesothelioma of pericardium')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C457   ', N'Mesothelioma of other sites', N'', N' ', N'', NULL, NULL, N'C457:Mesothelioma of other sites')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C459   ', N'Mesothelioma, unspecified', N'', N' ', N'', NULL, NULL, N'C459:Mesothelioma, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C46    ', N'Kaposi''s sarcoma', N'Includes :
 morphology code M9140 with behaviour code /3
', N' ', N'', NULL, NULL, N'C46:Kaposi''s sarcoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C460   ', N'Kaposi''s sarcoma of skin', N'', N' ', N'', NULL, NULL, N'C460:Kaposi''s sarcoma of skin')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C461   ', N'Kaposi''s sarcoma of soft tissue', N'', N' ', N'', NULL, NULL, N'C461:Kaposi''s sarcoma of soft tissue')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C462   ', N'Kaposi''s sarcoma of palate', N'', N' ', N'', NULL, NULL, N'C462:Kaposi''s sarcoma of palate')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C463   ', N'Kaposi''s sarcoma of lymph nodes', N'', N' ', N'', NULL, NULL, N'C463:Kaposi''s sarcoma of lymph nodes')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C467   ', N'Kaposi''s sarcoma of other sites', N'', N' ', N'', NULL, NULL, N'C467:Kaposi''s sarcoma of other sites')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C468   ', N'Kaposi''s sarcoma of multiple organs', N'', N' ', N'', NULL, NULL, N'C468:Kaposi''s sarcoma of multiple organs')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C469   ', N'Kaposi''s sarcoma, unspecified', N'', N' ', N'', NULL, NULL, N'C469:Kaposi''s sarcoma, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C47    ', N'Malignant neoplasm of peripheral nerves and autonomic nervous system', N'Includes :
 sympathetic and parasympathetic nerves and ganglia
', N' ', N'', NULL, NULL, N'C47:Malignant neoplasm of peripheral nerves and autonomic nervous system')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C470   ', N'Peripheral nerves of head, face and neck malignant neoplasm', N'
Excludes :
 peripheral nerves of orbit (C69.6)
', N' ', N'', NULL, NULL, N'C470:Peripheral nerves of head, face and neck malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C471   ', N'Peripheral nerves of upper limb,  including shoulder malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C471:Peripheral nerves of upper limb,  including shoulder malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C472   ', N'Peripheral nerves of of lower limb, inculiding hip malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C472:Peripheral nerves of of lower limb, inculiding hip malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C473   ', N'Peripheral nerves of of thorax malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C473:Peripheral nerves of of thorax malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C474   ', N'Peripheral nerves of of abdomen malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C474:Peripheral nerves of of abdomen malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C475   ', N'Peripheral nerves of pelvis malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C475:Peripheral nerves of pelvis malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C476   ', N'Peripheral nerves of trunk malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C476:Peripheral nerves of trunk malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C478   ', N'Overlapping lesion of peripheral nerves and autonomic nervous system malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C478:Overlapping lesion of peripheral nerves and autonomic nervous system malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C479   ', N'Peripheral nerves and autonomic nervous system malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C479:Peripheral nerves and autonomic nervous system malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C48    ', N'Malignant neoplasm of retroperitoneum and peritoneum', N'
Excludes :
 Kaposi''s sarcoma (C46.1)
 mesothelioma (C45.-)
', N' ', N'', NULL, NULL, N'C48:Malignant neoplasm of retroperitoneum and peritoneum')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C480   ', N'Retroperitoneum malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C480:Retroperitoneum malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C481   ', N'Specified parts of peritoneum malignant neoplasm', N'   Mesentery
   Mesocolon
   Omentum
   Peritoneum:
   . parietal
   . pelvic
', N' ', N'', NULL, NULL, N'C481:Specified parts of peritoneum malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C482   ', N'Peritoneum malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C482:Peritoneum malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C488   ', N'Overlapping lesion of retroperitoneum and peritoneum malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C488:Overlapping lesion of retroperitoneum and peritoneum malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C49    ', N'Malignant neoplasm of other connective and soft tissue', N'Includes :
 blood vessel
 bursa
 cartilage
 fascia
 fat
 ligament, except uterine
 lymphatic vessel
 muscle
 synovia
 tendon (sheath)

Excludes :
 cartilage (of):
 . articular (C40-C41)
 . larynx (C32.3)
 . nose (C30.0)
 connective tissue', N' ', N'', NULL, NULL, N'C49:Malignant neoplasm of other connective and soft tissue')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C490   ', N'Connective and soft tissue of head, face and neck malignant neoplasm', N'   Connective tissue of:
   . ear
   . eyelid

Excludes :
 connective tissue of orbit (C69.6)
', N' ', N'', NULL, NULL, N'C490:Connective and soft tissue of head, face and neck malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C491   ', N'Connective and soft tissue of upper limb, including shoulder malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C491:Connective and soft tissue of upper limb, including shoulder malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C492   ', N'Connective and soft tissue of lower limb, including hip malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C492:Connective and soft tissue of lower limb, including hip malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C493   ', N'Connective and soft tissue of thorax malignant neoplasm', N'   Axilla
   Diaphragm
   Great vessels

Excludes :
 breast (C50.-)
 heart (C38.0)
 mediastinum (C38.1-C38.3)
 thymus (C37)
', N' ', N'', NULL, NULL, N'C493:Connective and soft tissue of thorax malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C494   ', N'Connective and soft tissue of abdomen malignant neoplasm', N'   Abdominal wall
   Hypochondrium
', N' ', N'', NULL, NULL, N'C494:Connective and soft tissue of abdomen malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C495   ', N'Connective and soft tissue of pelvis malignant neoplasm', N'   Buttock
   Groin
   Perineum
', N' ', N'', NULL, NULL, N'C495:Connective and soft tissue of pelvis malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C496   ', N'Connective and soft tissue of trunk malignant neoplasm, unspecified', N'   Back NOS
', N' ', N'', NULL, NULL, N'C496:Connective and soft tissue of trunk malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C498   ', N'Overlapping lesion of connective and soft tissue malignant neoplasm', N'   Malignant neoplasm of connective and soft tissue whose point of origin
     cannot be classified to any one of the categories C47-C49.6
', N' ', N'', NULL, NULL, N'C498:Overlapping lesion of connective and soft tissue malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C499   ', N'Connective and soft tissue malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C499:Connective and soft tissue malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C50    ', N'Malignant neoplasm of breast', N'Includes :
 connective tissue of breast

Excludes :
 skin of breast (C43.5, C44.5)
', N' ', N'', NULL, NULL, N'C50:Malignant neoplasm of breast')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C500   ', N'Nipple and areola malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C500:Nipple and areola malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C501   ', N'Central portion of breast malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C501:Central portion of breast malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C502   ', N'Upper-inner quadrant of breast malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C502:Upper-inner quadrant of breast malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C503   ', N'Lower-inner quadrant of breast malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C503:Lower-inner quadrant of breast malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C504   ', N'Upper-outer quadrant of breast malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C504:Upper-outer quadrant of breast malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C505   ', N'Lower-outer quadrant of breast malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C505:Lower-outer quadrant of breast malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C506   ', N'Axillary tail of breast malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C506:Axillary tail of breast malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C508   ', N'Overlapping lesion of breast malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C508:Overlapping lesion of breast malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C509   ', N'Breast malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C509:Breast malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C51    ', N'Malignant neoplasm of vulva', N'', N' ', N'', NULL, NULL, N'C51:Malignant neoplasm of vulva')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C510   ', N'Labium majus malignant neoplasm', N'   Bartholin''s [greater vestibular] gland
', N' ', N'', NULL, NULL, N'C510:Labium majus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C511   ', N'Labium minus malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C511:Labium minus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C512   ', N'Clitoris malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C512:Clitoris malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C518   ', N'Overlapping lesion of vulva malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C518:Overlapping lesion of vulva malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C519   ', N'Vulva malignant neoplasm, unspecified', N'   External female genitalia NOS
   Pudendum
', N' ', N'', NULL, NULL, N'C519:Vulva malignant neoplasm, unspecified')
GO
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C52    ', N'Malignant neoplasm of vagaina', N'', N' ', N'', NULL, NULL, N'C52:Malignant neoplasm of vagaina')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C53    ', N'Malignant neoplasm of cervix uteri', N'', N' ', N'', NULL, NULL, N'C53:Malignant neoplasm of cervix uteri')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C530   ', N'Endocervix malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C530:Endocervix malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C531   ', N'Exoervix malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C531:Exoervix malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C538   ', N'Overlapping lesion of cervix uteri malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C538:Overlapping lesion of cervix uteri malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C539   ', N'Cervix uteri malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C539:Cervix uteri malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C54    ', N'Malignant neoplasm of corpus uteri', N'', N' ', N'', NULL, NULL, N'C54:Malignant neoplasm of corpus uteri')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C540   ', N'Isthmus uteri malignant neoplasm', N'   Lower uterine segment
', N' ', N'', NULL, NULL, N'C540:Isthmus uteri malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C541   ', N'Endometrium malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C541:Endometrium malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C542   ', N'Myometrium malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C542:Myometrium malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C543   ', N'Fundus uteri malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C543:Fundus uteri malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C548   ', N'Overlapping lesion of corpus uteri', N'', N' ', N'', NULL, NULL, N'C548:Overlapping lesion of corpus uteri')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C549   ', N'Corpus uteri malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C549:Corpus uteri malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C55    ', N'Malignant neoplasm of uterus, part unspecified', N'', N' ', N'', NULL, NULL, N'C55:Malignant neoplasm of uterus, part unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C56    ', N'Malignant neoplasm of ovary', N'', N' ', N'', NULL, NULL, N'C56:Malignant neoplasm of ovary')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C57    ', N'Malignant neoplasm of other and unspecified female genital organs', N'', N' ', N'', NULL, NULL, N'C57:Malignant neoplasm of other and unspecified female genital organs')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C570   ', N'Fallopian tube malignant neoplasm', N'   Oviduct
   Uterine tube
', N' ', N'', NULL, NULL, N'C570:Fallopian tube malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C571   ', N'Broad ligament malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C571:Broad ligament malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C572   ', N'Round ligament malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C572:Round ligament malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C573   ', N'Parametrium malignant neoplasm', N'   Uterine ligament NOS
', N' ', N'', NULL, NULL, N'C573:Parametrium malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C574   ', N'Uterine adnexa malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C574:Uterine adnexa malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C577   ', N'Other specified female genital organs malignant neoplasm', N'   Wolffian body or duct
', N' ', N'', NULL, NULL, N'C577:Other specified female genital organs malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C578   ', N'Overlapping lesion of female genital organs malignant neoplasm', N'   Malignant neoplasm of female genital organs whose point of origin cannot be
     classified to any one of the categories C51-C57.7, C58
   Tubo-ovarian
   Utero-ovarian
', N' ', N'', NULL, NULL, N'C578:Overlapping lesion of female genital organs malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C579   ', N'Female genital organ malignant neoplasm, unspecified', N'   Female genitourinary tract NOS
', N' ', N'', NULL, NULL, N'C579:Female genital organ malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C58    ', N'Malignant neoplasm of placenta', N'   Chorionepithelioma NOS

Excludes :
 chorioadenoma (destruens) (D39.2)
 hydatidiform mole:
 . NOS (O01.9)
 . invasive (D39.2)
 . malignant (D39.2)
', N' ', N'', NULL, NULL, N'C58:Malignant neoplasm of placenta')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C60    ', N'Malignant neoplasm of penis', N'', N' ', N'', NULL, NULL, N'C60:Malignant neoplasm of penis')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C600   ', N'Preuce malignant neoplasm', N'   Foreskin
', N' ', N'', NULL, NULL, N'C600:Preuce malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C601   ', N'Glans penis malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C601:Glans penis malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C602   ', N'Body of penis malignant neoplasm', N'   Corpus cavernosum
', N' ', N'', NULL, NULL, N'C602:Body of penis malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C608   ', N'Overlapping lesion of penis malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C608:Overlapping lesion of penis malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C609   ', N'Penis malignant neoplasm, unspecified', N'   Skin of penis NOS
', N' ', N'', NULL, NULL, N'C609:Penis malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C61    ', N'Malignant neoplasm of prostate', N'', N' ', N'', NULL, NULL, N'C61:Malignant neoplasm of prostate')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C62    ', N'Malignant neoplasm of testis', N'', N' ', N'', NULL, NULL, N'C62:Malignant neoplasm of testis')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C620   ', N'Undescended testis malignant neoplasm', N'   Ectopic testis [site of neoplasm]
   Retained testis [site of neoplasm]
', N' ', N'', NULL, NULL, N'C620:Undescended testis malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C621   ', N'Descended testis malignant neoplasm', N'   Scrotal testis
', N' ', N'', NULL, NULL, N'C621:Descended testis malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C629   ', N'Testis malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C629:Testis malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C63    ', N'Malignant neoplasm of other and unspecified male genitial organs', N'', N' ', N'', NULL, NULL, N'C63:Malignant neoplasm of other and unspecified male genitial organs')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C630   ', N'Epididymis malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C630:Epididymis malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C631   ', N'Spermatic cord malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C631:Spermatic cord malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C632   ', N'Scrotum malignant neoplasm', N'   Skin of scrotum
', N' ', N'', NULL, NULL, N'C632:Scrotum malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C637   ', N'Other specified male genital organs', N'   Seminal vesicle
   Tunica vaginalis
', N' ', N'', NULL, NULL, N'C637:Other specified male genital organs')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C638   ', N'Overalapping lesion of male genial organs', N'   Malignant neoplasm of male genital organs whose point of origin cannot be
     classified to any one of the categories C60-C63.7
', N' ', N'', NULL, NULL, N'C638:Overalapping lesion of male genial organs')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C639   ', N'Male genital organ malignant neoplasm, unspecified', N'   Male genitourinary tract NOS
', N' ', N'', NULL, NULL, N'C639:Male genital organ malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C64    ', N'Malignant neoplasm of kidney,except renal pelvis', N'
Excludes :
 renal:
 . calyces (C65)
 . pelvis (C65)
', N' ', N'', NULL, NULL, N'C64:Malignant neoplasm of kidney,except renal pelvis')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C65    ', N'Malignant neoplasm of renal pelvis', N'   Renal calyces
', N' ', N'', NULL, NULL, N'C65:Malignant neoplasm of renal pelvis')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C66    ', N'Malignant neoplasm of ureter', N'
Excludes :
 ureteric orifice of bladder (C67.6)
', N' ', N'', NULL, NULL, N'C66:Malignant neoplasm of ureter')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C67    ', N'Malignant neoplasm of bladder', N'', N' ', N'', NULL, NULL, N'C67:Malignant neoplasm of bladder')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C670   ', N'Trigone of bladder malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C670:Trigone of bladder malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C671   ', N'Dome of bladder malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C671:Dome of bladder malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C672   ', N'Lateral wall of bladder malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C672:Lateral wall of bladder malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C673   ', N'Anterior wall of bladder malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C673:Anterior wall of bladder malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C674   ', N'Posterior wall of bladder malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C674:Posterior wall of bladder malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C675   ', N'Bladder neck malignant neoplasm', N'   Internal urethral orifice
', N' ', N'', NULL, NULL, N'C675:Bladder neck malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C676   ', N'Ureteric orifice malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C676:Ureteric orifice malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C677   ', N'Urachus malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C677:Urachus malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C678   ', N'Overlapping lesion of bladder malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C678:Overlapping lesion of bladder malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C679   ', N'Bladder malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C679:Bladder malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C68    ', N'Malignant neoplasm of other and unspecified urinary organs', N'
Excludes :
 genitourinary tract NOS:
 . female (C57.9)
 . male (C63.9)
', N' ', N'', NULL, NULL, N'C68:Malignant neoplasm of other and unspecified urinary organs')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C680   ', N'Urethra malignant neoplasm', N'
Excludes :
 urethral orifice of bladder (C67.5)
', N' ', N'', NULL, NULL, N'C680:Urethra malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C681   ', N'Paraurethral gland malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C681:Paraurethral gland malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C688   ', N'Overlapping lesion of urinary organs malignant neoplasm', N'   Malignant neoplasm of urinary organs whose point of origin cannot be
     classified to any one of the categories C64-C68.1
', N' ', N'', NULL, NULL, N'C688:Overlapping lesion of urinary organs malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C689   ', N'Urinary organ malignant neoplasm,unspecified', N'   Urinary system NOS
', N' ', N'', NULL, NULL, N'C689:Urinary organ malignant neoplasm,unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C69    ', N'Malignant neoplasm of eye and adnexa', N'
Excludes :
 connective tissue of eyelid (C49.0)
 eyelid (skin) (C43.1, C44.1)
 optic nerve (C72.3)
', N' ', N'', NULL, NULL, N'C69:Malignant neoplasm of eye and adnexa')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C690   ', N'Conjunctiva malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C690:Conjunctiva malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C691   ', N'Cornea malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C691:Cornea malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C692   ', N'Retina malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C692:Retina malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C693   ', N'Choroid malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C693:Choroid malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C694   ', N'Ciliary body malignant neoplasm', N'   Eyeball
', N' ', N'', NULL, NULL, N'C694:Ciliary body malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C695   ', N'Lacrimal gland and duct malignant neoplasm', N'   Lacrimal sac
   Nasolacrimal duct
', N' ', N'', NULL, NULL, N'C695:Lacrimal gland and duct malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C696   ', N'Orbit malignant neoplasm', N'   Connective tissue of orbit
   Extraocular muscle
   Peripheral nerves of orbit
   Retrobulbar tissue
   Retro-ocular tissue

Excludes :
 orbital bone (C41.0)
', N' ', N'', NULL, NULL, N'C696:Orbit malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C698   ', N'Overalapping lesion of eye and adnexa malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C698:Overalapping lesion of eye and adnexa malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C699   ', N'Eye malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C699:Eye malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C70    ', N'Malignant neoplasm of meninges', N'', N' ', N'', NULL, NULL, N'C70:Malignant neoplasm of meninges')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C700   ', N'Cerebral meninges malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C700:Cerebral meninges malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C701   ', N'Spinal meninges malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C701:Spinal meninges malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C709   ', N'Meninges malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C709:Meninges malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C71    ', N'Malignant neoplasm of brain', N'
Excludes :
 cranial nerves (C72.2-C72.5)
 retrobulbar tissue (C69.6)
', N' ', N'', NULL, NULL, N'C71:Malignant neoplasm of brain')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C710   ', N'Cerebrum malignant neoplasm, except lobes and ventricles', N'   Corpus callosum
   Supratentorial NOS
', N' ', N'', NULL, NULL, N'C710:Cerebrum malignant neoplasm, except lobes and ventricles')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C711   ', N'Frontal lobe malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C711:Frontal lobe malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C712   ', N'Temporal lobe malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C712:Temporal lobe malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C713   ', N'Parietal lobe malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C713:Parietal lobe malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C714   ', N'Occipital lobe malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C714:Occipital lobe malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C715   ', N'Cerebral ventricle malignant neoplasm', N'
Excludes :
 fourth ventricle (C71.7)
', N' ', N'', NULL, NULL, N'C715:Cerebral ventricle malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C716   ', N'Cerebellum malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C716:Cerebellum malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C717   ', N'Brain stem malignant neoplasm', N'   Fourth ventricle
   Infratentorial NOS
', N' ', N'', NULL, NULL, N'C717:Brain stem malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C718   ', N'Overlapping lesion of brain malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C718:Overlapping lesion of brain malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C719   ', N'Brain malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C719:Brain malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C72    ', N'Malignant neoplasm of spinal cord, cranial nerves and other parts of central nervous system', N'
Excludes :
 meninges (C70.-)
 peripheral nerves and autonomic nervous system (C47.-)
', N' ', N'', NULL, NULL, N'C72:Malignant neoplasm of spinal cord, cranial nerves and other parts of central nervous system')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C720   ', N'Spinal cord malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C720:Spinal cord malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C721   ', N'Cauda equina malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C721:Cauda equina malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C722   ', N'Olfactory nerve malignant neoplasm', N'   Olfactory bulb
', N' ', N'', NULL, NULL, N'C722:Olfactory nerve malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C723   ', N'Optic nerve malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C723:Optic nerve malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C724   ', N'Acoustic nerve malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C724:Acoustic nerve malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C725   ', N'Other and unspecified cranial nerves malignant neoplasm', N'   Cranial nerve NOS
', N' ', N'', NULL, NULL, N'C725:Other and unspecified cranial nerves malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C728   ', N'Overlapping lesion of brain and other parts of central nevous system', N'   Malignant neoplasm of brain and other parts of central nervous system whose
            point of origin cannot be classified to any one of the categories
             C70-C72.5
', N' ', N'', NULL, NULL, N'C728:Overlapping lesion of brain and other parts of central nevous system')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C729   ', N'Central nevous system malignant neoplasm, unspecified', N'   Nervous system NOS
', N' ', N'', NULL, NULL, N'C729:Central nevous system malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C73    ', N'Malignant neoplasm of thyroid gland', N'', N' ', N'', NULL, NULL, N'C73:Malignant neoplasm of thyroid gland')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C74    ', N'Malignant neoplasm of adrenal gland', N'', N' ', N'', NULL, NULL, N'C74:Malignant neoplasm of adrenal gland')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C740   ', N'Cortex of adrenal gland malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C740:Cortex of adrenal gland malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C741   ', N'Medulla of adrenal gland malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C741:Medulla of adrenal gland malignant neoplasm')
GO
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C749   ', N'Adrenal gland malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C749:Adrenal gland malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C75    ', N'Malignant neoplasm of other endocrine glands and related structures', N'
Excludes :
 adrenal gland (C74.-)
 endocrine pancreas (C25.4)
 ovary (C56)
 testis (C62.-)
 thymus (C37)
 thyroid gland (C73)
', N' ', N'', NULL, NULL, N'C75:Malignant neoplasm of other endocrine glands and related structures')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C750   ', N'Parathyroid gland malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C750:Parathyroid gland malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C751   ', N'Pitutary gland malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C751:Pitutary gland malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C752   ', N'Craniopharyngral duct malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C752:Craniopharyngral duct malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C753   ', N'Pineal gland malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C753:Pineal gland malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C754   ', N'Carotid body malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C754:Carotid body malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C755   ', N'Aortic body and other paraganglia malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C755:Aortic body and other paraganglia malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C758   ', N'Pluriglandular  involvement,malignant meoplasm unspecified', N'', N' ', N'', NULL, NULL, N'C758:Pluriglandular  involvement,malignant meoplasm unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C759   ', N'Endocrine gland malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C759:Endocrine gland malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C76    ', N'Malignant neoplasm of other and iII-defined sites', N'
Excludes :
 malignant neoplasm of:
 . genitourinary tract NOS:
   . female (C57.9)
   . male (C63.9)
 . lymphoid, haematopoietic and related tissue (C81-C96)
 . unspecified site (C80)
', N' ', N'', NULL, NULL, N'C76:Malignant neoplasm of other and iII-defined sites')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C760   ', N'Head, face and neck malignant neoplasm', N'   Cheek NOS
   Nose NOS
', N' ', N'', NULL, NULL, N'C760:Head, face and neck malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C761   ', N'Thorax malignant neoplasm', N'   Axilla NOS
   Intrathoracic NOS
   Thoracic NOS
', N' ', N'', NULL, NULL, N'C761:Thorax malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C762   ', N'Abdomen malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C762:Abdomen malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C763   ', N'Pelvis malignant neoplasm', N'   Groin NOS
   Sites overlapping systems within the pelvis, such as:
   . rectovaginal (septum)
   . rectovesical (septum)
', N' ', N'', NULL, NULL, N'C763:Pelvis malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C764   ', N'Upper limb malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C764:Upper limb malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C765   ', N'Lower limb malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C765:Lower limb malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C767   ', N'Other iII-defined sites malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C767:Other iII-defined sites malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C768   ', N'Overalapping lesion of other and iII-defined sites malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C768:Overalapping lesion of other and iII-defined sites malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C77    ', N'Secondary and unspecified malignant neoplasm of lymph nodes', N'
Excludes :
 malignant neoplasm of lymph nodes, specified as primary (C81-C88, C96.-)
', N' ', N'', NULL, NULL, N'C77:Secondary and unspecified malignant neoplasm of lymph nodes')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C770   ', N'Lymph nodes of head, face and neck malignant neoplasm', N'   Supraclavicular lymph nodes
', N' ', N'', NULL, NULL, N'C770:Lymph nodes of head, face and neck malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C771   ', N'Intrathoracic lymph nodes malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C771:Intrathoracic lymph nodes malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C772   ', N'Intra-abdominal lymph nodes malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C772:Intra-abdominal lymph nodes malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C773   ', N'Axillary and upper limb lymph nodes malignant neoplasm', N'   Pectoral lymph nodes
', N' ', N'', NULL, NULL, N'C773:Axillary and upper limb lymph nodes malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C774   ', N'Inguinal and lower limb lymph nodes', N'', N' ', N'', NULL, NULL, N'C774:Inguinal and lower limb lymph nodes')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C775   ', N'Intrapelvic lymph nodes malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C775:Intrapelvic lymph nodes malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C778   ', N'Lymph nodes of multiple regions malignant neoplasm', N'', N' ', N'', NULL, NULL, N'C778:Lymph nodes of multiple regions malignant neoplasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C779   ', N'Lymph nodes malignant neoplasm, unspecified', N'', N' ', N'', NULL, NULL, N'C779:Lymph nodes malignant neoplasm, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C78    ', N'Secondary malignant neoplasm of respiratory and digestive organs', N'', N' ', N'', NULL, NULL, N'C78:Secondary malignant neoplasm of respiratory and digestive organs')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C780   ', N'Secondary malignant neoplasm of lung', N'', N' ', N'', NULL, NULL, N'C780:Secondary malignant neoplasm of lung')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C781   ', N'Secondary malignant neoplasm of mediastinum', N'', N' ', N'', NULL, NULL, N'C781:Secondary malignant neoplasm of mediastinum')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C782   ', N'Secondary malignant neoplasm of pleura', N'', N' ', N'', NULL, NULL, N'C782:Secondary malignant neoplasm of pleura')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C783   ', N'Secondary malignant neoplasm of other and unspecified respiratory organs', N'', N' ', N'', NULL, NULL, N'C783:Secondary malignant neoplasm of other and unspecified respiratory organs')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C784   ', N'Secondary malignant neoplasm of small intestine', N'', N' ', N'', NULL, NULL, N'C784:Secondary malignant neoplasm of small intestine')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C785   ', N'Secondary malignant neoplasm of large intestine and rectum', N'', N' ', N'', NULL, NULL, N'C785:Secondary malignant neoplasm of large intestine and rectum')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C786   ', N'Secondary malignant neoplasm of retroperitoneum and peritoneum', N'   Malignant ascites NOS
', N' ', N'', NULL, NULL, N'C786:Secondary malignant neoplasm of retroperitoneum and peritoneum')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C787   ', N'Secondary malignant neoplasm of liver', N'', N' ', N'', NULL, NULL, N'C787:Secondary malignant neoplasm of liver')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C788   ', N'Secondary malignant neoplasm of other and unspecified digestive organs', N'', N' ', N'', NULL, NULL, N'C788:Secondary malignant neoplasm of other and unspecified digestive organs')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C79    ', N'Secondary malignant neoplasm of other sites', N'', N' ', N'', NULL, NULL, N'C79:Secondary malignant neoplasm of other sites')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C790   ', N'Secondary malignant neoplasm of kidney and renal pelvis', N'', N' ', N'', NULL, NULL, N'C790:Secondary malignant neoplasm of kidney and renal pelvis')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C791   ', N'Secondary malignant neoplasm of bladder and other and unspecified urinary organs', N'organs
', N' ', N'', NULL, NULL, N'C791:Secondary malignant neoplasm of bladder and other and unspecified urinary organs')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C792   ', N'Secondary malignant neoplasm of skin', N'', N' ', N'', NULL, NULL, N'C792:Secondary malignant neoplasm of skin')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C793   ', N'Secondary malignant neoplasm of brain and cerebral meninges', N'', N' ', N'', NULL, NULL, N'C793:Secondary malignant neoplasm of brain and cerebral meninges')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C794   ', N'Secondary malignant neoplasm of other and unspecified parts of nervous system', N'', N' ', N'', NULL, NULL, N'C794:Secondary malignant neoplasm of other and unspecified parts of nervous system')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C795   ', N'Secondary malignant neoplasm of of bone and bone marrow', N'', N' ', N'', NULL, NULL, N'C795:Secondary malignant neoplasm of of bone and bone marrow')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C7950  ', N'SECONDARY MALIGNANT NEOPLASM OF MAXILLA                                             ', NULL, NULL, NULL, NULL, NULL, N'C7950:SECONDARY MALIGNANT NEOPLASM OF MAXILLA                                             ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C7951  ', N'SECONDARY MALIGNANT NEOPLASM OF MANDIBLE INCLUDE:CONDYLE                            ', NULL, NULL, NULL, NULL, NULL, N'C7951:SECONDARY MALIGNANT NEOPLASM OF MANDIBLE INCLUDE:CONDYLE                            ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C7958  ', N'SECONDARY MALIGNANT NEOPLASM OF OTHER FACIAL BONES                                  ', NULL, NULL, NULL, NULL, NULL, N'C7958:SECONDARY MALIGNANT NEOPLASM OF OTHER FACIAL BONES                                  ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C7959  ', N'SECONDARY MALIGNANT NEOPLASM OF FACIAL BONE,UNSPECIFIED                             ', NULL, NULL, NULL, NULL, NULL, N'C7959:SECONDARY MALIGNANT NEOPLASM OF FACIAL BONE,UNSPECIFIED                             ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C796   ', N'Secondary malignant neoplasm of ovary', N'', N' ', N'', NULL, NULL, N'C796:Secondary malignant neoplasm of ovary')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C797   ', N'Secondary malignant neoplasm of adrenal gland', N'', N' ', N'', NULL, NULL, N'C797:Secondary malignant neoplasm of adrenal gland')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C798   ', N'Secondary malignant neoplasm of other specified sites', N'', N' ', N'', NULL, NULL, N'C798:Secondary malignant neoplasm of other specified sites')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C80    ', N'Malignant neoplasm without specification of site', N'   Carcinoma       )
   Carcinomatosis  )
   Generalized:    )
   . cancer        ) unspecified site (primary)(secondary)
   . malignancy    )
   Malignancy      )
   Multiple cancer )
   Malignant cachexia
   Primary site unknown
', N' ', N'', NULL, NULL, N'C80:Malignant neoplasm without specification of site')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C81    ', N'Hodgkin''s disease', N'Includes :
 morphology codes M965-M966 with behaviour code /3
', N' ', N'', NULL, NULL, N'C81:Hodgkin''s disease')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C810   ', N'Lymphocytic predominance Hodgkin''s disease', N'   Lymphocytic-histiocytic predominance
', N' ', N'', NULL, NULL, N'C810:Lymphocytic predominance Hodgkin''s disease')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C811   ', N'Nodular sclerosis Hodgkin''s disease', N'', N' ', N'', NULL, NULL, N'C811:Nodular sclerosis Hodgkin''s disease')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C812   ', N'Mixed cellularity Hodgkin''s disease', N'', N' ', N'', NULL, NULL, N'C812:Mixed cellularity Hodgkin''s disease')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C813   ', N'Lymphocytic depletion Hodgkin''s disease', N'', N' ', N'', NULL, NULL, N'C813:Lymphocytic depletion Hodgkin''s disease')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C817   ', N'Other Hodgkin''s disease', N'', N' ', N'', NULL, NULL, N'C817:Other Hodgkin''s disease')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C819   ', N'Hodgkin''s disease, unspecified', N'', N' ', N'', NULL, NULL, N'C819:Hodgkin''s disease, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C82    ', N'Follicular [nodular] non-Hodgkin''s lymphoma', N'Includes :
 follicular non-Hodgkin''s lymphoma with or without diffuse areas
 morphology code M969 with behaviour code /3
', N' ', N'', NULL, NULL, N'C82:Follicular [nodular] non-Hodgkin''s lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C820   ', N'Small cleaved cell, follicular', N'', N' ', N'', NULL, NULL, N'C820:Small cleaved cell, follicular')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C821   ', N'Mixed small cleaved and large cell, follicular', N'', N' ', N'', NULL, NULL, N'C821:Mixed small cleaved and large cell, follicular')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C822   ', N'Large cell, follicular non-Hodgkin''s lymphoma', N'', N' ', N'', NULL, NULL, N'C822:Large cell, follicular non-Hodgkin''s lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C827   ', N'Other types  of follicular non-Hodgkin''s lymphoma', N'', N' ', N'', NULL, NULL, N'C827:Other types  of follicular non-Hodgkin''s lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C829   ', N'Follicular non-Hodgkin''s lymphoma, unspecified', N'   Nodular non-Hodgkins''s lymphoma NOS
', N' ', N'', NULL, NULL, N'C829:Follicular non-Hodgkin''s lymphoma, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C83    ', N'Diffuse non-Hodgkin''s lymphoma', N'Includes :
 morphology codes M9593, M9595, M967-M968 with behaviour code /3
', N' ', N'', NULL, NULL, N'C83:Diffuse non-Hodgkin''s lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C830   ', N'Small cell (diffuse) non-Hodgkin''s lymphoma', N'', N' ', N'', NULL, NULL, N'C830:Small cell (diffuse) non-Hodgkin''s lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C831   ', N'Small cleved cell (diffuse) non-Hodgkin''s lymphoma', N'', N' ', N'', NULL, NULL, N'C831:Small cleved cell (diffuse) non-Hodgkin''s lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C832   ', N'Mixed small and large cell (diffuse) non-Hodgkin''s lymphoma', N'', N' ', N'', NULL, NULL, N'C832:Mixed small and large cell (diffuse) non-Hodgkin''s lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C833   ', N'Large cell (diffuse) non-Hodgkin''s lymphoma', N'   Reticulum cell sarcoma
', N' ', N'', NULL, NULL, N'C833:Large cell (diffuse) non-Hodgkin''s lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C834   ', N'Immunoblastic (diffuse) non-Hodgkin''s lymphoma', N'', N' ', N'', NULL, NULL, N'C834:Immunoblastic (diffuse) non-Hodgkin''s lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C835   ', N'Lymphoblastic (diffuse) non-Hodgkin''s lymphoma', N'', N' ', N'', NULL, NULL, N'C835:Lymphoblastic (diffuse) non-Hodgkin''s lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C836   ', N'Undifferentiated (diffuse) non-Hodgkin''s lymphoma', N'', N' ', N'', NULL, NULL, N'C836:Undifferentiated (diffuse) non-Hodgkin''s lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C837   ', N'Burkitt''s tumour', N'', N' ', N'', NULL, NULL, N'C837:Burkitt''s tumour')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C838   ', N'Other types of diffuse non-Hodgkin''s lymphoma', N'', N' ', N'', NULL, NULL, N'C838:Other types of diffuse non-Hodgkin''s lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C8380  ', N'Mantle cell lymphoma                                                                ', NULL, NULL, NULL, NULL, NULL, N'C8380:Mantle cell lymphoma                                                                ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C8381  ', N'Lymphoma of mucosa-associated lymphoid tissues (MALT)                               ', NULL, NULL, NULL, NULL, NULL, N'C8381:Lymphoma of mucosa-associated lymphoid tissues (MALT)                               ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C8388  ', N'Other types of diffuse non-Hodgkin''s lymphoma                                       ', NULL, NULL, NULL, NULL, NULL, N'C8388:Other types of diffuse non-Hodgkin''s lymphoma                                       ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C839   ', N'Diffuse non-Hodgkin''s lymphoma, unspecified', N'', N' ', N'', NULL, NULL, N'C839:Diffuse non-Hodgkin''s lymphoma, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C84    ', N'Peripheral and cutaneous T-cell lymphomas', N'Includes :
 morphology code M970 with behaviour code /3
', N' ', N'', NULL, NULL, N'C84:Peripheral and cutaneous T-cell lymphomas')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C840   ', N'Mycosis fungoides', N'', N' ', N'', NULL, NULL, N'C840:Mycosis fungoides')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C841   ', N'Sezary''s disease', N'', N' ', N'', NULL, NULL, N'C841:Sezary''s disease')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C842   ', N'T-zone lymphoma', N'', N' ', N'', NULL, NULL, N'C842:T-zone lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C843   ', N'Lymphoepithelioid lymphoma', N'   Lennert''s lymphoma
', N' ', N'', NULL, NULL, N'C843:Lymphoepithelioid lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C844   ', N'Peripheral T-cell lymphoma', N'', N' ', N'', NULL, NULL, N'C844:Peripheral T-cell lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C8440  ', N'Anaplastic large cell lymphoma                                                      ', NULL, NULL, NULL, NULL, NULL, N'C8440:Anaplastic large cell lymphoma                                                      ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C8441  ', N'Angiocentric lymphoma                                                               ', NULL, NULL, NULL, NULL, NULL, N'C8441:Angiocentric lymphoma                                                               ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C8442  ', N'Angioimmunoblastic lymphoma                                                         ', NULL, NULL, NULL, NULL, NULL, N'C8442:Angioimmunoblastic lymphoma                                                         ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C8443  ', N'Hepatosplenic T-cell lymphoma                                                       ', NULL, NULL, NULL, NULL, NULL, N'C8443:Hepatosplenic T-cell lymphoma                                                       ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C8448  ', N'Other peripheral T-cell lymphoma                                                    ', NULL, NULL, NULL, NULL, NULL, N'C8448:Other peripheral T-cell lymphoma                                                    ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C8449  ', N'Peirpheral T-cell lymphoma, unspecified                                             ', NULL, NULL, NULL, NULL, NULL, N'C8449:Peirpheral T-cell lymphoma, unspecified                                             ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C845   ', N'Other and unspecified T-cell lymphomas', N'', N' ', N'', NULL, NULL, N'C845:Other and unspecified T-cell lymphomas')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C85    ', N'Other and unspecified types of non-Hodgkin''s lymphoma', N'Includes :
 morphology codes M9590-M9592, M9594, M971 with behaviour code /3
', N' ', N'', NULL, NULL, N'C85:Other and unspecified types of non-Hodgkin''s lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C850   ', N'Lymphosarcoma', N'', N' ', N'', NULL, NULL, N'C850:Lymphosarcoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C851   ', N'B-cell oymphoma, unspecified', N'', N' ', N'', NULL, NULL, N'C851:B-cell oymphoma, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C857   ', N'Other specified types of non-Hodgkin''s lymphoma', N'   Malignant:
   . reticuloendotheliosis
   . reticulosis
   Microglioma
', N' ', N'', NULL, NULL, N'C857:Other specified types of non-Hodgkin''s lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C859   ', N'Non-Hodgkin''s lymphoma, unspecified type', N'   Lymphoma NOS
   Malignant lymphoma NOS
   Non-Hodgkin''s lymphoma NOS
', N' ', N'', NULL, NULL, N'C859:Non-Hodgkin''s lymphoma, unspecified type')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C88    ', N'Malignant immunoproliferative diseases', N'Includes :
 morphology code M976 with behaviour code /3
', N' ', N'', NULL, NULL, N'C88:Malignant immunoproliferative diseases')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C880   ', N'Waldenstrom''s macroglobulinaemia', N'', N' ', N'', NULL, NULL, N'C880:Waldenstrom''s macroglobulinaemia')
GO
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C881   ', N'Alpha heavy chain disease', N'', N' ', N'', NULL, NULL, N'C881:Alpha heavy chain disease')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C882   ', N'Gamma heavy chain disease', N'   Franklin''s disease
', N' ', N'', NULL, NULL, N'C882:Gamma heavy chain disease')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C883   ', N'Immunoproliferative small intestinal disease', N'   Mediterranean lymphoma
', N' ', N'', NULL, NULL, N'C883:Immunoproliferative small intestinal disease')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C887   ', N'Other malignant immunoproliferative diseases', N'', N' ', N'', NULL, NULL, N'C887:Other malignant immunoproliferative diseases')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C889   ', N'Malignant immunoproliferative disease, unspecified', N'   Immunoproliferative disease NOS
', N' ', N'', NULL, NULL, N'C889:Malignant immunoproliferative disease, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C90    ', N'Multiple myeloma and malignant plasma cell neoplasms', N'Includes :
 morphology codes M973, M9830 with behaviour code /3
', N' ', N'', NULL, NULL, N'C90:Multiple myeloma and malignant plasma cell neoplasms')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C900   ', N'Multiple myeloma', N'   Kahler''s disease
   Myelomatosis

Excludes :
 solitary myeloma (C90.2)
', N' ', N'', NULL, NULL, N'C900:Multiple myeloma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C901   ', N'Plasma cell leukaemia', N'', N' ', N'', NULL, NULL, N'C901:Plasma cell leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C902   ', N'Plasmacytoma, extramedullary', N'   Malignant plasma cell tumour NOS
   Plasmacytoma NOS
   Solitary myeloma
', N' ', N'', NULL, NULL, N'C902:Plasmacytoma, extramedullary')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C91    ', N'Lymphoid leukaemia', N'Includes :
 morphology codes M982, M9940-M9941 with behaviour code /3
', N' ', N'', NULL, NULL, N'C91:Lymphoid leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C910   ', N'Acute lymphoblastic leukaemia', N'
Excludes :
 acute exacerbation of chronic lymphocytic leukaemia (C91.1)
', N' ', N'', NULL, NULL, N'C910:Acute lymphoblastic leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C911   ', N'Chronic lymphocytic leukaemia', N'', N' ', N'', NULL, NULL, N'C911:Chronic lymphocytic leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C912   ', N'Subacute lymphocytic leukaemia', N'', N' ', N'', NULL, NULL, N'C912:Subacute lymphocytic leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C913   ', N'Prolymphocytic leukaemia', N'', N' ', N'', NULL, NULL, N'C913:Prolymphocytic leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C914   ', N'Hairy-cell leukaemia', N'   Leukaemic reticuloendotheliosis
', N' ', N'', NULL, NULL, N'C914:Hairy-cell leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C915   ', N'Adult T-cell leukaemia', N'', N' ', N'', NULL, NULL, N'C915:Adult T-cell leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C917   ', N'Other lymphoid leukaemia', N'', N' ', N'', NULL, NULL, N'C917:Other lymphoid leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C919   ', N'Lymphoid leukaemia, unspecified', N'', N' ', N'', NULL, NULL, N'C919:Lymphoid leukaemia, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C92    ', N'Myploid leukaemia', N'Includes :
 leukaemia:
 . granulocytic
 . myelogenous
 morphology codes M986-M988, M9930 with behaviour code /3
', N' ', N'', NULL, NULL, N'C92:Myploid leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C920   ', N'Acute myeloid leukaemia', N'
Excludes :
 acute exacerbation of chronic myeloid leukaemia (C92.1)
', N' ', N'', NULL, NULL, N'C920:Acute myeloid leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C921   ', N'Chronic myeloid leukaemia', N'', N' ', N'', NULL, NULL, N'C921:Chronic myeloid leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C922   ', N'Subacute myeloid leukaemia', N'', N' ', N'', NULL, NULL, N'C922:Subacute myeloid leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C923   ', N'Myeloid sarcoma', N'   Chloroma
   Granulocytic sarcoma
', N' ', N'', NULL, NULL, N'C923:Myeloid sarcoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C924   ', N'Acute promyelocytic leukaemia', N'', N' ', N'', NULL, NULL, N'C924:Acute promyelocytic leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C925   ', N'Acute myelomonocytic leukaemia', N'', N' ', N'', NULL, NULL, N'C925:Acute myelomonocytic leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C927   ', N'Other myeloid leukaemia', N'', N' ', N'', NULL, NULL, N'C927:Other myeloid leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C929   ', N'Myeloid leukaemia, unspecified', N'', N' ', N'', NULL, NULL, N'C929:Myeloid leukaemia, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C93    ', N'Monocytic leukaemia', N'Includes :
 monocytoid leukaemia
 morphology code M989 with behaviour code /3
', N' ', N'', NULL, NULL, N'C93:Monocytic leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C930   ', N'Acute monocytic leukaemia', N'
Excludes :
 acute exacerbation of chronic monocytic leukaemia (C93.1)
', N' ', N'', NULL, NULL, N'C930:Acute monocytic leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C931   ', N'Chronic monocytic leukaemia', N'', N' ', N'', NULL, NULL, N'C931:Chronic monocytic leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C932   ', N'Subacute monocytic leukemia', N'', N' ', N'', NULL, NULL, N'C932:Subacute monocytic leukemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C937   ', N'Other monocytic leukaemia', N'', N' ', N'', NULL, NULL, N'C937:Other monocytic leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C939   ', N'Monocytic leukarmia, unspecified', N'', N' ', N'', NULL, NULL, N'C939:Monocytic leukarmia, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C94    ', N'Other leukaemia  of specified cell type', N'Includes :
 morphology codes M984, M9850, M9900, M9910, M9931-M9932 with
   behaviour code /3

Excludes :
 leukaemic reticuloendotheliosis (C91.4)
 plasma cell leukaemia (C90.1)
', N' ', N'', NULL, NULL, N'C94:Other leukaemia  of specified cell type')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C940   ', N'Acute erythraemia and erythroleukaemia', N'   Acute erythraemic myelosis
   Di Guglielmo''s disease
', N' ', N'', NULL, NULL, N'C940:Acute erythraemia and erythroleukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C941   ', N'Chronic erythraemia', N'   Heilmeyer-Sch”ner disease
', N' ', N'', NULL, NULL, N'C941:Chronic erythraemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C942   ', N'Acute megakaryoblastic leukaemia', N'   Leukaemia:
   . megakaryoblastic (acute)
   . megakaryocytic (acute)
', N' ', N'', NULL, NULL, N'C942:Acute megakaryoblastic leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C943   ', N'Mast cell leukaemia', N'', N' ', N'', NULL, NULL, N'C943:Mast cell leukaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C944   ', N'Acute panmyelosis', N'', N' ', N'', NULL, NULL, N'C944:Acute panmyelosis')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C945   ', N'Acute myelofibrosis', N'', N' ', N'', NULL, NULL, N'C945:Acute myelofibrosis')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C947   ', N'Other specified leukaemias', N'   Lymphosarcoma cell leukaemia
', N' ', N'', NULL, NULL, N'C947:Other specified leukaemias')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C95    ', N'Leukaemia of unspecified cell type', N'Includes :
 morphology code M980 with behaviour code /3
', N' ', N'', NULL, NULL, N'C95:Leukaemia of unspecified cell type')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C950   ', N'Acute leukaemia of unspecified cell type', N'   Blast cell leukaemia
   Stem cell leukaemia

Excludes :
 acute exacerbation of unspecified chronic leukaemia (C95.1)
', N' ', N'', NULL, NULL, N'C950:Acute leukaemia of unspecified cell type')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C951   ', N'Chronic leukaemia of unspecified cell type', N'', N' ', N'', NULL, NULL, N'C951:Chronic leukaemia of unspecified cell type')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C952   ', N'Subacute leukaemia unspecified cell type', N'', N' ', N'', NULL, NULL, N'C952:Subacute leukaemia unspecified cell type')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C957   ', N'Other  leukaemia unspecified cell type', N'', N' ', N'', NULL, NULL, N'C957:Other  leukaemia unspecified cell type')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C959   ', N'Leukaemia, unspecirfied', N'', N' ', N'', NULL, NULL, N'C959:Leukaemia, unspecirfied')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C96    ', N'Other and unspcified malignant neoplasms of lymphoid, haematopoietic and related tissue', N'Includes :
 morphology codes M972, M974 with behaviour code /3
', N' ', N'', NULL, NULL, N'C96:Other and unspcified malignant neoplasms of lymphoid, haematopoietic and related tissue')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C960   ', N'Letterer-Siwe disease', N'   Nonlipid:
   . reticuloendotheliosis
   . reticulosis
', N' ', N'', NULL, NULL, N'C960:Letterer-Siwe disease')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C961   ', N'Malignant histiocytosis', N'   Histiocytic medullary reticulosis
', N' ', N'', NULL, NULL, N'C961:Malignant histiocytosis')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C962   ', N'Malignant mast cell tumour', N'   Malignant:
   . mastocytoma
   . mastocytosis
   Mast cell sarcoma

Excludes :
 mast cell leukaemia (C94.3)
 mastocytosis (cutaneous) (Q82.2)
', N' ', N'', NULL, NULL, N'C962:Malignant mast cell tumour')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C963   ', N'true histiocytic lymphoma', N'', N' ', N'', NULL, NULL, N'C963:true histiocytic lymphoma')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C967   ', N'Other specified malignant neoplasms of lymphoid, haematopoietic and  related tissue', N'tissue
', N' ', N'', NULL, NULL, N'C967:Other specified malignant neoplasms of lymphoid, haematopoietic and  related tissue')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C969   ', N'Malignant neoplasm of lymphoid, haematopoietic and  related tissue, unspecified', N'', N' ', N'', NULL, NULL, N'C969:Malignant neoplasm of lymphoid, haematopoietic and  related tissue, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'C97    ', N'Malignant neoplasms of independent (primary) multiple sites', N'Includes :
 Bowen''s disease
 erythroplasia
 morphology codes with behaviour code /2
 Queyrat''s erythroplasia
', N' ', N'', NULL, NULL, N'C97:Malignant neoplasms of independent (primary) multiple sites')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E110   ', N'DM Type II (With coma)                                                              ', NULL, NULL, NULL, NULL, NULL, N'E110:DM Type II (With coma)                                                              ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E111   ', N'DM Type II (With Ketoacidosis)                                                      ', NULL, NULL, NULL, NULL, NULL, N'E111:DM Type II (With Ketoacidosis)                                                      ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E112   ', N'DM Type II (With renal complications)                                               ', NULL, NULL, NULL, NULL, NULL, N'E112:DM Type II (With renal complications)                                               ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E113   ', N'DM Type II (With ophthalmic complications)                                          ', NULL, NULL, NULL, NULL, NULL, N'E113:DM Type II (With ophthalmic complications)                                          ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E115   ', N'DM Type II (With peripheral circulatory complications)                              ', NULL, NULL, NULL, NULL, NULL, N'E115:DM Type II (With peripheral circulatory complications)                              ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E116   ', N'DM Type II (With other specified complications)                                     ', NULL, NULL, NULL, NULL, NULL, N'E116:DM Type II (With other specified complications)                                     ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E117   ', N'DM Type II (With multiple complications)                                            ', NULL, NULL, NULL, NULL, NULL, N'E117:DM Type II (With multiple complications)                                            ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E118   ', N'DM Type II (With unspecified complications)                                         ', NULL, NULL, NULL, NULL, NULL, N'E118:DM Type II (With unspecified complications)                                         ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E119   ', N'Noninsulin -dependent diabetes mellitus', N'{\rtf1\ansi\deff0{\fonttbl{\f0\fnil\fcharset222 Tahoma;}{\f1\fnil\fcharset0 Tahoma;}}
\viewkind4\uc1\pard\lang1054\f0\fs20  \lang1033\f1 DM.type 2 adult- onset , maturity- onset\lang1054\f0\par
}
', NULL, NULL, NULL, NULL, N'E119:Noninsulin -dependent diabetes mellitus')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E660   ', N'Obesity due to excess calories', N'', N' ', N'', NULL, NULL, N'E660:Obesity due to excess calories')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E661   ', N'Drug-induced obesity', N'', N' ', N'', NULL, NULL, N'E661:Drug-induced obesity')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E662   ', N'Extreme obesity with alveolar hypoventilation', N'   Pickwickian syndrome
', N' ', N'', NULL, NULL, N'E662:Extreme obesity with alveolar hypoventilation')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E668   ', N'Other obesity', N'   Morbid obesity
', N' ', N'', NULL, NULL, N'E668:Other obesity')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E669   ', N'Obesity, unspecified', N'   Simple obesity NOS
', N' ', N'', NULL, NULL, N'E669:Obesity, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E780   ', N'Pure hypercholesterolaemia', N'   Familial hypercholesterolaemia
   Fredrickson''s hyperlipoproteinaemia, type IIa
   Hyperbetalipoproteinaemia
   Hyperlipidaemia, Group A
   Low-density-lipoprotein-type [LDL] hyperlipoproteinaemia
', N' ', N'', NULL, NULL, N'E780:Pure hypercholesterolaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E781   ', N'Pure hyperglyceridaemia', N'   Endogenous hyperglyceridaemia
   Fredrickson''s hyperlipoproteinaemia, type IV
   Hyperlipidaemia, Group B
   Hyperprebeta lipoproteinaemia
   Very-low-density-lipoprotein-type [VLDL] hyperlipoproteinaemia
', N' ', N'', NULL, NULL, N'E781:Pure hyperglyceridaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E782   ', N'Mixed hyperlipidaemia', N'   Broad- or floating-betalipoproteinaemia
   Fredrickson''s hyperlipoproteinaemia, type IIb or III
   Hyperbetalipoproteinaemia with prebetalipoproteinaemia
   Hypercholesterolaemia with endogenous hyperglyceridaemia
   Hyperlipidaemia, Group C
   Tu', N' ', N'', NULL, NULL, N'E782:Mixed hyperlipidaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E783   ', N'Hyperchylomicronaemia', N'   Fredrickson''s hyperlipoproteinaemia, type I or V
   Hyperlipidaemia, Group D
   Mixed hyperglyceridaemia
', N' ', N'', NULL, NULL, N'E783:Hyperchylomicronaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E784   ', N'Other hyperlipidaemia', N'   Familial combined hyperlipidaemia
', N' ', N'', NULL, NULL, N'E784:Other hyperlipidaemia')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E785   ', N'Hyperlipidaemia, unspecified', N'', N' ', N'', NULL, NULL, N'E785:Hyperlipidaemia, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E786   ', N'Lipoprotein deficiency', N'   Abetalipoproteinaemia
   High-density lipoprotein deficiency
   Hypoalphalipoproteinaemia
   Hypobetalipoproteinaemia (familial)
   Lecithin cholesterol acyltransferase deficiency
   Tangier disease
', N' ', N'', NULL, NULL, N'E786:Lipoprotein deficiency')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E788   ', N'Other disorders of lipoprotein metabolism', N'', N' ', N'', NULL, NULL, N'E788:Other disorders of lipoprotein metabolism')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'E789   ', N'Disorder of lipoprotein metabolism,unspecified', N'', N' ', N'', NULL, NULL, N'E789:Disorder of lipoprotein metabolism,unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I10    ', N'hypertension', N'   Hypertension (arterial)(benign)(essential)(malignant)(primary)(systemic)

Excludes :
 involving vessels of:
 . brain (I60-I69)
 . eye (H35.0)
', N' ', N'', NULL, NULL, N'I10:hypertension')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I200   ', N'Unstable angina', N'   Angina:
   . crescendo
   . de novo effort
   . worsening effort
   Intermediate coronary syndrome
   Preinfarction syndrome
', N' ', N'', NULL, NULL, N'I200:Unstable angina')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I201   ', N'Angina pectoris with documented spasm', N'   Angina:
   . angiospastic
   . Prinzmetal
   . spasm-induced
   . variant
', N' ', N'', NULL, NULL, N'I201:Angina pectoris with documented spasm')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I208   ', N'Other formas of angina pectoris', N'   Angina of effort
   Stenocardia
', N' ', N'', NULL, NULL, N'I208:Other formas of angina pectoris')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I209   ', N'Angina pectoris, unspecified', N'   Angina:
   . NOS
   . cardiac
   Anginal syndrome
   Ischaemic chest pain
', N' ', N'', NULL, NULL, N'I209:Angina pectoris, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I21    ', N'Acute myocardial infarction', N'Includes :
 myocardial infarction specified as acute or with a stated duration of
           4 weeks (28 days) or less from onset

Excludes :
 certain current complications following acute myocardial infarction (I23.-)
 myocardial infarction:
 . ol', N' ', N'', NULL, NULL, N'I21:Acute myocardial infarction')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I210   ', N'Acute transmural myocardial infarction of anterior wall', N'   Transmural infarction (acute)(of):
     . anterior (wall) NOS
     . anteroapical
     . anterolateral
     . anteroseptal
', N' ', N'', NULL, NULL, N'I210:Acute transmural myocardial infarction of anterior wall')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I211   ', N'Acute transmural myocardial infarction of inferior wall', N'   Transmural infarction (acute)(of):
   . diaphragmatic wall
   . inferior (wall) NOS
   . inferolateral
   . inferoposterior
', N' ', N'', NULL, NULL, N'I211:Acute transmural myocardial infarction of inferior wall')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I212   ', N'Acute transmuural myocardial infarction of other sites', N'   Transmural infarction (acute)(of):
   . apical-lateral
   . basal-lateral
   . high lateral
   . lateral (wall) NOS
   . posterior (true)
   . posterobasal
   . posterolateral
   . posteroseptal
   . septal NOS
', N' ', N'', NULL, NULL, N'I212:Acute transmuural myocardial infarction of other sites')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I213   ', N'Acute transmuural myocardial infarction of unspecified site', N'   Transmural myocardial infarction NOS
', N' ', N'', NULL, NULL, N'I213:Acute transmuural myocardial infarction of unspecified site')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I214   ', N'Acute subendocardial myocardial infarction', N'   Nontransmural myocardial infarction NOS
', N' ', N'', NULL, NULL, N'I214:Acute subendocardial myocardial infarction')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I219   ', N'Acute myocardial infarction,unspecified', N'   Myocardial infarction (acute) NOS
', N' ', N'', NULL, NULL, N'I219:Acute myocardial infarction,unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I22    ', N'Subsequent myocardial infarction', N'Includes :
 recurrent myocardial infarction

Excludes :
 specified as chronic or with a stated duration of more than 4 weeks (more than 28 days) from onset (I25.8)
', N' ', N'', NULL, NULL, N'I22:Subsequent myocardial infarction')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I220   ', N'Subsequent myocardial infarction of anterior wall', N'   Subsequent infarction (acute)(of):
   . anterior (wall) NOS
   . anteroapical
   . anterolateral
   . anteroseptal
', N' ', N'', NULL, NULL, N'I220:Subsequent myocardial infarction of anterior wall')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I221   ', N'Subsequent myocardial infarction of inferior wall', N'   Subsequent infarction (acute)(of):
   . diaphragmatic wall
   . inferior (wall) NOS
   . inferolateral
   . inferoposterior
', N' ', N'', NULL, NULL, N'I221:Subsequent myocardial infarction of inferior wall')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I228   ', N'Subsequent myocardial infarction of other sites', N'   Subsequent myocardial infarction (acute)(of):
   . apical-lateral
   . basal-lateral
   . high lateral
   . lateral (wall) NOS
   . posterior (true)
   . posterobasal
   . posterolateral
   . posteroseptal
   . septal NOS
', N' ', N'', NULL, NULL, N'I228:Subsequent myocardial infarction of other sites')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I229   ', N'Subsequent myocardial infarction of unspecified site', N'', N' ', N'', NULL, NULL, N'I229:Subsequent myocardial infarction of unspecified site')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I23    ', N'Certain current complications following acute myocardial infarction', N'
Excludes :
 the listed conditions, when:
 . concurrent with acute myocardial infarction (I21-I22)
 . not specified as current complications following acute myocardial infarction (I31.-, I51.-)
', N' ', N'', NULL, NULL, N'I23:Certain current complications following acute myocardial infarction')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I230   ', N'Haemopericardium as current complication following acute myocardial infarction', N'', N' ', N'', NULL, NULL, N'I230:Haemopericardium as current complication following acute myocardial infarction')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I231   ', N'Atrial septal defect as current complication following acute myocardial infarction', N'infarction
', N' ', N'', NULL, NULL, N'I231:Atrial septal defect as current complication following acute myocardial infarction')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I232   ', N'Ventricular spetal defect as current complication following acute myocardial infarction', N'infarction
', N' ', N'', NULL, NULL, N'I232:Ventricular spetal defect as current complication following acute myocardial infarction')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I233   ', N'Rupture of cardiac wall without haemopericardium as current complication following acute myocardial ', N'following acute myocardial infarction

Excludes :
 with haemopericardium (I23.0)
', N' ', N'', NULL, NULL, N'I233:Rupture of cardiac wall without haemopericardium as current complication following acute myocardial ')
GO
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I234   ', N'Rupture of chordae tendineae as current complication following acute myocardial infarction', N'infarction
', N' ', N'', NULL, NULL, N'I234:Rupture of chordae tendineae as current complication following acute myocardial infarction')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I235   ', N'Rupture of papillary muscle as current complication following acute myocardial infarction', N'infarction
', N' ', N'', NULL, NULL, N'I235:Rupture of papillary muscle as current complication following acute myocardial infarction')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I236   ', N'Thrombosis of atrium, auricular appendage, and ventricle as current complications following acute my', N'complications following acute myocardial infarction
', N' ', N'', NULL, NULL, N'I236:Thrombosis of atrium, auricular appendage, and ventricle as current complications following acute my')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I238   ', N'Other current complications following acute myocardial infarction', N'', N' ', N'', NULL, NULL, N'I238:Other current complications following acute myocardial infarction')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I24    ', N'Other acute ischaemic heart diseases', N'
Excludes :
 angina pectoris (I20.-)
 transient myocardial ischaemia of newborn (P29.4)
', N' ', N'', NULL, NULL, N'I24:Other acute ischaemic heart diseases')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I240   ', N'Coronary thrombosis not resulting in myocardial infarction', N'   Coronary (artery)(vein):
   . embolism        )
   . occlusion       ) not resulting in myocardial infarction
   . thromboembolism )

Excludes :
 specified as chronic or with a stated duration of more than 4 weeks (more than 28 days) from onset (', N' ', N'', NULL, NULL, N'I240:Coronary thrombosis not resulting in myocardial infarction')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I241   ', N'Dressler''s syndrome', N'   Postmyocardial infarction syndrome
', N' ', N'', NULL, NULL, N'I241:Dressler''s syndrome')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I248   ', N'Other forms of acute ischaemic heart disease', N'   Coronary:
   . failure
   . insufficiency
', N' ', N'', NULL, NULL, N'I248:Other forms of acute ischaemic heart disease')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I249   ', N'Acute ischaemic heart disease, unspecified', N'
Excludes :
 ischaemic heart disease (chronic) NOS (I25.9)
', N' ', N'', NULL, NULL, N'I249:Acute ischaemic heart disease, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I25    ', N'Chronic ischaemic heart disease', N'
Excludes :
 cardiovascular disease NOS (I51.6)
', N' ', N'', NULL, NULL, N'I25:Chronic ischaemic heart disease')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I630   ', N'Cerebral infarction due to thrombosis of precerebral arteries', N'', N' ', N'', NULL, NULL, N'I630:Cerebral infarction due to thrombosis of precerebral arteries')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I631   ', N'Cerebral infarction due to embolism of precerebral arteries', N'', N' ', N'', NULL, NULL, N'I631:Cerebral infarction due to embolism of precerebral arteries')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I632   ', N'Cerebral infarction due to unspecified occlusion or stenosis of precerebral arteries', N'arteries
', N' ', N'', NULL, NULL, N'I632:Cerebral infarction due to unspecified occlusion or stenosis of precerebral arteries')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I633   ', N'Cerebral infarction due to thrombosis of cerebral arteries', N'{\rtf1\ansi\deff0{\fonttbl{\f0\fnil\fcharset222 Tahoma;}{\f1\fnil\fcharset0 Tahoma;}}
\viewkind4\uc1\pard\lang1054\f0\fs20  \lang1033\f1 Cerebral Vascular thrombosis\lang1054\f0\par
}
', N' ', N'', NULL, NULL, N'I633:Cerebral infarction due to thrombosis of cerebral arteries')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I634   ', N'Cerebral infarction due to embolism of cerebral arteries', N'', N' ', N'', NULL, NULL, N'I634:Cerebral infarction due to embolism of cerebral arteries')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I635   ', N'Cerebral infarction due to unspecified occlusion or stenosis of cerebral arteries', N'arteries
', N' ', N'', NULL, NULL, N'I635:Cerebral infarction due to unspecified occlusion or stenosis of cerebral arteries')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I636   ', N'Cerebral infarction due to cerebral venous thrombosis,nonpyogenic', N'', N' ', N'', NULL, NULL, N'I636:Cerebral infarction due to cerebral venous thrombosis,nonpyogenic')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I638   ', N'Other cerebral infarction', N'', N' ', N'', NULL, NULL, N'I638:Other cerebral infarction')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I639   ', N'Cerebral infarction,unspecified', N'', N' ', N'', NULL, NULL, N'I639:Cerebral infarction,unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'I64    ', N'Stroke,not specified as haemorrhage or infarction', N'
Excludes :
 sequelae of stroke (I69.4)
', N' ', N'', NULL, NULL, N'I64:Stroke,not specified as haemorrhage or infarction')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M100   ', N'Idiopathic gout', N'   Gouty bursitis
   Primary gout
   Urate tophus of heart+ (I43.8*)
', N' ', N'', NULL, NULL, N'M100:Idiopathic gout')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M1000  ', N'Idiopathic gout (Multiple sites)                                                    ', NULL, NULL, NULL, NULL, NULL, N'M1000:Idiopathic gout (Multiple sites)                                                    ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M1001  ', N'Idiopathic gout (Shoulder region)                                                   ', NULL, NULL, NULL, NULL, NULL, N'M1001:Idiopathic gout (Shoulder region)                                                   ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M1002  ', N'Idiopathic gout (Upper arm)                                                         ', NULL, NULL, NULL, NULL, NULL, N'M1002:Idiopathic gout (Upper arm)                                                         ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M1003  ', N'Idiopathic gout (Forearm)                                                           ', NULL, NULL, NULL, NULL, NULL, N'M1003:Idiopathic gout (Forearm)                                                           ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M1004  ', N'Idiopathic gout (Hand)                                                              ', NULL, NULL, NULL, NULL, NULL, N'M1004:Idiopathic gout (Hand)                                                              ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M1005  ', N'Idiopathic gout (Pelvic region and thigh)                                           ', NULL, NULL, NULL, NULL, NULL, N'M1005:Idiopathic gout (Pelvic region and thigh)                                           ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M1006  ', N'Idiopathic gout (Lower leg)                                                         ', NULL, NULL, NULL, NULL, NULL, N'M1006:Idiopathic gout (Lower leg)                                                         ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M1007  ', N'Idiopathic gout (Ankle and foot)                                                    ', NULL, NULL, NULL, NULL, NULL, N'M1007:Idiopathic gout (Ankle and foot)                                                    ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M1008  ', N'Idiopathic gout (Other)                                                             ', NULL, NULL, NULL, NULL, NULL, N'M1008:Idiopathic gout (Other)                                                             ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M1009  ', N'Idiopathic gout (Site unspecified)                                                  ', NULL, NULL, NULL, NULL, NULL, N'M1009:Idiopathic gout (Site unspecified)                                                  ')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M101   ', N'Lead-induced gout', N'', N' ', N'', NULL, NULL, N'M101:Lead-induced gout')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M102   ', N'Drug-induced gout', N'', N' ', N'', NULL, NULL, N'M102:Drug-induced gout')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M103   ', N'Gout due to impairment of renal function', N'', N' ', N'', NULL, NULL, N'M103:Gout due to impairment of renal function')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M104   ', N'Other secondary gout', N'', N' ', N'', NULL, NULL, N'M104:Other secondary gout')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'M109   ', N'Gout, unspecified', N'', N' ', N'', NULL, NULL, N'M109:Gout, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'N179   ', N'Acute renal failure, unspecified', N'', N' ', N'', NULL, NULL, N'N179:Acute renal failure, unspecified')
INSERT [dbo].[NUTR_DIAG] ([CODE], [DES], [TEXTS], [DISEASE], [STARTS], [HIDESELECT], [SECLEVEL], [FULLDES]) VALUES (N'N19    ', N'Unspecified renal failure', N'
Excludes :
 uraemia of newborn (P96.0)
 renal failure with hypertension (I12.0)
', N' ', N'', NULL, NULL, N'N19:Unspecified renal failure')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00010001', N'ผู้ป่วยสามัญ', NULL, N'0001')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00010002', N'ผู้ป่วยพิเศษ', NULL, N'0001')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00030001', N'งดสัตว์ปีก', NULL, N'0003')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00030002', N'งดอาหารดำแดง', NULL, N'0003')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00030003', N'แพ้อาหารทะเล', NULL, N'0003')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00030004', N'งดผักผลไม้สด', NULL, N'0003')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00030005', N'งดเนื้อสัตว์', NULL, N'0003')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00030006', N'งดนม', NULL, N'0003')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00030007', N'งดถั่ว', NULL, N'0003')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00210001', N'นมถั่วเหลืองไม่มีน้ำตาล', NULL, N'0021')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00210002', N'นมถั่วเหลืองเจ', NULL, N'0021')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00210003', N'นมถั่วเหลือง', NULL, N'0021')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00210004', N'นมมพร่องมันเนย', NULL, N'0021')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00210005', N'นม UHT', NULL, N'0021')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00210006', N'น้ำซุป', NULL, N'0021')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00210007', N'น้ำหวานใส', NULL, N'0021')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00210008', N'น้ำหวานสี', NULL, N'0021')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'00210009', N'น้ำข้าว', NULL, N'0021')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'0021000A', N'น้ำขิง', NULL, N'0021')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'0021000B', N'โอวัลติน', NULL, N'0021')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'0021000C', N'น้ำเชื่อม', NULL, N'0021')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'02310001', N'อาหารธรรมดาปกติ', NULL, N'0231')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'02310002', N'อาหารธรรมดาเพิ่มไข่', NULL, N'0231')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'22210001', N'โจ๊ก', NULL, N'2221')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'22210002', N'โจ๊กปั่น', NULL, N'2221')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'22210003', N'ข้าวต้มกุ้ย', NULL, N'2221')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'22210004', N'ข้าวต้มเครื่อง', NULL, N'2221')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'22220001', N'เบาหวาน', NULL, N'2222')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'22220002', N'จืด', NULL, N'2222')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'22220003', N'จืดโรคไต', NULL, N'2222')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'22220004', N'จืดเบาหวาน', NULL, N'2222')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'22220005', N'จืดโรคไตแล้วเบาหวาน', NULL, N'2222')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'22220006', N'ปลอดเชื้อ', NULL, N'2222')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'22220007', N'โปรตีนสูง', NULL, N'2222')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'22220008', N'ไขมันต่ำ', NULL, N'2222')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'22220009', N'แยกโรค', NULL, N'2222')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'2222000A', N'COPD', NULL, N'2222')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'2222000B', N'กากน้อย', NULL, N'2222')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'22230001', N'ทดสอบการเพิ่มข้อมูล', N'ทดสอบ', N'2223')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24210001', N'COPD', NULL, N'2421')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24210002', N'MI', NULL, N'2421')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24210003', N'STROKE', NULL, N'2421')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24210004', N'DM', NULL, N'2421')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24210005', N'DM+COPD', NULL, N'2421')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24210006', N'COPD+MI', NULL, N'2421')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24210007', N'DM+MI', NULL, N'2421')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24210008', N'DM+STROKE', NULL, N'2421')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24210009', N'DM+COPD+MI', NULL, N'2421')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'2421000A', N'DM+โปรตีนต่ำ', NULL, N'2421')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24220001', N'0.5:1', NULL, N'2422')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24220002', N'1:1', NULL, N'2422')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24220003', N'1.2:1', NULL, N'2422')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24220004', N'1.5:1', NULL, N'2422')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24220005', N'2:1', NULL, N'2422')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24220006', N'0.75:1', NULL, N'2422')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'24230001', N'250x4F', NULL, N'2423')
INSERT [dbo].[NUTR_FACT] ([CODE], [FDES], [NOTE], [FGRC]) VALUES (N'freetext', N'ข้อมูลเพิ่มเติม', NULL, N'9999')
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'00001001', N'อาหารสายยางสูตรปกติ', N'ตำรับสูตร', N'ความเข้มข้น|ปริมาณ(ซ๊ซ๊)|ไข่นึ่ง(ฟอง)|ไข่ขาวนึ่ง(g)|อกไก่นึ่ง(g)|กล้วยน้ำว้านึ่ง(g)|ฟักทองนึ่ง(g)|น้ำตาลทราย(g)|น้ำมันพืช(g)', N'recipe', N'00', N'001', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'00001002', N'อาหารสายยางสูตรเบาหวาน', N'ตำรับสูตร', N'ความเข้มข้น|ปริมาณ(ซ๊ซ๊)|ไข่นึ่ง(ฟอง)|ไข่ขาวนึ่ง(g)|อกไก่นึ่ง(g)|กล้วยน้ำว้านึ่ง(g)|ฟักทองนึ่ง(g)|น้ำตาลฟรุคต๊ส(g)|น้ำมันพืช(g)', N'recipe', N'00', N'001', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001001', N'ธรรมดา 1:1', N'อาหารสายยางสูตรปกติ', N'1:1|1000|3.7|0|100|70|70|80|4', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001002', N'ธรรมดา 1.5:1', N'อาหารสายยางสูตรปกติ', N'1.5:1|1000|6|0|130|120|120|105|5', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001003', N'ธรรมดา 2:1', N'อาหารสายยางสูตรปกติ', N'2:1|1000|6|160|160|150|150|150|18', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001004', N'COPD 1:1', N'อาหารสายยางสูตรปกติ', N'1:1|1000|4|60|60|70|70|56|12', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001005', N'COPD 1.5:1', N'อาหารสายยางสูตรปกติ', N'1.5:1|1000|6|90|90|110|110|76|20', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001006', N'COPD 2:1', N'อาหารสายยางสูตรปกติ', N'2:1|1000|8.3|100|100|170|170|90|25', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001007', N'MI 1:1', N'อาหารสายยางสูตรปกติ', N'1:1|1000|0|200|125|90|90|70|27', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001008', N'MI 1.5:1', N'อาหารสายยางสูตรปกติ', N'1.5:1|1000|0|360|155|150|150|96|40', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001009', N'MI 2:1', N'อาหารสายยางสูตรปกติ', N'2:1|1000|0|400|250|180|180|140|54', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001010', N'STROKE 1:1', N'อาหารสายยางสูตรปกติ', N'1:1|1000|0|200|125|90|90|40|27', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001011', N'STROKE 1.5:1', N'อาหารสายยางสูตรปกติ', N'1.5:1|1000|0|360|155|150|150|96|40', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001012', N'STROKE 2:1', N'อาหารสายยางสูตรปกติ', N'2:1|1000|0|400|250|180|180|140|54', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001013', N'CVA 1:1', N'อาหารสายยางสูตรปกติ', N'1:1|1000|0|200|125|90|90|40|27', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001014', N'CVA 1.5:1', N'อาหารสายยางสูตรปกติ', N'1.5:1|1000|0|360|155|150|150|96|40', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001015', N'CVA 2:1', N'อาหารสายยางสูตรปกติ', N'2:1|1000|0|400|250|180|180|140|54', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001016', N'COPD MI 1:1', N'อาหารสายยางสูตรปกติ', N'1:1|1000|0|250|100|75|75|70|32', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001017', N'COPD MI 1.5:1', N'อาหารสายยางสูตรปกติ', N'1.5:1|1000|0|360|160|130|130|90|48', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01001018', N'COPD MI 2:1', N'อาหารสายยางสูตรปกติ', N'2:1|1000|0|400|250|150|150|135|65', N'feed', N'01', N'001', N'00001001', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002001', N'เบาหวาน ธรรมดา 1:1', N'อาหารสายยางสูตรเบาหวาน', N'1:1|1000|3.3|0|100|100|100|62|6', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002002', N'เบาหวาน ธรรมดา 1.5:1', N'อาหารสายยางสูตรเบาหวาน', N'1.5:1|1000|5.5|0|135|150|150|90|7', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002003', N'เบาหวาน ธรรมดา 2:1', N'อาหารสายยางสูตรเบาหวาน', N'2:1|1000|6|130|150|275|275|80|14', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002004', N'เบาหวาน COPD 1:1', N'อาหารสายยางสูตรเบาหวาน', N'1:1|1000|1.7|120|110|70|70|56|5', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002005', N'เบาหวาน COPD 1.5:1', N'อาหารสายยางสูตรเบาหวาน', N'1.5:1|1000|2|240|150|100|100|85|46', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002006', N'เบาหวาน COPD 2:1', N'อาหารสายยางสูตรเบาหวาน', N'2:1|1000|3.3|245|220|150|150|100|57', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002007', N'เบาหวาน MI 1:1', N'อาหารสายยางสูตรเบาหวาน', N'1:1|1000|0|200|60|120|120|65|28', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002008', N'เบาหวาน MI 1.5:1', N'อาหารสายยางสูตรเบาหวาน', N'1.5:1|1000|0|300|90|180|180|96|42', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002009', N'เบาหวาน MI 2:1', N'อาหารสายยางสูตรเบาหวาน', N'2:1|1000|0|340|160|200|200|152|62', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002010', N'เบาหวาน STROKE 1:1', N'อาหารสายยางสูตรเบาหวาน', N'1:1|1000|0|200|60|120|120|65|28', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002011', N'เบาหวาน STROKE 1.5:1', N'อาหารสายยางสูตรเบาหวาน', N'1.5:1|1000|0|300|90|180|180|96|42', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002012', N'เบาหวาน STROKE 2:1', N'อาหารสายยางสูตรเบาหวาน', N'2:1|1000|0|340|160|200|200|152|62', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002013', N'เบาหวาน CVA 1:1', N'อาหารสายยางสูตรเบาหวาน', N'1:1|1000|0|200|60|120|120|65|28', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002014', N'เบาหวาน CVA 1.5:1', N'อาหารสายยางสูตรเบาหวาน', N'1.5:1|1000|0|300|90|180|180|96|42', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002015', N'เบาาหวาาน CVA 2:1', N'อาหารสายยางสูตรเบาหวาน', N'2:1|1000|0|340|160|200|200|152|62', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002016', N'เบาหวาน COPD MI 1:1', N'อาหารสายยางสูตรเบาหวาน', N'1:1|1000|0|250|100|75|75|70|32', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002017', N'เบาหวาน COPD MI 1.5:1', N'อาหารสายยางสูตรเบาหวาน', N'1.5:1|1000|0|360|160|130|130|90|48', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'01002018', N'เบาหวาน COPD MI 2:1', N'อาหารสายยางสูตรเบาหวาน', N'2:1|1000|0|400|250|150|150|135|65', N'feed', N'01', N'002', N'00001002', 1)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'11001001', N'เลือดหมู', N'ประเภทเนื้อหมู', N'กว้าง 4" ยาว 4" หนา 1"', N'foodtype', N'11', N'001', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'11001002', N'เลือดไก่', N'ประเภทเนื้อหมู', N'ราคา 100', N'foodtype', N'11', N'001', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'11001003', N'ผู้ป่วยสามัญ', N'ประเภทผู้ป่วย', N'', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'11002001', N'อาหารธรรมดา - วอร์ดสามัญทดสอบ', N'อาหารธรรมดา', N'', N'foodtype', N'11', N'002', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'11002002', N'อาหารธรรมดา - วอร์ดสามัญ(อิสลาม)', N'อาหารธรรมดา', N'', N'foodtype', N'11', N'002', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'11002003', N'อาหารธรรมดา - วอร์ดพิเศษ', N'อาหารธรรมดา', N'', N'foodtype', N'11', N'002', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'11002004', N'อาหารธรรมดา - วอร์ดพิเสษ(อิสลาม)', N'อาหารธรรมดา', N'', N'foodtype', N'11', N'002', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'11003001', N'อาหารอ่อน - ปกติ', N'อาหารอ่อน', N'', N'foodtype', N'11', N'003', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'11003002', N'อาหารอ่อน - จืด', N'อาหารอ่อน', N'', N'foodtype', N'11', N'003', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'11003003', N'อาหารอ่อน - จืด (เบาหวาน)', N'อาหารอ่อน', N'', N'foodtype', N'11', N'003', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'11003004', N'อาหารอ่อน - โปรตีนสูง', N'อาหารอ่อน', N'', N'foodtype', N'11', N'003', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'11003005', N'อาหารอ่อน - ไขมันต่ำ', N'อาหารอ่อน', N'', N'foodtype', N'11', N'003', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'11004001', N'อาหารเหลว - นม UHT', N'อาหารเหลว', N'', N'foodtype', N'11', N'004', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'11111111', N'ผู้ป่วยพิเศษ', N'ประเภทผู้ป่วย', N'', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'31001001', N'CHF res.failure', N'โรค', N'ทดสอบครั้งที่ 1', N'diag', N'31', N'001', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'31001002', N'peritonitis', N'โรค', N'', N'diag', N'31', N'001', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'31001004', N'Pnuemonia DM; HT, ESRD', N'โรค', N'', N'diag', N'31', N'001', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'31001005', N'NSTEMI', N'โรค', N'', N'diag', N'31', N'001', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_BK0] ([CODE], [FDES], [FTYP], [NOTE], [FGRP], [FGRC], [FTYC], [PCOD], [LEV]) VALUES (N'31001006', N'COPD', N'โรค', N'', N'diag', N'31', N'001', N'00000000', 0)
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'0001', N'ประเภทผู้ป่วย', 0, N'', N'0', NULL, N'N')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'0002', N'ชนิดอาหาร', 0, N'', N'0', NULL, N'N')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'0003', N'ข้อจำกัด', 0, N'', N'0', NULL, N'N')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'0021', N'อาหารเหลว', 1, N'', N'L', N'0002', N'N')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'0022', N'อาหารอ่อน', 1, N'', N'L', N'0002', N'N')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'0023', N'อาหารธรรมดา', 1, N'', N'L', N'0002', N'N')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'0024', N'อาหารสายยาง', 1, N'', N'L', N'0002', N'N')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'0211', N'อาหารเหลวเฉพาะโรค', 2, N'', N'L', N'0021', N'Y')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'0221', N'อาหารอ่อนปกติ', 2, N'', N'L', N'0022', N'N')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'0222', N'อาหารอ่อนเฉพาะโรค', 2, N'', N'L', N'0022', N'Y')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'0231', N'อาหารธรรมดาปกติ', 2, N'', N'L', N'0023', N'N')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'0232', N'อาหารธรรมดาเฉพาะโรค', 2, N'', N'L', N'0023', N'Y')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'0241', N'อาหารสายยางปกติ', 2, N'', N'L', N'0024', N'N')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'0242', N'อาหารสายยางเฉพาะโรค', 2, N'', N'L', N'0024', N'Y')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'2221', N'อาหารอ่อนเฉพาะโรค-ชนิดอาหาร', 3, N'', N'P1', N'0222', N'Y')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'2222', N'อาหารอ่อนเฉพาะโรค-ลักษณะอาหาร', 3, N'', N'P2', N'0222', N'Y')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'2223', N'อาหารอ่อนเฉพาะโรค', 3, N'', N'P3', N'0222', N'Y')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'2421', N'อาหารสายยางเฉพาะโรค-ชนิดอาหาร', 3, N'', N'P1', N'0242', N'Y')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'2422', N'อาหารสายยางเฉพาะโรค-ความเข้มข้น', 3, N'', N'P2', N'0242', N'Y')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'2423', N'อาหารสายยางเฉาพะโรค-จำนวนซ๊ซ๊', 3, N'', N'P3', N'0242', N'Y')
INSERT [dbo].[NUTR_FACT_GRPS] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD], [SLIPPRN]) VALUES (N'9999', N'ข้อมูลเพิ่มเติม', 0, N'', N'0', NULL, N'N')
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'0001', N'PATIENT TYPE', 0, N'ประเภทผู้ป่วย', N'0', NULL)
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'0002', N'FOOD TYPE', 0, N'ชนิดอาหาร', N'0', NULL)
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'0003', N'FEED RESTRICTION', 0, N'ข้อจำกัด', N'0', NULL)
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'0021', N'FOOD LIQUID', 1, N'อาหารเหลว', N'L', N'0002')
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'0022', N'DIET SOFT', 1, N'อาหารอ่อน', N'L', N'0002')
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'0023', N'NORMAL FOOD', 1, N'อาหารธรรมดา', N'L', N'0002')
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'0024', N'FEED', 1, N'อาหารสายยาง', N'L', N'0002')
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'0221', N'DIET SOFT NORMAL', 2, N'อาหารอ่อนปกติ', N'L', N'0022')
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'0222', N'DIET SOFT SPECIAL', 2, N'อาหารอ่อนเฉพาะโรค', N'L', N'0022')
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'0231', N'NORMAL FOOD', 2, N'อาหารธรรมดาปกติ', N'L', N'0023')
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'0232', N'SPECILAL FOOD', 2, N'อาหารธรรมดาเฉพาะโรค', N'L', N'0023')
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'0241', N'FEED NORMAL', 2, N'อาหารสายยางปกติ', N'L', N'0024')
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'0242', N'FEED SPECIAL', 2, N'อาหารสายยางเฉพาะโรค', N'L', N'0024')
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'2221', N'DIET FOFT APPEARANCE', 3, N'อาหารอ่อนเฉพาะโรค-ลักษณะอาหาร', N'P1', N'0222')
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'2222', N'DIET FOFT TYPE', 3, N'อาหารอ่อนเฉพาะโรค-ชนิดอาหาร', N'P2', N'0222')
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'2421', N'FEED SPECIAL TYPE', 3, N'อาหารสายยางเฉพาะโรค-ชนิดอาหาร', N'P1', N'0242')
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'2422', N'FEED SPECIAL CONCENTRATE', 3, N'อาหารสายยางเฉพาะโรค-ความเข้มข้น', N'P2', N'0242')
INSERT [dbo].[NUTR_FACT_GRPS0] ([FGRC], [FGRP], [FLEV], [NOTE], [FPRP], [PCOD]) VALUES (N'2423', N'CC AMOUNT', 3, N'อาหารสายยางเฉพาะโรค-จำนวนซ๊ซี', N'P3', N'0242')
INSERT [dbo].[NUTR_FMNU] ([MNUID], [MNUNAME]) VALUES (N'0000000001', N'เมนูอาหารตอนเช้า 7.00')
INSERT [dbo].[NUTR_FMNU] ([MNUID], [MNUNAME]) VALUES (N'0000000002', N'เมนูอาหารกลางวัน')
INSERT [dbo].[NUTR_FMNU_ITMS] ([MNUID], [FDID]) VALUES (N'0000000001', N'00001     ')
INSERT [dbo].[NUTR_FMNU_ITMS] ([MNUID], [FDID]) VALUES (N'000111    ', N'0000000001')
INSERT [dbo].[NUTR_FOOD] ([FDID], [FDNAME], [FDTYPE]) VALUES (N'00001     ', N'ข้าวต้ม', N'01003001')
INSERT [dbo].[NUTR_FOOD] ([FDID], [FDNAME], [FDTYPE]) VALUES (N'00002     ', N'ไข่เจียว', N'01003001')
INSERT [dbo].[NUTR_FOOD] ([FDID], [FDNAME], [FDTYPE]) VALUES (N'00003     ', N'ผัดผักบุ้งจีน', N'01002001')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'00005', N'00010001', N'ผู้ป่วยสามัญ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'00005', N'02310002', N'อาหารธรรมดาเพิ่มไข่')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'00007', N'00010001', N'ผู้ป่วยสามัญ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'00007', N'00210001', N'นมถั่วเหลืองไม่มีน้ำตาล')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'00008', N'00010001', N'ผู้ป่วยสามัญ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'00008', N'00030006', N'งดนม')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'00008', N'24210003', N'STROKE')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'00008', N'24220003', N'1.2:1')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'00008', N'24230001', N'250x4F')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'00008', N'freetext', N'ผู้ป่วยท้องเสีย')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000B', N'00010001', N'ผู้ป่วยสามัญ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000B', N'02310001', N'อาหารธรรมดาปกติ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000C', N'00010001', N'ผู้ป่วยสามัญ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000C', N'02310001', N'อาหารธรรมดาปกติ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000C', N'freetext', N'2 ชุด')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000D', N'00010001', N'ผู้ป่วยสามัญ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000D', N'00210002', N'นมถั่วเหลืองเจ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000D', N'freetext', N'2 กล่อง')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000H', N'00010001', N'ผู้ป่วยสามัญ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000H', N'02310001', N'อาหารธรรมดาปกติ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000J', N'00010001', N'ผู้ป่วยสามัญ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000J', N'00030001', N'งดสัตว์ปีก')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000J', N'24210003', N'STROKE')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000J', N'24220003', N'1.2:1')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000J', N'24230001', N'250x4F')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000K', N'00010001', N'ผู้ป่วยสามัญ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000K', N'22210001', N'โจ๊ก')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000K', N'22220008', N'ไขมันต่ำ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000M', N'00010001', N'ผู้ป่วยสามัญ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000M', N'24210001', N'COPD')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000M', N'24220003', N'1.2:1')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000M', N'24230001', N'250x4F')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000N', N'00010001', N'ผู้ป่วยสามัญ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000N', N'24210003', N'STROKE')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000N', N'24220003', N'1.2:1')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000N', N'24230001', N'250x4F')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000O', N'00010001', N'ผู้ป่วยสามัญ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000O', N'00030005', N'งดเนื้อสัตว์')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000O', N'24210008', N'DM+STROKE')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000O', N'24220003', N'1.2:1')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000O', N'24230001', N'250x4F')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000P', N'00010001', N'ผู้ป่วยสามัญ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000P', N'22210002', N'โจ๊กปั่น')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000P', N'22220006', N'ปลอดเชื้อ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000Q', N'00010001', N'ผู้ป่วยสามัญ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000Q', N'22210003', N'ข้าวต้มกุ้ย')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000Q', N'22220002', N'จืด')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000R', N'00010001', N'ผู้ป่วยสามัญ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000R', N'02310001', N'อาหารธรรมดาปกติ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000S', N'00010002', N'ผู้ป่วยพิเศษ')
INSERT [dbo].[NUTR_FOOD_REQD] ([REQID], [REQCODE], [REQDESC]) VALUES (N'0000S', N'02310002', N'อาหารธรรมดาเพิ่มไข่')
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'00002', N'    800', N'5000045', N'C001   ', 60, 165, N'N', CAST(0x0000A56400000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Y', CAST(0x0000A56A00000000 AS DateTime))
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'00003', N'    123', N'5305794', N'C001   ', 55, 165, N'N', CAST(0x0000A57900000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'00005', N'    782', N'5200002', N'C001   ', 52, 160, N'N', CAST(0x0000A57E00000000 AS DateTime), N'00010001', N'0023    ', N'0231    ', N'        ', N'00010001=ผู้ป่วยสามัญ>0023=อาหารธรรมดา>0231=อาหารธรรมดาปกติ>02310002=อาหารธรรมดาเพิ่มไข่', NULL, NULL, NULL, N'Y', CAST(0x0000A58900000000 AS DateTime))
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'00006', N'     22', N'5305822', N'C001   ', 55, 165, NULL, CAST(0x0000A59200000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'00007', N' 188822', N'5000066', N'C001   ', 75, 165, NULL, CAST(0x0000A5A800000000 AS DateTime), N'00010001', N'0021    ', N'00210001', N'        ', N'00010001=ผู้ป่วยสามัญ>0021=อาหารเหลว>00210001=นมถั่วเหลืองไม่มีน้ำตาล', NULL, NULL, NULL, N'Y', CAST(0x0000A5B200000000 AS DateTime))
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'00008', N'      5', N'5300010', N'C002   ', 50, 165, NULL, CAST(0x0000A5B800000000 AS DateTime), N'00010001', N'0024    ', N'0242    ', N'00030006', N'00010001=ผู้ป่วยสามัญ>0024=อาหารสายยาง>0242=อาหารสายยางเฉพาะโรค>24210003=STROKE>24220003=1.2:1>24230001=250x4F>00030006=งดนม>freetext=ผู้ป่วยท้องเสีย', NULL, N'Y', 1, N'Y', CAST(0x0000A5C600000000 AS DateTime))
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'00009', N'    235', N'5300006', N'C001   ', 47, 150, NULL, CAST(0x0000A5C500000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000A', N'    122', N'5305769', N'C001   ', 45, 150, NULL, CAST(0x0000A5D800000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000B', N'     21', N'5200042', N'C001   ', 60, 170, NULL, CAST(0x0000A5C600000000 AS DateTime), N'00010001', N'0023    ', N'0231    ', N'        ', N'00010001=ผู้ป่วยสามัญ>0023=อาหารธรรมดา>0231=อาหารธรรมดาปกติ>02310001=อาหารธรรมดาปกติ', NULL, NULL, NULL, N'Y', CAST(0x0000A5CD00000000 AS DateTime))
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000C', N'      5', N'5300010', N'C003   ', 50, 165, NULL, CAST(0x0000A5C600000000 AS DateTime), N'00010001', N'0023    ', N'0231    ', N'        ', N'00010001=ผู้ป่วยสามัญ>0023=อาหารธรรมดา>0231=อาหารธรรมดาปกติ>02310001=อาหารธรรมดาปกติ>freetext=2 ชุด', NULL, NULL, 3, N'Y', CAST(0x0000A5CD00000000 AS DateTime))
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000D', N'      5', N'5300010', N'C001   ', 50, 165, NULL, CAST(0x0000A5CD00000000 AS DateTime), N'00010001', N'00210001', N'        ', N'        ', N'00010001=ผู้ป่วยสามัญ>0021=อาหารเหลว>00210001=นมถั่วเหลืองไม่มีน้ำตาล', NULL, NULL, NULL, N'Y', CAST(0x0000A5DE00000000 AS DateTime))
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000E', N'     76', N'5305751', N'C003   ', NULL, NULL, NULL, NULL, N'00010001', N'22210001', N'22220003', N'        ', N'00010001:ผู้ป่วยสามัญ>0022:อาหารอ่อน>0222:อาหารอ่อนเฉพาะโรค>22210001:โจ๊ก>22220003:จืดโรคไต', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000F', N'     30', N'5305816', N'C002   ', NULL, NULL, NULL, NULL, N'00010001', N'00210001', N'        ', N'        ', N'00010001=ผู้ป่วยสามัญ>0021=อาหารเหลว>00210001=นมถั่วเหลืองไม่มีน้ำตาล', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000G', N'     17', N'5305763', N'C001   ', NULL, NULL, NULL, NULL, N'00010001', N'22210001', N'22220002', N'        ', N'00010001=ผู้ป่วยสามัญ>0022=อาหารอ่อน>0222=อาหารอ่อนเฉพาะโรค>22210001=โจ๊ก>22220002=จืด', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000H', N'     13', N'5000005', N'C003   ', 45, NULL, NULL, CAST(0x0000A60200000000 AS DateTime), N'00010001', N'0023    ', N'0231    ', N'        ', N'00010001=ผู้ป่วยสามัญ>0023=อาหารธรรมดา>0231=อาหารธรรมดาปกติ>02310001=อาหารธรรมดาปกติ', NULL, NULL, 1, N'Y', CAST(0x0000A61D00000000 AS DateTime))
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000J', N'    800', N'5000045', N'C00    ', 80, 168, NULL, CAST(0x0000A5B800000000 AS DateTime), N'00010001', N'0024    ', N'0242    ', N'00030001', N'00010001=ผู้ป่วยสามัญ>0024=อาหารสายยาง>0242=อาหารสายยางเฉพาะโรค>24210003=STROKE>24220003=1.2:1>24230001=250x4F>00030001=งดสัตว์ปีก', NULL, NULL, 1, N'Y', CAST(0x0000A5BC00000000 AS DateTime))
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000K', N' 200024', N'5000058', N'C002   ', 50, 158, NULL, CAST(0x0000A5B800000000 AS DateTime), N'00010001', N'0022    ', N'0222    ', N'        ', N'00010001=ผู้ป่วยสามัญ>0022=อาหารอ่อน>0222=อาหารอ่อนเฉพาะโรค>22210001=โจ๊ก>22220008=ไขมันต่ำ', NULL, NULL, 1, N'Y', CAST(0x0000A5BC00000000 AS DateTime))
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000M', N'    101', N'5100026', N'C003   ', 45, 150, NULL, CAST(0x0000A5B800000000 AS DateTime), N'00010001', N'0024    ', N'0242    ', N'        ', N'00010001=ผู้ป่วยสามัญ>0024=อาหารสายยาง>0242=อาหารสายยางเฉพาะโรค>24210001=COPD>24220003=1.2:1>24230001=250x4F', NULL, NULL, 1, N'Y', CAST(0x0000A642001E7C66 AS DateTime))
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000N', N'    245', N'5200018', N'C002   ', 60, 154, NULL, CAST(0x0000A5B800000000 AS DateTime), N'00010001', N'0024    ', N'0242    ', N'        ', N'00010001=ผู้ป่วยสามัญ>0024=อาหารสายยาง>0242=อาหารสายยางเฉพาะโรค>24210003=STROKE>24220003=1.2:1>24230001=250x4F', NULL, N'Y', 2, N'Y', CAST(0x0000A5C500000000 AS DateTime))
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000O', N'    245', N'5200018', N'C001   ', 58, 160, NULL, CAST(0x0000A5C500000000 AS DateTime), N'00010001', N'0024    ', N'0242    ', N'00030005', N'00010001=ผู้ป่วยสามัญ>0024=อาหารสายยาง>0242=อาหารสายยางเฉพาะโรค>24210008=DM+STROKE>24220003=1.2:1>24230001=250x4F>00030005=งดเนื้อสัตว์', NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000P', N'    651', N'5200022', N'C00    ', 50, 160, NULL, CAST(0x0000A64400000000 AS DateTime), N'00010001', N'0022    ', N'0222    ', N'        ', N'00010001=ผู้ป่วยสามัญ>0022=อาหารอ่อน>0222=อาหารอ่อนเฉพาะโรค>22210002=โจ๊กปั่น>22220006=ปลอดเชื้อ', NULL, NULL, 1, N'Y', CAST(0x0000A64600000000 AS DateTime))
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000Q', N'    651', N'5200022', N'C000   ', 50, 170, NULL, CAST(0x0000A64600000000 AS DateTime), N'00010001', N'0022    ', N'0222    ', N'        ', N'00010001=ผู้ป่วยสามัญ>0022=อาหารอ่อน>0222=อาหารอ่อนเฉพาะโรค>22210003=ข้าวต้มกุ้ย>22220002=จืด', NULL, NULL, 3, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000R', N'     38', N'5305823', N'C000   ', 55, 150, NULL, CAST(0x0000A64E00000000 AS DateTime), N'00010001', N'0023    ', N'0231    ', N'        ', N'00010001=ผู้ป่วยสามัญ>0023=อาหารธรรมดา>0231=อาหารธรรมดาปกติ>02310001=อาหารธรรมดาปกติ', NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS] ([REQID], [HN], [AN], [DIAG], [WTS], [HTS], [PRINTED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [NOTE], [COMDIS], [MEALORD], [REQEND], [REQENDDATE]) VALUES (N'0000S', N'     21', N'5200042', N'C00    ', 57, 162, NULL, CAST(0x0000A5CD00000000 AS DateTime), N'00010002', N'0023    ', N'0231    ', N'        ', N'00010002=ผู้ป่วยพิเศษ>0023=อาหารธรรมดา>0231=อาหารธรรมดาปกติ>02310002=อาหารธรรมดาเพิ่มไข่', NULL, NULL, 3, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS0] ([REQID], [HN], [AN], [DIAG], [FOODTYPE], [REQFR], [REQTO], [MLFR], [MLTO], [AMOUNTAM], [AMOUNTPM], [WTS], [HTS], [PRINTED], [SALTWT], [FOODTYPC], [FEED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [FOODPROP3], [NOTE], [COMDIS], [MEALORD], [REQEND]) VALUES (N'00002', N'    800', N'5000045', N'NSTEMI', N'ปกติ 1:1', CAST(0x0000A56400000000 AS DateTime), CAST(0x0000A57E00000000 AS DateTime), N'          ', N'          ', 400, 300, 60, 165, N'N', 10, N'01001001', NULL, CAST(0x0000A56400000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS0] ([REQID], [HN], [AN], [DIAG], [FOODTYPE], [REQFR], [REQTO], [MLFR], [MLTO], [AMOUNTAM], [AMOUNTPM], [WTS], [HTS], [PRINTED], [SALTWT], [FOODTYPC], [FEED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [FOODPROP3], [NOTE], [COMDIS], [MEALORD], [REQEND]) VALUES (N'00003', N'    123', N'5305794', N'Pnuemonia DM; HT, ESRD', N'CVA 1.5:1', CAST(0x0000A57900000000 AS DateTime), CAST(0x0000A57B00000000 AS DateTime), N'          ', N'          ', 300, 400, 55, 165, N'N', 5, N'01001014', NULL, CAST(0x0000A57900000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS0] ([REQID], [HN], [AN], [DIAG], [FOODTYPE], [REQFR], [REQTO], [MLFR], [MLTO], [AMOUNTAM], [AMOUNTPM], [WTS], [HTS], [PRINTED], [SALTWT], [FOODTYPC], [FEED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [FOODPROP3], [NOTE], [COMDIS], [MEALORD], [REQEND]) VALUES (N'00005', N'    782', N'5200002', N'peritonitis', N'STROKE 1:1', CAST(0x0000A57E00000000 AS DateTime), CAST(0x0000A58200000000 AS DateTime), N'          ', N'          ', 400, 400, 52, 160, N'N', 5, N'01001010', NULL, CAST(0x0000A57E00000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS0] ([REQID], [HN], [AN], [DIAG], [FOODTYPE], [REQFR], [REQTO], [MLFR], [MLTO], [AMOUNTAM], [AMOUNTPM], [WTS], [HTS], [PRINTED], [SALTWT], [FOODTYPC], [FEED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [FOODPROP3], [NOTE], [COMDIS], [MEALORD], [REQEND]) VALUES (N'00006', N'     22', N'5305822', N'peritonitis', N'CVA 1.5:1', CAST(0x0000A59200000000 AS DateTime), CAST(0x0000A59800000000 AS DateTime), NULL, NULL, 250, 750, 55, 165, NULL, 2, N'01001014', N'250x4F', CAST(0x0000A59200000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS0] ([REQID], [HN], [AN], [DIAG], [FOODTYPE], [REQFR], [REQTO], [MLFR], [MLTO], [AMOUNTAM], [AMOUNTPM], [WTS], [HTS], [PRINTED], [SALTWT], [FOODTYPC], [FEED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [FOODPROP3], [NOTE], [COMDIS], [MEALORD], [REQEND]) VALUES (N'00007', N' 188822', N'5000066', N'NSTEMI', N'เบาหวาน 1.5:1', CAST(0x0000A5A800000000 AS DateTime), CAST(0x0000A5AA00000000 AS DateTime), NULL, NULL, 250, 750, 75, 165, NULL, 2, N'01002002', N'250x4F', CAST(0x0000A5A800000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS0] ([REQID], [HN], [AN], [DIAG], [FOODTYPE], [REQFR], [REQTO], [MLFR], [MLTO], [AMOUNTAM], [AMOUNTPM], [WTS], [HTS], [PRINTED], [SALTWT], [FOODTYPC], [FEED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [FOODPROP3], [NOTE], [COMDIS], [MEALORD], [REQEND]) VALUES (N'00008', N'      5', N'5300010', N'C002', N'CVA 2:1', CAST(0x0000A5B800000000 AS DateTime), CAST(0x0000A5B800000000 AS DateTime), NULL, NULL, 750, 250, 50, 165, NULL, 2, N'01001015', N'250x4F', CAST(0x0000A5B800000000 AS DateTime), N'00010001', N'0024    ', N'0242    ', N'00030006', N'00010001=ผู้ป่วยสามัญ>0024=อาหารสายยาง>0242=อาหารสายยางเฉพาะโรค>24210003=STROKE>24220003=1.2:1>24230001=250x4F>00030006=งดนม>freetext=ผู้ป่วยท้องเสีย', NULL, NULL, N'Y', 1, N'Y')
INSERT [dbo].[NUTR_FOOD_REQS0] ([REQID], [HN], [AN], [DIAG], [FOODTYPE], [REQFR], [REQTO], [MLFR], [MLTO], [AMOUNTAM], [AMOUNTPM], [WTS], [HTS], [PRINTED], [SALTWT], [FOODTYPC], [FEED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [FOODPROP3], [NOTE], [COMDIS], [MEALORD], [REQEND]) VALUES (N'00009', N'    235', N'5300006', N'peritonitis', N'เบาหวาน MI 2:1', CAST(0x0000A5C500000000 AS DateTime), CAST(0x0000A5C600000000 AS DateTime), NULL, NULL, 200, 600, 47, 150, NULL, 2, N'01002009', N'200x4F', CAST(0x0000A5C500000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS0] ([REQID], [HN], [AN], [DIAG], [FOODTYPE], [REQFR], [REQTO], [MLFR], [MLTO], [AMOUNTAM], [AMOUNTPM], [WTS], [HTS], [PRINTED], [SALTWT], [FOODTYPC], [FEED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [FOODPROP3], [NOTE], [COMDIS], [MEALORD], [REQEND]) VALUES (N'0000A', N'    122', N'5305769', N'peritonitis', N'เบาหวาน MI 2:1', CAST(0x0000A5D800000000 AS DateTime), CAST(0x0000A5DA00000000 AS DateTime), NULL, NULL, 200, 600, 45, 150, NULL, 5, N'01002009', N'200x4F', CAST(0x0000A5D800000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS0] ([REQID], [HN], [AN], [DIAG], [FOODTYPE], [REQFR], [REQTO], [MLFR], [MLTO], [AMOUNTAM], [AMOUNTPM], [WTS], [HTS], [PRINTED], [SALTWT], [FOODTYPC], [FEED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [FOODPROP3], [NOTE], [COMDIS], [MEALORD], [REQEND]) VALUES (N'0000B', N'     21', N'5200042', N'peritonitis', N'STROKE 1.5:1', CAST(0x0000A5C600000000 AS DateTime), CAST(0x0000A5C700000000 AS DateTime), NULL, NULL, 250, 750, 60, 170, NULL, 2, N'01001011', N'250x4F', CAST(0x0000A5C600000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS0] ([REQID], [HN], [AN], [DIAG], [FOODTYPE], [REQFR], [REQTO], [MLFR], [MLTO], [AMOUNTAM], [AMOUNTPM], [WTS], [HTS], [PRINTED], [SALTWT], [FOODTYPC], [FEED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [FOODPROP3], [NOTE], [COMDIS], [MEALORD], [REQEND]) VALUES (N'0000C', N'      5', N'5300010', N'C003', N'เบาหวาน STROKE 1:1', CAST(0x0000A5C600000000 AS DateTime), CAST(0x0000A5C700000000 AS DateTime), NULL, NULL, 300, 900, 50, 165, NULL, 5, N'01002010', N'300x4F', CAST(0x0000A5C600000000 AS DateTime), N'00010001', N'0023    ', N'0231    ', N'        ', N'00010001=ผู้ป่วยสามัญ>0023=อาหารธรรมดา>0231=อาหารธรรมดาปกติ>02310001=อาหารธรรมดาปกติ>freetext=2 ชุด', NULL, NULL, NULL, 3, N'Y')
INSERT [dbo].[NUTR_FOOD_REQS0] ([REQID], [HN], [AN], [DIAG], [FOODTYPE], [REQFR], [REQTO], [MLFR], [MLTO], [AMOUNTAM], [AMOUNTPM], [WTS], [HTS], [PRINTED], [SALTWT], [FOODTYPC], [FEED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [FOODPROP3], [NOTE], [COMDIS], [MEALORD], [REQEND]) VALUES (N'0000D', N'      5', N'5300010', N'peritonitis', N'เบาหวาน COPD 2:1', CAST(0x0000A5CD00000000 AS DateTime), CAST(0x0000A5CE00000000 AS DateTime), NULL, NULL, 250, 750, 50, 165, NULL, 4, N'01002006', N'250x4F', CAST(0x0000A5CD00000000 AS DateTime), N'00010001', N'00210001', N'        ', N'        ', N'00010001=ผู้ป่วยสามัญ>0021=อาหารเหลว>00210001=นมถั่วเหลืองไม่มีน้ำตาล', NULL, NULL, NULL, NULL, N'Y')
INSERT [dbo].[NUTR_FOOD_REQS0] ([REQID], [HN], [AN], [DIAG], [FOODTYPE], [REQFR], [REQTO], [MLFR], [MLTO], [AMOUNTAM], [AMOUNTPM], [WTS], [HTS], [PRINTED], [SALTWT], [FOODTYPC], [FEED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [FOODPROP3], [NOTE], [COMDIS], [MEALORD], [REQEND]) VALUES (N'0000E', N'     76', N'5305751', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'00010001', N'22210001', N'22220003', N'        ', N'00010001:ผู้ป่วยสามัญ>0022:อาหารอ่อน>0222:อาหารอ่อนเฉพาะโรค>22210001:โจ๊ก>22220003:จืดโรคไต', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS0] ([REQID], [HN], [AN], [DIAG], [FOODTYPE], [REQFR], [REQTO], [MLFR], [MLTO], [AMOUNTAM], [AMOUNTPM], [WTS], [HTS], [PRINTED], [SALTWT], [FOODTYPC], [FEED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [FOODPROP3], [NOTE], [COMDIS], [MEALORD], [REQEND]) VALUES (N'0000F', N'     30', N'5305816', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'00010001', N'00210001', N'        ', N'        ', N'00010001=ผู้ป่วยสามัญ>0021=อาหารเหลว>00210001=นมถั่วเหลืองไม่มีน้ำตาล', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS0] ([REQID], [HN], [AN], [DIAG], [FOODTYPE], [REQFR], [REQTO], [MLFR], [MLTO], [AMOUNTAM], [AMOUNTPM], [WTS], [HTS], [PRINTED], [SALTWT], [FOODTYPC], [FEED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [FOODPROP3], [NOTE], [COMDIS], [MEALORD], [REQEND]) VALUES (N'0000G', N'     17', N'5305763', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'00010001', N'22210001', N'22220002', N'        ', N'00010001=ผู้ป่วยสามัญ>0022=อาหารอ่อน>0222=อาหารอ่อนเฉพาะโรค>22210001=โจ๊ก>22220002=จืด', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[NUTR_FOOD_REQS0] ([REQID], [HN], [AN], [DIAG], [FOODTYPE], [REQFR], [REQTO], [MLFR], [MLTO], [AMOUNTAM], [AMOUNTPM], [WTS], [HTS], [PRINTED], [SALTWT], [FOODTYPC], [FEED], [REQDATE], [PATTYPE], [FOODPROP1], [FOODPROP2], [FOODRESTR], [FOODREQDESC], [FOODPROP3], [NOTE], [COMDIS], [MEALORD], [REQEND]) VALUES (N'0000H', N'     13', N'5000005', N'C003', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 45, NULL, NULL, NULL, NULL, NULL, CAST(0x0000A60200000000 AS DateTime), N'00010001', N'0023    ', N'0231    ', N'        ', N'00010001=ผู้ป่วยสามัญ>0023=อาหารธรรมดา>0231=อาหารธรรมดาปกติ>02310001=อาหารธรรมดาปกติ', NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[NUTR_MEAL] ([MLID], [MLNAME]) VALUES (N'000111    ', N'มื้ออาหารเช้า')
INSERT [dbo].[NUTR_MEAL_ITMS] ([MLID], [MNUID]) VALUES (N'000111    ', N'0000000001')
INSERT [dbo].[NUTR_MISC] ([COD], [VAL]) VALUES (N'CNHC', N'SPB-MYNB\SQL2012EX;DEVHC;sa;pongpeng')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'     13', N'3750200020381', N'น.ส.', N'สร้อยทอง', N'เกิดกิจการ', N'F', CAST(0x0000697800000000 AS DateTime), N'5000005', N'241', N'กุมารเวชกรรม', CAST(0x000099CD00C3D4D0 AS DateTime), NULL, N'24100', N'          ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'    800', N'3750300472101', N'นาย', N'ทศพร', N'กลิ่นระรวย', N'F', CAST(0x0000749300000000 AS DateTime), N'5000045', N'211', N'อายุรกรรมชาย', CAST(0x000099CD00DF05C0 AS DateTime), CAST(0x000099CD00DF05C0 AS DateTime), N'     ', N'          ', NULL, NULL)
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N' 200024', N'3730200503195', N'นาย', N'มล', N'ดอนละไพร', N'M', CAST(0x0000743500000000 AS DateTime), N'5000058', N'214', N'สงฆ์อาพาธ', CAST(0x000099CD009F4D40 AS DateTime), NULL, N'21400', N'          ', NULL, NULL)
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N' 188822', N'             ', N'น.ส.', N'ติ๊ก', N'พันธุ์ประชา', N'F', CAST(0x00007C4C00000000 AS DateTime), N'5000066', N'241', N'กุมารเวชกรรม', CAST(0x000099DD00B4FFF0 AS DateTime), NULL, N'24100', N'1         ', NULL, NULL)
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'    101', N'3750300374907', N'นาง', N'นิตยา', N'ชื่นสงวน', N'F', CAST(0x00006D5A00000000 AS DateTime), N'5100026', N'261', N'ไอซียูอายุรกรรม', CAST(0x00009A5400BFFC70 AS DateTime), NULL, N'26100', N'          ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'    782', N'3759900014543', N'น.ส.', N'จงจิตร', N'พวังคะพินธุ์', N'F', CAST(0x0000575000000000 AS DateTime), N'5200002', N'222', N'ศัลยกรรมหญิง', CAST(0x00009B9301046040 AS DateTime), CAST(0x00009B9301046040 AS DateTime), N'22200', N'45        ', NULL, NULL)
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'    245', N'3759900104542', N'นาย', N'สมชัย', N'สังขศิริ', N'F', CAST(0x000049DA00000000 AS DateTime), N'5200018', N'211', N'อายุรกรรมชาย', CAST(0x00009C310100CE30 AS DateTime), NULL, N'21108', N'          ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'    651', N'3759800054373', N'นาง', N'นงนุช', N'กล่อมเดช', N'F', CAST(0x00004A6F00000000 AS DateTime), N'5200022', N'224', N'ศัลยกรรมกระดูก', CAST(0x00009C53010ED020 AS DateTime), NULL, N'22400', N'          ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'     21', N'3759900169504', N'นาย', N'วัง', N'สุขเกษม', N'F', CAST(0x00004A3000000000 AS DateTime), N'5200042', N'283', N'ห้องคลอด', CAST(0x00009C7D010C5750 AS DateTime), NULL, N'28300', N'          ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'    235', N'3709900172378', N'นาง', N'จงกลณี', N'ยอดปรีดา', N'F', CAST(0x000047CE00000000 AS DateTime), N'5300006', N'221', N'ศัลยกรรมชาย', CAST(0x00009B9600D8B490 AS DateTime), NULL, N'22112', N'          ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'      5', N'3770600115303', N'น.ส.', N'วิภาวี', N'รักษ์ธรรมมั่ง', N'F', CAST(0x00006B3200000000 AS DateTime), N'5300010', N'224', N'ศัลยกรรมกระดูก', CAST(0x00009D1100E297D0 AS DateTime), NULL, N'22407', N'          ', NULL, NULL)
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'    419', N'3100902178206', N'พ.ญ.', N'วี', N'ม่วงสวย', N'F', CAST(0x0000614400000000 AS DateTime), N'5300015', N'212', N'อายุรกรรมหญิง 1', CAST(0x00009D1200A67160 AS DateTime), NULL, N'21224', N'          ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'     76', N'3    750  1 0', N'นาง', N'สุนันทา', N'แจ่มจำรัส', N'F', CAST(0x00005B6E00000000 AS DateTime), N'5305751', N'211', N'อายุรกรรมชาย', CAST(0x00009D5901034700 AS DateTime), NULL, N'21112', N'          ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'     17', N'3759900135146', N'นาง', N'อรพินท์', N'อัศพจน์', N'F', CAST(0x00005C9200000000 AS DateTime), N'5305763', N'213', N'อายุรกรรมหญิง 2', CAST(0x00009D7300ED9450 AS DateTime), NULL, N'21307', N'          ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'     31', N'3750200208975', N'น.ส.', N'เพ็ญจันทร์', N'ราษฎร์อาศัย', N'F', CAST(0x00006F8400000000 AS DateTime), N'5305764', N'213', N'อายุรกรรมหญิง 2', CAST(0x00009C3100F1B300 AS DateTime), NULL, N'21306', N'          ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'    122', N'3919900126064', N'ภ.ก.', N'วิภพ', N'รัตนดิลก ณ.ภูเก็ต', N'F', CAST(0x0000494A00000000 AS DateTime), N'5305769', N'211', N'อายุรกรรมชาย', CAST(0x00009D8E00C15C00 AS DateTime), NULL, N'21128', N'          ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'     60', N'3750200175058', N'นาง', N'ทิพย์รัตน์', N'จินดาศักดิ์', N'F', CAST(0x0000673200000000 AS DateTime), N'5305773', N'222', N'ศัลยกรรมหญิง', CAST(0x00009D8F00ABEFA0 AS DateTime), NULL, N'11ร  ', N'305       ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'    123', N'375020039171 ', N'นาง', N'ถนอม', N'นิลศาสตร์', N'F', CAST(0x0000338D00000000 AS DateTime), N'5305794', N'212', N'อายุรกรรมหญิง 1', CAST(0x00009BC60101E770 AS DateTime), CAST(0x00009BC60101E770 AS DateTime), N'     ', N'          ', NULL, NULL)
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'     19', N'3199900425859', N'น.ส.', N'เรณู', N'อนันต์สวัสดิ์', N'F', CAST(0x00005E3C00000000 AS DateTime), N'5305814', N'222', N'ศัลยกรรมหญิง', CAST(0x00009D90009DA760 AS DateTime), NULL, N'11ร  ', N'          ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'     30', N'3759900221328', N'นาง', N'วลีรัตน์', N'เอี่ยมสำอางค์', N'F', CAST(0x0000565000000000 AS DateTime), N'5305816', N'212', N'อายุรกรรมหญิง 1', CAST(0x00009D90009EC0A0 AS DateTime), NULL, N'21200', N'          ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'     22', N'3759900170391', N'น.ส.', N'วาสนา', N'ศิริวิลาศ', N'F', CAST(0x00004ED200000000 AS DateTime), N'5305822', N'213', N'อายุรกรรมหญิง 2', CAST(0x00009D9200EC7B10 AS DateTime), NULL, N'21302', N'          ', NULL, NULL)
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'     38', N'3759900031758', N'น.ส.', N'นุชนาท', N'กลัดเจริญ', N'F', CAST(0x000054BD00000000 AS DateTime), N'5305823', N'222', N'ศัลยกรรมหญิง', CAST(0x00009D9200BCB0B0 AS DateTime), NULL, N'11ร  ', N'          ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PADM] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO], [RELGCODE], [RELGDESC]) VALUES (N'     37', N'3759900077197', N'พ.ญ.', N'เรวดี', N'กนกวุฒิ', N'F', CAST(0x00004C7200000000 AS DateTime), N'5305835', N'222', N'ศัลยกรรมหญิง', CAST(0x00009DC800A36BF0 AS DateTime), NULL, N'11ร  ', N'          ', N'0 ', N'พุทธ')
INSERT [dbo].[NUTR_PATN] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH]) VALUES (N'     40', N'3750100446351', N'น.ส.', N'นารีรัตน์', N'ขันกำเหนิด', N'F', CAST(0x00006DDE00000000 AS DateTime))
INSERT [dbo].[NUTR_PATN] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH]) VALUES (N'    123', N'375020039171 ', N'นาง', N'ถนอม', N'นิลศาสตร์', N'F', CAST(0x0000338D00000000 AS DateTime))
INSERT [dbo].[NUTR_PATN] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH]) VALUES (N'    782', N'3759900014543', N'น.ส.', N'จงจิตร', N'พวังคะพินธุ์', N'F', CAST(0x0000575000000000 AS DateTime))
INSERT [dbo].[NUTR_PATN] ([HN], [PID], [TNAME], [FNAME], [LNAME], [GENDER], [BIRTH]) VALUES (N'    800', N'3750300472101', N'นาย', N'ทศพร', N'กลิ่นระรวย', N'F', CAST(0x0000749300000000 AS DateTime))
INSERT [dbo].[NUTR_PATN_ADMT] ([HN], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO]) VALUES (N'    123', N'5305794', N'212', N'อายุรกรรมหญิง 1', CAST(0x00009BC60101E770 AS DateTime), CAST(0x00009BC60101E770 AS DateTime), N'     ', N'          ')
INSERT [dbo].[NUTR_PATN_ADMT] ([HN], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO]) VALUES (N'    782', N'5200002', N'222', N'ศัลยกรรมหญิง', CAST(0x00009B9301046040 AS DateTime), CAST(0x00009B9301046040 AS DateTime), N'22200', N'45        ')
INSERT [dbo].[NUTR_PATN_ADMT] ([HN], [AN], [WARDID], [WARDNAME], [ADMITDATE], [DISCHDATE], [ROOMNO], [BEDNO]) VALUES (N'    800', N'5000045', N'211', N'อายุรกรรมชาย', CAST(0x000099CD00DF05C0 AS DateTime), CAST(0x000099CD00DF05C0 AS DateTime), N'     ', N'          ')
SET IDENTITY_INSERT [dbo].[NUTR_SLOG] ON 

INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130920, N'user=admin', N'login', CAST(0x0000A5CF00B4516E AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130921, N'user=admin', N'login', CAST(0x0000A5CF00B70FD7 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130922, N'user=admin', N'login', CAST(0x0000A5CF00B7BDFE AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130923, N'user=admin', N'login', CAST(0x0000A5CF00B9016A AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130924, N'user=admin', N'login', CAST(0x0000A5CF00B93ACB AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130925, N'user=admin', N'login', CAST(0x0000A5CF00B9C12A AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130926, N'user=admin', N'login', CAST(0x0000A5CF00BA81A4 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130927, N'user=admin', N'login', CAST(0x0000A5CF00BAE58B AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130928, N'user=admin', N'login', CAST(0x0000A5CF00C31F9D AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130929, N'user=admin', N'login', CAST(0x0000A5CF00C5DF20 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130930, N'user=admin', N'login', CAST(0x0000A5CF00CA4E71 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130931, N'user=admin', N'login', CAST(0x0000A5CF00CF4E70 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130932, N'user=admin', N'login', CAST(0x0000A5CF00CFCDFC AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130933, N'user=admin', N'login', CAST(0x0000A5CF00D0593E AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130934, N'user=admin', N'login', CAST(0x0000A5CF00D08B5B AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130935, N'user=admin', N'login', CAST(0x0000A5CF00D2405A AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130936, N'user=admin', N'login', CAST(0x0000A5CF00D2B389 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130937, N'user=admin', N'login', CAST(0x0000A5CF00D3F8EC AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130938, N'user=admin', N'login', CAST(0x0000A5CF00D443A1 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130939, N'user=admin', N'login', CAST(0x0000A5CF00D4C3B6 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130940, N'user=admin', N'login', CAST(0x0000A5CF00D54033 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130941, N'user=admin', N'login', CAST(0x0000A5CF00D622FC AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130942, N'user=admin', N'login', CAST(0x0000A5CF00D7DD40 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130943, N'user=admin', N'login', CAST(0x0000A5CF00DC31DF AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130944, N'user=admin', N'login', CAST(0x0000A5CF00DD9384 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130945, N'user=admin', N'login', CAST(0x0000A5CF00DF577A AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130946, N'user=admin', N'login', CAST(0x0000A5CF00DF9938 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130947, N'user=admin', N'login', CAST(0x0000A5D000EA6197 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130948, N'user=admin', N'login', CAST(0x0000A5D000EB629E AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130949, N'user=admin', N'login', CAST(0x0000A5D000EBAF21 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130950, N'user=admin', N'login', CAST(0x0000A5D000EC035E AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130951, N'user=admin', N'login', CAST(0x0000A5D000EDD31B AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130952, N'user=admin', N'login', CAST(0x0000A5D000EE12D9 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130953, N'user=admin', N'login', CAST(0x0000A5D000EE81A2 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130954, N'user=admin', N'login', CAST(0x0000A5D000F02788 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130955, N'user=admin', N'login', CAST(0x0000A5D000F16954 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130956, N'user=admin', N'login', CAST(0x0000A5D000F1A306 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130957, N'user=admin', N'login', CAST(0x0000A5D000F81934 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130958, N'user=admin', N'login', CAST(0x0000A5D000F89811 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130959, N'user=admin', N'login', CAST(0x0000A5D000FA525A AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130960, N'user=admin', N'login', CAST(0x0000A5D000FD24AF AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130961, N'user=admin', N'login', CAST(0x0000A5D000FD666E AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130962, N'user=admin', N'login', CAST(0x0000A5D000FE0FDD AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130963, N'user=admin', N'login', CAST(0x0000A5D000FE4C40 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130964, N'user=admin', N'login', CAST(0x0000A5D001008BF3 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130965, N'user=admin', N'login', CAST(0x0000A5D001021567 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130966, N'user=admin', N'login', CAST(0x0000A5D00103291F AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130967, N'user=admin', N'login', CAST(0x0000A5D00103EDD1 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130968, N'user=admin', N'login', CAST(0x0000A5D001063D73 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130969, N'user=admin', N'login', CAST(0x0000A5D001084204 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130970, N'user=admin', N'login', CAST(0x0000A5D00108EF86 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130971, N'user=admin', N'login', CAST(0x0000A5D001095097 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130972, N'user=admin', N'login', CAST(0x0000A5D001098D93 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130973, N'user=admin', N'login', CAST(0x0000A5D0010A2208 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130974, N'user=admin', N'login', CAST(0x0000A5D0010B3D6C AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130975, N'user=admin', N'login', CAST(0x0000A5D0010C2BD6 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130976, N'user=admin', N'login', CAST(0x0000A5D0010D20B6 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130977, N'user=admin', N'login', CAST(0x0000A5D001461D19 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130978, N'user=admin', N'login', CAST(0x0000A5D0014A7846 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130979, N'user=admin', N'login', CAST(0x0000A5D00150D884 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130980, N'user=admin', N'login', CAST(0x0000A5D001525A0F AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130981, N'user=admin', N'login', CAST(0x0000A5D001555179 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130982, N'user=admin', N'login', CAST(0x0000A5D00155B218 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130983, N'user=admin', N'login', CAST(0x0000A5D00156B7F2 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130984, N'user=admin', N'login', CAST(0x0000A5D001572B2A AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130985, N'user=admin', N'login', CAST(0x0000A5D00157F9B8 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130986, N'user=admin', N'login', CAST(0x0000A5D00158B31B AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130987, N'user=admin', N'login', CAST(0x0000A5D00159D085 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130988, N'user=admin', N'login', CAST(0x0000A5D1008B4833 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130989, N'user=admin', N'login', CAST(0x0000A5D1008B7C05 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130990, N'user=admin', N'login', CAST(0x0000A5D10090DA09 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130991, N'user=admin', N'login', CAST(0x0000A5D100921BE7 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130992, N'user=admin', N'login', CAST(0x0000A5D100924548 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130993, N'user=admin', N'login', CAST(0x0000A5D100927CBE AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130994, N'user=admin', N'login', CAST(0x0000A5D10092940B AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130995, N'user=admin', N'login', CAST(0x0000A5D10092C335 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130996, N'user=admin', N'login', CAST(0x0000A5D10094674B AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130997, N'user=admin', N'login', CAST(0x0000A5D10094C7E3 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130998, N'user=admin', N'login', CAST(0x0000A5D100980C4C AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131018, N'user=admin', N'login', CAST(0x0000A5D100A91E75 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130919, N'user=admin', N'login', CAST(0x0000A5CE00F1F59D AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131001, N'user=admin', N'login', CAST(0x0000A5D10099E753 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131002, N'user=admin', N'login', CAST(0x0000A5D1009BB959 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131003, N'user=admin', N'login', CAST(0x0000A5D1009D3D87 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131004, N'user=admin', N'login', CAST(0x0000A5D1009E174F AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131005, N'user=admin', N'login', CAST(0x0000A5D1009E55B7 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131006, N'user=admin', N'login', CAST(0x0000A5D100A03698 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131007, N'user=admin', N'login', CAST(0x0000A5D100A10A38 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131008, N'user=admin', N'login', CAST(0x0000A5D100A17283 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131009, N'user=admin', N'login', CAST(0x0000A5D100A1B43B AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131010, N'user=admin', N'login', CAST(0x0000A5D100A1FB07 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131011, N'user=admin', N'login', CAST(0x0000A5D100A25771 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131012, N'user=admin', N'login', CAST(0x0000A5D100A3641C AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131013, N'user=admin', N'login', CAST(0x0000A5D100A38E0D AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131014, N'user=admin', N'login', CAST(0x0000A5D100A3C99E AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131015, N'user=admin', N'login', CAST(0x0000A5D100A41E38 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131016, N'user=admin', N'login', CAST(0x0000A5D100A58A4B AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131017, N'user=admin', N'login', CAST(0x0000A5D100A62889 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131019, N'user=admin', N'login', CAST(0x0000A5D100AA37C1 AS DateTime))
GO
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131020, N'user=admin', N'login', CAST(0x0000A5D100AF0651 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131021, N'user=admin', N'login', CAST(0x0000A5D100B6FFC9 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130917, N'user=admin', N'login', CAST(0x0000A5CE00ED7155 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130918, N'user=admin', N'login', CAST(0x0000A5CE00EF1049 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (130999, N'user=admin', N'login', CAST(0x0000A5D10098D5F8 AS DateTime))
INSERT [dbo].[NUTR_SLOG] ([LOGID], [LOGDS], [LOGTY], [LOGDT]) VALUES (131000, N'user=admin', N'login', CAST(0x0000A5D100997C10 AS DateTime))
SET IDENTITY_INSERT [dbo].[NUTR_SLOG] OFF
INSERT [dbo].[NUTR_USER] ([ID], [FNAME], [LNAME], [ANAME], [GENDER], [EMAIL], [LOGIN], [PASSWORD], [UNUSED], [UTYPE]) VALUES (N'0000000001', N'ผู้ดูแลระบบ', N'โภชนาการ', N'ผู้ดูแลระบบ โภชนาการ', N'M', N'admin@gmail.com', N'admin', N'6VCHA1', N'N', N'A')
INSERT [dbo].[NUTR_USER] ([ID], [FNAME], [LNAME], [ANAME], [GENDER], [EMAIL], [LOGIN], [PASSWORD], [UNUSED], [UTYPE]) VALUES (N'0000000002', N'นที', N'เกตุแก้ว', N'นที เกตุแก้ว', N'M', N'natee@gmail.com', N'natee', N'6XAm61', N'N', N'0')
INSERT [dbo].[NUTR_USER] ([ID], [FNAME], [LNAME], [ANAME], [GENDER], [EMAIL], [LOGIN], [PASSWORD], [UNUSED], [UTYPE]) VALUES (N'0000000003', N'พงศ์', N'นิติวรธรรม', N'พงศ์ นิติวรธรรม', N'M', N'pong@mail.com', N'pong', N'6XAm61', N'N', N'0')
SET ANSI_PADDING ON

GO
/****** Object:  Index [PK_NUTR_FACT]    Script Date: 27/7/2559 8:46:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FACT]') AND name = N'PK_NUTR_FACT')
ALTER TABLE [dbo].[NUTR_FACT] ADD  CONSTRAINT [PK_NUTR_FACT] PRIMARY KEY NONCLUSTERED 
(
	[CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PK_NUTR_FACT_GRPS]    Script Date: 27/7/2559 8:46:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FACT_GRPS]') AND name = N'PK_NUTR_FACT_GRPS')
ALTER TABLE [dbo].[NUTR_FACT_GRPS] ADD  CONSTRAINT [PK_NUTR_FACT_GRPS] PRIMARY KEY NONCLUSTERED 
(
	[FGRC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PK_NUTR_FOOD_REQD]    Script Date: 27/7/2559 8:46:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQD]') AND name = N'PK_NUTR_FOOD_REQD')
ALTER TABLE [dbo].[NUTR_FOOD_REQD] ADD  CONSTRAINT [PK_NUTR_FOOD_REQD] PRIMARY KEY NONCLUSTERED 
(
	[REQID] ASC,
	[REQCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PK_NUTR_FOOD_REQS]    Script Date: 27/7/2559 8:46:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQS]') AND name = N'PK_NUTR_FOOD_REQS')
ALTER TABLE [dbo].[NUTR_FOOD_REQS] ADD  CONSTRAINT [PK_NUTR_FOOD_REQS] PRIMARY KEY NONCLUSTERED 
(
	[REQID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX1_NUTR_FOOD_REQS]    Script Date: 27/7/2559 8:46:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQS]') AND name = N'IDX1_NUTR_FOOD_REQS')
CREATE NONCLUSTERED INDEX [IDX1_NUTR_FOOD_REQS] ON [dbo].[NUTR_FOOD_REQS]
(
	[HN] ASC,
	[AN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX0_NUTR_PADM]    Script Date: 27/7/2559 8:46:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NUTR_PADM]') AND name = N'IDX0_NUTR_PADM')
CREATE UNIQUE NONCLUSTERED INDEX [IDX0_NUTR_PADM] ON [dbo].[NUTR_PADM]
(
	[HN] ASC,
	[AN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__NUTR_FACT__SLIPP__6C6E1476]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[NUTR_FACT_GRPS] ADD  DEFAULT ('N') FOR [SLIPPRN]
END

GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NUTR_FACT_NUTR_FACT_GRPS]') AND parent_object_id = OBJECT_ID(N'[dbo].[NUTR_FACT]'))
ALTER TABLE [dbo].[NUTR_FACT]  WITH CHECK ADD  CONSTRAINT [FK_NUTR_FACT_NUTR_FACT_GRPS] FOREIGN KEY([FGRC])
REFERENCES [dbo].[NUTR_FACT_GRPS] ([FGRC])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NUTR_FACT_NUTR_FACT_GRPS]') AND parent_object_id = OBJECT_ID(N'[dbo].[NUTR_FACT]'))
ALTER TABLE [dbo].[NUTR_FACT] CHECK CONSTRAINT [FK_NUTR_FACT_NUTR_FACT_GRPS]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NUTR_FOOD_REQD_NUTR_FACT]') AND parent_object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQD]'))
ALTER TABLE [dbo].[NUTR_FOOD_REQD]  WITH CHECK ADD  CONSTRAINT [FK_NUTR_FOOD_REQD_NUTR_FACT] FOREIGN KEY([REQCODE])
REFERENCES [dbo].[NUTR_FACT] ([CODE])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NUTR_FOOD_REQD_NUTR_FACT]') AND parent_object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQD]'))
ALTER TABLE [dbo].[NUTR_FOOD_REQD] CHECK CONSTRAINT [FK_NUTR_FOOD_REQD_NUTR_FACT]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NUTR_FOOD_REQD_NUTR_FOOD_REQS]') AND parent_object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQD]'))
ALTER TABLE [dbo].[NUTR_FOOD_REQD]  WITH CHECK ADD  CONSTRAINT [FK_NUTR_FOOD_REQD_NUTR_FOOD_REQS] FOREIGN KEY([REQID])
REFERENCES [dbo].[NUTR_FOOD_REQS] ([REQID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NUTR_FOOD_REQD_NUTR_FOOD_REQS]') AND parent_object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQD]'))
ALTER TABLE [dbo].[NUTR_FOOD_REQD] CHECK CONSTRAINT [FK_NUTR_FOOD_REQD_NUTR_FOOD_REQS]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NUTR_FOOD_REQS_NUTR_DIAG]') AND parent_object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQS]'))
ALTER TABLE [dbo].[NUTR_FOOD_REQS]  WITH CHECK ADD  CONSTRAINT [FK_NUTR_FOOD_REQS_NUTR_DIAG] FOREIGN KEY([DIAG])
REFERENCES [dbo].[NUTR_DIAG] ([CODE])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NUTR_FOOD_REQS_NUTR_DIAG]') AND parent_object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQS]'))
ALTER TABLE [dbo].[NUTR_FOOD_REQS] CHECK CONSTRAINT [FK_NUTR_FOOD_REQS_NUTR_DIAG]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NUTR_FOOD_REQS_NUTR_PADM]') AND parent_object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQS]'))
ALTER TABLE [dbo].[NUTR_FOOD_REQS]  WITH CHECK ADD  CONSTRAINT [FK_NUTR_FOOD_REQS_NUTR_PADM] FOREIGN KEY([AN])
REFERENCES [dbo].[NUTR_PADM] ([AN])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NUTR_FOOD_REQS_NUTR_PADM]') AND parent_object_id = OBJECT_ID(N'[dbo].[NUTR_FOOD_REQS]'))
ALTER TABLE [dbo].[NUTR_FOOD_REQS] CHECK CONSTRAINT [FK_NUTR_FOOD_REQS_NUTR_PADM]
GO
