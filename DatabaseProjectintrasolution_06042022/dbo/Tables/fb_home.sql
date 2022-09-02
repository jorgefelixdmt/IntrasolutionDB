CREATE TABLE [dbo].[fb_home] (
    [fb_home_id]             DECIMAL (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                 VARCHAR (20)  NULL,
    [nombre]                 VARCHAR (100) NULL,
    [descripcion]            VARCHAR (200) NULL,
    [created]                SMALLDATETIME NULL,
    [created_by]             DECIMAL (10)  NULL,
    [updated]                SMALLDATETIME NULL,
    [updated_by]             DECIMAL (10)  NULL,
    [owner_id]               DECIMAL (10)  NULL,
    [is_deleted]             DECIMAL (1)   NULL,
    [estado]                 NUMERIC (10)  NULL,
    [stored_procedure_anhos] VARCHAR (100) NULL
);


GO

