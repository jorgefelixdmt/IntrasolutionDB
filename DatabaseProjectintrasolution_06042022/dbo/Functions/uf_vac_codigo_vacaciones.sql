
			
/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_vac_codigo_vacaciones]
Fecha Creacion: 02/03/2020
Autor: Mauro Roque
Descripcion: Funcion que genera codigo correlativo del modulo Solicitud de Vacaciones
Llamado por: trigger "tr_vac_vacaciones_genera_codigo" 
Usado por: Modulo: Propuesta
Parametros: @ID_VACACIONES - ID VACACIONES
Uso: select dbo.[uf_vac_codigo_vacaciones] (3)

**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/

create function [dbo].[uf_vac_codigo_vacaciones] (@ID_VACACIONES numeric(10,0) )                
                
returns varchar(150)                
                
AS                
                
BEGIN                
                  
    DECLARE @anno varchar(50)                
    DECLARE @codigo_patron varchar(50)                
    DECLARE @codigo_vacaciones varchar(50)                
	DECLARE @contador int                
    DECLARE @contador_patron int             
                   
							  
   SET  @anno =  (SELECT year(fecha_inicio)
						FROM vac_solicitud_vacaciones
						WHERE vac_solicitud_vacaciones_id= @ID_VACACIONES )

                 
 -- DEFINE PATRON DEL CODIGO --                
 SET  @codigo_patron =  'VAC' +'-'+ @anno      
                 
 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --                
 SET @codigo_vacaciones  = (Select MAX(codigo) FROM vac_solicitud_vacaciones  WHERE is_deleted=0 and codigo like @codigo_patron + '%' )                 
 
                   
 -- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO                
 IF (@codigo_vacaciones is Null)                
  BEGIN                
   
     
   set @codigo_vacaciones = @codigo_patron  + '-' + '0001' 
          
  END                
 ELSE                
  BEGIN                
    
     
 SET  @contador = convert(int,SUBSTRING(@codigo_vacaciones,10,4))   
          
   SET @contador = @contador + 1     
   SET @codigo_vacaciones = @codigo_patron + '-' + right('000'+ convert(varchar(4),@contador),4)
   END     
               
 RETURN (@codigo_vacaciones)                
END

GO

