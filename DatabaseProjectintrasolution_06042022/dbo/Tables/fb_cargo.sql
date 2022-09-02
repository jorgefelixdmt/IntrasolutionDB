CREATE TABLE [dbo].[fb_cargo] (
    [fb_cargo_id]  NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]       VARCHAR (50)  NULL,
    [nombre]       VARCHAR (400) NULL,
    [estado]       NUMERIC (1)   NULL,
    [created]      DATETIME      NULL,
    [created_by]   NUMERIC (10)  NULL,
    [updated]      DATETIME      NULL,
    [updated_by]   NUMERIC (10)  NULL,
    [owner_id]     NUMERIC (10)  NULL,
    [is_deleted]   NUMERIC (1)   NULL,
    [fb_uea_pe_id] NUMERIC (10)  NULL,
    [id_Carga]     NUMERIC (10)  NULL,
    CONSTRAINT [PK_fb_cargo] PRIMARY KEY CLUSTERED ([fb_cargo_id] ASC)
);


GO

