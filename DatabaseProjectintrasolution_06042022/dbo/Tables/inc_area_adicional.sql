CREATE TABLE [dbo].[inc_area_adicional] (
    [inc_area_adicional_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                VARCHAR (50)  NULL,
    [nombre]                VARCHAR (200) NULL,
    [estado]                NUMERIC (1)   NULL,
    [created]               DATETIME      NULL,
    [created_by]            NUMERIC (10)  NULL,
    [updated]               DATETIME      NULL,
    [updated_by]            NUMERIC (10)  NULL,
    [owner_id]              NUMERIC (10)  NULL,
    [is_deleted]            NUMERIC (1)   NULL,
    CONSTRAINT [PK_inc_area_adicional] PRIMARY KEY CLUSTERED ([inc_area_adicional_id] ASC)
);


GO

