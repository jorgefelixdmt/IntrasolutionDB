CREATE TABLE [dbo].[doc_gestion] (
    [doc_gestion_id]    NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo_documento]  VARCHAR (50)  NULL,
    [nombre_documento]  VARCHAR (200) NULL,
    [tipo_verificacion] VARCHAR (50)  NULL,
    [mensaje_error]     VARCHAR (200) NULL,
    [activo]            NUMERIC (1)   NULL,
    [created]           DATETIME      NULL,
    [created_by]        NUMERIC (10)  NULL,
    [updated]           DATETIME      NULL,
    [updated_by]        NUMERIC (10)  NULL,
    [owner_id]          NUMERIC (10)  NULL,
    [is_deleted]        NUMERIC (1)   NULL,
    CONSTRAINT [PK_doc_gestion] PRIMARY KEY CLUSTERED ([doc_gestion_id] ASC)
);


GO

