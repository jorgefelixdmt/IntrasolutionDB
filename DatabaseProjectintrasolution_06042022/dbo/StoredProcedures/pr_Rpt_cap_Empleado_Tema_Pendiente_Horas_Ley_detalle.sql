

/*    
 Retorna la relacion de empleados por Tema que no han completado la capacitacion por Horas Ley.    
     
  pr_Rpt_cap_Empleado_Tema_Pendiente_Horas_Ley_detalle 0,2014  
      
*/

CREATE PROCEDURE [dbo].[pr_Rpt_cap_Empleado_Tema_Pendiente_Horas_Ley_detalle]    
 @fb_uea_pe_id int,    
 @Anno     int    
 --@flag_alcance  int -- 0: Curso en cualquier unidad , 1: Curso solo en la Unidad    
As    
    
Set nocount on    
    
/* Crea Tabla Temporal con Totales de Horas Asistidas por Tema */    
Select    
   emp.numero_documento,    
   are.nombre  as area_nombre,    
   emp.nombreCompleto,     
      tem.codigo as Tema_Codigo,    
      tem.nombre as Tema,    
      capt.hora_por_ley as Horas_Ley,    
      capt.hora_corp as Horas_Corp,    
      (
    
   
         Select     
                  IsNull(SUM(cur_t.duracion_hora),0)     
            from cap_curso_asistencia cur_as    
                  inner join cap_curso_tema cur_t on cur_t.cap_curso_id = cur_as.cap_curso_id    
                  inner join cap_curso cur on cur.cap_curso_id = cur_as.cap_curso_id    
            Where    
                  cur_as.fb_empleado_id = emp.fb_empleado_id    
                  and cur.cap_curso_estado_id = 4 -- 4: EJECUTADO    
                  and cur_t.cap_tema_id = tem.cap_tema_id    
                  and cur_as.resultado_nombre = 'Aprobado' -- APROBADO    
                  and YEAR(cur.fecha_inicio) = @Anno    
                  and (cur.fb_uea_pe_id = @fb_uea_pe_id OR @fb_uea_pe_id = 0)    
                 
 and emp.is_deleted = 0    
                  and cur_as.is_deleted = 0    
                  and cur.is_deleted = 0    
                  and cur_t.is_deleted = 0    
      ) as Horas_Asistidas    
    
into #Tmp_Asistencia          
from fb_empleado emp

    
      inner join fb_cargo car on car.fb_cargo_id = emp.fb_cargo_id  
	  inner join fb_area are on are.fb_area_id = emp.fb_area_id
      inner join cap_rol_capacitacion_cargo rol_car on rol_car.fb_cargo_id = car.fb_cargo_id    
      inner join cap_rol_capacitacion rol on rol.cap_rol_capacitacion_id = rol_car.cap_rol_capacitacion_id    
      inner join cap_tema_rol capt on capt.cap_rol_capacitacion_id = rol.cap_rol_capacitacion_id    
      inner join cap_tema tem on tem.cap_tema_id = capt.cap_tema_id   
Where ( emp.fb_uea_pe_id = @fb_uea_pe_id  or @fb_uea_pe_id =0 )
 and emp.is_deleted = 0
 and car.is_deleted=0 and are.is_deleted=0 and rol_car.is_deleted=0 and rol.is_deleted=0 and capt.is_deleted=0 and tem.is_deleted=0    
    
/* Recupera la cantid
ad de horas pendientes por Tema */    
Select    
   numero_documento,    
   area_nombre,    
   nombreCompleto,     
      Tema_Codigo,    
      Tema,    

 SUM(Horas_Ley - Horas_Asistidas) as Cantidad_HH    
from #Tmp_Asistencia    
Where (Horas_Asistidas - Horas_Ley ) < 0    
Group by numero_documento, area_nombre, nombreCompleto, Tema_Codigo, Tema    
Order by area_nombre,nombreCompleto

GO

