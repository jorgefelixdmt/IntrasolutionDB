CREATE TABLE [dbo].[sol_categoria] (
    [sol_categoria_id]            NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                      VARCHAR (50)  NULL,
    [nombre]                      VARCHAR (200) NULL,
    [descripcion]                 VARCHAR (MAX) NULL,
    [orden]                       NUMERIC (10)  NULL,
    [fb_responsable_principal_id] NUMERIC (10)  NULL,
    [fb_responsable_alterno_id]   NUMERIC (10)  NULL,
    [fb_aprobador_principal_id]   NUMERIC (10)  NULL,
    [fb_aprobador_alterno_id]     NUMERIC (10)  NULL,
    [created]                     DATETIME      NULL,
    [created_by]                  NUMERIC (10)  NULL,
    [updated]                     DATETIME      NULL,
    [updated_by]                  NUMERIC (10)  NULL,
    [owner_id]                    NUMERIC (10)  NULL,
    [is_deleted]                  NUMERIC (1)   NULL,
    CONSTRAINT [sol_categoria_id] PRIMARY KEY CLUSTERED ([sol_categoria_id] ASC)
);


GO

