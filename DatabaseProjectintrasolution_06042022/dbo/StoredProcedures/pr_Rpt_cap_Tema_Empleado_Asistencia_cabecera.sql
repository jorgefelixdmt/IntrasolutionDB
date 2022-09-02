
/*
	Retorna los temas capacitados en un año y unidad especifica
	
		pr_Rpt_cap_Tema_Empleado_Asistencia_cabecera 4,2014,1
		
*/

CREATE PROCEDURE [dbo].[pr_Rpt_cap_Tema_Empleado_Asistencia_cabecera]
 (@tema_id int,
 @Anno int,  
 @fb_uea_pe_id int)
AS
BEGIN

Select 
distinct tema.cap_tema_id,tema.codigo, tema.nombre as Tema, uea.nombre as uea,year(cur.fecha_inicio) as anno
from cap_curso_asistencia asi 
inner join cap_curso cur on asi.cap_curso_id=cur.cap_curso_id 
inner join cap_curso_tema curte on cur.cap_curso_id=curte.cap_curso_id
inner join cap_tema tema on tema.cap_tema_id=curte.cap_tema_id
inner join fb_uea_pe uea on cur.fb_uea_pe_id=uea.fb_uea_pe_id

WHERE 
    tema.estado = 1
    and (year(cur.fecha_inicio) = @Anno or @Anno=0) 
	and  cur.is_deleted =0
    and (@fb_uea_pe_id is null or cur.fb_uea_pe_id = @fb_uea_pe_id)
    and (@tema_id is null or tema.cap_tema_id = @tema_id)
END

GO

