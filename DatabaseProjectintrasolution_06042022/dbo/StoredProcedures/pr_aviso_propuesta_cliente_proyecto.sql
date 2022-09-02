/*      
****************************************************************************************************************************************
Nombre: dbo.[pr_aviso_propuesta_cliente_proyecto]
Fecha Creacion: 03/12/2021
Autor: Mauro Roque
Descripcion: Store enviar un correo de aviso de notificación del modulo Propuesta, Cliente, Proyecto
Usado por: Modulo: Propuesta
Parametros: @id_pk - ID de PK del modulo
			@nombre_modulo - Nombre del Modulo
Uso: [pr_aviso_propuesta_cliente_proyecto] 2,'PROPUESTA'
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
12/01/2022              Valky Salinas          Se modificó ejecución de pr_EMAIL_ENVIO_V2 para funcionamiento con nueva versión.

***************************************************************************************************************************************
*/
CREATE proc [dbo].[pr_aviso_propuesta_cliente_proyecto]     
@id_pk numeric(10,0),
@nombre_modulo varchar(200)  
      
AS      
    
BEGIN      
    
DECLARE @PERFIL_MAIL_SQL varchar(128), @CODIGO_EMAIL varchar(200), @UEA numeric(10,0), @MAIL_TEST varchar(128)    
DECLARE @TO varchar(256), @SUBJECT varchar(1024), @BODY varchar(MAX),@BODY_FORMAT varchar(128), @Tabla_html varchar(MAX)    
DECLARE @EMAIL varchar(max),@CUERPO_EMAIL varchar(MAX),@ASUNTO_EMAIL varchar(128)    
DECLARE @CodigoUEA varchar(200), @Flag_Email_Test varchar(1), @Email_Test varchar(128)    
    
DECLARE @Correlativo int,     
  @Titulo varchar(500), 
  @cliente varchar(500),
  @Producto varchar(MAX),
  @Descripcion varchar(MAX),
  @Fecha_solicitud varchar(10),     
  @Estado varchar(200), 
  @fb_uea_pe numeric(10,0),  
  @Empleado_id numeric(10,0),    
  @CodigoUnidad varchar(200),      
  @Responsable varchar(100)    
      
    
-- Recupera Valores de la Configuracion para el Envio de Emails    
SELECT @PERFIL_MAIL_SQL = value from PM_PARAMETER where code= 'PERFIL_SQL_MAIL'    
SELECT @Flag_Email_Test = value from PM_PARAMETER where code= 'FLAG_EMAIL_TEST'    
SELECT @Email_Test = value from PM_PARAMETER where code= 'EMAIL_TEST'    
    
 SET @CODIGO_EMAIL = 'AVISO_PROYECTO_CLIENTE_PROPUESTA'

IF @nombre_modulo = 'PROPUESTA'
		BEGIN
		
				DECLARE Cursor_AVISO_PROPUESTA_CLIENTE_PROYECTO CURSOR FOR 
 
 				SELECT  
						top 1
						pro.titulo as titulo,
						isnull(cli.nombre,'') as cliente,
						prod.nombre as producto,
						isnull(pro.descripcion,'') as descripcion,
						isnull(CONVERT(VARCHAR(10),pro.fecha_solicitante,103),'') as fecha_solicitud,
						est.nombre as estado,
						emp.fb_empleado_id,  
						uea.codigo  as CodigoUEA
						from pro_propuesta pro 
						left join fb_cliente cli on pro.fb_cliente_id = cli.fb_cliente_id 
						left join prd_producto prod on prod.prd_producto_id = pro.prd_producto_id  
												   
						left join pro_estado_propuesta est on est.pro_estado_propuesta_id = pro.pro_estado_propuesta_id  
						left join fb_uea_pe uea on uea.fb_uea_pe_id = pro.fb_uea_pe_id  

						left join sc_user usu on usu.sc_user_id = pro.updated_by  
						left join fb_empleado emp on emp.fb_empleado_id = usu.fb_empleado_id  

						WHERE  
						pro.pro_propuesta_id = @id_pk  

		END
  


  IF @nombre_modulo = 'PROYECTO'
		BEGIN
		
				DECLARE Cursor_AVISO_PROPUESTA_CLIENTE_PROYECTO CURSOR FOR 
 
 				SELECT  
						top 1
						proy.nombre as titulo,
						isnull(cli.nombre,'') as cliente,
						prod.nombre as producto,
						isnull(proy.descripcion,'') as descripcion,
						isnull(CONVERT(VARCHAR(10),proy.fecha_inicio_estimada,103),'') as fecha,
						est.nombre as estado,
						emp.fb_empleado_id,  
						uea.codigo  as CodigoUEA
						from pry_proyecto proy 
						left join fb_cliente cli on proy.fb_cliente_id = cli.fb_cliente_id 
						left join prd_producto prod on prod.prd_producto_id = proy.prd_producto_id  
												   
						left join pry_estado_proyecto est on est.pry_estado_proyecto_id = proy.pry_estado_proyecto_id  
						left join pro_propuesta pro on pro.pro_propuesta_id = proy.pro_propuesta_id  
				
						left join sc_user usu on usu.sc_user_id = proy.updated_by  
						left join fb_empleado emp on emp.fb_empleado_id = usu.fb_empleado_id  
						left join fb_uea_pe uea on uea.fb_uea_pe_id = emp.fb_uea_pe_id  

						WHERE  
						proy.pry_proyecto_id = @id_pk  

		END
	
	
 IF @nombre_modulo = 'CLIENTE'
BEGIN
		
		DECLARE Cursor_AVISO_PROPUESTA_CLIENTE_PROYECTO CURSOR FOR 
 
 		SELECT  
				top 1
				cli.codigo as cod_cliente,
				cli.nombre as cliente,
				cli.ruc as ruc,
				isnull(cli.descripcion,'') as descripcion,
				isnull(CONVERT(VARCHAR(10),cli.created,103),'') as fecha,
				(case  cli.estado when 1 then 'SI ' else 'NO' end)  as estado,
				emp.fb_empleado_id,  
				uea.codigo  as CodigoUEA
				from fb_cliente cli 
				
				left join sc_user usu on usu.sc_user_id = cli.updated_by  
				left join fb_empleado emp on emp.fb_empleado_id = usu.fb_empleado_id  
				left join fb_uea_pe uea on uea.fb_uea_pe_id = emp.fb_uea_pe_id  

				WHERE  
				cli.fb_cliente_id = @id_pk  

END
	  
OPEN Cursor_AVISO_PROPUESTA_CLIENTE_PROYECTO    
    
FETCH NEXT FROM Cursor_AVISO_PROPUESTA_CLIENTE_PROYECTO INTO     
   @Titulo , 
  @cliente ,
  @Producto ,
  @Descripcion ,
  @Fecha_solicitud ,     
  @Estado ,  
 @Empleado_id,  
 @CodigoUnidad  
   
SET @UEA = -1    
SET @Correlativo = 0    
    
WHILE @@Fetch_Status = 0     
 BEGIN    
  IF @UEA <> @Empleado_id    
   BEGIN    
    SET @Correlativo = 0    
    SET @UEA = @Empleado_id  
    SET @CodigoUEA = @CodigoUnidad    
      
    IF(@FLAG_EMAIL_TEST = 1)    
     SET @Email = @EMail_Test    
    ELSE    
    BEGIN    


	--SELECT  @Email = 'GRUPO.ADMINISTRACION@DOMINIOTECH.COM.PE' 
	--SELECT  @Email = 'mauro.tec.pro.sis@gmail.com' 
	
	
	SELECT @Email = destinatario_email from fb_mensaje_email where codigo= 'AVISO_PROYECTO_CLIENTE_PROPUESTA'        
    
	
	END    
    -- Inicializa el Mensaje la primera vez    
   SET @Tabla_html ='<table BORDER CELLPADDING=10 CELLSPACING=0 ><tr><TH bgcolor="A4A4A4"><font color="white" >#</TH>
					<TH bgcolor="A4A4A4"><font color="white">Título</TH>
					<TH bgcolor="A4A4A4"><font color="white">Cliente</TH>
					<TH bgcolor="A4A4A4"><font color="white">Producto</TH>
					<TH bgcolor="A4A4A4"><font color="white">Descripcion</TH>
					<TH bgcolor="A4A4A4"><font color="white">Fecha</TH>
					<TH bgcolor="A4A4A4"><font color="white">Estado</TH></tr>'  
   END    
     
  SET @Correlativo = @Correlativo + 1  
   
	SET  @Tabla_html = @Tabla_html + '<TR><TD>' + Convert(varchar(3),@Correlativo) + '</TD>
											<TD>&nbsp;' + @Titulo + '</TD>}
											<TD>&nbsp;' + @cliente + '</TD>
											<TD>&nbsp;' + @Producto +  '</TD>
											<TD>&nbsp;' + @Descripcion +  '</TD>
											<TD>&nbsp;' + CONVERT(varchar(50),@Fecha_solicitud,103) + '</TD>
											<TD>&nbsp;' + CONVERT(varchar(50),@Estado,103) + '</TD>
											</TR>'    
  
  SELECT @Responsable = nombreCompleto FROM fb_empleado WHERE fb_empleado_id = @Empleado_id  
    
 FETCH NEXT FROM Cursor_AVISO_PROPUESTA_CLIENTE_PROYECTO INTO     
 @Titulo , 
  @cliente ,
  @Producto ,
  @Descripcion ,
  @Fecha_solicitud ,     
  @Estado ,
 @Empleado_id,  
 @CodigoUnidad  
  
    
    
 IF ( @Correlativo > 0)    
  BEGIN    


   IF @nombre_modulo = 'CLIENTE'
		BEGIN
				   SET @Tabla_html ='<table BORDER CELLPADDING=10 CELLSPACING=0 ><tr><TH bgcolor="A4A4A4"><font color="white" >#</TH>
							<TH bgcolor="A4A4A4"><font color="white">Codigo</TH>
							<TH bgcolor="A4A4A4"><font color="white">Nombre</TH>
							<TH bgcolor="A4A4A4"><font color="white">Ruc</TH>
							<TH bgcolor="A4A4A4"><font color="white">Descripcion</TH>
							<TH bgcolor="A4A4A4"><font color="white">Fecha</TH>
							<TH bgcolor="A4A4A4"><font color="white">Activo</TH></tr>'  

		END
ELSE
		BEGIN
			   SET @Tabla_html ='<table BORDER CELLPADDING=10 CELLSPACING=0 ><tr><TH bgcolor="A4A4A4"><font color="white" >#</TH>
							<TH bgcolor="A4A4A4"><font color="white">Título</TH>
							<TH bgcolor="A4A4A4"><font color="white">Cliente</TH>
							<TH bgcolor="A4A4A4"><font color="white">Producto</TH>
							<TH bgcolor="A4A4A4"><font color="white">Descripcion</TH>
							<TH bgcolor="A4A4A4"><font color="white">Fecha</TH>
							<TH bgcolor="A4A4A4"><font color="white">Estado</TH></tr>'  
		END
		  
   
			  SET  @Tabla_html = @Tabla_html + '<TR><TD>' + Convert(varchar(3),@Correlativo) + '</TD>
											<TD>&nbsp;' + @Titulo + '</TD>
											<TD>&nbsp;' + @cliente + '</TD>
											<TD>&nbsp;' + @Producto +  '</TD>
											<TD>&nbsp;' + @Descripcion +  '</TD>
											<TD>&nbsp;' + CONVERT(varchar(50),@Fecha_solicitud,103) + '</TD>
											<TD>&nbsp;' + @Estado + '</TD>
											</TR>'   
  	SET @Tabla_html= @Tabla_html+'</table>' 

      -- se Arma el cuerpo del email  
      
	 SET @cuerpo_email = (SELECT cuerpo from fb_mensaje_email where codigo=@CODIGO_EMAIL )    
	 SET @asunto_email = (SELECT asunto from fb_mensaje_email where codigo=@CODIGO_EMAIL ) 
	 SET @asunto_email = (SELECT Replace(@asunto_email,'[NOMBRE_MODULO]',@nombre_modulo))  
  

    SET @cuerpo_email = (SELECT Replace(@cuerpo_email,'[TABLA_DATOS]',@Tabla_html))    
    SET @cuerpo_email = (SELECT Replace(@cuerpo_email,'[NOMBRE_MODULO]',@nombre_modulo))    
           
	
        
   IF (@Email <> '')    
      
		Exec pr_EMAIL_ENVIO_V2 '',@email,@asunto_email,'HTML',@cuerpo_email,'',@CODIGO_EMAIL,1,1,@id_pk   
    
           
  END    
    
 CLOSE Cursor_AVISO_PROPUESTA_CLIENTE_PROYECTO      
 DEALLOCATE Cursor_AVISO_PROPUESTA_CLIENTE_PROYECTO    
END

END

GO

