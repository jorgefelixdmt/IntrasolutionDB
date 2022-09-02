CREATE TABLE [dbo].[cap_tema_rol] (
    [cap_tema_rol_id]         NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [cap_tema_id]             NUMERIC (10) NULL,
    [cap_rol_capacitacion_id] NUMERIC (10) NULL,
    [periodicidad]            NVARCHAR (2) NULL,
    [hora_por_ley]            NUMERIC (10) NULL,
    [hora_corp]               NUMERIC (10) NULL,
    [n_veces_ley]             NUMERIC (10) NULL,
    [obligatorio]             NUMERIC (1)  NULL,
    [estado]                  NUMERIC (1)  NULL,
    [created]                 DATETIME     NULL,
    [created_by]              NUMERIC (10) NULL,
    [updated]                 DATETIME     NULL,
    [updated_by]              NUMERIC (10) NULL,
    [owner_id]                NUMERIC (10) NULL,
    [is_deleted]              NUMERIC (1)  NULL,
    [id_Carga]                NUMERIC (10) NULL,
    CONSTRAINT [cap_tema_rol_id] PRIMARY KEY CLUSTERED ([cap_tema_rol_id] ASC)
);


GO

