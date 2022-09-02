CREATE TABLE [dbo].[inc_incidente_archivo] (
    [inc_incidente_archivo_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [inc_incidencia_id]        NUMERIC (10)  NULL,
    [fecha_documento]          DATETIME      NULL,
    [titulo]                   VARCHAR (200) NULL,
    [descripcion]              VARCHAR (MAX) NULL,
    [archivo]                  VARCHAR (200) NULL,
    [created]                  DATETIME      NULL,
    [created_by]               NUMERIC (10)  NULL,
    [updated]                  DATETIME      NULL,
    [updated_by]               NUMERIC (10)  NULL,
    [owner_id]                 NUMERIC (10)  NULL,
    [is_deleted]               NUMERIC (1)   NULL,
    CONSTRAINT [PK_inc_incidente_archivo] PRIMARY KEY CLUSTERED ([inc_incidente_archivo_id] ASC)
);


GO

