CREATE TABLE [dbo].[inc_costo] (
    [inc_costo_id]      NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]            VARCHAR (50)  NULL,
    [inc_tipo_costo_id] NUMERIC (10)  NULL,
    [descripcion]       VARCHAR (200) NULL,
    [costo]             VARCHAR (50)  NULL,
    [orden]             NUMERIC (2)   NULL,
    [created]           DATETIME      NULL,
    [created_by]        NUMERIC (10)  NULL,
    [updated]           DATETIME      NULL,
    [updated_by]        NUMERIC (10)  NULL,
    [owner_id]          NUMERIC (10)  NULL,
    [is_deleted]        NUMERIC (1)   NULL,
    [version]           VARCHAR (50)  NULL,
    CONSTRAINT [PK_inc_costo] PRIMARY KEY CLUSTERED ([inc_costo_id] ASC)
);


GO

