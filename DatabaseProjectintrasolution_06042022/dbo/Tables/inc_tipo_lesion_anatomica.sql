CREATE TABLE [dbo].[inc_tipo_lesion_anatomica] (
    [inc_tipo_lesion_anatomica_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                       VARCHAR (50)  NULL,
    [nombre]                       VARCHAR (100) NULL,
    [codigo_gobierno]              VARCHAR (25)  NULL,
    [texto_x]                      NUMERIC (10)  NULL,
    [texto_y]                      NUMERIC (10)  NULL,
    [inicio_x]                     NUMERIC (10)  NULL,
    [inicio_y]                     NUMERIC (10)  NULL,
    [fin_x]                        NUMERIC (10)  NULL,
    [fin_y]                        NUMERIC (10)  NULL,
    [estado]                       NUMERIC (1)   NULL,
    [created]                      DATETIME      NULL,
    [created_by]                   NUMERIC (10)  NULL,
    [updated]                      DATETIME      NULL,
    [updated_by]                   NUMERIC (10)  NULL,
    [owner_id]                     NUMERIC (10)  NULL,
    [is_deleted]                   NUMERIC (1)   NULL,
    [orden]                        NUMERIC (10)  NULL,
    CONSTRAINT [inc_tipo_lesion_anatomica_id] PRIMARY KEY CLUSTERED ([inc_tipo_lesion_anatomica_id] ASC)
);


GO

