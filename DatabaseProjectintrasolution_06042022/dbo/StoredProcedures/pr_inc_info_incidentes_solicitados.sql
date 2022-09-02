/*
Creado por: Valky Salinas
Fecha Creacion: 22/02/2021
Descripcion: SP para tabla de incidencias pendientes
Parametros: @usuario   -    ID Usuario
[dbo].[pr_inc_info_incidentes_solicitados] 1,0

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_inc_info_incidentes_solicitados]
@usuario numeric(10,0),
@tipoinc numeric(10,0)

AS

SET NOCOUNT ON;

DECLARE @cliente_id numeric(10,0)

SELECT TOP 1 
	@cliente_id = ISNULL(id_empresa,0) 
FROM SC_USER 
WHERE SC_USER_ID = @usuario



DECLARE @total int, @cant_int int, @cant_ext int

SELECT @total = COUNT(*)
FROM inc_incidencia
WHERE
	is_deleted = 0 AND
	inc_estado_incidencia_id IN (1,2,3,4,10003,10004) AND -- Pre Cliente
	(inc_tipo_incidencia_id = @tipoinc OR @tipoinc = 0) AND
	(fb_cliente_id = @cliente_id OR @cliente_id = 0)

SELECT @cant_int = COUNT(*)
FROM inc_incidencia
WHERE
	is_deleted = 0 AND
	inc_estado_incidencia_id IN (1,2,3,4,10003,10004) AND -- Pre Cliente
	(inc_tipo_incidencia_id = @tipoinc OR @tipoinc = 0) AND
	(ambito = 'INT') AND
	(fb_cliente_id = @cliente_id OR @cliente_id = 0)

SELECT @cant_ext = COUNT(*)
FROM inc_incidencia
WHERE
	is_deleted = 0 AND
	inc_estado_incidencia_id IN (1,2,3,4,10003,10004) AND -- Pre Cliente
	(inc_tipo_incidencia_id = @tipoinc OR @tipoinc = 0) AND
	(ambito = 'EXT') AND
	(fb_cliente_id = @cliente_id OR @cliente_id = 0)

SELECT
	 @cliente_id cliente_id,
	 @total total,
	 @cant_int internos,
	 @cant_ext externos

GO

