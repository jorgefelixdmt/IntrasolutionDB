CREATE TABLE [dbo].[exa_datos_medico_temporal] (
    [exa_datos_medico_temporal_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                       VARCHAR (20)  NULL,
    [fecha]                        DATETIME      NULL,
    [hora]                         VARCHAR (25)  NULL,
    [operador]                     VARCHAR (200) NULL,
    [correo_operador]              VARCHAR (200) NULL,
    [nombre_archivo]               VARCHAR (200) NULL,
    [ruta_archivo]                 VARCHAR (200) NULL,
    [fb_uea_pe_id]                 NUMERIC (10)  NULL,
    [estado]                       NUMERIC (1)   NULL,
    [created]                      DATETIME      NULL,
    [created_by]                   NUMERIC (10)  NULL,
    [updated]                      DATETIME      NULL,
    [updated_by]                   NUMERIC (10)  NULL,
    [owner_id]                     NUMERIC (10)  NULL,
    [is_deleted]                   NCHAR (10)    NULL,
    CONSTRAINT [PK_exa_datos_medico_temporal] PRIMARY KEY CLUSTERED ([exa_datos_medico_temporal_id] ASC)
);


GO

