CREATE TABLE [dbo].[cv_caso_sospechoso_sintoma] (
    [cv_caso_sospechoso_sintoma_id] NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [cv_caso_sospechoso_id]         NUMERIC (10) NULL,
    [cv_sintoma_covid_id]           NUMERIC (10) NULL,
    [fecha_inicio]                  DATETIME     NULL,
    [numero_dias]                   NUMERIC (10) NULL,
    [fecha_fin]                     DATETIME     NULL,
    [created]                       DATETIME     NULL,
    [created_by]                    NUMERIC (10) NULL,
    [updated]                       DATETIME     NULL,
    [updated_by]                    NUMERIC (10) NULL,
    [owner_id]                      NUMERIC (10) NULL,
    [is_deleted]                    NUMERIC (1)  NULL,
    CONSTRAINT [PK_cv_caso_sospecho_sintoma] PRIMARY KEY CLUSTERED ([cv_caso_sospechoso_sintoma_id] ASC)
);


GO

