CREATE TABLE [dbo].[g_tipo_origen] (
    [g_tipo_origen_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]           VARCHAR (50)  NULL,
    [nombre]           VARCHAR (100) NULL,
    [categoria_origen] VARCHAR (50)  NULL,
    [estado]           NUMERIC (1)   NULL,
    [created]          DATETIME      NULL,
    [created_by]       NUMERIC (10)  NULL,
    [updated]          DATETIME      NULL,
    [updated_by]       NUMERIC (10)  NULL,
    [owner_id]         NUMERIC (10)  NULL,
    [is_deleted]       NUMERIC (1)   NULL,
    [orden]            NUMERIC (10)  NULL,
    CONSTRAINT [g_tipo_origen_id] PRIMARY KEY CLUSTERED ([g_tipo_origen_id] ASC)
);


GO

