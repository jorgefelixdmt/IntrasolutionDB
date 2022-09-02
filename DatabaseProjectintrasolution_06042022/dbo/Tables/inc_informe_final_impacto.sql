CREATE TABLE [dbo].[inc_informe_final_impacto] (
    [inc_informe_final_impacto_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [inc_informe_final_id]         NUMERIC (10)  NULL,
    [ausentismo_incapacidad]       VARCHAR (20)  NULL,
    [descripcion_ausentismo]       VARCHAR (500) NULL,
    [tiempos_tercero]              VARCHAR (20)  NULL,
    [descripcion_tiempo_tercero]   VARCHAR (500) NULL,
    [dano_material_obra]           VARCHAR (20)  NULL,
    [descripcion_dano_material]    VARCHAR (500) NULL,
    [dano_epp]                     VARCHAR (20)  NULL,
    [descripcion_dano_epp]         VARCHAR (500) NULL,
    [dano_herramienta]             VARCHAR (20)  NULL,
    [descripcion_dano_herramienta] VARCHAR (500) NULL,
    [dano_edificio]                VARCHAR (20)  NULL,
    [descripcion_dano_edificio]    VARCHAR (500) NULL,
    [tiempo_perdido_proyecto]      VARCHAR (20)  NULL,
    [descripcion_tiempo_perdido]   VARCHAR (500) NULL,
    [dano_medio_ambiente]          VARCHAR (20)  NULL,
    [descripcion_dano_ambiente]    VARCHAR (500) NULL,
    [materiales_primeros_auxilios] VARCHAR (20)  NULL,
    [descripcion_primero_auxilio]  VARCHAR (500) NULL,
    [otros]                        VARCHAR (20)  NULL,
    [descripcion_otros]            VARCHAR (500) NULL,
    [created]                      DATETIME      NULL,
    [created_by]                   NUMERIC (10)  NULL,
    [updated]                      DATETIME      NULL,
    [updated_by]                   NUMERIC (10)  NULL,
    [owner_id]                     NUMERIC (10)  NULL,
    [is_deleted]                   NUMERIC (1)   NULL,
    CONSTRAINT [PK_inc_informe_final_impacto] PRIMARY KEY CLUSTERED ([inc_informe_final_impacto_id] ASC)
);


GO

