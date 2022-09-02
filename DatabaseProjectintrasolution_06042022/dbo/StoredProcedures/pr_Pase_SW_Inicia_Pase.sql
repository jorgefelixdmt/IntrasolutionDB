/*      
****************************************************************************************************************************************
Nombre: dbo.pr_Pase_SW_Inicia_Pase
Fecha Creacion: 02/06/2020
Autor: Mauro Roque
Descripcion: store que valida si un pase de software contiene version anterior
Parametros: @ps_pase_id - ID de pase de software,
			@Tipo_Pase - Tipo Pase
			@Version - Version actual del pase
			@Descripcion_Pase - descripcion del pase
			@Flag_Version_Requerida_App - 1 valida si requiere version de la app
			@Version_Requerida_App - version anterior de la app
			@Flag_Version_Requerida_Frw - 1 valida si requiere version del framework
			@Version_Requerida_Frw - version anterior del framework
			@Flag_Version_Requerida_App_Std - 1 valida si requiere version estándar de la app
			@Version_Requerida_App_Std - version anterior estándar de la app

tablas afectadas : pl_pase_log INSERTA
Uso: exec pr_Pase_SW_Inicia_Pase 1,'DMTPAS-541',1,'0.0.2','Pase Dominiotech 542',1,'0.0.1',0,'',0,''
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/ 
CREATE proc [dbo].[pr_Pase_SW_Inicia_Pase]
  @ps_pase_id   numeric(10,0),
  @codigo_jira varchar(50),
  @Tipo_Pase     numeric(10,0), 
  @Version  varchar(32),
  @Descripcion_Pase     varchar(1024),
  @Flag_Version_Requerida_App     int,
  @Version_Requerida_App     varchar(32),
  @Flag_Version_Requerida_Frw     int,
  @Version_Requerida_Frw    varchar(32),
  @Flag_Version_Requerida_App_Std     int,
  @Version_Requerida_App_Std    varchar(32)
AS

DECLARE @Version_Actual_App varchar(32), @Version_Actual_Frw varchar(32), @Version_Actual_App_Std varchar(32)
DECLARE @nombre_tipo_pase varchar(50), @OBSERVACION VARCHAR(500)

SET @nombre_tipo_pase = (SELECT nombre FROM pl_tipo_pase WHERE pl_tipo_pase_id = @Tipo_Pase)

SET @OBSERVACION = CAST(@ps_pase_id AS varchar)+'/'+@nombre_tipo_pase+'/'+@Version+'/'+@Descripcion_Pase+'/'+
					CAST(@Flag_Version_Requerida_App AS varchar)+'/'+@Version_Requerida_App+'/'+
					CAST(@Flag_Version_Requerida_Frw AS varchar)+'/'+@Version_Requerida_Frw+'/'+
					CAST(@Flag_Version_Requerida_App_Std AS varchar)+'/'+@Version_Requerida_App_Std


-- Insert registro de pase_log y coloca estado INICIO.

INSERT INTO pl_pase_log
	VALUES(
	@ps_pase_id,
	@Version,
	@Descripcion_Pase,
	GETDATE(),
	null,
	@codigo_jira,
	GETDATE(),
	GETDATE(),
	@Flag_Version_Requerida_App,
	@Version_Requerida_App,
	@Flag_Version_Requerida_Frw,
	@Version_Requerida_Frw,
	@Flag_Version_Requerida_App_Std,
	@Version_Requerida_App_Std,
	@Tipo_Pase,
	1, -- ESTADO INICIO
	@OBSERVACION,
	GETDATE(),  --created
	1,			--creado por 
	GETDATE(),	--actualizado
	1,			--actualizado por
	1,			--propietario
	0)			--eliminado


-- Valida Version Requerida
IF  @Flag_Version_Requerida_App = 1 
  BEGIN
     SET @Version_Actual_App = (SELECT value FROM pm_parameter WHERE code = 'VERSION')
      IF  @Version_Actual_App <> @Version_Requerida_App
          BEGIN
                 -- Insert registro de pase_log y coloca estado ERROR EN VERSION APP. REQUIERE VERSION + Version_Anterior_App
               
			   	   INSERT INTO pl_pase_log
					VALUES(
					@ps_pase_id,
					@Version,
					@Descripcion_Pase,
					GETDATE(),
					null,
					@codigo_jira,
					GETDATE(),
					GETDATE(),
					@Flag_Version_Requerida_App,
					@Version_Requerida_App,
					@Flag_Version_Requerida_Frw,
					@Version_Requerida_Frw,
					@Flag_Version_Requerida_App_Std,
					@Version_Requerida_App_Std,
					@Tipo_Pase,
					2, -- Error Version
					@OBSERVACION,
					GETDATE(),  --created
					1,			--creado por 
					GETDATE(),	--actualizado
					1,			--actualizado por
					1,			--propietario
					0)			--eliminado
				
				 RAISERROR('La versión de cliente requerida no es la correcta.',16,1)

			     RETURN
          END
  END

IF  @Flag_Version_Requerida_Frw = 1 
  BEGIN
     SET @Version_Actual_Frw = (SELECT value FROM pm_parameter WHERE code = 'VERSION_FRAMEWORK')
      IF  @Version_Actual_Frw <> @Version_Requerida_Frw
          BEGIN
                 -- Insert registro de pase_log y coloca estado ERROR EN VERSION FRAMEWORK
               
			    INSERT INTO pl_pase_log
					VALUES(
					@ps_pase_id,
					@Version,
					@Descripcion_Pase,
					GETDATE(),
					null,
					@codigo_jira,
					GETDATE(),
					GETDATE(),
					@Flag_Version_Requerida_App,
					@Version_Requerida_App,
					@Flag_Version_Requerida_Frw,
					@Version_Requerida_Frw,
					@Flag_Version_Requerida_App_Std,
					@Version_Requerida_App_Std,
					@Tipo_Pase,
					4, -- Error Version Framework
					@OBSERVACION,
					GETDATE(),  --created
					1,			--creado por 
					GETDATE(),	--actualizado
					1,			--actualizado por
					1,			--propietario
					0)			--eliminado
				
				 RAISERROR('La versión de framework requerida no es la correcta.',16,1)

			     RETURN
          END
	END

-- Valida Version Estándar Requerida
IF  @Flag_Version_Requerida_App_Std = 1 
  BEGIN
     SET @Version_Actual_App_Std = (SELECT value FROM pm_parameter WHERE code = 'VERSION_STD')
      IF  @Version_Actual_App_Std <> @Version_Requerida_App_Std
          BEGIN
                 -- Insert registro de pase_log y coloca estado ERROR EN VERSION APP. REQUIERE VERSION + Version_Anterior_App
               
			   	   INSERT INTO pl_pase_log
					VALUES(
					@ps_pase_id,
					@Version,
					@Descripcion_Pase,
					GETDATE(),
					null,
					@codigo_jira,
					GETDATE(),
					GETDATE(),
					@Flag_Version_Requerida_App,
					@Version_Requerida_App,
					@Flag_Version_Requerida_Frw,
					@Version_Requerida_Frw,
					@Flag_Version_Requerida_App_Std,
					@Version_Requerida_App_Std,
					@Tipo_Pase,
					5, -- Error Version Estándar
					@OBSERVACION,
					GETDATE(),  --created
					1,			--creado por 
					GETDATE(),	--actualizado
					1,			--actualizado por
					1,			--propietario
					0)			--eliminado
				
				 RAISERROR('La versión estándar requerida no es la correcta.',16,1)

			     RETURN
          END
  END

GO

