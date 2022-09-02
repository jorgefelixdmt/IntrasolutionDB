CREATE TABLE [dbo].[pa_entrega_objetos_estado] (
    [pa_entrega_objetos_estado_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                       VARCHAR (200) NULL,
    [nombre]                       VARCHAR (200) NULL,
    [created]                      DATETIME      NULL,
    [created_by]                   NUMERIC (10)  NULL,
    [updated]                      DATETIME      NULL,
    [updated_by]                   NUMERIC (10)  NULL,
    [owner_id]                     NUMERIC (10)  NULL,
    [is_deleted]                   NUMERIC (1)   NULL
);


GO

