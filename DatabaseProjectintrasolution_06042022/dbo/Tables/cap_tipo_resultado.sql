CREATE TABLE [dbo].[cap_tipo_resultado] (
    [cap_tipo_resultado_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]                NVARCHAR (50)  NULL,
    [nombre]                NVARCHAR (100) NULL,
    [descripcion]           NVARCHAR (400) NULL,
    [orden]                 NUMERIC (10)   NULL,
    [flag_aprobado]         NUMERIC (1)    NULL,
    [created]               DATETIME       NULL,
    [created_by]            NUMERIC (10)   NULL,
    [updated]               DATETIME       NULL,
    [updated_by]            NUMERIC (10)   NULL,
    [owner_id]              NUMERIC (10)   NULL,
    [is_deleted]            NUMERIC (1)    NULL,
    [id_Carga]              NUMERIC (10)   NULL,
    CONSTRAINT [cap_tipo_resultado_id] PRIMARY KEY CLUSTERED ([cap_tipo_resultado_id] ASC)
);


GO

