CREATE TABLE [dbo].[sol_instalacion_base_datos] (
    [sol_instalacion_base_datos_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [sol_instalacion_id]            NUMERIC (10)  NULL,
    [codigo]                        VARCHAR (50)  NULL,
    [nombre]                        VARCHAR (200) NULL,
    [servidor]                      VARCHAR (200) NULL,
    [observacion]                   VARCHAR (599) NULL,
    [estado]                        NUMERIC (1)   NULL,
    [created]                       DATETIME      NULL,
    [created_by]                    NUMERIC (10)  NULL,
    [updated]                       DATETIME      NULL,
    [updated_by]                    NUMERIC (10)  NULL,
    [owner_id]                      NUMERIC (10)  NULL,
    [is_deleted]                    NUMERIC (1)   NULL,
    CONSTRAINT [sol_instalacion_base_datos_id] PRIMARY KEY CLUSTERED ([sol_instalacion_base_datos_id] ASC)
);


GO

