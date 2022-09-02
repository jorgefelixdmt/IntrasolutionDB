

/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_cv_codigo_control_covid]
Fecha Creacion: 13/05/2020
Autor: Mauro Roque
Descripcion: Genera codigo correlativo de control covid por sede
Llamado por: TRIGGER
Usado por: Modulo: COntrol covid
Parametros: 
	@cv_control_covid_diario_id - ID de control covid
	@fb_uea_pe_id - ID sede
Uso: select dbo.[uf_cv_codigo_control_covid] (1,1)
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE function [dbo].[uf_cv_codigo_control_covid] (@cv_control_covid_diario_id numeric(10,0),@fb_uea_pe_id numeric(10,0))           
returns varchar(150)              
AS              
BEGIN              
    DECLARE @codigo_uea varchar(50)              
    DECLARE @anno varchar(50)              
    DECLARE @codigo_patron varchar(50)              
    DECLARE @codigo_CV varchar(50)              
 DECLARE @contador int         
      
 set @codigo_uea = (select UPPER(codigo) from fb_uea_pe where fb_uea_pe_id=@fb_uea_pe_id)              
set @anno = (select year(fecha_registro) from cv_control_covid_diario where cv_control_covid_diario_id=@cv_control_covid_diario_id)   
 
 -- DEFINE PATRON DEL CODIGO --              
 set  @codigo_patron = 'CT-' + @codigo_uea + '-' + @anno        
 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --              
 SET @codigo_CV  = (Select MAX(codigo) from cv_control_covid_diario  where is_deleted=0 and codigo like @codigo_patron + '%' and fb_uea_pe_id = @fb_uea_pe_id )               

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

