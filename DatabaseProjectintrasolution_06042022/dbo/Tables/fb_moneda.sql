CREATE TABLE [dbo].[fb_moneda] (
    [fb_moneda_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]       VARCHAR (20)  NULL,
    [nombre]       VARCHAR (100) NULL,
    [estado]       INT           NULL,
    [created]      DATETIME      NULL,
    [created_by]   NUMERIC (10)  NULL,
    [updated]      DATETIME      NULL,
    [updated_by]   NUMERIC (10)  NULL,
    [owner_id]     NUMERIC (10)  NULL,
    [is_deleted]   NUMERIC (1)   NULL,
    CONSTRAINT [PK_fb_moneda] PRIMARY KEY CLUSTERED ([fb_moneda_id] ASC)
);


GO

