CREATE TABLE [dbo].[pa_carga_lista_objetos] (
    [pa_carga_lista_objetos_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                    VARCHAR (20)  NULL,
    [fecha]                     DATETIME      NULL,
    [hora]                      VARCHAR (25)  NULL,
    [operador]                  VARCHAR (200) NULL,
    [correo_operador]           VARCHAR (200) NULL,
    [nombre_archivo]            VARCHAR (MAX) NULL,
    [ruta_archivo]              VARCHAR (MAX) NULL,
    [fb_uea_pe_id]              NUMERIC (10)  NULL,
    [estado]                    NUMERIC (1)   NULL,
    [created]                   DATETIME      NULL,
    [created_by]                NUMERIC (10)  NULL,
    [updated]                   DATETIME      NULL,
    [updated_by]                NUMERIC (10)  NULL,
    [owner_id]                  NUMERIC (10)  NULL,
    [is_deleted]                NUMERIC (1)   NULL,
    CONSTRAINT [PK_fb_carga_lista_objetos] PRIMARY KEY CLUSTERED ([pa_carga_lista_objetos_id] ASC)
);


GO

