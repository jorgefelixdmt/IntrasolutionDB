CREATE TABLE [dbo].[pa_carga_lista_objetos_detalle] (
    [pa_carga_lista_objetos_detalle_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [nombre_objeto]                     VARCHAR (150) NULL,
    [categoria_objeto]                  VARCHAR (150) NULL,
    [tipo_objeto]                       VARCHAR (100) NULL,
    [objeto_relacionado]                VARCHAR (150) NULL,
    [evento_relacionado]                VARCHAR (150) NULL,
    [cliente]                           VARCHAR (150) NULL,
    [codigo_jira_incidente]             VARCHAR (150) NULL,
    [codigo_jira_pase]                  VARCHAR (150) NULL,
    [codigo_is_incidente]               VARCHAR (150) NULL,
    [programador]                       VARCHAR (150) NULL,
    [tipo_cambio]                       VARCHAR (150) NULL,
    [comentario]                        VARCHAR (MAX) NULL,
    [comentario_cabecera]               VARCHAR (MAX) NULL,
    [fb_uea_pe_id]                      NUMERIC (10)  NULL,
    [estado]                            NUMERIC (1)   NULL,
    [created]                           DATETIME      NULL,
    [created_by]                        NUMERIC (10)  NULL,
    [updated]                           DATETIME      NULL,
    [updated_by]                        NUMERIC (10)  NULL,
    [owner_id]                          NUMERIC (10)  NULL,
    [is_deleted]                        NUMERIC (1)   NULL,
    [pa_carga_lista_objetos_id]         NUMERIC (10)  NULL,
    [numero_errores]                    NUMERIC (10)  NULL,
    [errores_encontrados]               VARCHAR (500) NULL,
    CONSTRAINT [PK_pa_carga_lista_objetos_detalle] PRIMARY KEY CLUSTERED ([pa_carga_lista_objetos_detalle_id] ASC)
);


GO

