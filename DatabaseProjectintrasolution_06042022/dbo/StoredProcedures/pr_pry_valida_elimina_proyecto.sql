
/*      
****************************************************************************************************************************************
Nombre: dbo.[pr_pry_valida_elimina_proyecto]
Fecha Creacion: 16/02/2021     
Autor: Mauro Roque
Descripcion: store que valida si existen resultados de un de un proyecto, antes de eliminar
Llamado por: javacript
Usado por: Modulo: Proyectos
Parametros: @p_pry_proyecto_id - ID del Proyecto
objetos afectados : tabla PRY_PROYECTO Actualiza
Uso: [pr_pry_valida_elimina_proyecto] 38
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios

**********************************************************************************************************
*/

CREATE PROC [dbo].[pr_pry_valida_elimina_proyecto]    
@p_pry_proyecto_id numeric(10,0)    
AS    
BEGIN    
     
  DECLARE @mensaje varchar(500),@INCIDENCIAS INT, @PASES INT,@VENTAS INT, @flag INT
  SET @mensaje = ''  

    
  SET @INCIDENCIAS = (SELECT COUNT(*) FROM inc_incidencia WHERE is_deleted=0 and pry_proyecto_id =@p_pry_proyecto_id)
  SET @PASES = (SELECT COUNT(*) FROM pa_pase WHERE is_deleted=0 and pry_proyecto_id = @p_pry_proyecto_id)
  SET @VENTAS = (SELECT COUNT(*) FROM fnz_venta WHERE is_deleted=0 and pry_proyecto_id = @p_pry_proyecto_id)
  
IF @INCIDENCIAS >= 1    
 BEGIN    
 
  SET @mensaje = 'No se Puede Eliminar, Existen Incidencias asociadas  '  
  SET @flag = 1

 END     
 IF @PASES >= 1    
 BEGIN  
  
   SET @mensaje = 'No se Puede Eliminar, Existen Pases asociados  '  
    SET @flag = 1
 END     
 IF @VENTAS >=1
 BEGIN    
    
  SET @mensaje = 'No se Puede Eliminar, Existen Ventas asociados '  
    SET @flag = 1   
 END 
 
      
IF (@INCIDENCIAS=0 AND @PASES=0 AND @VENTAS=0 )    
 BEGIN  
  
	UPDATE pry_proyecto SET updated=getdate(), codigo=codigo+'_xxxxx', is_deleted=1,estado=0 
	  WHERE pry_proyecto_id = @p_pry_proyecto_id    
	 
	  SET @flag = 0
   
 END    
     
 select @mensaje as Mensaje,@flag AS flag     
END

GO

