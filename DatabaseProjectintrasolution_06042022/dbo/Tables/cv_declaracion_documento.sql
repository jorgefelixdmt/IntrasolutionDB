CREATE TABLE [dbo].[cv_declaracion_documento] (
    [cv_declaracion_documento_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [cv_declaracion_id]           NUMERIC (10)  NULL,
    [archivo]                     VARCHAR (200) NULL,
    [detalle]                     VARCHAR (MAX) NULL,
    [created]                     DATETIME      NULL,
    [created_by]                  NUMERIC (10)  NULL,
    [updated]                     DATETIME      NULL,
    [updated_by]                  NUMERIC (10)  NULL,
    [owner_id]                    NUMERIC (10)  NULL,
    [is_deleted]                  NUMERIC (1)   NULL,
    CONSTRAINT [PK_cv_declaracion_documento] PRIMARY KEY CLUSTERED ([cv_declaracion_documento_id] ASC)
);


GO

