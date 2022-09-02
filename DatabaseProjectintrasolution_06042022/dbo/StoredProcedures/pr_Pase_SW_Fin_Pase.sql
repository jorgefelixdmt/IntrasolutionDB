/*      
****************************************************************************************************************************************
Nombre: dbo.pr_Pase_SW_Fin_Pase
Fecha Creacion: 02/06/2020
Autor: Mauro Roque
Descripcion: store que inserta pase log con estado INSTALADO y actualiza version del pase en pm_parameter
Parametros: @ps_pase_id - ID de pase de software,
			@codigo_jira - Codigo del jira pase
			@Tipo_Pase - Tipo Pase
			@Version - NUEVA VERSION DEL PASE
			@Descripcion_Pase - descripcion del pase
			@Flag_Version_Requerida_App - 1 valida si requiere version de la app
			@Version_Requerida_App - version anterior de la app
			@Flag_Version_Requerida_Frw - 1 valida si requiere version del framework
			@Version_Requerida_Frw - version anterior del framework
			@Flag_Version_Requerida_App_Std - 1 valida si requiere version estándar de la app
			@Version_Requerida_App_Std - version anterior estándar de la app

tablas afectadas : pl_pase_log INSERTA , pm_parameter ACTUALIZA
Uso: exec pr_Pase_SW_Fin_Pase 1,'DMTPAS-541',1,'0.0.2','Pase Dominiotech 542',1,'0.0.1',0,'',0,''
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE proc [dbo].[pr_Pase_SW_Fin_Pase]
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
as



DECLARE @Version_Actual_App varchar(32), @Version_Actual_Frw varchar(32)
DECLARE @nombre_tipo_pase varchar(50), @OBSERVACION VARCHAR(500)

SET @nombre_tipo_pase = (SELECT nombre FROM pl_tipo_pase WHERE pl_tipo_pase_id = @Tipo_Pase)

SET @OBSERVACION = CAST(@ps_pase_id AS varchar)+'/'+@nombre_tipo_pase+'/'+@Version+'/'+@Descripcion_Pase+'/'+
					CAST(@Flag_Version_Requerida_App AS varchar)+'/'+@Version_Requerida_App+'/'+
					CAST(@Flag_Version_Requerida_Frw AS varchar)+'/'+@Version_Requerida_Frw+'/'+
					CAST(@Flag_Version_Requerida_App_Std AS varchar)+'/'+@Version_Requerida_App_Std


IF @Tipo_Pase = 3 -- Pase App Cliente
 BEGIN
	UPDATE PM_PARAMETER
	SET value = CAST(@Version AS varchar)
	WHERE  CODE = 'VERSION'
 END

IF @Tipo_Pase = 1 -- Pase Framework
 BEGIN
	UPDATE PM_PARAMETER
	SET value = CAST(@Version AS varchar)
	WHERE  CODE = 'VERSION_FRAMEWORK'
 END

IF @Tipo_Pase = 2 -- Pase App Estándar
 BEGIN
	UPDATE PM_PARAMETER
	SET value = CAST(@Version AS varchar)
	WHERE  CODE = 'VERSION_STD'
 END


-- Insert registro de pase_log y coloca estado INSTALADO.

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
	3, --instalado
	@OBSERVACION,
	GETDATE(),
	1,
	GETDATE(),
	1,
	1,
	0)

GO

