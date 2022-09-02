/*      
****************************************************************************************************************************************
Nombre: dbo.pr_cv_calculo_clasificacion_IMC
Fecha Creacion: 08/05/2020
Autor: Mauro Roque
Descripcion: store que consulta el rango la clasificacion IMC segun el rango minimo entre maximo
Llamado por: js
Usado por: Modulo: Covid-19 / Declaracion
Parametros: @IMC - valor IMC  
Uso: pr_cv_calculo_clasificacion_IMC 6
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/  
CREATE proc pr_cv_calculo_clasificacion_IMC  
@IMC numeric(10,0)
as  
  
 declare @id_clasi_imc int
  
  
select @id_clasi_imc = exa_clasificacion_imc_id  
         from exa_clasificacion_imc  
         Where @IMC >=rango_minimo   
         and @IMC <=rango_maximo  
         and is_deleted=0
  
select  @id_clasi_imc as  exa_clasificacion_imc_id

GO

