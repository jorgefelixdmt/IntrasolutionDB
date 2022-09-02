CREATE TABLE [dbo].[fb_procesos_log] (
    [fb_procesos_log_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo_proceso]     VARCHAR (MAX) NULL,
    [fechahora]          DATETIME      NULL,
    [created]            DATETIME      NULL,
    [created_by]         NUMERIC (10)  NULL,
    [updated]            DATETIME      NULL,
    [updated_by]         NUMERIC (10)  NULL,
    [owner_id]           NUMERIC (10)  NULL,
    [is_deleted]         NUMERIC (1)   NULL,
    [ejecutado]          NUMERIC (1)   NULL,
    CONSTRAINT [PK_fb_proceso_log] PRIMARY KEY CLUSTERED ([fb_procesos_log_id] ASC)
);


GO

