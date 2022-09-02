CREATE TABLE [dbo].[inc_segun_tipo_temporal] (
    [inc_segun_tipo_temporal_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fb_uea_pe_id]               NUMERIC (10)  NULL,
    [codigo]                     VARCHAR (50)  NULL,
    [nombre]                     VARCHAR (100) NULL,
    [codigo_gobierno]            VARCHAR (50)  NULL,
    [activo]                     VARCHAR (50)  NULL,
    [activo_id]                  NUMERIC (1)   NULL,
    [num_row]                    NUMERIC (10)  NULL,
    [id_carga]                   NUMERIC (10)  NULL,
    [descripcion_error]          VARCHAR (200) NULL,
    [fb_usuario_id]              NUMERIC (10)  NULL,
    [flag_Error]                 NUMERIC (1)   NULL
);


GO

