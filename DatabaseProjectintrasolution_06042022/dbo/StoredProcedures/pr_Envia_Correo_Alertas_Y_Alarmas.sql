

/*      
****************************************************************************************************************************************
Nombre: dbo.[pr_Envia_Correo_Alertas_Y_Alarmas]
Fecha Creacion: 23/04/2020
Autor: Mauro Roque
Descripcion:Envia Correo de Alerta y Alarmas del sistema 
Llamado por: javascript 
Usado por: Modulo: Configuracion de alertas y alarmas
Uso: [pr_Envia_Correo_Alertas_Y_Alarmas] '5',1,15
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/

CREATE PROC [dbo].[pr_Envia_Correo_Alertas_Y_Alarmas]      
@fb_mensaje_email numeric(10,0),
@ID_UEA int,
@ID_MODULO INT   
as      
DECLARE @sp_mensaje varchar(300),@dias_previos varchar(100),@tipo_mensaje varchar(50),@mensaje varchar(300),@correo_email varchar(100)      
DECLARE @destinatarios_email_IGA VARCHAR(200),@destinatarios VARCHAR(200),@codigo varchar(200)
 
 
 SELECT      
   @sp_mensaje=sp_mensaje,      
  
 @tipo_mensaje=tipo_mensaje,      
   @correo_email=destinatario_email,
   @codigo=codigo
    FROM fb_mensaje_email      
 WHERE       
  fb_mensaje_email_id=@fb_mensaje_email AND    
  is_deleted=0 

  if (@correo_email like '%{%')
  begin
		  	set @correo_email =  (SELECT  (email_superintendente+' : '+email_gerente_ma) FROM fb_uea_pe WHERE fb_uea_pe_id=@ID_UEA )
				
  end
  else 
  
  begin
			set @correo_email= (select destinatario_email  FROM fb_mensaje_email      
								 WHERE       
								  fb_mensaje_email_id=@fb_mensaje_email AND    
								  is_deleted=0 )

  end


 IF (@tipo_mensaje='AVI')     
    
   BEGIN      
    SET @mensaje = 'Seleccione un Registro de Tipo Alerta ó Alarma'      
   END      
 ELSE   IF ( (@tipo_mensaje='ALE' OR @tipo_mensaje='ALA') AND  @codigo <>'ALERTA_RESPONSABLE_MATRIZ_KPI'
 )   
   BEGIN      
    EXEC @sp_mensaje        
       SET @mensaje = 'Correo Enviado a ' + @correo_email          
   END    
  
 SELECT @mensaje AS mensaje

GO

