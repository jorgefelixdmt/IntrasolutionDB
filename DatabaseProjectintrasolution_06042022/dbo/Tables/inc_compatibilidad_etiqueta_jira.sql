CREATE TABLE [dbo].[inc_compatibilidad_etiqueta_jira] (
    [inc_compatibilidad_etiqueta_jira_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                              VARCHAR (50)  NULL,
    [nombre]                              VARCHAR (200) NULL,
    [id_jira]                             NUMERIC (10)  NULL,
    [orden]                               NUMERIC (10)  NULL,
    [estado]                              NUMERIC (1)   NULL,
    [created]                             DATETIME      NULL,
    [created_by]                          NUMERIC (10)  NULL,
    [updated]                             DATETIME      NULL,
    [updated_by]                          NUMERIC (10)  NULL,
    [owner_id]                            NUMERIC (10)  NULL,
    [is_deleted]                          NUMERIC (1)   NULL,
    CONSTRAINT [PK_inc_compatibilidad_etiqueta_jira] PRIMARY KEY CLUSTERED ([inc_compatibilidad_etiqueta_jira_id] ASC)
);


GO

