


/*      
****************************************************************************************************************************************
Nombre: dbo.pr_g_actualiza_datos_jira
Fecha Creacion: 14/01/2021
Autor: Mauro Roque
Descripcion: Store que actualiza datos del jira en el Modulo Mesa de Ayuda
Llamado por: js
Usado por: Modulo: Mesa de Ayuda
Parametros: @id_incidencia - Cadena de IDS de Incidencia
Uso: exec pr_g_actualiza_datos_jira '1-'
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
17/01/2021              Valky Salinas          Se agregaron los procedimientos de actualización de data de incidentes.

23/03/2021              Valky Salinas          Se agregó parámetro a los SP de actualización de incidencias y pases.

****************************************************************************************************************************************
*/

CREATE proc [dbo].[pr_g_actualiza_datos_jira]
@id_incidencia varchar(200)
as
begin
declare @flag int

set  @flag = 1

exec pr_pry_jira_actualiza_incidencias_relacionadas ''

exec pr_pry_jira_actualiza_estado_incidencias ''

select @flag as flag
end

GO

