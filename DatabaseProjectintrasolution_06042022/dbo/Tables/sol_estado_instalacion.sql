CREATE TABLE [dbo].[sol_estado_instalacion] (
    [sol_estado_instalacion_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                    VARCHAR (50)  NULL,
    [nombre]                    VARCHAR (200) NULL,
    [orden]                     NUMERIC (10)  NULL,
    [estado]                    NUMERIC (1)   NULL,
    [created]                   DATETIME      NULL,
    [created_by]                NUMERIC (10)  NULL,
    [updated]                   DATETIME      NULL,
    [updated_by]                NUMERIC (10)  NULL,
    [owner_id]                  NUMERIC (10)  NULL,
    [is_deleted]                NUMERIC (1)   NULL,
    CONSTRAINT [sol_estado_instalacion_id] PRIMARY KEY CLUSTERED ([sol_estado_instalacion_id] ASC)
);


GO

