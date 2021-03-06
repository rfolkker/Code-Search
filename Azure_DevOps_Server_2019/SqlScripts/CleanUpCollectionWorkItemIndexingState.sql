/**
This script cleans up all the tables/entries which has the state of indexing of the WorkItem indexing units of the Collection. 
**/

TRUNCATE TABLE [Search].[tbl_ClassificationNode]

DELETE FROM [Search].[tbl_ResourceLockTable]
WHERE LeaseId in
(SELECT Distinct(LeaseId) from [Search].[tbl_IndexingUnitChangeEvent]
	WHERE IndexingUnitId in 
	(
		SELECT IndexingUnitId FROM [Search].[tbl_IndexingUnit] WHERE EntityType = 'WorkItem' AND PartitionId > 0
	)
	AND PartitionId > 0
)
AND PartitionId > 0

DELETE FROM [Search].[tbl_IndexingUnitChangeEvent]
	WHERE IndexingUnitId in 
	(
		SELECT IndexingUnitId FROM [Search].[tbl_IndexingUnit] WHERE EntityType = 'WorkItem' and PartitionId > 0
	)
	AND PartitionId > 0

DELETE FROM [Search].[tbl_ItemLevelFailures]
	WHERE IndexingUnitId in 
	(
		SELECT IndexingUnitId FROM [Search].[tbl_IndexingUnit] WHERE EntityType = 'WorkItem' and PartitionId > 0
	)
	AND PartitionId > 0

DELETE FROM [Search].[tbl_IndexingUnit] WHERE EntityType = 'WorkItem' AND PartitionId > 0