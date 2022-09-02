CREATE TABLE [dbo].[fb_puesto_trabajo] (
    [fb_puesto_trabajo_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]               VARCHAR (50)  NULL,
    [nombre]               VARCHAR (100) NULL,
    [fb_cargo_id]          NUMERIC (10)  NULL,
    [fb_area_id]           NUMERIC (10)  NULL,
    [fb_uea_pe_id]         NUMERIC (10)  NULL,
    [estado]               NUMERIC (1)   NULL,
    [orden]                NUMERIC (10)  NULL,
    [created]              DATETIME      NULL,
    [created_by]           NUMERIC (10)  NULL,
    [updated]              DATETIME      NULL,
    [updated_by]           NUMERIC (10)  NULL,
    [owner_id]             NUMERIC (10)  NULL,
    [is_deleted]           NUMERIC (1)   NULL,
    [id_carga]             NUMERIC (10)  NULL,
    CONSTRAINT [fb_puesto_trabajo_id] PRIMARY KEY CLUSTERED ([fb_puesto_trabajo_id] ASC),
    CONSTRAINT [fk_pt_fb_cargo_id] FOREIGN KEY ([fb_cargo_id]) REFERENCES [dbo].[fb_cargo] ([fb_cargo_id])
);


GO

