CREATE TABLE [dbo].[g_nivel_riesgo] (
    [g_nivel_riesgo_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]            NVARCHAR (50)  NULL,
    [nombre]            NVARCHAR (100) NULL,
    [estado]            NUMERIC (1)    NULL,
    [owner_id]          NUMERIC (10)   NULL,
    [created]           DATETIME       NULL,
    [created_by]        NUMERIC (10)   NULL,
    [updated]           DATETIME       NULL,
    [updated_by]        NUMERIC (10)   NULL,
    [is_deleted]        NUMERIC (1)    NULL,
    [orden]             NUMERIC (10)   NULL
);


GO

