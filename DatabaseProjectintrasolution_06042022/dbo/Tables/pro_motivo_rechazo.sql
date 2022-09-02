CREATE TABLE [dbo].[pro_motivo_rechazo] (
    [pro_motivo_rechazo_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]                VARCHAR (100)  NULL,
    [nombre]                VARCHAR (150)  NULL,
    [descripcion]           VARCHAR (1024) NULL,
    [estado]                NUMERIC (1)    NULL,
    [orden]                 NUMERIC (10)   NULL,
    [created]               DATETIME       NULL,
    [created_by]            NUMERIC (10)   NULL,
    [updated]               DATETIME       NULL,
    [updated_by]            NUMERIC (10)   NULL,
    [owner_id]              NUMERIC (10)   NULL,
    [is_deleted]            NUMERIC (1)    NULL,
    CONSTRAINT [PK_pro_motivo_rechazo] PRIMARY KEY CLUSTERED ([pro_motivo_rechazo_id] ASC)
);


GO

