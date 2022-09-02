CREATE TABLE [dbo].[pry_proyecto_jira_empleado] (
    [pry_proyecto_jira_empleado_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [empleado_IS_id]                NUMERIC (10)  NULL,
    [empleado_J_id]                 NUMERIC (10)  NULL,
    [nombre]                        VARCHAR (255) NULL,
    [estado]                        NUMERIC (1)   NULL,
    [created]                       DATETIME      NULL,
    [created_by]                    NUMERIC (10)  NULL,
    [updated]                       DATETIME      NULL,
    [updated_by]                    NUMERIC (10)  NULL,
    [owner_id]                      NUMERIC (10)  NULL,
    [is_deleted]                    NUMERIC (1)   NULL,
    CONSTRAINT [PK_pry_proyecto_jira_empleado_id] PRIMARY KEY CLUSTERED ([pry_proyecto_jira_empleado_id] ASC)
);


GO

