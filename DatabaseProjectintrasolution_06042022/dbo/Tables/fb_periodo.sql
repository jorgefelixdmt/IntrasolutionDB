CREATE TABLE [dbo].[fb_periodo] (
    [fb_periodo_id] INT           IDENTITY (1, 1) NOT NULL,
    [codigo]        VARCHAR (100) NULL,
    [nombre]        VARCHAR (100) NULL,
    [tipo]          VARCHAR (100) NULL,
    [estado]        NUMERIC (1)   NULL,
    [created]       DATETIME      NULL,
    [created_by]    NUMERIC (10)  NULL,
    [updated]       DATETIME      NULL,
    [updated_by]    NUMERIC (10)  NULL,
    [owner_id]      NUMERIC (10)  NULL,
    [is_deleted]    NUMERIC (1)   NULL,
    [orden]         NUMERIC (10)  NULL,
    CONSTRAINT [PK_fb_periodo] PRIMARY KEY CLUSTERED ([fb_periodo_id] ASC)
);


GO

