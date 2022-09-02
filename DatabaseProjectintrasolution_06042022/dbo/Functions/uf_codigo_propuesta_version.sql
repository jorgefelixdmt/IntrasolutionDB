--select [dbo].[uf_codigo_propuesta_version] (PRO-DMT-2017-00001)
create function [dbo].[uf_codigo_propuesta_version] (@pro_propuesta_id int)

returns varchar(150)

AS

BEGIN
    --DECLARE @modulo varchar(50)
    DECLARE @codigo varchar(2)
    --DECLARE @anno varchar(50)
    DECLARE @codigo_patron varchar(50)
    DECLARE @codigo_ver varchar(22)
	DECLARE @contador int
	
	--SET  @i=(select COUNT(*) codigo from cap_curso where fb_uea_pe_id=@fb_uea_pe_id )
	
	-- DEFINE PATRON DEL CODIGO --
	--set @codigo_pro = Select MAX(codigo_version) from pro_propuesta_version where pro_propuesta_id = @pro_propuesta_id  
	set @codigo_patron = (Select codigo from pro_propuesta where pro_propuesta_id = @pro_propuesta_id)
	--set @codigo_patron = @codigo 
	
	-- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --
	SET @codigo_ver  = (Select MAX(codigo_version) from pro_propuesta_version where pro_propuesta_id = @pro_propuesta_id ) 
	
	-- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO
	IF (@codigo_ver is Null)
		BEGIN
			-- CREA EL CODIGO CON 01
			set  @codigo_ver = @codigo_patron + '-' + '01'
		END
	ELSE
		BEGIN
			-- ARMA EL CODIGO RECUPERANDO EL ULTIMO CONTADOR Y SUMANDOLE 1
			SET @contador = convert(int,right(@codigo_ver,2))
			SET @contador = @contador + 1
			SET @codigo_ver = @codigo_patron + '-' + right('00'+ convert(varchar(2),@contador),2)
		END
		
	RETURN (@codigo_ver)
END

GO

