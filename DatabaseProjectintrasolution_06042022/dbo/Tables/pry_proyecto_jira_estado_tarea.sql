CREATE TABLE [dbo].[pry_proyecto_jira_estado_tarea] (
    [pry_proyecto_jira_estado_tarea_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [estado_tarea_IS_id]                NUMERIC (10)  NULL,
    [estado_tarea_IS_key]               VARCHAR (255) NULL,
    [estado_tarea_IS_descripcion]       VARCHAR (255) NULL,
    [estado_tarea_J_id]                 NUMERIC (10)  NULL,
    [estado_tarea_J_descripcion]        VARCHAR (255) NULL,
    [estado]                            NUMERIC (1)   NULL,
    [created]                           DATETIME      NULL,
    [created_by]                        NUMERIC (10)  NULL,
    [updated]                           DATETIME      NULL,
    [updated_by]                        NUMERIC (10)  NULL,
    [owner_id]                          NUMERIC (10)  NULL,
    [is_deleted]                        NUMERIC (1)   NULL,
    PRIMARY KEY CLUSTERED ([pry_proyecto_jira_estado_tarea_id] ASC)
);


GO

