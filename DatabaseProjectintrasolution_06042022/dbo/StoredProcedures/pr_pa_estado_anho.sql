/*
Creado por: Valky Salinas
Fecha Creacion: 03/07/2020
Descripcion: SP que devuelve data de gráficos de pases pendientes por estado
Parametros: @usuario   -    ID Usuario
[dbo].[pr_pa_estado_anho] 19,0

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_pa_estado_anho]
@usuario numeric(10,0),
@anho int

AS

SET NOCOUNT ON;

DECLARE @cliente_id numeric(10,0)

SELECT TOP 1 
	@cliente_id = ISNULL(id_empresa,0) 
FROM SC_USER 
WHERE SC_USER_ID = @usuario


SELECT 
	pe.nombre estado,
	COUNT(*) cantidad
FROM pa_pase p
	INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = p.pry_proyecto_id
	INNER JOIN pa_pase_estado pe ON pe.pa_pase_estado_id = p.pa_pase_estado_id
WHERE
	p.is_deleted = 0 AND
	pr.is_deleted = 0 AND
	pe.is_deleted = 0 AND
	p.pa_pase_estado_id NOT IN (9,10004) AND -- Culminado, Cancelado
	(pr.fb_cliente_id = @cliente_id OR @cliente_id = 0) AND
	(pe.orden >= 50 OR @cliente_id = 0)
GROUP BY pe.nombre
ORDER BY pe.nombre

GO

