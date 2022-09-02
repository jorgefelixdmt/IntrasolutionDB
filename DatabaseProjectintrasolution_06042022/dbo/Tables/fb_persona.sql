CREATE TABLE [dbo].[fb_persona] (
    [fb_persona_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]        NVARCHAR (50)  NULL,
    [nombre]        NVARCHAR (200) NULL,
    [estado]        NUMERIC (1)    NULL,
    [sc_user_id]    NUMERIC (10)   NULL,
    [created]       DATETIME       NULL,
    [created_by]    NUMERIC (10)   NULL,
    [updated]       DATETIME       NULL,
    [updated_by]    NUMERIC (10)   NULL,
    [owner_id]      NUMERIC (10)   NULL,
    [is_deleted]    NUMERIC (1)    NULL,
    [sexo]          NVARCHAR (2)   NULL,
    CONSTRAINT [PK_fb_persona] PRIMARY KEY CLUSTERED ([fb_persona_id] ASC)
);


GO

