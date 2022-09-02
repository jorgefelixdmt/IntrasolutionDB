CREATE TABLE [dbo].[cv_declaracion_contactos] (
    [cv_declaracion_contactos_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [cv_declaracion_id]           NUMERIC (10)  NULL,
    [nombre_completo]             VARCHAR (200) NULL,
    [g_parentesco_id]             NUMERIC (10)  NULL,
    [cv_tipo_vulnerable_id]       NUMERIC (10)  NULL,
    [detalle]                     VARCHAR (MAX) NULL,
    [created]                     DATETIME      NULL,
    [created_by]                  NUMERIC (10)  NULL,
    [updated]                     DATETIME      NULL,
    [updated_by]                  NUMERIC (10)  NULL,
    [owner_id]                    NUMERIC (10)  NULL,
    [is_deleted]                  NUMERIC (1)   NULL,
    CONSTRAINT [PK_cv_declaracion_contactos] PRIMARY KEY CLUSTERED ([cv_declaracion_contactos_id] ASC)
);


GO

