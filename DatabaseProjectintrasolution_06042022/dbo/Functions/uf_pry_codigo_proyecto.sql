/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_pry_codigo_proyecto]
Fecha Creacion: 27/02/2020
Autor: Mauro Roque
Descripcion: Funcion que genera codigo correlativo del modulo proyecto
Llamado por: trigger "tr_pry_proyecto_genera_codigo" 
Usado por: Modulo: Propuesta
Parametros: @ID_PROYECTO - ID PROYECTO
Uso: select dbo.[uf_pry_codigo_proyecto] (20013)

**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
13-05-2020				MAURO ROQUE			El correlative es del AÑO  y no por CLIENTE-AÑO 

**********************************************************************************************************
*/

CREATE function [dbo].[uf_pry_codigo_proyecto] (@ID_PROYECTO numeric(10,0) )                
                
returns varchar(150)                
                
AS                
                
BEGIN                
                  
    DECLARE @anno varchar(50)                
    DECLARE @codigo_patron varchar(50)                
    DECLARE @codigo_proyecto varchar(50)                
	DECLARE @contador int                
    DECLARE @contador_patron int             
                   
    DECLARE @cod_cliente varchar(50)  
    DECLARE @cod_producto varchar(50)
	
	SET  @cod_cliente =  (SELECT cli.codigo 
						from fb_cliente cli inner join pry_proyecto pro
						on cli.fb_cliente_id=pro.fb_cliente_id
						where cli.is_deleted=0 and pro.pry_proyecto_id= @ID_PROYECTO )
						  
   SET  @cod_producto =  (SELECT prod.codigo 
						from prd_producto prod inner join pry_proyecto pro
						on prod.prd_producto_id=pro.prd_producto_id
						where prod.is_deleted=0 and pro.pry_proyecto_id= @ID_PROYECTO )
						             
   
        
								             
 set @anno = (SELECT YEAR(fecha_inicio_estimada) FROM pry_proyecto WHERE pry_proyecto_id = @ID_PROYECTO)
          
 -- DEFINE PATRON DEL CODIGO --                
 set  @codigo_patron =  'PRY' +'-'+ @anno      
                 
 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --                
 --SET @codigo_proyecto  = (Select MAX(codigo) from pry_proyecto  where is_deleted=0 and codigo like @codigo_patron + '%' + '-' + @cod_cliente + '-' + @cod_producto)                 
   SET @codigo_proyecto  = (Select MAX(codigo) from pry_proyecto  where is_deleted=0 and codigo like @codigo_patron + '%')                 
 
                   
 -- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO                
 IF (@codigo_proyecto is Null)                
  BEGIN                
   
     
   set @codigo_proyecto = @codigo_patron  + '-' + '0001' + '-' +  @cod_cliente + '-' + @cod_producto    
          
  END                
 ELSE                
  BEGIN                
    
     
 SET  @contador = convert(int,SUBSTRING(@codigo_proyecto,10,4))   
          
   SET @contador = @contador + 1     
   SET @codigo_proyecto = @codigo_patron + '-' + right('000'+ convert(varchar(4),@contador),4) + '-' +  @cod_cliente + '-' + @cod_producto    
   END     
               
 RETURN (@codigo_proyecto)                
END

GO

