CREATE TABLE [dbo].[pry_aprobacion_permiso] (
    [pry_aprobacion_permiso_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [pry_tipo_permiso_id]       NUMERIC (10)  NOT NULL,
    [fecha]                     DATETIME      NULL,
    [descripcion]               VARCHAR (MAX) NULL,
    [hora_solicitada]           VARCHAR (50)  NULL,
    [fecha_aprobacion]          DATETIME      NULL,
    [aprobado_por]              VARCHAR (200) NULL,
    [fecha_revision]            DATETIME      NULL,
    [revisado_por]              VARCHAR (200) NULL,
    [pry_estado_permiso_id]     NUMERIC (10)  NULL,
    [observaciones]             VARCHAR (MAX) NULL,
    [created]                   DATETIME      NULL,
    [created_by]                NUMERIC (10)  NULL,
    [updated]                   DATETIME      NULL,
    [updated_by]                NUMERIC (10)  NULL,
    [owner_id]                  NUMERIC (10)  NULL,
    [is_deleted]                NUMERIC (1)   NULL,
    CONSTRAINT [PK_pry_aprobacion_permiso] PRIMARY KEY CLUSTERED ([pry_aprobacion_permiso_id] ASC)
);


GO

