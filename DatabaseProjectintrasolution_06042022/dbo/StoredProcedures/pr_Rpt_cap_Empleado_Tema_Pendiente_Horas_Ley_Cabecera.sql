
CREATE proc [pr_Rpt_cap_Empleado_Tema_Pendiente_Horas_Ley_Cabecera]
 @fb_uea_pe_id int,  
 @Anno     int
 --@flag_alcance  int -- 0: Curso en cualquier unidad , 1: Curso solo en la Unidad  
As  
begin    
Select 
distinct          
   case @fb_uea_pe_id when 0
   then 'TODAS'
   else uea.nombre end as Unidad,    
   YEAR(cur.fecha_inicio) as Anno 
from fb_uea_pe uea inner join cap_curso cur    
on uea.fb_uea_pe_id=cur.fb_uea_pe_id    
where     
YEAR(cur.fecha_inicio) = @Anno and
--(cur.fb_uea_pe_id = @fb_uea_pe_id OR @flag_alcance = 0)  
(cur.fb_uea_pe_id = @fb_uea_pe_id OR @fb_uea_pe_id = 0)  
end

GO

