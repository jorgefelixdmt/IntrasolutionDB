/*      
****************************************************************************************************************************************
Nombre: dbo.[dbo.uf_calcula_horas_trabajadas]
Fecha Creacion: 05/04/2022
Autor: Jorge Felix
Descripcion: Funcion que calcula horas trabajadas de una actividad con fecha_hora_inicio y fecha_hora_fin
Usado por: Modulo: Registro de Actividades
Parametros: (@id numeric(10,0) - ID de PK del modulo
Uso: select dbo.[uf_calcula_horas_trabajadas](82)
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE function dbo.uf_calcula_horas_trabajadas
(@id numeric(10,0))

RETURNS numeric(10,2)
AS
Begin
	DECLARE @fecha_inicio datetime
    DECLARE @fecha_fin datetime
	DECLARE @numero_horas numeric(10,2)

	Select @fecha_inicio = fecha_hora_inicio, @fecha_fin = fecha_hora_fin  From inc_incidencia_hh where inc_incidencia_hh_id = @id

	Set @numero_horas = (select convert(numeric(10,2),DATEDIFF(mi,@fecha_inicio,@fecha_fin))/60)

	RETURN (@numero_horas)

End

GO

