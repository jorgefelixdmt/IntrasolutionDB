

CREATE VIEW [dbo].[pry_vw_jira_project] AS
SELECT
	ID as pry_vw_jira_project_id,
	pkey as project_key,
	pname as project_name,
	PROJECTTYPE as project_type,
	NULL as created,
	NULL as created_by,
	NULL as updated,
	NULL as updated_by,
	NULL as owner_id,
	0 as is_deleted
FROM DTECH_185.jira_db.dbo.project
WHERE 
	PROJECTTYPE NOT LIKE 'service_desk'

GO

