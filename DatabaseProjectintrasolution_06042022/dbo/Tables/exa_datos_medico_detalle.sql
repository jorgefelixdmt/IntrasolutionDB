CREATE TABLE [dbo].[exa_datos_medico_detalle] (
    [exa_datos_medico_detalle_id]  NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [exa_datos_medico_id]          NUMERIC (10)  NULL,
    [exa_enfermedad_patologica_id] NUMERIC (10)  NULL,
    [detalle_patalogico]           VARCHAR (MAX) NULL,
    [created]                      DATETIME      NULL,
    [created_by]                   NUMERIC (10)  NULL,
    [updated]                      DATETIME      NULL,
    [updated_by]                   NUMERIC (10)  NULL,
    [owner_id]                     NUMERIC (10)  NULL,
    [is_deleted]                   NUMERIC (1)   NULL,
    CONSTRAINT [PK_exa_datos_medico_detalle] PRIMARY KEY CLUSTERED ([exa_datos_medico_detalle_id] ASC)
);


GO

