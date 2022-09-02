


/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_pro_codigo_propuesta_v2]
Fecha Creacion: 21/05/2021
Autor: Mauro Roque
Descripcion: Funcion que genera codigo correlativo del modulo Propuesta
Llamado por: trigger "tr_pro_propuesta_genera_codigo" 
Usado por: Modulo: Propuesta
Parametros: @ID_PROPUESTA - ID de la propuesta
Uso: select dbo.[uf_pro_codigo_propuesta_v2] (7)

**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
create function [dbo].[uf_pro_codigo_propuesta_v2] (@id_propuesta numeric(10,0))              
returns varchar(150)              
AS              
BEGIN              
    DECLARE @codigo_cliente varchar(50)              
    DECLARE @anno varchar(50)              
    DECLARE @codigo_patron varchar(50)              
    DECLARE @codigo_pro varchar(50)              
 DECLARE @contador int              
          
 set @anno = ( select year(fecha_solicitante) from pro_propuesta where pro_propuesta_id =  @id_propuesta)      

 -- DEFINE PATRON DEL CODIGO --              

 set  @codigo_patron = @anno +'-'+ '000'   

 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --              

 SET @codigo_pro  = (Select MAX(codigo) from pro_propuesta  where is_deleted=0 and codigo  like  @codigo_patron + '%' )               
           
 
-- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO              
  IF (@codigo_pro is Null)              
    BEGIN              
	   -- CREA EL CODIGO CON 0001              
	      set  @codigo_pro = @anno + '-' + '0001'          
		    END              
 ELSE              
  BEGIN              
   -- ARMA EL CODIGO RECUPERANDO EL ULTIMO CONTADOR Y SUMANDOLE 1              

   SET @contador = convert(int,SUBSTRING(@codigo_pro,6,4))        
   SET @contador = @contador + 1              
   SET @codigo_pro = @anno + '-' + right('000'+ convert(varchar(4),@contador),4)             
  END              
 RETURN (@codigo_pro)  
 END

GO

