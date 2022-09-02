CREATE TABLE [dbo].[g_tipo_cambio] (
    [g_tipo_cambio_id] NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [g_moneda_id]      NUMERIC (10) NULL,
    [fecha]            DATETIME     NULL,
    [cambio_soles]     NUMERIC (20) NULL,
    [estado]           NUMERIC (1)  NULL,
    [owner_id]         NUMERIC (10) NULL,
    [created]          DATETIME     NULL,
    [created_by]       NUMERIC (10) NULL,
    [updated]          DATETIME     NULL,
    [updated_by]       NUMERIC (10) NULL,
    [is_deleted]       NUMERIC (1)  NULL
);


GO

