


/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_inc_codigo_prueba]
Fecha Creacion: 08/03/2022
Autor: Mauro Roque
Descripcion: funcion que genera codigo correlativo del la tabla inc_prueba
Llamado por: Trigger [tr_inc_incidencia_genera_cod]
Usado por: Plan de Pruebas
Parametros: @anno Año actual del sistema
Uso: SELECT dbo.[uf_inc_codigo_prueba] (2022)
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
create function [dbo].[uf_inc_codigo_prueba] (@anno varchar(4))              
returns varchar(150)              
AS              
BEGIN                                   
    DECLARE @codigo_patron varchar(50)              
    DECLARE @codigo_prueba varchar(50)              
 DECLARE @contador int              
          

 -- DEFINE PATRON DEL CODIGO --              

 set  @codigo_patron = 'P' +'-'+  @anno

 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --              

 SET @codigo_prueba  = (Select MAX(codigo) from inc_prueba  where is_deleted=0 and codigo  like  @codigo_patron + '%' )               
           
 
-- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO              
  IF (@codigo_prueba is Null)              
    BEGIN              
	   -- CREA EL CODIGO CON 0001              
	      set  @codigo_prueba = @codigo_patron+ '-' + '0001'          
		    END              
 ELSE              
  BEGIN              
   -- ARMA EL CODIGO RECUPERANDO EL ULTIMO CONTADOR Y SUMANDOLE 1              

   SET @contador = convert(int,right(@codigo_prueba,4))      
   SET @contador = @contador + 1            
   SET @codigo_prueba = @codigo_patron + '-' + right('000'+ convert(varchar(4),@contador),4)                
  END              
 RETURN (@codigo_prueba)  
 END

GO

