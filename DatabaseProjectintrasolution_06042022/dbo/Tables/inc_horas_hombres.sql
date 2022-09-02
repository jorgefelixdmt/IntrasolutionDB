CREATE TABLE [dbo].[inc_horas_hombres] (
    [inc_horas_hombres_id]        NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [anno]                        VARCHAR (10) NULL,
    [mes]                         VARCHAR (50) NULL,
    [fb_empresa_especializada_id] NUMERIC (10) NULL,
    [n_obreros]                   NUMERIC (10) NULL,
    [hh_obreros]                  NUMERIC (10) NULL,
    [n_empleados]                 NUMERIC (10) NULL,
    [hh_empleados]                NUMERIC (10) NULL,
    [fb_uea_pe_id]                NUMERIC (10) NULL,
    [created]                     DATETIME     NULL,
    [created_by]                  NUMERIC (10) NULL,
    [updated]                     DATETIME     NULL,
    [updated_by]                  NUMERIC (10) NULL,
    [owner_id]                    NUMERIC (10) NULL,
    [is_deleted]                  NUMERIC (1)  NULL,
    CONSTRAINT [PK_inc_horas_hombres] PRIMARY KEY CLUSTERED ([inc_horas_hombres_id] ASC)
);


GO

