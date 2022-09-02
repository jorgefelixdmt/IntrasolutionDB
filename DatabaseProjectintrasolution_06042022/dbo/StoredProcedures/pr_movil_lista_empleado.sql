/*
Creado Por : Jorge Felix
Fecha Creacion : 16/02/2022
Descripcion :	--Retorna todos los empleados asignados a una gerencia
				--si se envia como parametro el numero 0 retornara todos los empleados
Para: aplicacion movil nodejs
*/
CREATE proc [dbo].[pr_movil_lista_empleado]
@dato numeric(10,0)
as
set nocount on
select 
	emp.fb_empleado_id,
	emp.nombreCompleto,
	emp.apellido_paterno,
	emp.apellido_materno,
	emp.nombreCompleto,
	emp.sexo,
	emp.estado_civil,
	emp.direccion,
	emp.celular,
	emp.fb_area_id,
	a.nombre as area,
	emp.fb_cargo_id,
	c.nombre as cargo,
	emp.email,
	emp.tipo_documento,
	emp.fecha_nacimiento,
	emp.g_rol_empresa_id,
	gr.nombre as clase_trabajador,
	emp.fb_empresa_especializada_id,
	ee.razon_social as empresa_especializada
 
from fb_empleado emp
inner join fb_area a on a.fb_area_id = emp.fb_area_id
inner join fb_cargo c on c.fb_cargo_id = emp.fb_cargo_id
inner join g_rol_empresa gr on gr.g_rol_empresa_id = emp.g_rol_empresa_id
inner join fb_empresa_especializada ee on ee.fb_empresa_especializada_id = emp.fb_empresa_especializada_id
where emp.is_deleted = 0 and emp.estado = 1

GO

