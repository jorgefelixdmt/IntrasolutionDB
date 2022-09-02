/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_pro_codigo_propuesta]
Fecha Creacion: 27/02/2020
Autor: Mauro Roque
Descripcion: Funcion que genera codigo correlativo del modulo Propuesta
Llamado por: trigger "tr_pro_propuesta_genera_codigo" 
Usado por: Modulo: Propuesta
Parametros: @ID_PROPUESTA - ID de la propuesta
Uso: select dbo.[uf_pro_codigo_propuesta] (10010)
PROP-2021-0001-E2B-BVN-BVN
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
15/11/2021				MAURO ROQUE				se remplazo el campo "propuesta_cliente_id" por "fb_cliente_id"
**********************************************************************************************************
*/

CREATE function [dbo].[uf_pro_codigo_propuesta] (@ID_PROPUESTA numeric(10,0) )                
                
returns varchar(150)                
                
AS                
                
BEGIN                
                  
    DECLARE @anno varchar(50)                
    DECLARE @codigo_patron varchar(50)                
    DECLARE @codigo_propuesta varchar(50)                
	DECLARE @contador int                
    DECLARE @contador_patron int             
                   
    DECLARE @cod_cliente varchar(50)  
    DECLARE @cod_producto varchar(50)
	
	SET  @cod_cliente =  (SELECT cli.codigo 
						from fb_cliente cli inner join pro_propuesta pro
						on cli.fb_cliente_id=pro.fb_cliente_id
						where cli.is_deleted=0 and pro.pro_propuesta_id= @ID_PROPUESTA )
						  
   SET  @cod_producto =  (SELECT prod.codigo 
						from prd_producto prod inner join pro_propuesta pro
						on prod.prd_producto_id=pro.prd_producto_id
						where prod.is_deleted=0 and pro.pro_propuesta_id= @ID_PROPUESTA )
						             
 set @anno = (select  year(fecha_solicitante) from pro_propuesta where pro_propuesta_id = @ID_PROPUESTA)
                 
 -- DEFINE PATRON DEL CODIGO --                
 set  @codigo_patron =  'PROP' +'-'+ @anno      
                 
 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --                
 SET @codigo_propuesta  = (Select MAX(codigo) from pro_propuesta  where   is_deleted=0 and codigo like @codigo_patron + '%' )                 
 
                   
 -- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO                
 IF (@codigo_propuesta is Null)                
  BEGIN                
   
     
   set @codigo_propuesta = @codigo_patron  + '-' + '0001' + '-' +  @cod_producto + '-' +  @cod_cliente   
          
  END                
 ELSE                
  BEGIN                
    
     
 SET  @contador = convert(int,SUBSTRING(@codigo_propuesta,11,4))   
          
   SET @contador = @contador + 1     
   SET @codigo_propuesta = @codigo_patron + '-' + right('000'+ convert(varchar(4),@contador),4) + '-' +  @cod_producto + '-' + @cod_cliente    
   END     
               
 RETURN (@codigo_propuesta)                
END

GO

