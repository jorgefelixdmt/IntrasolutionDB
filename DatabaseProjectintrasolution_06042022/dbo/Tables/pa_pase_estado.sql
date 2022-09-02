CREATE TABLE [dbo].[pa_pase_estado] (
    [pa_pase_estado_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]            VARCHAR (50)  NULL,
    [nombre]            VARCHAR (150) NULL,
    [orden]             NUMERIC (10)  NULL,
    [estado]            NUMERIC (1)   NULL,
    [created]           DATETIME      NULL,
    [created_by]        NUMERIC (10)  NULL,
    [updated]           DATETIME      NULL,
    [updated_by]        NUMERIC (10)  NULL,
    [owner_id]          NUMERIC (10)  NULL,
    [is_deleted]        NUMERIC (10)  NULL,
    CONSTRAINT [PK_pa_pase_estado] PRIMARY KEY CLUSTERED ([pa_pase_estado_id] ASC)
);


GO

