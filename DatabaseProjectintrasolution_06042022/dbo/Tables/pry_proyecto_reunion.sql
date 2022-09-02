CREATE TABLE [dbo].[pry_proyecto_reunion] (
    [pry_proyecto_reunion_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [pry_proyecto_id]         NUMERIC (10)   NULL,
    [pry_tipo_reunion_id]     NUMERIC (10)   NULL,
    [nombre]                  VARCHAR (100)  NULL,
    [fecha_reunion]           DATETIME       NULL,
    [ojetivo]                 VARCHAR (2048) NULL,
    [conclusiones]            VARCHAR (2048) NULL,
    [participantes]           VARCHAR (2048) NULL,
    [acta_reunion]            VARCHAR (1024) NULL,
    [created]                 DATETIME       NULL,
    [created_by]              NUMERIC (10)   NULL,
    [updated]                 DATETIME       NULL,
    [updated_by]              NUMERIC (10)   NULL,
    [owner_id]                NUMERIC (10)   NULL,
    [is_deleted]              NUMERIC (1)    NULL,
    CONSTRAINT [PK_pry_proyecto_reunion] PRIMARY KEY CLUSTERED ([pry_proyecto_reunion_id] ASC)
);


GO

