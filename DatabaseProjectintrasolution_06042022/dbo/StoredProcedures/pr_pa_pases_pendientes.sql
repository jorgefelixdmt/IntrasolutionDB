/*
Creado por: Valky Salinas
Fecha Creacion: 03/07/2020
Descripcion: SP que devuelve una lista de los pases pendientes
Parametros: @usuario   -    ID Usuario
[dbo].[pr_pa_pases_pendientes] 19

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_pa_pases_pendientes]
@usuario numeric(10,0)

AS

SET NOCOUNT ON;

DECLARE @cliente_id numeric(10,0)

SELECT TOP 1 
	@cliente_id = ISNULL(id_empresa,0) 
FROM SC_USER 
WHERE SC_USER_ID = @usuario

SELECT 
	pr.codigo as proyecto,
	p.codigo_jira + '</br>' + REPLACE(p.descripcion, CHAR(10), '<br/>') as pase,
	(
		SELECT TOP 1 CONVERT(VARCHAR,fecha,103)
		FROM pa_pase_seguimiento
		WHERE 
			pa_pase_id = p.pa_pase_id AND
			pa_pase_estado_id = 6 -- Instalado QA Cliente
		ORDER BY fecha DESC
	) as fecha_qa,
	pe.nombre + ' - ' + CONVERT(VARCHAR,p.fecha_estado,103) as estado_pase
FROM pa_pase p
	INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = p.pry_proyecto_id
	INNER JOIN pa_pase_estado pe ON pe.pa_pase_estado_id = p.pa_pase_estado_id
WHERE
	p.is_deleted = 0 AND
	pr.is_deleted = 0 AND
	pe.is_deleted = 0 AND
	(p.pa_pase_estado_id NOT IN (9,10004) AND p.pa_pase_estado_id >= 5) AND -- Culminado, Cancelado
	(pr.fb_cliente_id = @cliente_id OR @cliente_id = 0)

GO

