CREATE TABLE [dbo].[inc_informe_final_causa] (
    [inc_informe_final_causa_id]    NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [inc_informe_final_id]          NUMERIC (10)   NULL,
    [g_tipo_causa_id]               NUMERIC (10)   NULL,
    [g_tipo_causa_id_clase]         NUMERIC (10)   NULL,
    [g_tipo_causa_id_causa]         NUMERIC (10)   NULL,
    [g_tipo_causa_id_sub_causa]     NUMERIC (10)   NULL,
    [g_tipo_causa_id_sub_sub_causa] NUMERIC (10)   NULL,
    [codigo_tipo_causa]             VARCHAR (50)   NULL,
    [descripcion_tipo_causa]        VARCHAR (200)  NULL,
    [comentario]                    VARCHAR (4000) NULL,
    [nivel]                         NUMERIC (2)    NULL,
    [created]                       DATETIME       NULL,
    [created_by]                    NUMERIC (10)   NULL,
    [updated]                       DATETIME       NULL,
    [updated_by]                    NUMERIC (10)   NULL,
    [owner_id]                      NUMERIC (10)   NULL,
    [is_deleted]                    NUMERIC (1)    NULL,
    [porque1]                       VARCHAR (4000) NULL,
    [porque2]                       VARCHAR (4000) NULL,
    [porque3]                       VARCHAR (4000) NULL,
    [porque4]                       VARCHAR (4000) NULL,
    [porque5]                       VARCHAR (4000) NULL,
    CONSTRAINT [PK_inc_informe_final_causa] PRIMARY KEY CLUSTERED ([inc_informe_final_causa_id] ASC)
);


GO

