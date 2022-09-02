CREATE TABLE [dbo].[pa_entrega_incidentes] (
    [pa_entrega_incidentes_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo_jira]              VARCHAR (200) NULL,
    [inc_incidencia_id]        NUMERIC (10)  NULL,
    [link_jira]                VARCHAR (500) NULL,
    [created]                  DATETIME      NULL,
    [created_by]               NUMERIC (10)  NULL,
    [updated]                  DATETIME      NULL,
    [updated_by]               NUMERIC (10)  NULL,
    [owner_id]                 NUMERIC (10)  NULL,
    [is_deleted]               NUMERIC (1)   NULL,
    [pa_entrega_objetos_id]    NUMERIC (10)  NULL
);


GO

