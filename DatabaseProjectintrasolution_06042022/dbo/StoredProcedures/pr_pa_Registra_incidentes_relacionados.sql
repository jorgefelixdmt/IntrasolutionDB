/*
Nombre: dbo.pr_pa_Registra_incidentes_relacionados
Fecha Creación: 01/03/2022
Autor: Valky Salinas
Descripción: Actualiza los registros de carga masiva de Objetos.
Llamado por: dbo.[pr_pa_Registra_incidentes_relacionados]
Usado por: Carga de Objetos
Parámetro(s): @pa_entrega_objetos_id numeric(10,0), @usuario_id numeric(10,0)
Uso: exec pr_pa_Registra_incidentes_relacionados 2,1

********************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ------------------------------------------------------------------------------------------------

*********************************************************************************************************************************************
*/

CREATE procedure [dbo].[pr_pa_Registra_incidentes_relacionados]
@pa_entrega_objetos_id numeric(10,0), @usuario_id numeric(10,0)
as
set nocount on
Set dateformat dmy

DECLARE @incidencia_id numeric(10,0), @jira varchar(200), @url_jira varchar(500), @base_url varchar(200)

SELECT @base_url = propertyvalue 
FROM DTECH_185.jira_db.dbo.propertystring 
WHERE 
	ID IN (
			SELECT ID 
			FROM DTECH_185.jira_db.dbo.propertyentry 
			WHERE property_key LIKE '%baseurl%'
			)

DECLARE CURSOR_REGS CURSOR FOR
	SELECT 
		incidencia_jira_codigo,
		inc_incidencia_id
	FROM pa_objetos
	WHERE
		is_deleted = 0 AND
		pa_entrega_objetos_id = @pa_entrega_objetos_id

OPEN CURSOR_REGS

FETCH NEXT FROM CURSOR_REGS INTO
	@jira,
	@incidencia_id

 WHILE @@Fetch_Status = 0   
  BEGIN
	SET @url_jira = @base_url + '/browse/' + @jira

	IF NOT EXISTS(SELECT * FROM pa_entrega_incidentes WHERE is_deleted = 0 AND codigo_jira = @jira AND pa_entrega_objetos_id = @pa_entrega_objetos_id)
	 BEGIN
		Insert into pa_entrega_incidentes
			(
			codigo_jira,
			inc_incidencia_id,
			link_jira,
			pa_entrega_objetos_id,
			created,
			created_by,
			updated,
			updated_by,
			owner_id,
			is_deleted
			)
		values
			(
			@jira,
			@incidencia_id,
			@url_jira,
			@pa_entrega_objetos_id,
			getdate(),
			@usuario_id,
			getdate(),
			@usuario_id,
			@usuario_id,
			0
			)
	 END

	FETCH NEXT FROM CURSOR_REGS INTO
		@jira,
		@incidencia_id

 END

CLOSE CURSOR_REGS
DEALLOCATE CURSOR_REGS

GO

