--Step 1: Check the Database
DBCC CHECKDB WITH DATA_PURITY

--Step 2: Perform a Backup
BACKUP DATABASE [DEVNUT] TO DISK = N'D:\Backup\_Database\DEVNUT_BeforeCollationChange.bak' WITH COPY_ONLY, NOFORMAT, NOINIT, NAME = 'DEVNUT',SKIP, NOREWIND, NOUNLOAD, STATS = 10

--Step 3: Change the Collation at the Database Level
ALTER DATABASE [AYHNUTR] COLLATE Thai_BIN

--Step 4: Find All the Table Columns Whose Collation Must Be Changed
SELECT t.name, c.name, c.collation_name
FROM sys.columns c INNER JOIN sys.tables t
ON t.object_id = c.object_id
WHERE c.object_id IN (SELECT object_id FROM sys.objects WHERE type = 'U')
AND c.collation_name = 'Thai_CI_AS'
--AND (t.name not like '%BK')
--AND (t.name not like '%BK0')
--AND (t.name not like '%0')
AND (t.name = 'NUTR_REPORTS')
ORDER BY t.name,c.name

--Step 5: Change the Collation at the Table Level
--ALTER TABLE [NUTR_PADM] 
--ALTER COLUMN [BEDNO] char(1)
--COLLATE Thai_BIN null

