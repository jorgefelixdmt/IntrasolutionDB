/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_inc_codigo_incidencia_v2]
Fecha Creacion: 26/04/2021
Autor: Mauro Roque
Descripcion: funcion que genera codigo corelativo de la incidencia
Llamado por: javascript
Usado por: Incidencias, Incidencias del Cliente
Parametros: @id_cliente Id del cliente
Uso: select dbo.[uf_inc_codigo_incidencia_v2] (1)
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
15/06/2021			 Mauro Roque			  se agrego variable @numero_autogenerado para obtener el numero correlativo del 
											  codigo patron, el codigo ultimo ticket autogenerado
**********************************************************************************************************
*/
CREATE function [dbo].[uf_inc_codigo_incidencia_v2] (@id_cliente numeric(10,0))              
returns varchar(150)              
AS              
BEGIN              
    DECLARE @codigo_cliente varchar(50), @numero_autogenerado varchar(5)              
    DECLARE @anno varchar(50)              
    DECLARE @codigo_patron varchar(50)              
    DECLARE @codigo_inc varchar(50)              
 DECLARE @contador int              
          
 set @anno = YEAR(getdate())              

 -- @numero_autogenerado para obtener el numero correlativo del codigo patron, el codigo ultimo ticket autogenerado

 SET @numero_autogenerado  = (Select top 1 substring(codigo_ticket,9,1) from inc_incidencia  where is_deleted=0  order by created desc   )
	

 SET  @codigo_patron = @anno +'-'+ '0000' + @numero_autogenerado
    

 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --              

 SET @codigo_inc  = (Select MAX(codigo_ticket) from inc_incidencia  where is_deleted=0 and codigo_ticket  like  @codigo_patron + '%' )               
           
 
-- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO              
  IF (@codigo_inc is Null)              
    BEGIN              
	   -- CREA EL CODIGO CON 0001              
	      set  @codigo_inc = @anno + '-' + '00001'          
		    END              
 ELSE              
  BEGIN              
   -- ARMA EL CODIGO RECUPERANDO EL ULTIMO CONTADOR Y SUMANDOLE 1              

   SET @contador = convert(int,SUBSTRING(@codigo_inc,6,5))        
   SET @contador = @contador + 1              
   SET @codigo_inc = @anno + '-' + right('0000'+ convert(varchar(5),@contador),5)             
  END              
 RETURN (@codigo_inc)  
 END

GO

