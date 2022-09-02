CREATE TABLE [dbo].[pa_pase_actividad] (
    [pa_pase_actividad_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]               VARCHAR (150)  NULL,
    [nombre]               VARCHAR (150)  NULL,
    [descripcion]          VARCHAR (1024) NULL,
    [orden]                NUMERIC (10)   NULL,
    [estado]               NUMERIC (1)    NULL,
    [created]              DATETIME       NULL,
    [created_by]           NUMERIC (10)   NULL,
    [updated]              DATETIME       NULL,
    [updated_by]           NUMERIC (10)   NULL,
    [owner_id]             NUMERIC (10)   NULL,
    [is_deleted]           NUMERIC (10)   NULL,
    CONSTRAINT [PK_pa_pase_actividad] PRIMARY KEY CLUSTERED ([pa_pase_actividad_id] ASC)
);


GO

