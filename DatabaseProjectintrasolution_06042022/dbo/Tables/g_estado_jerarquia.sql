CREATE TABLE [dbo].[g_estado_jerarquia] (
    [g_estado_jerarquia_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]                NVARCHAR (50)  NULL,
    [nombre]                NVARCHAR (200) NULL,
    [calidad]               NVARCHAR (20)  NULL,
    [estado]                NUMERIC (1)    NULL,
    [created]               DATETIME       NULL,
    [created_by]            NUMERIC (10)   NULL,
    [updated]               DATETIME       NULL,
    [updated_by]            NUMERIC (10)   NULL,
    [owner_id]              NUMERIC (10)   NULL,
    [si_ordenamiento]       NUMERIC (2)    NULL,
    [is_deleted]            NUMERIC (1)    NULL,
    CONSTRAINT [PK_g_estado_jerarquia] PRIMARY KEY CLUSTERED ([g_estado_jerarquia_id] ASC)
);


GO

