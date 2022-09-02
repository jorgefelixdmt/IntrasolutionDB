CREATE TABLE [dbo].[pry_proyecto_jira] (
    [pry_proyecto_jira_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [proyecto_IS_id]       NUMERIC (10)  NULL,
    [proyecto_J_id]        NUMERIC (10)  NULL,
    [proyecto_J_key]       VARCHAR (255) NULL,
    [estado]               NUMERIC (1)   NULL,
    [created]              DATETIME      NULL,
    [created_by]           NUMERIC (10)  NULL,
    [updated]              DATETIME      NULL,
    [updated_by]           NUMERIC (10)  NULL,
    [owner_id]             NUMERIC (10)  NULL,
    [is_deleted]           NUMERIC (1)   NULL,
    PRIMARY KEY CLUSTERED ([pry_proyecto_jira_id] ASC)
);


GO

