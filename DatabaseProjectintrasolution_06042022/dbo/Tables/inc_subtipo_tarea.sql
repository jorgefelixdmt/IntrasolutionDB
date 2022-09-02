CREATE TABLE [dbo].[inc_subtipo_tarea] (
    [inc_subtipo_tarea_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [inc_tipo_tarea_id]    NUMERIC (10)  NULL,
    [codigo]               VARCHAR (50)  NULL,
    [nombre]               VARCHAR (200) NULL,
    [orden]                NUMERIC (10)  NULL,
    [estado]               NUMERIC (1)   NULL,
    [created]              DATETIME      NULL,
    [created_by]           NUMERIC (10)  NULL,
    [updated]              DATETIME      NULL,
    [updated_by]           NUMERIC (10)  NULL,
    [owner_id]             NUMERIC (10)  NULL,
    [is_deleted]           NUMERIC (1)   NULL
);


GO

