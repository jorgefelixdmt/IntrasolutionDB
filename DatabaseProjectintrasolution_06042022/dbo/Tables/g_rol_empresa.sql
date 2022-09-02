CREATE TABLE [dbo].[g_rol_empresa] (
    [g_rol_empresa_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]           NVARCHAR (50)  NULL,
    [nombre]           NVARCHAR (200) NULL,
    [estado]           NUMERIC (1)    NULL,
    [owner_id]         NUMERIC (10)   NULL,
    [created]          DATETIME       NULL,
    [created_by]       NUMERIC (10)   NULL,
    [updated]          DATETIME       NULL,
    [updated_by]       NUMERIC (10)   NULL,
    [is_deleted]       NUMERIC (1)    NULL,
    [orden]            NUMERIC (10)   NULL,
    CONSTRAINT [PK_g_rol_empresa] PRIMARY KEY CLUSTERED ([g_rol_empresa_id] ASC)
);


GO

