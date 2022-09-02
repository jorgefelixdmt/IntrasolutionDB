CREATE TABLE [dbo].[pry_proyecto_jira_etiqueta] (
    [pry_proyecto_jira_etiqueta_id]  NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [tipo_incidencia_IS_id]          NUMERIC (10)  NULL,
    [tipo_incidencia_IS_descripcion] VARCHAR (255) NULL,
    [label_jira]                     VARCHAR (255) NULL,
    [estado]                         NUMERIC (1)   NULL,
    [created]                        DATETIME      NULL,
    [created_by]                     NUMERIC (10)  NULL,
    [updated]                        DATETIME      NULL,
    [updated_by]                     NUMERIC (10)  NULL,
    [owner_id]                       NUMERIC (10)  NULL,
    [is_deleted]                     NUMERIC (1)   NULL,
    PRIMARY KEY CLUSTERED ([pry_proyecto_jira_etiqueta_id] ASC)
);


GO

