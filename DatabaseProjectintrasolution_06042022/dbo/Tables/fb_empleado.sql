CREATE TABLE [dbo].[fb_empleado] (
    [fb_empleado_id]              NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]                      VARCHAR (50)   NULL,
    [numero_documento]            VARCHAR (50)   NULL,
    [ruc_empresa]                 VARCHAR (50)   NULL,
    [apellido_paterno]            VARCHAR (50)   NULL,
    [apellido_materno]            VARCHAR (50)   NULL,
    [nombre]                      VARCHAR (50)   NULL,
    [nombreCompleto]              VARCHAR (150)  NULL,
    [direccion]                   VARCHAR (300)  NULL,
    [telefono]                    VARCHAR (50)   NULL,
    [celular]                     VARCHAR (50)   NULL,
    [codigo_compania]             NVARCHAR (20)  NULL,
    [cod_localidad]               VARCHAR (50)   NULL,
    [fb_area_id]                  NUMERIC (10)   NULL,
    [area_codigo]                 NVARCHAR (20)  NULL,
    [area_nombre]                 NVARCHAR (100) NULL,
    [clase_trabajador]            NVARCHAR (20)  NULL,
    [fb_cargo_id]                 NUMERIC (10)   NULL,
    [cargo_nombre]                NVARCHAR (50)  NULL,
    [fb_uea_pe_id]                NUMERIC (10)   NULL,
    [email]                       VARCHAR (150)  NULL,
    [fecha_baja]                  DATETIME       NULL,
    [tipo_documento]              VARCHAR (20)   NULL,
    [is_deleted]                  NUMERIC (1)    NULL,
    [created]                     DATETIME       NULL,
    [fecha_nacimiento]            DATETIME       NULL,
    [fecha_salida]                DATETIME       NULL,
    [cargo_codigo]                VARCHAR (50)   NULL,
    [id_Carga]                    NUMERIC (10)   NULL,
    [seguro_social]               VARCHAR (20)   NULL,
    [ruc_natural]                 VARCHAR (20)   NULL,
    [constancia_alta_temprana]    VARCHAR (400)  NULL,
    [fecha_ingreso]               DATETIME       NULL,
    [sexo]                        VARCHAR (10)   NULL,
    [estado]                      NUMERIC (1)    NULL,
    [created_by]                  NUMERIC (10)   NULL,
    [updated_by]                  NUMERIC (10)   NULL,
    [updated]                     DATETIME       NULL,
    [owner_id]                    NUMERIC (10)   NULL,
    [fb_puesto_trabajo_id]        NUMERIC (10)   NULL,
    [g_rol_empresa_id]            NUMERIC (10)   NULL,
    [fb_empresa_especializada_id] NUMERIC (10)   NULL,
    [estado_civil]                VARCHAR (200)  NULL,
    [puesto_trabajo_codigo]       VARCHAR (50)   NULL,
    [puesto_trabajo_nombre]       VARCHAR (250)  NULL,
    [foto]                        VARCHAR (150)  NULL,
    [archivo]                     VARCHAR (250)  NULL,
    [email_personal]              VARCHAR (200)  NULL,
    [telefono_casa]               VARCHAR (50)   NULL,
    [nombre_contacto]             VARCHAR (200)  NULL,
    [telefono_contacto]           VARCHAR (50)   NULL,
    CONSTRAINT [PK_fb_empleado] PRIMARY KEY CLUSTERED ([fb_empleado_id] ASC)
);


GO




CREATE TRIGGER [dbo].[tr_empleado_update]
   ON  [dbo].[fb_empleado]
   AFTER update 
AS 
BEGIN
declare @nombre varchar(200), @apellido_paterno varchar(200), @apellido_materno varchar(200), @ID NUMERIC(10,0)

IF (UPDATE(nombre) OR UPDATE(apellido_paterno) OR UPDATE(apellido_materno))
 BEGIN
	set @nombre = (select nombre from inserted)
	set @apellido_paterno = (select apellido_paterno from inserted)
	set @apellido_materno = (select apellido_materno from inserted)
	set @ID = (select fb_empleado_id from inserted)

	UPDATE fb_empleado
	SET nombreCompleto = @apellido_paterno + ' ' + @apellido_materno + ', ' + @nombre
	WHERE fb_empleado_id = @ID
 END

END

GO

