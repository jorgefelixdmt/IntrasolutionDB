  
/*        
        
<StoreProcedure>        
 <Name>        
         pr_aviso_documento_distribucion      
   </Name>        
    <Description>        
  Alerta a los responsables que el documento se ha actualizado        
          
  La informacion a enviar es :        
   - Correlativo        
   - Codigo       
   - Titulo        
   - Ruta        
   - FechaActualizacion        
         
 -- pr_aviso_documento_distribucion         
 </Description>        
 <Parameters>        
 </Parameters>        
    <Author>        
          Daniel Restrepo         
    </Author>        
    <Date>        
         27/02/2017        
    </Date>        
</StoreProcedure>          
*/        
--exec pr_aviso_documento_distribucion         
CREATE proc [dbo].[pr_aviso_documento_distribucion]         
@id_documento numeric(10,0)      
          
AS          
        
BEGIN          
        
DECLARE @PERFIL_MAIL_SQL varchar(128), @CODIGO_EMAIL varchar(64), @UEA numeric(10,0), @MAIL_TEST varchar(128)        
DECLARE @TO varchar(256), @SUBJECT varchar(1024), @BODY varchar(MAX),@BODY_FORMAT varchar(128), @Tabla_html varchar(MAX)        
DECLARE @EMAIL varchar(256),@CUERPO_EMAIL varchar(MAX),@ASUNTO_EMAIL varchar(128)        
DECLARE @CodigoUEA varchar(200), @Flag_Email_Test varchar(1), @Email_Test varchar(128)        
        
DECLARE @Correlativo int,         
  @Codigo varchar(50),         
  @Titulo varchar(180),         
  @Ruta varchar(MAX),         
  @FechaActualizacion varchar(10),         
  @fb_uea_pe numeric(10,0),      
  @folderId numeric(10,0),      
  @Empleado_id numeric(10,0),        
  @CodigoUnidad varchar(200),          
  @diasPrevios numeric(10,0),      
  @Responsable varchar(100)       
        
          
        
-- Recupera Valores de la Configuracion para el Envio de Emails        
SELECT @PERFIL_MAIL_SQL = value from PM_PARAMETER where code= 'PERFIL_SQL_MAIL'        
SELECT @Flag_Email_Test = value from PM_PARAMETER where code= 'FLAG_EMAIL_TEST'        
SELECT @Email_Test = value from PM_PARAMETER where code= 'EMAIL_TEST'        
        
SET @CodigoUnidad = 'GLOBAL'      
        
DECLARE Cursor_DOCActualizado CURSOR FOR      
         
      
SELECT      
dd.codigo as Codigo,      
dd.titulo as Titulo,      
dbo.uf_doc_Ruta_Documento(dd.doc_documento_id) as Ruta,      
CONVERT(VARCHAR(10), GETDATE(),103) as FechaActualizacion,      
empleado.fb_empleado_id      
      
FROM      
doc_documento_distribucion ddd      
inner join doc_documento dd on ddd.doc_documento_id = dd.doc_documento_id      
inner join fb_empleado empleado on empleado.fb_area_id = ddd.fb_area_id and empleado.fb_cargo_id = ddd.fb_cargo_id      
      
WHERE       
dd.doc_documento_id = @id_documento      
       
ORDER BY empleado.fb_empleado_id -- Ordenado por EMPLEADO          
        
OPEN Cursor_DOCActualizado        
        
FETCH NEXT FROM Cursor_DOCActualizado INTO         
 @Codigo,      
 @Titulo,      
 @Ruta,      
 @FechaActualizacion,      
 @Empleado_id      
       
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
     SELECT  @Email = IsNull(email,'')  from fb_empleado where fb_empleado_id=@Empleado_id      
     --SELECT @EMAIL = Responsable SST        
             
    END        
    -- Inicializa el Mensaje la primera vez        
    SET @Tabla_html ='<table BORDER CELLPADDING=10 CELLSPACING=0 ><tr><TH bgcolor="A4A4A4"><font color="white" >#</TH><TH bgcolor="A4A4A4"><font color="white">Codigo</TH><TH bgcolor="A4A4A4">      
       <font color="white">Titulo</TH><TH bgcolor="A4A4A4"><font color="white">Ruta</TH><TH bgcolor="A4A4A4"><font color="white"><Center>Fecha Actualizacion</Center></TH></tr>'        
   END        
         
  SET @Correlativo = @Correlativo + 1        
         
  SET  @Tabla_html = @Tabla_html + '<TR><TD>' + Convert(varchar(3),@Correlativo) + '</TD><TD>&nbsp;' + @Codigo + '</TD><TD>&nbsp;' + @Titulo + '</TD><TD>&nbsp;' + @Ruta + '</TD><TD>&nbsp;' + @FechaActualizacion + '</TD></TR>'          
        
  SELECT @Responsable = nombreCompleto FROM fb_empleado WHERE fb_empleado_id = @Empleado_id      
        
 FETCH NEXT FROM Cursor_DOCActualizado INTO         
 @Codigo,      
 @Titulo,      
 @Ruta,      
 @FechaActualizacion,      
 @Empleado_id      
      
          
  IF (@UEA <> @Empleado_id)        
   BEGIN        
    SET @Tabla_html= @Tabla_html+'</table>'          
              
    -- se trae de DB el cuerpo y asunto de email          
    SET @cuerpo_email = '<div><font face="tahoma, arial, verdana, sans-serif">&nbsp;Estimado:</font></div><div><font face="tahoma, arial, verdana, sans-serif"><b>[RESPONSABLE] :</b></font></div><div><font face="tahoma, arial, verdana, sans-serif"><br></fo
  
    
nt></div><div><font face="tahoma, arial, verdana, sans-serif"><br></font></div><div><font face="tahoma, arial, verdana, sans-serif"><br></font></div><div><font face="tahoma, arial, verdana, sans-serif">Por intermedio de la presente mostramos la informació
  
    
n sobre el documento de distribucion actualizado :</font></div><div><font face="tahoma, arial, verdana, sans-serif"><br></font></div><div><font face="tahoma, arial, verdana, sans-serif">[TABLA_DATOS]</font></div>'      
    SET @asunto_email = 'Safe2biz - Documento Distribucion Actualizado'      
    SET @asunto_email = @asunto_email + ' - ' + @CodigoUEA           
      -- se Arma el cuerpo del email      
               
    SET @CUERPO_EMAIL = (SELECT REPLACE(@CUERPO_EMAIL,'[RESPONSABLE]',@Responsable))      
 SET @cuerpo_email = (SELECT Replace(@cuerpo_email,'[TABLA_DATOS]',@Tabla_html))        
             
    IF (@Email <> '')        
     -- se envia el email          
     EXEC  msdb.dbo.sp_send_dbmail           
        @profile_name=@PERFIL_MAIL_SQL ,          
        @recipients= @email,          
        @subject= @asunto_email,        
        @body = @cuerpo_email,          
        @body_format = 'HTML' ;         
   END        
        
 END        
        
 IF ( @Correlativo > 0)        
  BEGIN        
   SET @Tabla_html= @Tabla_html+'</table>'          
             
   -- se trae de DB el cuerpo y asunto de email          
   SET @cuerpo_email = '<div><font face="tahoma, arial, verdana, sans-serif">&nbsp;Estimado:</font></div><div><font face="tahoma, arial, verdana, sans-serif"><b>[RESPONSABLE] :</b></font></div><div><font face="tahoma, arial, verdana, sans-serif"><br></fon
  
    
t></div><div><font face="tahoma, arial, verdana, sans-serif"><br></font></div><div><font face="tahoma, arial, verdana, sans-serif"><br></font></div><div><font face="tahoma, arial, verdana, sans-serif">Por intermedio de la presente mostramos la información
  
    
 sobre el documento de distribucion actualizado :</font></div><div><font face="tahoma, arial, verdana, sans-serif"><br></font></div><div><font face="tahoma, arial, verdana, sans-serif">[TABLA_DATOS]</font></div>'      
    SET @asunto_email = 'Safe2biz - Documento Distribucion Actualizado'      
    SET @asunto_email = @asunto_email + ' - ' + @CodigoUEA           
      -- se Arma el cuerpo del email          
   SET @CUERPO_EMAIL = (SELECT REPLACE(@CUERPO_EMAIL,'[RESPONSABLE]',@Responsable))      
   SET @cuerpo_email = (SELECT Replace(@cuerpo_email,'[TABLA_DATOS]',@Tabla_html))        
              
            
   IF (@Email <> '')        
    -- Se envia el email al responsable del control          
    EXEC  msdb.dbo.sp_send_dbmail           
       @profile_name=@PERFIL_MAIL_SQL ,          
       @recipients= @email,          
       @subject= @asunto_email ,        
                 
       @body = @cuerpo_email,          
       @body_format = 'HTML' ;        
               
               
  END        
        
 CLOSE Cursor_DOCActualizado          
 DEALLOCATE Cursor_DOCActualizado        
END

GO

