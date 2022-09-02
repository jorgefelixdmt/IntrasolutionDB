CREATE function [dbo].[uf_pa_obtiene_link_ultimo_adjunto] (@pase_entregas_id numeric(10,0))  
returns varchar(1000)  
  
As  
 Begin  
	 
	Declare @retorno_final varchar(1000) 
	DECLARE @adj1 varchar(200), @adj2 varchar(200), @adj3 varchar(200), @adj4 varchar(200)
 
	SELECT
		@adj1 = po.adjunto,
		@adj2 = po.adjunto_v2,
		@adj3 = po.adjunto_v3,
		@adj4 = po.adjunto_v4
	FROM pa_pase_entregas pe
		INNER JOIN pa_entrega_objetos po ON po.pa_entrega_objetos_id = pe.pa_entrega_objetos_id
	WHERE
		pe.pa_pase_entregas_id = @pase_entregas_id

	IF (@adj4 IS NOT NULL AND @adj4 <> '')
	 BEGIN
		SET @retorno_final = dbo.uf_link_descarga(@adj4,NULL)
	 END
	ELSE
	 BEGIN
		IF (@adj3 IS NOT NULL AND @adj3 <> '')
		 BEGIN
			SET @retorno_final = dbo.uf_link_descarga(@adj3,NULL)
		 END
		ELSE
		 BEGIN
			IF (@adj2 IS NOT NULL AND @adj2 <> '')
			 BEGIN
				SET @retorno_final = dbo.uf_link_descarga(@adj2,NULL)
			 END
			ELSE
			 BEGIN
				IF (@adj1 IS NOT NULL AND @adj1 <> '')
				 BEGIN
					SET @retorno_final = dbo.uf_link_descarga(@adj1,NULL)
				 END
				ELSE
				 BEGIN
					SET @retorno_final = NULL
				 END
			 END
		 END
	 END

	return (@retorno_final)  

 End

GO

