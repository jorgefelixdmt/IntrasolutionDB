

CREATE PROCEDURE [dbo].[pr_reporte_asistencia_cabecera]
(@curso_id int, @Anno int,  @fb_uea_pe_id int)
AS
BEGIN
select curso.nombre as nombre_curso, Convert(varchar(10),curso.fecha_inicio, 103) as fecha_curso,expositor, institucion, horas as duracion_horas,
 uea.nombre as uea, curso.cap_curso_id
from cap_curso curso
inner join fb_uea_pe uea on curso.fb_uea_pe_id=uea.fb_uea_pe_id
WHERE 
    (year(curso.fecha_inicio) = @Anno or @Anno=0) 
	   and  curso.is_deleted =0
       and (@fb_uea_pe_id is null or curso.fb_uea_pe_id = @fb_uea_pe_id)
       and (@curso_id is null or curso.cap_curso_id = @curso_id)

END

GO

