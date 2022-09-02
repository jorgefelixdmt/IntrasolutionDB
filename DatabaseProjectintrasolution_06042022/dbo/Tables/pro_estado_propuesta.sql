CREATE TABLE [dbo].[pro_estado_propuesta] (
    [pro_estado_propuesta_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                  VARCHAR (50)  NULL,
    [nombre]                  VARCHAR (100) NULL,
    [estado]                  NUMERIC (10)  NULL,
    [orden]                   NUMERIC (10)  NULL,
    [created]                 DATETIME      NULL,
    [created_by]              NUMERIC (10)  NULL,
    [updated]                 DATETIME      NULL,
    [updated_by]              NUMERIC (10)  NULL,
    [owner_id]                NUMERIC (10)  NULL,
    [is_deleted]              NUMERIC (1)   NULL,
    CONSTRAINT [PK_pro_propuesta_estado] PRIMARY KEY CLUSTERED ([pro_estado_propuesta_id] ASC)
);


GO

