CREATE TABLE [dbo].[pro_origen_documento] (
    [pro_origen_documento_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                  VARCHAR (50)  NULL,
    [nombre]                  VARCHAR (100) NULL,
    [estado]                  NUMERIC (1)   NULL,
    [orden]                   NUMERIC (10)  NULL,
    [created]                 DATETIME      NULL,
    [created_by]              NUMERIC (10)  NULL,
    [updated]                 DATETIME      NULL,
    [updated_by]              NUMERIC (10)  NULL,
    [owner_id]                NUMERIC (10)  NULL,
    [is_deleted]              NUMERIC (1)   NULL,
    CONSTRAINT [PK_pro_origen_documento] PRIMARY KEY CLUSTERED ([pro_origen_documento_id] ASC)
);


GO

