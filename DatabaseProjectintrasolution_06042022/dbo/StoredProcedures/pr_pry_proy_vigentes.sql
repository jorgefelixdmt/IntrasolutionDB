/*
Creado por: Valky Salinas
Fecha Creacion: 03/07/2020
Descripcion: SP que devuelve una lista de los proyectos vigentes
Parametros: @usuario   -    ID Usuario
[dbo].[pr_pry_proy_vigentes] 19

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_pry_proy_vigentes]
@usuario numeric(10,0)

AS

SET NOCOUNT ON;

DECLARE @cliente_id numeric(10,0)

SELECT TOP 1 
	@cliente_id = ISNULL(id_empresa,0) 
FROM SC_USER 
WHERE SC_USER_ID = @usuario

SELECT
	codigo + ': ' + nombre as proyecto,
	CONVERT(VARCHAR,ISNULL(fecha_inicio_real,fecha_inicio_estimada),103) as fecha_ini,
	CONVERT(VARCHAR,ISNULL(fecha_fin_real,fecha_fin_estimada),103) as fecha_fin
FROM pry_proyecto
WHERE
	is_deleted = 0 AND
	estado = 1 AND
	(fb_cliente_id = @cliente_id OR @cliente_id = 0)

GO

