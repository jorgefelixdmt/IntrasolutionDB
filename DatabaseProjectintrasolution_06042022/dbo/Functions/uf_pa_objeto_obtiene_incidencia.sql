
CREATE function [dbo].[uf_pa_objeto_obtiene_incidencia] (@objeto_id numeric(10,0))  
returns varchar(1000)  
  
As  
Begin  
 Declare @retorno_final varchar(1000) 
 
 SELECT 
	@retorno_final = i.titulo_incidencia
 FROM pa_objetos o
	INNER JOIN inc_incidencia i ON i.inc_incidencia_id = o.inc_incidencia_id
 WHERE
	o.pa_objetos_id = @objeto_id

 return (@retorno_final)  
End

GO

