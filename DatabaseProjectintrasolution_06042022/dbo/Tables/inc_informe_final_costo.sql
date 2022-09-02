CREATE TABLE [dbo].[inc_informe_final_costo] (
    [inc_informe_final_costo_id] NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [inc_informe_final_id]       NUMERIC (10)    NULL,
    [g_categoria_costo_id]       NUMERIC (10)    NULL,
    [g_tipo_costo_id]            NUMERIC (10)    NULL,
    [observacion]                VARCHAR (4000)  NULL,
    [archivo]                    VARCHAR (400)   NULL,
    [cantidad]                   NUMERIC (15, 3) NULL,
    [costo_unitario]             NUMERIC (15, 3) NULL,
    [sub_total]                  NUMERIC (15, 3) NULL,
    [estado]                     NUMERIC (1)     NULL,
    [created]                    DATETIME        NULL,
    [created_by]                 NUMERIC (10)    NULL,
    [updated]                    DATETIME        NULL,
    [updated_by]                 NUMERIC (10)    NULL,
    [owner_id]                   NUMERIC (10)    NULL,
    [is_deleted]                 NUMERIC (1)     NULL,
    CONSTRAINT [PK_inc_informe_final_costo] PRIMARY KEY CLUSTERED ([inc_informe_final_costo_id] ASC)
);


GO

