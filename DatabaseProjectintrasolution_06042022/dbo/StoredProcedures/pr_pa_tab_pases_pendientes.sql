/*
Creado por: Valky Salinas
Fecha Creacion: 26/02/2021
Descripcion: SP para tabla de incidencias pendientes
Parametros: @usuario   -    ID Usuario
[dbo].[pr_pa_tab_pases_pendientes] 1

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------
02/06/2021				Jorge Felix			Se agrego formato de fecha yy/mm/dd
*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_pa_tab_pases_pendientes]
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
	p.descripcion,
	p.codigo_jira,
	CONVERT(varchar(10), p.fecha_solicitud, 120) fecha,
	pe.nombre as estado,
	DATEDIFF(DAY,fecha_solicitud,GETDATE()) as dias
FROM pa_pase p
	INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = p.pry_proyecto_id
	INNER JOIN pa_pase_estado pe ON pe.pa_pase_estado_id = p.pa_pase_estado_id
WHERE
	p.is_deleted = 0 AND
	pr.is_deleted = 0 AND
	pe.is_deleted = 0 AND
	p.pa_pase_estado_id NOT IN (9,10004) AND -- Culminado, Cancelado
	(pr.fb_cliente_id = @cliente_id OR @cliente_id = 0)
ORDER BY p.fecha_solicitud

GO

