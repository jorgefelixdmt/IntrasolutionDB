

/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_dc_codigo_documentario]
Fecha Creacion: 18/05/2020
Autor: Mauro Roque
Descripcion: Funcion que genera codigo correlativo del modulo Documentario
Llamado por: trigger "tr_dc_documentario_genera_codigo" 
Usado por: Modulo: Coltrol Documentario
Parametros: @ID_DOCUMENTO - ID Documento
Uso: select dbo.[uf_dc_codigo_documentario] (2)

**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/

CREATE function [dbo].[uf_dc_codigo_documentario] (@ID_DOCUMENTO numeric(10,0) )                
                
returns varchar(150)                
                
AS                
                
BEGIN                
                  
    DECLARE @anno varchar(50)                
    DECLARE @codigo_patron varchar(50)                
    DECLARE @codigo_documento varchar(50)                
	DECLARE @contador int                
    DECLARE @contador_patron int             
                   
				             
   
        
								             
 set @anno = year(getdate())
          
 -- DEFINE PATRON DEL CODIGO --                
 set  @codigo_patron =  @anno      
                 
 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --                
   SET @codigo_documento  = (Select MAX(codigo) from dc_documento  where is_deleted=0 and codigo like @codigo_patron + '%')                 
 
                   
 -- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO                
 IF (@codigo_documento is Null)                
  BEGIN                
   
     
   set @codigo_documento = @codigo_patron  + '-' + '00001'  
          
  END                
 ELSE                
  BEGIN                
    
     
 SET  @contador = convert(int,SUBSTRING(@codigo_documento,6,5))   
          
   SET @contador = @contador + 1     
   SET @codigo_documento = @codigo_patron + '-' + right('0000'+ convert(varchar(5),@contador),5) 
   END     
               
 RETURN (@codigo_documento)                
END

GO

