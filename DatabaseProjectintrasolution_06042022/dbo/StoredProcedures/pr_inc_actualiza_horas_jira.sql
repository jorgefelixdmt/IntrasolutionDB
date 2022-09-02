/*
****************************************************************************************************************************************
Nombre: dbo.pr_inc_actualiza_horas_jira
Fecha Creacion: 02/02/2022
Autor: Valky Salinas  
Descripcion: SP que actualiza horas de JIRA
Usado por: IncidenciaPorEjecutarController.js
Parametros: @horas_id  -  Lista de ID de registros de horas
Uso: pr_inc_actualiza_horas_jira '1-2-3'
****************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(aaaa-mm-dd)       Autor                  Comentarios
------------------      -----------------      ------------------------------------------------------------------------------------

**************************************************************************************************************************************
*/
CREATE proc [dbo].[pr_inc_actualiza_horas_jira]  
 @horas_id varchar(max) 
AS  
  
DECLARE @inc_incidencia_hh_id numeric(10,0), @codigo_jira varchar(200), @horas numeric(23,10)
DECLARE @base_url varchar(200), @titulo varchar(max)

-- Obtiene URL base
SELECT @base_url = propertyvalue 
FROM DTECH_185.jira_db.dbo.propertystring 
WHERE 
	ID IN (
			SELECT ID 
			FROM DTECH_185.jira_db.dbo.propertyentry 
			WHERE property_key LIKE '%baseurl%'
			)

-- Recorre registros de horas
DECLARE CURSOR_HH CURSOR FOR 
	SELECT CAST(item AS numeric(10,0))
	FROM dbo.uf_Split(@horas_id,'-')

OPEN CURSOR_HH  
FETCH NEXT FROM CURSOR_HH INTO @inc_incidencia_hh_id  

WHILE @@FETCH_STATUS = 0  
 BEGIN  
	SELECT @codigo_jira = codigo_jira
	FROM inc_incidencia_hh
	WHERE inc_incidencia_hh_id = @inc_incidencia_hh_id

	SELECT 
		@horas = t.tiempo/3600,
		@titulo = t.titulo
	FROM (
			SELECT 
				jpr.pkey + '-' + CONVERT(VARCHAR,ji.issuenum) codigo_jira,
				ji.ID jiraissue_id,
				ji.TIMESPENT tiempo,
				ji.SUMMARY titulo
			FROM DTECH_185.jira_db.dbo.jiraissue ji
				INNER JOIN DTECH_185.jira_db.dbo.project jpr ON ji.PROJECT = jpr.ID
		 ) t
	WHERE t.codigo_jira = @codigo_jira

	UPDATE inc_incidencia_hh
	SET numero_hh = @horas, url_jira = @base_url + '/browse/' + @codigo_jira, concepto = @titulo
	WHERE inc_incidencia_hh_id = @inc_incidencia_hh_id

	FETCH NEXT FROM CURSOR_HH INTO @inc_incidencia_hh_id 
 END 

CLOSE CURSOR_HH  
DEALLOCATE CURSOR_HH 

SELECt 1 response

GO

