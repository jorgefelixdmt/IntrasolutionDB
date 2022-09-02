CREATE TABLE [dbo].[fb_mensaje_email_destinatarios] (
    [fb_mensaje_email_destinatarios_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [email_destinatario]                VARCHAR (MAX) NULL,
    [fb_empleado_id]                    NUMERIC (10)  NULL,
    [empleado_codigo]                   VARCHAR (50)  NULL,
    [empleado_nombreCompleto]           VARCHAR (200) NULL,
    [empleado_email]                    VARCHAR (200) NULL,
    [fb_tipo_destinatario_id]           NUMERIC (10)  NULL,
    [tipo_destinatario_code]            VARCHAR (50)  NULL,
    [created]                           DATETIME      NULL,
    [created_by]                        NUMERIC (10)  NULL,
    [updated]                           DATETIME      NULL,
    [updated_by]                        NUMERIC (10)  NULL,
    [owner_id]                          NUMERIC (10)  NULL,
    [is_deleted]                        NUMERIC (1)   NULL,
    CONSTRAINT [PK_fb_mensaje_email_destinatarios_id] PRIMARY KEY CLUSTERED ([fb_mensaje_email_destinatarios_id] ASC)
);


GO

