
/*      
****************************************************************************************************************************************
Nombre: dbo.pr_cv_consulta_empleado_caso_medico
Fecha Creacion: 08/05/2020
Autor: Mauro Roque
Descripcion: store que consulta datos del empleado y caso medico
Llamado por: js
Usado por: Modulo: Covid-19 / Caso Sospechoso
Parametros: @codigo_empleado - codigo empleado  
Uso: pr_cv_consulta_empleado_caso_medico '73977291'
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/  
create proc pr_cv_consulta_empleado_caso_medico  
@codigo_empleado varchar(50)
as  
  
 select
em.g_rol_empresa_id,
em.fb_empresa_especializada_id,
exa.codigo_tributario,
em.fb_uea_pe_id,
em.fb_empleado_id,
em.nombreCompleto,
em.numero_documento,
em.sexo,
convert(varchar(10),em.fecha_nacimiento,103) as fecha_nacimiento,
dbo.uf_fb_edad_actual_de_empleados (em.fb_empleado_id) as edad,
--edad
exa.peso,
exa.talla,
exa.imc,
exa.exa_clasificacion_imc_id
from fb_empleado em left join exa_datos_medico exa
on em.fb_empleado_id=exa.fb_empleado_id
where em.numero_documento=@codigo_empleado 
		--and exa.is_deleted=0

GO

