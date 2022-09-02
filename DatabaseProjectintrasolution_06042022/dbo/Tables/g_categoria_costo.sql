CREATE TABLE [dbo].[g_categoria_costo] (
    [g_categoria_costo_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]               VARCHAR (50)  NULL,
    [nombre]               VARCHAR (200) NULL,
    [proceso]              VARCHAR (50)  NULL,
    [estado]               NUMERIC (1)   NULL,
    [created]              DATETIME      NULL,
    [created_by]           NUMERIC (10)  NULL,
    [updated]              DATETIME      NULL,
    [updated_by]           NUMERIC (10)  NULL,
    [owner_id]             NUMERIC (10)  NULL,
    [is_deleted]           NUMERIC (1)   NULL,
    [orden]                NUMERIC (10)  NULL,
    CONSTRAINT [PK_g_categoria_costo] PRIMARY KEY CLUSTERED ([g_categoria_costo_id] ASC)
);


GO
