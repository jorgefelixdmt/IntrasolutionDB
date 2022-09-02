CREATE TABLE [dbo].[g_tipo_seguro] (
    [g_tipo_seguro_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]           VARCHAR (50)  NULL,
    [nombre]           VARCHAR (100) NULL,
    [estado]           NUMERIC (1)   NULL,
    [created]          DATETIME      NULL,
    [created_by]       NUMERIC (10)  NULL,
    [updated]          DATETIME      NULL,
    [updated_by]       NUMERIC (10)  NULL,
    [owner_id]         NUMERIC (10)  NULL,
    [is_deleted]       NUMERIC (1)   NULL,
    CONSTRAINT [PK_g_tipo_seguro] PRIMARY KEY CLUSTERED ([g_tipo_seguro_id] ASC)
);


GO

