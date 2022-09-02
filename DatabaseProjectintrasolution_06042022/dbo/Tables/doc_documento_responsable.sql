CREATE TABLE [dbo].[doc_documento_responsable] (
    [doc_documento_responsable_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [doc_documento_id]             NUMERIC (10)  NULL,
    [fb_empleado_id]               NUMERIC (10)  NULL,
    [empleado_nombreCompleto]      VARCHAR (200) NULL,
    [empleado_cargo]               VARCHAR (200) NULL,
    [empleado_area]                VARCHAR (200) NULL,
    [tipo_responsable]             VARCHAR (50)  NULL,
    [created]                      DATETIME      NULL,
    [created_by]                   NUMERIC (10)  NULL,
    [updated]                      DATETIME      NULL,
    [updated_by]                   NUMERIC (10)  NULL,
    [owner_id]                     NUMERIC (10)  NULL,
    [is_deleted]                   NUMERIC (1)   NULL,
    CONSTRAINT [PK_doc_documento_responsable] PRIMARY KEY CLUSTERED ([doc_documento_responsable_id] ASC)
);


GO

