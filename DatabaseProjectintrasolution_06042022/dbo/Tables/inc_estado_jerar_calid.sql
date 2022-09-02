CREATE TABLE [dbo].[inc_estado_jerar_calid] (
    [inc_estado_jerar_calid_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                    VARCHAR (50)  NULL,
    [nombre]                    VARCHAR (200) NULL,
    [calidad]                   VARCHAR (20)  NULL,
    [estado]                    NUMERIC (1)   NULL,
    [created]                   DATETIME      NULL,
    [created_by]                NUMERIC (10)  NULL,
    [updated]                   DATETIME      NULL,
    [updated_by]                NUMERIC (10)  NULL,
    [owner_id]                  NUMERIC (10)  NULL,
    [is_deleted]                NUMERIC (1)   NULL,
    CONSTRAINT [PK_inc_estado_jerar_calid] PRIMARY KEY CLUSTERED ([inc_estado_jerar_calid_id] ASC)
);


GO

