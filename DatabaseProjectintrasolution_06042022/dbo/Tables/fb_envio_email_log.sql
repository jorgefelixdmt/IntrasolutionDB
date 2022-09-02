CREATE TABLE [dbo].[fb_envio_email_log] (
    [fb_envio_email_log_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fb_uea_pe_id]          NUMERIC (10)  NULL,
    [sc_user_id]            NUMERIC (10)  NULL,
    [codigo_email]          VARCHAR (MAX) NULL,
    [perfil]                VARCHAR (MAX) NULL,
    [a_email]               VARCHAR (MAX) NULL,
    [asunto]                VARCHAR (500) NULL,
    [mensaje]               VARCHAR (MAX) NULL,
    [fechahora]             DATETIME      NULL,
    [numero_error]          NUMERIC (10)  NULL,
    [mensaje_error]         VARCHAR (500) NULL,
    [created]               DATETIME      NULL,
    [created_by]            NUMERIC (10)  NULL,
    [updated]               DATETIME      NULL,
    [updated_by]            NUMERIC (10)  NULL,
    [owner_id]              NUMERIC (10)  NULL,
    [is_deleted]            NUMERIC (1)   NULL,
    [estado]                NUMERIC (1)   NULL,
    [origen_id]             NUMERIC (10)  NULL,
    [modulo_id]             NUMERIC (10)  NULL,
    [enviado]               NUMERIC (1)   NULL,
    CONSTRAINT [PK_fb_envio_email_log] PRIMARY KEY CLUSTERED ([fb_envio_email_log_id] ASC)
);


GO

