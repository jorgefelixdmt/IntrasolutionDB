CREATE TABLE [dbo].[pl_pase_log_componente] (
    [pl_pase_log_componente_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [pl_pase_log_id]            NUMERIC (10)  NULL,
    [nombre_componente]         VARCHAR (200) NULL,
    [pl_tipo_componente_id]     NUMERIC (10)  NULL,
    [pl_sub_tipo_componente_id] NUMERIC (10)  NULL,
    [pl_tipo_cambio_id]         NUMERIC (10)  NULL,
    [descripcion_cambio]        VARCHAR (MAX) NULL,
    [autor_cambio]              VARCHAR (200) NULL,
    [fecha_cambio]              DATETIME      NULL,
    [created]                   DATETIME      NULL,
    [created_by]                NUMERIC (10)  NULL,
    [updated]                   DATETIME      NULL,
    [updated_by]                NUMERIC (10)  NULL,
    [owner_id]                  NUMERIC (10)  NULL,
    [is_deleted]                NUMERIC (10)  NULL,
    CONSTRAINT [PK_pl_pase_componente] PRIMARY KEY CLUSTERED ([pl_pase_log_componente_id] ASC)
);


GO

