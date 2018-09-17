SELECT tidi.VaultID
, tv.KVSVaultName AS 'Archive Name'
, tidi.CaseID AS 'Case ID'
, tc.Name AS 'Case Name'
, ts1.Name AS 'Case Status'
, ts2.Name AS 'Legal Hold Status'
, tidi.SearchID As 'Search ID'
, tis.Name AS 'Search Name'
, COUNT(tidi.DiscoveredItemID) AS 'Number of Search Results'
FROM tblIntDiscoveredItems tidi
JOIN tblVaults tv ON tidi.VaultID = tv.VaultID
JOIN tblCase tc ON tidi.CaseID = tc.CaseID
JOIN tblStatus ts1 ON tc.StatusID = ts1.StatusID
JOIN tblStatus ts2 ON tc.LegalHoldState = ts2.StatusID
JOIN tblIntSearches tis ON tidi.SearchID = tis.SearchID
--WHERE tidi.VaultID IN (SELECT VaultID FROM tblVaults WHERE KVSVaultName LIKE '%') --change vaultname to the Archive Name
GROUP BY tidi.VaultID, tv.KVSVaultName, tidi.CaseID, tc.Name, tidi.SearchID, tis.Name, ts1.Name, ts2.Name
ORDER BY tidi.VaultID, tidi.CaseID, tidi.SearchID
COMPUTE SUM(COUNT(tidi.DiscoveredItemID))
