/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_sol_codigo_solicitud]
Fecha Creacion: 12/07/2021
Autor: Mauro Roque
Descripcion: Funcion que genera codigo correlativo del modulo Solicitud
Llamado por: trigger "tr_INSERT_sol_solicitud_genera_codigo" 
Usado por: Modulo: Registro Solicitud
Parametros: @id_sol - ID de la Solicitud
Uso: select dbo.[uf_sol_codigo_solicitud] (1)

**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
create function [dbo].[uf_sol_codigo_solicitud] (@id_sol numeric(10,0))              
returns varchar(150)              
AS              
BEGIN                           
    DECLARE @anno varchar(50)              
    DECLARE @codigo_patron varchar(50)              
    DECLARE @codigo_sol varchar(50)              
 DECLARE @contador int              
          
 set @anno = ( select year(fecha_solicitud) from sol_solicitud where sol_solicitud_id =  @id_sol)      

 -- DEFINE PATRON DEL CODIGO --              

 set  @codigo_patron = 'SOL' +'-'+  @anno

 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --              

 SET @codigo_sol  = (Select MAX(codigo) from sol_solicitud  where is_deleted=0 and codigo  like  @codigo_patron + '%' )               
           
 
-- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO              
  IF (@codigo_sol is Null)              
    BEGIN              
	   -- CREA EL CODIGO CON 0001              
	      set  @codigo_sol = @codigo_patron+ '-' + '0001'          
		    END              
 ELSE              
  BEGIN              
   -- ARMA EL CODIGO RECUPERANDO EL ULTIMO CONTADOR Y SUMANDOLE 1              

   SET @contador = convert(int,right(@codigo_sol,4))      
   SET @contador = @contador + 1            
   SET @codigo_sol = @codigo_patron + '-' + right('000'+ convert(varchar(4),@contador),4)                
  END              
 RETURN (@codigo_sol)  
 END

GO

