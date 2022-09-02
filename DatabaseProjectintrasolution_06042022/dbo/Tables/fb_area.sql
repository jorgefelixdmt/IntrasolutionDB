CREATE TABLE [dbo].[fb_area] (
    [fb_area_id]      NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [fb_uea_pe_id]    NUMERIC (10)    NULL,
    [codigo]          NVARCHAR (50)   NULL,
    [nombre]          NVARCHAR (50)   NULL,
    [estado]          NUMERIC (1)     NULL,
    [created]         DATETIME        NULL,
    [created_by]      NUMERIC (10)    NULL,
    [updated]         DATETIME        NULL,
    [updated_by]      NUMERIC (10)    NULL,
    [owner_id]        NUMERIC (10)    NULL,
    [is_deleted]      NUMERIC (1)     NULL,
    [fb_area_base_id] NUMERIC (15, 5) NULL,
    [id_carga]        NUMERIC (10)    NULL,
    [fb_empresa_id]   NUMERIC (10)    NULL,
    CONSTRAINT [PK_fb_area] PRIMARY KEY CLUSTERED ([fb_area_id] ASC)
);


GO

