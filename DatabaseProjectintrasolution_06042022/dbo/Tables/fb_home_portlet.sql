CREATE TABLE [dbo].[fb_home_portlet] (
    [fb_home_portlet_id] DECIMAL (10) IDENTITY (1, 1) NOT NULL,
    [fb_home_id]         DECIMAL (10) NULL,
    [fb_portlet_id]      DECIMAL (10) NULL,
    [Color]              VARCHAR (50) NULL,
    [Orden_fila]         INT          NULL,
    [Orden_columna]      INT          NULL,
    [flag_header]        INT          NULL,
    [ancho]              INT          NULL,
    [altura]             VARCHAR (50) NULL,
    [created]            DATETIME     NULL,
    [created_by]         DECIMAL (10) NULL,
    [updated]            DATETIME     NULL,
    [updated_by]         DECIMAL (10) NULL,
    [owner_id]           DECIMAL (10) NULL,
    [is_deleted]         DECIMAL (1)  NULL,
    [estado]             NUMERIC (10) NULL
);


GO

