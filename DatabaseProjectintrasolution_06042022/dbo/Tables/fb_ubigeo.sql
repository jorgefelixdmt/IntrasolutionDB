CREATE TABLE [dbo].[fb_ubigeo] (
    [fb_ubigeo_id]    NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]          NVARCHAR (50)  NULL,
    [created]         DATETIME       NULL,
    [created_by]      NUMERIC (10)   NULL,
    [updated]         DATETIME       NULL,
    [updated_by]      NUMERIC (10)   NULL,
    [owner_id]        NUMERIC (10)   NULL,
    [departamento_id] NUMERIC (10)   NULL,
    [provincia_id]    NUMERIC (10)   NULL,
    [distrito_id]     NUMERIC (10)   NULL,
    [nombre]          NVARCHAR (200) NULL,
    [concatenado]     NVARCHAR (400) NULL,
    [is_deleted]      NUMERIC (1)    NULL,
    CONSTRAINT [PK_fb_ubigeo] PRIMARY KEY CLUSTERED ([fb_ubigeo_id] ASC)
);


GO

