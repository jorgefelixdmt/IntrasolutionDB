/*      
****************************************************************************************************************************************
Nombre: dbo.pr_aviso_evaluacion
Fecha Creacion: --
Autor: --
Descripcion: funcion que genera codigo correlativo de la SAC
Llamado por: js
Usado por: Modulo: PLanes de Accion
Parametros: @sac_accion_correctiva_id - ID de la SAC
			@fb_uea_pe_id - Id de la UEA
Uso: select dbo.[uf_sac_codigo_accion_correctiva] (1,1)
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE function [dbo].[uf_sac_codigo_accion_correctiva] (@sac_accion_correctiva_id numeric(10,0),@fb_uea_pe_id numeric(10,0))      
      
returns varchar(150)      
      
AS      
      
BEGIN              
             
    DECLARE @codigo_origen varchar(50), @codigo_sam varchar(50)  
	DECLARE @contador int    , @codigo_patron VARCHAR(200)          
                                      
 set @codigo_origen = (Select codigo_registro_origen from sac_accion_correctiva where sac_accion_correctiva_id = @sac_accion_correctiva_id)              
      
	  
	   set  @codigo_patron = 'SAC' +'-'+  @codigo_origen
	            
 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --              
 SET @codigo_sam  = (Select MAX(codigo_accion_correctiva) from sac_accion_correctiva  where   is_deleted=0 and codigo_accion_correctiva  like  @codigo_patron + '%')               
               
 -- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO              
 IF (@codigo_sam is Null)              
  BEGIN              
   -- CREA EL CODIGO CON 0001              
      set  @codigo_sam = @codigo_patron+ '-' + '01'      
	        
  END              
 ELSE              
  BEGIN              
   -- ARMA EL CODIGO RECUPERANDO EL ULTIMO CONTADOR Y SUMANDOLE 1              
   SET @contador = convert(int,right(@codigo_sam,2))        
   SET @contador = @contador + 1              
   SET @codigo_sam = @codigo_patron + '-' + right('0'+ convert(varchar(5),@contador),2)             
  END              
 RETURN (@codigo_sam)              
END

GO

