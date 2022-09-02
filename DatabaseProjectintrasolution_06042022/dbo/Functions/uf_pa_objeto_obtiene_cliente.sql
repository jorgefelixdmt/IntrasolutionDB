
CREATE function [dbo].[uf_pa_objeto_obtiene_cliente] (@objeto_id numeric(10,0))  
returns varchar(1000)  
  
As  
Begin  
 Declare @retorno_final varchar(1000) 
 
 SELECT 
	@retorno_final = c.nombre
 FROM pa_objetos o
	INNER JOIN fb_cliente c ON c.fb_cliente_id = o.fb_cliente_id
 WHERE
	o.pa_objetos_id = @objeto_id

 return (@retorno_final)  
End

GO

