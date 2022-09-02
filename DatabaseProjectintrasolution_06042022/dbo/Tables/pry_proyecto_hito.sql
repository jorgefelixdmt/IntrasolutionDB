CREATE TABLE [dbo].[pry_proyecto_hito] (
    [pry_proyecto_hito_id]     NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [pry_proyecto_id]          NUMERIC (10)    NULL,
    [numero_hito]              VARCHAR (20)    NULL,
    [titulo]                   VARCHAR (200)   NULL,
    [descripcion]              VARCHAR (2048)  NULL,
    [entregables]              VARCHAR (2048)  NULL,
    [inicio_planificado]       DATETIME        NULL,
    [fin_planificado]          DATETIME        NULL,
    [inicio_real]              DATETIME        NULL,
    [fin_real]                 DATETIME        NULL,
    [porcentaje]               NUMERIC (10)    NULL,
    [monto]                    NUMERIC (19, 4) NULL,
    [archivo_informe_hito]     VARCHAR (255)   NULL,
    [archivo_hes_hito]         VARCHAR (255)   NULL,
    [archivo_acta_conformidad] VARCHAR (255)   NULL,
    [archivo_factura_hito]     VARCHAR (255)   NULL,
    [estado]                   INT             NULL,
    [pry_estado_hito_id]       NUMERIC (10)    NULL,
    [created]                  DATETIME        NULL,
    [created_by]               NUMERIC (10)    NULL,
    [updated]                  DATETIME        NULL,
    [updated_by]               NUMERIC (10)    NULL,
    [owner_id]                 NUMERIC (10)    NULL,
    [is_deleted]               NUMERIC (1)     NULL,
    CONSTRAINT [PK_pry_proyecto_hito] PRIMARY KEY CLUSTERED ([pry_proyecto_hito_id] ASC)
);


GO

