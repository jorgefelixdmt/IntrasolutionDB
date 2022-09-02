


CREATE PROCEDURE [dbo].[pr_Rpt_cap_Tema_Empleado_Asistencia_detalle]
@tema_id int
,@Anno int
AS
BEGIN
    Select 
    emp.nombreCompleto ,
    emp.numero_documento  as dni,
    asi.area_nombre,
    car.nombre  as puesto_trabajo_nombre,
    asi.rol_capacitacion_nombre,
    tresultado.nombre as tipo_resultado,
    curte.duracion_hora as Cantidad_HH,
    Convert(varchar(10),asi.fecha_curso, 103) as fecha_curso,
	asi.nota as nota
    from cap_curso_asistencia asi 
    inner join cap_curso cur on asi.cap_curso_id=cur.cap_curso_id 
    inner join cap_curso_tema curte on cur.cap_curso_id=curte.cap_curso_id
    inner join cap_tema tema on tema.cap_tema_id=curte.cap_tema_id
    inner join fb_empleado emp on emp.fb_empleado_id=asi.fb_empleado_id
    inner join cap_tipo_resultado tresultado on tresultado.cap_tipo_resultado_id = asi.cap_tipo_resultado_id
	inner join fb_cargo car on car.fb_cargo_id=asi.fb_cargo_id
WHERE 
	(curte.cap_tema_id = @tema_id)
    and asi.cap_tipo_resultado_id = 1
    and asi.estado = 1
	and asi.is_deleted=0 and curte.is_deleted=0 and tema.is_deleted=0 and car.is_deleted=0
     and (year(cur.fecha_inicio) = @Anno or @Anno=0
) 
Order by asi.area_nombre, emp.nombreCompleto
END

GO

