CREATE TABLE [dbo].[cap_tema] (
    [cap_tema_id]              NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                   VARCHAR (50)  NULL,
    [nombre]                   VARCHAR (100) NULL,
    [descripcion]              VARCHAR (400) NULL,
    [hora_por_ley]             NUMERIC (10)  NULL,
    [cap_tipo_tema_id]         NUMERIC (10)  NULL,
    [estado]                   NUMERIC (1)   NULL,
    [fb_uea_pe_id]             NUMERIC (10)  NULL,
    [cap_tipo_capacitacion_id] NUMERIC (10)  NULL,
    [fb_empresa_id]            NUMERIC (10)  NULL,
    [orden]                    NUMERIC (10)  NULL,
    [created]                  DATETIME      NULL,
    [created_by]               NUMERIC (10)  NULL,
    [updated]                  DATETIME      NULL,
    [updated_by]               NUMERIC (10)  NULL,
    [owner_id]                 NUMERIC (10)  NULL,
    [is_deleted]               NUMERIC (1)   NULL,
    [id_carga]                 NUMERIC (10)  NULL,
    CONSTRAINT [cap_tema_id] PRIMARY KEY CLUSTERED ([cap_tema_id] ASC)
);


GO

