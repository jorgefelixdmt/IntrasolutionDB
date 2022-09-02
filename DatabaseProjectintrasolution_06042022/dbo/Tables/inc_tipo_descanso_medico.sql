CREATE TABLE [dbo].[inc_tipo_descanso_medico] (
    [inc_tipo_descanso_medico_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                      VARCHAR (50)  NULL,
    [nombre]                      VARCHAR (100) NULL,
    [dias_descanso]               NUMERIC (10)  NULL,
    [inc_categoria_lesion_id]     NUMERIC (10)  NULL,
    [estado]                      NUMERIC (1)   NULL,
    [created]                     DATETIME      NULL,
    [created_by]                  NUMERIC (10)  NULL,
    [updated]                     DATETIME      NULL,
    [updated_by]                  NUMERIC (10)  NULL,
    [owner_id]                    NUMERIC (10)  NULL,
    [is_deleted]                  NUMERIC (1)   NULL,
    [orden]                       NUMERIC (10)  NULL,
    CONSTRAINT [inc_tipo_descanso_medico_id] PRIMARY KEY CLUSTERED ([inc_tipo_descanso_medico_id] ASC)
);


GO

