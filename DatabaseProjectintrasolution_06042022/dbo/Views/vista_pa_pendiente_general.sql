

/*      
****************************************************************************************************************************************
Nombre: dbo.vista_pa_pendiente_general
Fecha Creacion: 23/02/2021
Autor: Mauro Roque
Descripcion: vista general de pases pendientes
Llamado por: Clase java
Usado por: Modulo: mesa de Ayuda 
Uso: select * from vista_pa_pendiente_general
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
**********************************************************************************************************
*/
create view vista_pa_pendiente_general
as

select 
ROW_NUMBER() OVER(ORDER BY pa.pa_pase_id asc)as pa_pase_id ,      
pa.codigo_jira as codigo_pase,
pa.fecha_solicitud as fecha_pase,
pa.descripcion as descripcion_pase,
pae.nombre as estado_pase,
pa.fecha_estado as fecha_estado_pase,
(Select top 1 nombre 
			from pa_pase_estado pae2  
			Where pae2.orden >  pae.orden)  as proximo_estado,
ISNULL(inc.codigo_ticket,pa_aso.codigo_jira) as ticket,
ISNULL(convert(varchar(10),inc.fecha,120),convert(varchar(10),pa_aso.fecha_incidencia,120)) as fecha_incidente,
inc.ambito as ambito_incidente,
ti.nombre as  tipo_incidente,
ISNULL(inc.reportado_por,'') as reportador_por,
ISNULL(inc.descripcion_incidente,pa_aso.descripcion)	 as descripcion_incidente,
pa.created,
pa.created_by,
pa.updated,
pa.updated_by,
pa.owner_id,
pa.is_deleted
from pa_pase pa 
inner join pry_proyecto pry on pry.pry_proyecto_id = pa.pry_proyecto_id
inner join fb_cliente cl on cl.fb_cliente_id = pry.fb_cliente_id
left join pa_pase_estado pae on pae.pa_pase_estado_id = pa.pa_pase_estado_id
left join pa_pase_asociado pa_aso on pa_aso.pa_pase_id = pa.pa_pase_id
left join inc_incidencia inc on pa_aso.inc_incidencia_id = inc.inc_incidencia_id
left join inc_tipo_incidencia ti on ti.inc_tipo_incidencia_id = inc.inc_tipo_incidencia_id	
where
pa.is_deleted = 0 AND
pa_aso.is_deleted = 0 AND
inc.is_deleted = 0

GO

