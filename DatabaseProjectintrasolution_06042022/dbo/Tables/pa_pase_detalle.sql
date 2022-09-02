CREATE TABLE [dbo].[pa_pase_detalle] (
    [pa_pase_detalle_id]   NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [pa_pase_id]           NUMERIC (10)   NULL,
    [codigo]               VARCHAR (50)   NULL,
    [nombre]               VARCHAR (200)  NULL,
    [fb_responsable_id]    NUMERIC (10)   NULL,
    [pa_pase_actividad_id] NUMERIC (10)   NULL,
    [flag_error]           NUMERIC (1)    NULL,
    [descripcion]          VARCHAR (1024) NULL,
    [estado]               NUMERIC (10)   NULL,
    [created]              DATETIME       NULL,
    [created_by]           NUMERIC (10)   NULL,
    [updated]              DATETIME       NULL,
    [updated_by]           NUMERIC (10)   NULL,
    [owner_id]             NUMERIC (10)   NULL,
    [is_deleted]           NUMERIC (10)   NULL,
    CONSTRAINT [PK_pa_pase_detalle] PRIMARY KEY CLUSTERED ([pa_pase_detalle_id] ASC)
);


GO

