CREATE proc pr_lista_empleados_mes_anterior    
@uea_id numeric(10,0)    
AS    
BEGIN    
SELECT    
emp.nombreCompleto as nombre,    
emp.area_nombre as area,    
emp.cargo_nombre as cargo,    
emp.fecha_ingreso as fecha_ingreso    
FROM fb_empleado emp    
where emp.fb_uea_pe_id = @uea_id    
and DATEDIFF(DAY,DATEADD(DAY, -30, GETDATE()),EMP.fecha_ingreso) >= 0    
  
END

GO

