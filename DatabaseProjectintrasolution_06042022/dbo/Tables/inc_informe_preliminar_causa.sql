CREATE TABLE [dbo].[inc_informe_preliminar_causa] (
    [inc_informe_preliminar_causa_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [inc_informe_preliminar_id]       NUMERIC (10)   NULL,
    [codigo_causa]                    VARCHAR (50)   NULL,
    [causa]                           VARCHAR (200)  NULL,
    [comentario_causa]                VARCHAR (1000) NULL,
    [created]                         DATETIME       NULL,
    [created_by]                      NUMERIC (10)   NULL,
    [updated]                         DATETIME       NULL,
    [updated_by]                      NUMERIC (10)   NULL,
    [owner_id]                        NUMERIC (10)   NULL,
    [is_deleted]                      NUMERIC (1)    NULL,
    [g_tipo_causa_id]                 NUMERIC (10)   NULL,
    CONSTRAINT [PK_inc_informe_preliminar_causa] PRIMARY KEY CLUSTERED ([inc_informe_preliminar_causa_id] ASC)
);


GO

