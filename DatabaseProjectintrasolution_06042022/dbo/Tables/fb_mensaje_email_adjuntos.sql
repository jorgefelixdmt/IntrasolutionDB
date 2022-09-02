CREATE TABLE [dbo].[fb_mensaje_email_adjuntos] (
    [fb_mensaje_email_adjuntos_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fb_mensaje_email_id]          NUMERIC (10)  NULL,
    [archivo_adjunto]              VARCHAR (200) NULL,
    [fb_tipo_adjunto_id]           NUMERIC (10)  NULL,
    [tipo_adjunto_codigo]          VARCHAR (50)  NULL,
    [created]                      DATETIME      NULL,
    [created_by]                   NUMERIC (10)  NULL,
    [updated]                      DATETIME      NULL,
    [updated_by]                   NUMERIC (10)  NULL,
    [owner_id]                     NUMERIC (10)  NULL,
    [is_deleted]                   NUMERIC (1)   NULL,
    CONSTRAINT [PK_fb_mensaje_email_adjuntos_id] PRIMARY KEY CLUSTERED ([fb_mensaje_email_adjuntos_id] ASC)
);


GO

