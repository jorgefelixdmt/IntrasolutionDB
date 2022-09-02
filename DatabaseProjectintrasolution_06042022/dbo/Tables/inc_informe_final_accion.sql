CREATE TABLE [dbo].[inc_informe_final_accion] (
    [inc_informe_final_accion_id]       NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [inc_informe_final_id]              NUMERIC (10)   NULL,
    [codigo]                            VARCHAR (50)   NULL,
    [inc_tipo_accion_correctiva_inm_id] NUMERIC (10)   NULL,
    [tipo_accion_correctiva_inm_nombre] NVARCHAR (20)  NULL,
    [inc_estado_jerar_calid_id]         NUMERIC (10)   NULL,
    [estado_jerar_calid_nombre]         VARCHAR (200)  NULL,
    [accion_correctiva]                 VARCHAR (4000) NULL,
    [causas_que_corrige]                VARCHAR (100)  NULL,
    [fecha_cumplimiento]                DATETIME       NULL,
    [fb_empleado_id]                    NUMERIC (10)   NULL,
    [empleado_nombre]                   VARCHAR (200)  NULL,
    [empleado_doc]                      VARCHAR (50)   NULL,
    [created]                           DATETIME       NULL,
    [created_by]                        NUMERIC (10)   NULL,
    [updated]                           DATETIME       NULL,
    [updated_by]                        NUMERIC (10)   NULL,
    [owner_id]                          NUMERIC (10)   NULL,
    [is_deleted]                        NUMERIC (1)    NULL,
    CONSTRAINT [PK_inc_informe_final_accion] PRIMARY KEY CLUSTERED ([inc_informe_final_accion_id] ASC)
);


GO

