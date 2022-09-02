/*
Creado por: Valky Salinas
Fecha Creacion: 22/02/2021
Descripcion: SP para tabla de pases pendientes
Parametros: @usuario   -    ID Usuario
[dbo].[pr_inc_info_pases_pendientes] 2

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------
01/07/2021				Jorge Felix			Se agrego variable @cant_dom donde se guarda cantidad de pases en Dominiotech
											@cant_cli donde se guarda cantidad de Enviados al cliente
*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_inc_info_pases_pendientes]
@usuario numeric(10,0)

AS

SET NOCOUNT ON;

DECLARE @cliente_id numeric(10,0)

SELECT TOP 1 
	@cliente_id = ISNULL(id_empresa,0) 
FROM SC_USER 
WHERE SC_USER_ID = @usuario



DECLARE @total int, @cant_qa int, @cant_dom int, @cant_prod int, @cant_cli int

IF @cliente_id <> 0
 BEGIN
	SELECT @total = COUNT(*)
	FROM pa_pase p
		INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = p.pry_proyecto_id
	WHERE
		p.is_deleted = 0 AND
		(pa_pase_estado_id NOT IN (7, 9,10004) AND pa_pase_estado_id > 4) AND -- 7: Revisado en QA, 9: Conforme, 10004: Cancelado / Enviado a cliente

		(pr.fb_cliente_id = @cliente_id OR @cliente_id = 0)
 END
ELSE
 BEGIN
	SELECT @total = COUNT(*)
	FROM pa_pase p
		INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = p.pry_proyecto_id
	WHERE
		p.is_deleted = 0 AND
		pa_pase_estado_id NOT IN (9,10004) AND -- 9: Conforme, 10004: Cancelado / Enviado a cliente
		(pr.fb_cliente_id = @cliente_id OR @cliente_id = 0)
 END

SELECT @cant_qa = COUNT(*)
FROM pa_pase p
	INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = p.pry_proyecto_id
WHERE
	p.is_deleted = 0 AND
	pa_pase_estado_id IN (5,6) AND -- 5: Enviado a Cliente, 6: Instalado en QA
	(pr.fb_cliente_id = @cliente_id OR @cliente_id = 0)

SELECT @cant_dom = COUNT(*)
FROM pa_pase p
	INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = p.pry_proyecto_id
WHERE
	p.is_deleted = 0 AND
	pa_pase_estado_id < 5 AND -- Menor que 50 corresponde a Dominiotech
	pa_pase_estado_id NOT IN (9,10004) AND -- 9: Conforme, 10004: Cancelado
	(pr.fb_cliente_id = @cliente_id OR @cliente_id = 0)

SELECT @cant_prod = COUNT(*)
FROM pa_pase p
	INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = p.pry_proyecto_id
WHERE
	p.is_deleted = 0 AND
	pa_pase_estado_id = 8 AND -- Instalado en Producción
	(pr.fb_cliente_id = @cliente_id OR @cliente_id = 0)

-- Agregado por JF
SELECT @cant_cli = COUNT(*)
FROM pa_pase p
	INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = p.pry_proyecto_id
WHERE
	p.is_deleted = 0 AND
	pa_pase_estado_id >= 5 AND -- En el Cliente
	pa_pase_estado_id NOT IN (9,10004) AND -- 9: Conforme, 10004: Cancelado
	(pr.fb_cliente_id = @cliente_id OR @cliente_id = 0)
--

SELECT
	 @total total,
	 @cant_qa qa,
	 @cant_dom dominiotech,
	 @cant_prod produccion,
	 @cant_cli cliente

GO

