
CREATE function uf_fb_edad_actual_de_empleados (@fb_empleado_id  varchar(20))    
    
returns numeric(10,0)    
    
as    
begin    
declare @edad_empleado numeric(10,0)    
    
set @edad_empleado= (select DATEDIFF(year, fecha_nacimiento, getdate())     
    from fb_empleado where fb_empleado_id=@fb_empleado_id )    
    
    
    
 return (@edad_empleado)       
 end

GO

