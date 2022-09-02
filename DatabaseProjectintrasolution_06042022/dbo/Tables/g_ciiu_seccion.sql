CREATE TABLE [dbo].[g_ciiu_seccion] (
    [g_ciiu_seccion_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [nombre]            NVARCHAR (400) NULL,
    [rango_division]    NVARCHAR (50)  NULL,
    [estado]            NUMERIC (1)    NULL,
    [owner_id]          NUMERIC (10)   NULL,
    [created]           DATETIME       NULL,
    [created_by]        NUMERIC (10)   NULL,
    [updated]           DATETIME       NULL,
    [updated_by]        NUMERIC (10)   NULL,
    [is_deleted]        NUMERIC (1)    NULL,
    [codigo]            VARCHAR (50)   NULL,
    CONSTRAINT [PK_g_ciiu_seccion] PRIMARY KEY CLUSTERED ([g_ciiu_seccion_id] ASC)
);


GO

