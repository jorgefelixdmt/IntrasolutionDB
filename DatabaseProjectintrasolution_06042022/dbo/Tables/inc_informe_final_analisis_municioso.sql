CREATE TABLE [dbo].[inc_informe_final_analisis_municioso] (
    [inc_informe_final_analisis_municioso_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [inc_informe_final_id]                    NUMERIC (10)  NULL,
    [factor_contribuyente]                    VARCHAR (50)  NULL,
    [descripcion]                             VARCHAR (500) NULL,
    [estado]                                  NUMERIC (1)   NULL,
    [created]                                 DATETIME      NULL,
    [created_by]                              NUMERIC (10)  NULL,
    [updated]                                 DATETIME      NULL,
    [updated_by]                              NUMERIC (10)  NULL,
    [owner_id]                                NUMERIC (10)  NULL,
    [is_deleted]                              NUMERIC (1)   NULL,
    CONSTRAINT [PK_inc_informe_final_analisis_municioso] PRIMARY KEY CLUSTERED ([inc_informe_final_analisis_municioso_id] ASC)
);


GO

