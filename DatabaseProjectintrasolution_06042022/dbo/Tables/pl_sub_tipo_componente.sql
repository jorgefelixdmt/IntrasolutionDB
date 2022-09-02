CREATE TABLE [dbo].[pl_sub_tipo_componente] (
    [pl_sub_tipo_componente_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                    VARCHAR (50)  NULL,
    [nombre]                    VARCHAR (150) NULL,
    [orden]                     NUMERIC (10)  NULL,
    [estado]                    NUMERIC (1)   NULL,
    [created]                   DATETIME      NULL,
    [created_by]                NUMERIC (10)  NULL,
    [updated]                   DATETIME      NULL,
    [updated_by]                NUMERIC (10)  NULL,
    [owner_id]                  NUMERIC (10)  NULL,
    [is_deleted]                NUMERIC (10)  NULL
);


GO

