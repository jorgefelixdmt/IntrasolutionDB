CREATE TABLE [dbo].[fb_portlet] (
    [fb_portlet_id] DECIMAL (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]        VARCHAR (40)  NULL,
    [nombre]        VARCHAR (200) NULL,
    [titulo]        VARCHAR (100) NULL,
    [tipo]          VARCHAR (100) NULL,
    [file_JS]       VARCHAR (100) NULL,
    [file_CSS]      VARCHAR (100) NULL,
    [file_ASP]      VARCHAR (100) NULL,
    [flag_expand]   CHAR (1)      NULL,
    [flag_download] CHAR (1)      NULL,
    [flag_reload]   CHAR (1)      NULL,
    [created]       SMALLDATETIME NULL,
    [created_by]    DECIMAL (10)  NULL,
    [updated]       SMALLDATETIME NULL,
    [updated_by]    DECIMAL (10)  NULL,
    [owner_id]      DECIMAL (10)  NULL,
    [is_deleted]    DECIMAL (1)   NULL,
    [descripcion]   VARCHAR (MAX) NULL,
    [estado]        NUMERIC (10)  NULL,
    [archivo]       VARCHAR (200) NULL
);


GO

