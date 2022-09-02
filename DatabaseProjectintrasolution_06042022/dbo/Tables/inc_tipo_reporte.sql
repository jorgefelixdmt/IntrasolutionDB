CREATE TABLE [dbo].[inc_tipo_reporte] (
    [inc_tipo_reporte_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]              VARCHAR (50)  NULL,
    [nombre]              VARCHAR (100) NULL,
    [prioridad]           NUMERIC (2)   NULL,
    [estado]              NUMERIC (1)   NULL,
    [created]             DATETIME      NULL,
    [created_by]          NUMERIC (10)  NULL,
    [updated]             DATETIME      NULL,
    [updated_by]          NUMERIC (10)  NULL,
    [owner_id]            NUMERIC (10)  NULL,
    [is_deleted]          NUMERIC (10)  NULL,
    [Abreviatura]         VARCHAR (25)  NULL,
    [tipo_reporte]        NUMERIC (1)   NULL,
    [orden]               NUMERIC (10)  NULL,
    CONSTRAINT [inc_tipo_reporte_id] PRIMARY KEY CLUSTERED ([inc_tipo_reporte_id] ASC)
);


GO

