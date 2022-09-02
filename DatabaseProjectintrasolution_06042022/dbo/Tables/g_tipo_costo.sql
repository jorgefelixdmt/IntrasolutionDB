CREATE TABLE [dbo].[g_tipo_costo] (
    [g_tipo_costo_id]      NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [g_categoria_costo_id] NUMERIC (10)    NULL,
    [codigo]               VARCHAR (50)    NULL,
    [nombre]               VARCHAR (200)   NULL,
    [cantidad]             NUMERIC (10)    NULL,
    [costo_unitario]       NUMERIC (15, 2) NULL,
    [sub_total]            NUMERIC (15, 2) NULL,
    [estado]               NUMERIC (1)     NULL,
    [fb_uea_pe_id]         NUMERIC (10)    NULL,
    [created]              DATETIME        NULL,
    [created_by]           NUMERIC (10)    NULL,
    [updated]              DATETIME        NULL,
    [updated_by]           NUMERIC (10)    NULL,
    [owner_id]             NUMERIC (10)    NULL,
    [is_deleted]           NUMERIC (1)     NULL,
    [orden]                NUMERIC (10)    NULL,
    CONSTRAINT [PK_g_tipo_costo] PRIMARY KEY CLUSTERED ([g_tipo_costo_id] ASC)
);


GO

