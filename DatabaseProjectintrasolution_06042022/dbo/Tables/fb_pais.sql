CREATE TABLE [dbo].[fb_pais] (
    [fb_pais_id]   NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]       VARCHAR (50)  NULL,
    [nombre]       VARCHAR (200) NULL,
    [estado]       NUMERIC (1)   NULL,
    [created]      DATETIME      NULL,
    [created_by]   NUMERIC (10)  NULL,
    [updated]      DATETIME      NULL,
    [updated_by]   NUMERIC (10)  NULL,
    [owner_id]     NUMERIC (10)  NULL,
    [is_deleted]   NUMERIC (1)   NULL,
    [orden]        NUMERIC (10)  NULL,
    [nacionalidad] VARCHAR (200) NULL,
    CONSTRAINT [PK_fb_pais] PRIMARY KEY CLUSTERED ([fb_pais_id] ASC)
);


GO

