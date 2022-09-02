CREATE TABLE [dbo].[g_moneda] (
    [g_moneda_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]      VARCHAR (50)  NULL,
    [nombre]      VARCHAR (128) NULL,
    [simbolo]     VARCHAR (20)  NULL,
    [estado]      NUMERIC (1)   NULL,
    [owner_id]    NUMERIC (10)  NULL,
    [created]     DATETIME      NULL,
    [created_by]  NUMERIC (10)  NULL,
    [updated]     DATETIME      NULL,
    [updated_by]  NUMERIC (10)  NULL,
    [is_deleted]  NUMERIC (1)   NULL
);


GO

