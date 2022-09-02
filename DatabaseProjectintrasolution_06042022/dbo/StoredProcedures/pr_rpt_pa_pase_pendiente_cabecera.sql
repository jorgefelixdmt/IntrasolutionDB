


/*      
****************************************************************************************************************************************
Nombre: dbo.pr_rpt_pa_pase_pendiente_cabecera
Fecha Creacion: 23/02/2021
Autor: Mauro Roque
Descripcion: store que lista la cabecera de un pase pendiente
Llamado por: Clase java
Usado por: Modulo: mesa de Ayuda / Consulta
Uso: pr_rpt_pa_pase_pendiente_cabecera 2,10010,2,2020
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
**********************************************************************************************************
*/
create proc pr_rpt_pa_pase_pendiente_cabecera
@id_cliente int,
@id_proyecto int,
@id_mes int,
@anno int
as
SELECT 
			
			pry.nombre as proyecto,
			pa.codigo_jira as codigo_pase,
			convert(varchar(10),pa.fecha_solicitud,103) as fecha_pase,
			IsNull(pa.descripcion,'') as descripcion_pase,
			pae.nombre as estado_actual,
			(Select top 1 nombre from pa_pase_estado pae2  Where pae2.orden >  pae.orden) as estado_pase_siguiente,
			cl.nombre as cliente,
			pa.pa_pase_id
		FROM pa_pase pa
			inner join pry_proyecto pry on pry.pry_proyecto_id = pa.pry_proyecto_id
			inner join fb_cliente cl on cl.fb_cliente_id = pry.fb_cliente_id
			inner join pa_pase_estado pae on pae.pa_pase_estado_id = pa.pa_pase_estado_id
		WHERE
			pa.is_deleted = 0 AND
			(pa.pry_proyecto_id = @id_proyecto or @id_proyecto = 0) and
			(pa.fb_cliente_id =  @id_cliente or @id_cliente = 0) and
			(month(pa.fecha_solicitud) = @id_mes  or @id_mes = 0) and
			(year(pa.fecha_solicitud) = @anno or @anno = 0 )

GO

