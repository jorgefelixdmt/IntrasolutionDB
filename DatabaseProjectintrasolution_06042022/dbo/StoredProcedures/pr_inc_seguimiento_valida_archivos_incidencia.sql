/*      
****************************************************************************************************************************************
Nombre: dbo.pr_inc_seguimiento_valida_archivos_incidencia
Fecha Creacion: 14/10/2021
Autor: Mauro Roque
Descr
ipcion: Store que valida archivos de evidencia de una incidencia en Pestana Seguimiento
Llamado por: javascript
Usado por: Modulo: Mesa Ayuda / Seguimiento
Parametros: @id_incidencia - ID de Incidencia
Uso: pr_inc_seguimiento_valida_archivos_incidencia 1
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
11/11/2021              Valky Salinas          Había un ID en duro. Se cambió por el parámetro de entrada.

****************************************************************************************************************************************
*/
CREATE PROC [dbo].[pr_inc_seguimiento_valida_archivos_incidencia]
@id_incidencia int
as
begin
DECLARE @FLAG INT
DECLARE @archivo_informe_incidente varchar(200),@paquete_archivo VARCHAR(200),@archivo_procedimiento_instalacion VARCHAR(200),
	@archivo_casos_prueba VARCHAR(200)

SET @archivo_informe_incidente = (select archivo_informe_incidente 
									from inc_incidencia 
									where inc_incidencia_id = @id_incidencia )

SET @paquete_archivo = (select paquete_archivo 
									from inc_incidencia 
									where inc_incidencia_id = @id_incidencia )

SET @archivo_procedimiento_instalacion = (select archivo_procedimiento_instalacion 
									from inc_incidencia 
									where inc_incidencia_id = @id_incidencia )

SET @archivo_casos_prueba = (select archivo_casos_prueba 
									from inc_incidencia 
									where inc_incidencia_id = @id_incidencia )

IF (@archivo_informe_incidente IS NULL OR @paquete_archivo IS NULL
	OR @archivo_procedimiento_instalacion IS NULL OR @archivo_casos_prueba IS NULL)
	BEGIN
			SET @FLAG = 0
	END
ELSE 
	BEGIN
			SET @FLAG = 1
	END

SELECT @FLAG AS flag

end

GO

