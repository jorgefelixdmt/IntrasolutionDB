CREATE TABLE [dbo].[g_tipo_causa] (
    [g_tipo_causa_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]          NVARCHAR (50)  NULL,
    [descripcion]     NVARCHAR (200) NULL,
    [estado]          NUMERIC (1)    NULL,
    [codigoREL]       VARCHAR (50)   NULL,
    [nivel]           NUMERIC (5)    NULL,
    [metodologia]     VARCHAR (10)   NULL,
    [owner_id]        NUMERIC (10)   NULL,
    [created]         DATETIME       NULL,
    [created_by]      NUMERIC (10)   NULL,
    [updated]         DATETIME       NULL,
    [updated_by]      NUMERIC (10)   NULL,
    [is_deleted]      NUMERIC (1)    NULL,
    [orden]           NUMERIC (10)   NULL,
    CONSTRAINT [PK_g_tipo_causa] PRIMARY KEY CLUSTERED ([g_tipo_causa_id] ASC)
);


GO

