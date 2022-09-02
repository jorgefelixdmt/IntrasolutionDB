CREATE function [dbo].[uf_pa_objeto_obtiene_producto] (@objeto_id numeric(10,0))  
returns varchar(1000)  
  
As  
Begin  
 Declare @retorno_final varchar(1000) 
 
 SELECT 
	@retorno_final = p.nombre
 FROM pa_objetos o
	INNER JOIN prd_producto p ON p.prd_producto_id = o.prd_producto_id
 WHERE
	o.pa_objetos_id = @objeto_id

 return (@retorno_final)  
End

GO

