CREATE TABLE [dbo].[inc_informe_factor_riesgo] (
    [inc_informe_factor_riesgo_id]       NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [inc_informe_final_id]               NUMERIC (10) NULL,
    [inc_factor_riesgo_id]               NUMERIC (10) NULL,
    [inc_factor_riesgo_clasificacion_id] NUMERIC (10) NULL,
    [inc_factor_riesgo_dano_id]          NUMERIC (10) NULL,
    [estado]                             NUMERIC (1)  NULL,
    [created]                            DATETIME     NULL,
    [created_by]                         NUMERIC (10) NULL,
    [updated]                            DATETIME     NULL,
    [updated_by]                         NUMERIC (10) NULL,
    [owner_id]                           NUMERIC (10) NULL,
    [is_deleted]                         NUMERIC (1)  NULL,
    CONSTRAINT [PK_inc_informe_factor_riesgo] PRIMARY KEY CLUSTERED ([inc_informe_factor_riesgo_id] ASC)
);


GO

