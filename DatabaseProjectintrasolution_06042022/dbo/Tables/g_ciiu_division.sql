CREATE TABLE [dbo].[g_ciiu_division] (
    [g_ciiu_division_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [nombre]             NVARCHAR (400) NULL,
    [estado]             NUMERIC (1)    NULL,
    [owner_id]           NUMERIC (10)   NULL,
    [created]            DATETIME       NULL,
    [created_by]         NUMERIC (10)   NULL,
    [updated]            DATETIME       NULL,
    [updated_by]         NUMERIC (10)   NULL,
    [is_deleted]         NUMERIC (1)    NULL,
    [codigo]             VARCHAR (50)   NULL,
    CONSTRAINT [PK_g_ciiu_division] PRIMARY KEY CLUSTERED ([g_ciiu_division_id] ASC)
);


GO

