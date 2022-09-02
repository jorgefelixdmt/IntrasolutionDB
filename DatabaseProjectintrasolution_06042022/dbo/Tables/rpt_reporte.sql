CREATE TABLE [dbo].[rpt_reporte] (
    [rpt_reporte_id]         INT           IDENTITY (1, 1) NOT NULL,
    [nombre]                 VARCHAR (100) NULL,
    [codigo]                 VARCHAR (100) NULL,
    [nombre_archivo_reporte] VARCHAR (200) NULL,
    [imagen_empresa]         VARCHAR (200) NULL,
    [imagen_reporte]         VARCHAR (200) NULL,
    [rpt_tipo_reporte_id]    INT           NULL,
    [fb_modulo_id]           NUMERIC (10)  NULL,
    [estado]                 NUMERIC (1)   NULL,
    [created]                DATETIME      NULL,
    [created_by]             NUMERIC (10)  NULL,
    [updated]                DATETIME      NULL,
    [updated_by]             NUMERIC (10)  NULL,
    [owner_id]               NUMERIC (10)  NULL,
    [is_deleted]             NUMERIC (1)   NULL,
    CONSTRAINT [PK_rpt_reporte] PRIMARY KEY CLUSTERED ([rpt_reporte_id] ASC)
);


GO

