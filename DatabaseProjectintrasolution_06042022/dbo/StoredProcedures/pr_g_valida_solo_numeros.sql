

/*      
****************************************************************************************************************************************
Nombre: dbo.[pr_g_valida_solo_numeros]
Fecha Creacion: 12/05/20202
Autor: Mauro Roque
Descripcion: SE AGREGÓ LA FUNCION QUE VALIDA LOS CAMPOS "HORA_MINUTO" EN TODOS LOS MODULOS DEL SISTEMA
SI RETORNA VALOR "1" ES VERDADERO CASO CONTRARIO ES VALOR FALSO
Llamado por: js
Usado por: Modulo: Varios
Parametros: @valor - valor "hora"
Uso: exec [pr_g_valida_solo_numeros] '51'
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/


CREATE proc [dbo].[pr_g_valida_solo_numeros]    
@valor varchar(10)    
as    
BEGIN TRY      
declare @valor_retorna numeric(10,0),@mensaje varchar(20)  
    
  set @valor_retorna = dbo.[uf_Valida_HoraMinuto] (@valor)   

if @valor_retorna <> 0  

begin    
 set @mensaje = '1'    
end    
else     
begin    
 set @mensaje = '0'    
end    
    
select @mensaje as Mensaje    
    
END TRY      
    
BEGIN CATCH      
    SELECT       
       0 AS Mensaje;      
END CATCH

GO

