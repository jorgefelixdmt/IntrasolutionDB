
/*
exec [pr_reporte_asistencia_detalle] 22

*/

CREATE PROCEDURE [dbo].[pr_reporte_asistencia_detalle]
(@curso_id int)
AS
BEGIN
select 
empl.nombreCompleto as empleado
, empl.numero_documento as dni
, are.nombre as area_nombre
, car.nombre as  cargo_nombre
, asis.nota as nota
, tresultado.nombre as tipo_resultado
--, Convert(varchar(10),asis.fecha_curso, 103) as fecha_curso
from cap_curso_asistencia asis
inner join cap_curso curso on curso.cap_curso_id=asis.cap_curso_id
inner join fb_empleado empl on asis
.fb_empleado_id= empl.fb_empleado_id
      inner join fb_cargo car on car.fb_cargo_id = empl.fb_cargo_id  
	  inner join fb_area are on are.fb_area_id = empl.fb_area_id
inner join cap_tipo_resultado tresultado on tresultado.cap_tipo_resultado_id=asis.cap_tipo_resultado_id
WHERE 
	(asis.cap_curso_id = @curso_id)
Order by empl.nombreCompleto ,are.nombre 
asc
END

GO

