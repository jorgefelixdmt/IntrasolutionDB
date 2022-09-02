/*      
****************************************************************************************************************************************
Nombre: dbo.pr_rpt_pa_pase_pendiente_detalle
Fecha Creacion: 23/02/2021
Autor: Mauro Roque
Descripcion: store que lista la detalle de incidentes de un pase pendiente
Llamado por: Clase java
Usado por: Modulo: mesa de Ayuda / Consulta
Uso: pr_rpt_pa_pase_pendiente_detalle 160294
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
**********************************************************************************************************
*/
CREATE proc pr_rpt_pa_pase_pendiente_detalle
@pa_pase_id int
AS
	SELECT 
		ISNULL(inc.codigo_ticket,paa.codigo_jira) as ticket,
		ISNULL(convert(varchar(10),inc.fecha,120),convert(varchar(10),paa.fecha_incidencia,120)) as fecha,
		inc.ambito as ambito_inc,
		ti.nombre as tipo_inc,
		ISNULL(inc.reportado_por,'') as reportado_por,
		ISNULL(inc.descripcion_incidente,paa.descripcion) as descipcion
	FROM pa_pase_asociado paa 
		LEFT OUTER JOIN inc_incidencia inc on paa.inc_incidencia_id = inc.inc_incidencia_id
		left join inc_tipo_incidencia ti on ti.inc_tipo_incidencia_id = inc.inc_tipo_incidencia_id	-- 2021-10-16
	WHERE
		paa.is_deleted = 0 AND
		paa.pa_pase_id = @pa_pase_id

GO

