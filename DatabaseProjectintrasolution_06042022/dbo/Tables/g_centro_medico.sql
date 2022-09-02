CREATE TABLE [dbo].[g_centro_medico] (
    [g_centro_medico_id]  NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [razon_social]        NVARCHAR (500) NULL,
    [ruc_centro_medico]   NVARCHAR (20)  NULL,
    [codigo]              NVARCHAR (50)  NULL,
    [representante_legal] NVARCHAR (200) NULL,
    [direccion]           NVARCHAR (200) NULL,
    [telefono_1]          NVARCHAR (100) NULL,
    [telefono_2]          NVARCHAR (100) NULL,
    [descripcion]         NVARCHAR (300) NULL,
    [fax]                 NVARCHAR (50)  NULL,
    [email]               NVARCHAR (50)  NULL,
    [url]                 NVARCHAR (100) NULL,
    [movil]               NVARCHAR (50)  NULL,
    [estado]              NUMERIC (1)    NULL,
    [created]             DATETIME       NULL,
    [created_by]          NUMERIC (10)   NULL,
    [updated]             DATETIME       NULL,
    [updated_by]          NUMERIC (10)   NULL,
    [owner_id]            NUMERIC (10)   NULL,
    [is_deleted]          NUMERIC (1)    NULL,
    CONSTRAINT [PK_g_centro_medico] PRIMARY KEY CLUSTERED ([g_centro_medico_id] ASC)
);


GO

