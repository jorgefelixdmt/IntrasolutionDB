CREATE TABLE [dbo].[exa_datos_medico_temporal_detalle] (
    [exa_datos_medico_temporal_detalle_id] NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [exa_datos_medico_temporal_id]         NUMERIC (10)    NULL,
    [codigo_trabajador]                    VARCHAR (50)    NULL,
    [n_documento_identidad]                VARCHAR (50)    NULL,
    [apellido_nombre]                      VARCHAR (150)   NULL,
    [fecha_examen]                         DATETIME        NULL,
    [talla]                                NUMERIC (10, 2) NULL,
    [peso]                                 NUMERIC (10, 2) NULL,
    [imc]                                  NUMERIC (10, 2) NULL,
    [clasificacion_imc]                    VARCHAR (150)   NULL,
    [enfermedad_patalogica]                VARCHAR (500)   NULL,
    [detalle_patalogico]                   VARCHAR (500)   NULL,
    [estado]                               NUMERIC (1)     NULL,
    [created]                              DATETIME        NULL,
    [created_by]                           NUMERIC (10)    NULL,
    [updated]                              DATETIME        NULL,
    [updated_by]                           NUMERIC (10)    NULL,
    [owner_id]                             NUMERIC (10)    NULL,
    [is_deleted]                           NUMERIC (10)    NULL,
    [fb_uea_pe_id]                         NUMERIC (10)    NULL,
    [numero_errores]                       NUMERIC (10)    NULL,
    [errores_encontrados]                  VARCHAR (MAX)   NULL,
    CONSTRAINT [PK_exa_datos_medico_temporal_detalle] PRIMARY KEY CLUSTERED ([exa_datos_medico_temporal_detalle_id] ASC)
);


GO

