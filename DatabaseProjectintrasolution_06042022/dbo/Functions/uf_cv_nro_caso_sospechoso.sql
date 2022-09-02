
/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_cv_nro_caso_sospechoso]
Fecha Creacion: 08/05/2020
Autor: Mauro Roque
Descripcion: Genera nro caso correlaltivo por Sede
Llamado por: TRIGGER tr_cv_genera_nro_caso
Usado por: Modulo: Caso Sospechoso
Parametros: 
	@cv_caso_sospechoso_id - ID de caso sospechoso
	@fb_uea_pe_id - ID sede
Uso: select dbo.[uf_cv_nro_caso_sospechoso] (5,1)
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE function [dbo].[uf_cv_nro_caso_sospechoso] (@cv_caso_sospechoso_id numeric(10,0),@fb_uea_pe_id numeric(10,0))           
returns varchar(150)              
AS              
BEGIN              
    DECLARE @codigo_uea varchar(50)              
    DECLARE @anno varchar(50)              
    DECLARE @codigo_patron varchar(50)              
    DECLARE @codigo_CV varchar(50)              
 DECLARE @contador int         
      
 set @codigo_uea = (select UPPER(codigo) from fb_uea_pe where fb_uea_pe_id=@fb_uea_pe_id)              
set @anno = (select year(fecha_registro) from cv_caso_sospechoso where cv_caso_sospechoso_id=@cv_caso_sospechoso_id)   
 
 -- DEFINE PATRON DEL CODIGO --              
 set  @codigo_patron = @codigo_uea + '-' + @anno        
 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --              
 SET @codigo_CV  = (Select MAX(numero_caso) from cv_caso_sospechoso  where is_deleted=0 and numero_caso like @codigo_patron + '%' and fb_uea_pe_id = @fb_uea_pe_id )               

 -- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO              
  IF (@codigo_CV is Null)              
    BEGIN              
	   -- CREA EL CODIGO CON 0001              
	      set  @codigo_CV = @codigo_patron + '-' + '0000000001'          
		    END              
 ELSE              
  BEGIN              
   -- ARMA EL CODIGO RECUPERANDO EL ULTIMO CONTADOR Y SUMANDOLE 1              

   SET @contador = convert(int,right(@codigo_CV,10))        
   SET @contador = @contador + 1              
   SET @codigo_CV = @codigo_patron + '-' + right('000000000'+ convert(varchar(10),@contador),10)             
  END              
 RETURN (@codigo_CV)              
END

GO

