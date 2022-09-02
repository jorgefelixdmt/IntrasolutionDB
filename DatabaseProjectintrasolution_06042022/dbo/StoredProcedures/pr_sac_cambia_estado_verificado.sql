

/*
Autor : Mauro Max Roque Villavicecion
Descripcion : cambia de estado a verificado


*/
  
CREATE proc pr_sac_cambia_estado_verificado    
@sac_accion_correctiva_id numeric(10,0),
@fecha_verificacion varchar(10),
@observacion_verificador varchar(500) 
as    
update sac_accion_correctiva   
	set
	    sac_estado_accion_correctiva_id=7 , 
		fecha_verificacion = convert(datetime,@fecha_verificacion, 103),
		observaciones_verificador = @observacion_verificador
where sac_accion_correctiva_id= @sac_accion_correctiva_id

GO

