CREATE TABLE [dbo].[inc_asigna_verificador] (
    [inc_asigna_verificador_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                    VARCHAR (50)  NULL,
    [nombre]                    VARCHAR (100) NULL,
    [estado]                    NUMERIC (1)   NULL,
    [fb_uea_pe_id]              NUMERIC (10)  NULL,
    [created]                   DATETIME      NULL,
    [created_by]                NUMERIC (10)  NULL,
    [updated]                   DATETIME      NULL,
    [updated_by]                NUMERIC (10)  NULL,
    [owner_id]                  NUMERIC (10)  NULL,
    [is_deleted]                NUMERIC (1)   NULL,
    CONSTRAINT [inc_asigna_verificador_id] PRIMARY KEY CLUSTERED ([inc_asigna_verificador_id] ASC)
);


GO

