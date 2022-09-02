CREATE TABLE [dbo].[pa_pase_envio_destinatario] (
    [pa_pase_envio_destinatario_id] NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [fb_contacto_id]                NUMERIC (10) NULL,
    [created]                       DATETIME     NULL,
    [created_by]                    NUMERIC (18) NULL,
    [updated]                       DATETIME     NULL,
    [updated_by]                    NUMERIC (10) NULL,
    [owner_id]                      NUMERIC (10) NULL,
    [is_deleted]                    NUMERIC (10) NULL,
    [pa_pase_envio_id]              NUMERIC (10) NULL
);


GO

