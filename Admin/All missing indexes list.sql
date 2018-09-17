/*
Missing Index Details from missing index.sqlplan
The Query Processor estimates that implementing the following index could improve the query cost by 89.4294%.
*/

/*
USE [EVMailVaultStore]
GO
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [dbo].[WatchSISPartFile] ([SavesetIdPartition])
INCLUDE ([SavesetIdentity])
GO
*/


 Indexs for EVMailVaultStore
 ---------------------------------------------------------
 ------------------------------------------------------------



 CREATE NONCLUSTERED INDEX ix_WatchSISPartFile_SavesetIdPartition
 ON [EVMailVaultStore].[dbo].[WatchSISPartFile] ([SavesetIdPartition])
 INCLUDE ([SavesetIdentity]);
  --00:00:16
 
 CREATE NONCLUSTERED INDEX ix_JournalUpdate_ArchivePointIdentity_UpdateType_IndexCommittedItemSeqNo_UpdateSeqNo
  ON [EVMailVaultStore].[dbo].[JournalUpdate] ( [ArchivePointIdentity], [UpdateType], [IndexCommitted],[ItemSeqNo], [UpdateSeqNo] ) ;
  -- 00:00:01
  

CREATE NONCLUSTERED INDEX ix_JournalUpdate_IndexCommitted
 ON [EVMailVaultStore].[dbo].[JournalUpdate] ( [IndexCommitted] ) INCLUDE ([ItemSeqNo], [UpdateSeqNo], [ArchivePointIdentity]);
 
   -- 00:00:01

CREATE NONCLUSTERED INDEX ix_JournalUpdate_IndexCommittedUpdateDateTime
 ON [EVMailVaultStore].[dbo].[JournalUpdate] ( [IndexCommitted],[UpdateDateTime] ) INCLUDE ([ItemSeqNo], [UpdateSeqNo], [ArchivePointIdentity]);
   -- 00:00:01




CREATE NONCLUSTERED INDEX ix_JournalArchive_IndexCommited_BackupCompleteRecordCreationDate
 ON [EVMailVaultStore].[dbo].[JournalArchive] ( [IndexCommited], [BackupComplete],[RecordCreationDate] ) INCLUDE ([SavesetIdentity],[IndexSeqNo],[ArchivePointIdentity]);
 -- 00:00:41
 
USE [EVMailVaultStore]
GO
CREATE NONCLUSTERED INDEX [ix_JournalArchive_IndexCommited] ON [dbo].[JournalArchive] 
(
	[IndexCommited] ASC
)
INCLUDE ( [IndexSeqNo],
[ArchivePointIdentity]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO

--00:00:20
