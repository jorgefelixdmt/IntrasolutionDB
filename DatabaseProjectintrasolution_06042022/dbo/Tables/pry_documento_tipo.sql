CREATE TABLE [dbo].[pry_documento_tipo] (
    [pry_documento_tipo_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                VARCHAR (20)  NULL,
    [nombre]                VARCHAR (100) NULL,
    [orden]                 NUMERIC (10)  NULL,
    [estado]                NUMERIC (1)   NULL,
    [created]               DATETIME      NULL,
    [created_by]            NUMERIC (10)  NULL,
    [updated]               DATETIME      NULL,
    [updated_by]            NUMERIC (10)  NULL,
    [owner_id]              NUMERIC (10)  NULL,
    [is_deleted]            NUMERIC (1)   NULL,
    CONSTRAINT [PK_pry_documento_tipo] PRIMARY KEY CLUSTERED ([pry_documento_tipo_id] ASC)
);


GO

