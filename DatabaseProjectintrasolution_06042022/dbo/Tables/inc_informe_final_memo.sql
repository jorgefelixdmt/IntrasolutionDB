CREATE TABLE [dbo].[inc_informe_final_memo] (
    [inc_informe_final_memo_id]        NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [inc_informe_final_id]             NUMERIC (10)  NULL,
    [fb_empleado_id_empleado_dirigido] NUMERIC (10)  NULL,
    [dirigido_a_nombre]                VARCHAR (200) NULL,
    [dirigido_a_dni]                   VARCHAR (50)  NULL,
    [dirigido_a_cargo]                 VARCHAR (50)  NULL,
    [fb_empleado_id_empleado_deremite] NUMERIC (10)  NULL,
    [deremite_nombre]                  VARCHAR (200) NULL,
    [deremiten_dni]                    VARCHAR (20)  NULL,
    [deremitente_cargo]                VARCHAR (50)  NULL,
    [presentacion]                     VARCHAR (MAX) NULL,
    [created]                          DATETIME      NULL,
    [created_by]                       NUMERIC (10)  NULL,
    [updated]                          DATETIME      NULL,
    [updated_by]                       NUMERIC (10)  NULL,
    [owner_id]                         NUMERIC (10)  NULL,
    [is_deleted]                       NUMERIC (1)   NULL,
    CONSTRAINT [PK_inc_informe_final_memo] PRIMARY KEY CLUSTERED ([inc_informe_final_memo_id] ASC)
);


GO

