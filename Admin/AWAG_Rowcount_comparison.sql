
/* compare rowcounts for tables used by BW in EP1*/

select a.*,b.[RowCounts] as RowCounts_readonly  , a.[RowCounts]-b.[RowCounts] as delta
 from msdb.dbo.rowcount_prd_bw a
 join [LV-SAPSQLP3\RO].[msdb].[dbo].[rowcount_ro_bw] b 
on a.TableName = b.TableName
where a.[RowCounts]-b.[RowCounts] <> 0
order by 5 desc


/* compare rowcounts for  all tables  in EP1*/


select a.*,b.[RowCounts] as RowCounts_readonly  , a.[RowCounts]-b.[RowCounts] as delta
 from msdb.dbo.rowcount_prd_all a
 join [LV-SAPSQLP3\RO].[msdb].[dbo].[rowcount_ro_all] b 
on a.TableName = b.TableName
where a.[RowCounts]-b.[RowCounts] <> 0
order by 5 desc



/* compare rowcounts for  all tables  in ACC */


select a.*,b.[RowCounts] as RowCounts_readonly  , a.[RowCounts]-b.[RowCounts] as delta
 from msdb.dbo.rowcount_prd_all_ACC a
 join [LV-SAPSQLP3\RO].[msdb].[dbo].[rowcount_ro_all_ACC] b 
on a.TableName = b.TableName
where a.[RowCounts]-b.[RowCounts] <> 0
order by 5 desc