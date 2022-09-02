

CREATE proc [dbo].[pr_Curso_En_Ejecucion_List]
@fb_uea_pe_id  numeric(10,0)
as
select 
	cap_curso_id,
	codigo, 
	nombre, 
	institucion, 
	fecha_final, 
	fecha_final,
	fb_uea_pe_id, 
	nombre + ' / ' + institucion  as detalle_curso
from cap_curso 
where fb_uea_pe_id=@fb_uea_pe_id 
	and estado = 1 -- 1: ACTIVO , 0: INACTIVO
	and cap_curso_estado_id= 2  -- 1:PROGRAMADO 2:EJECUCION 3:ANULADO 4:EJECUTADO 
	and is_deleted = '0'
order by nombre

GO

