


--select [dbo].[uf_codigo_curso] (14,'2016-04-01')
CREATE function [dbo].[uf_codigo_curso] (@fb_uea_pe_id numeric(10,0), @fecha_curso datetime)

returns varchar(150)

AS

BEGIN
    DECLARE @modulo varchar(50)
    DECLARE @codigo_uea varchar(50)
    DECLARE @anno varchar(50)
    DECLARE @codigo_patron varchar(50)
    DECLARE @codigo_cur varchar(50)
	DECLARE @contador int
	
	--SET  @i=(select COUNT(*) codigo from cap_curso where fb_uea_pe_id=@fb_uea_pe_id )
	
	set @modulo = 'CUR'
	set @codigo_uea = (select UPPER(codigo) from fb_uea_pe where fb_uea_pe_id=@fb_uea_pe_id)
	set @anno = YEAR(@fecha_curso)
	
	-- DEFINE PATRON DEL CODIGO --
	set  @codigo_patron = @modulo + '-' + @codigo_uea + '-' + @anno 
	
	-- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --
	SET @codigo_cur  = (Select MAX(codigo) from cap_curso  where codigo like @codigo_patron + '%') 
	
	-- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO
	IF (@codigo_cur is Null)
		BEGIN
			-- CREA EL CODIGO CON 0001
			set  @codigo_cur = @codigo_patron + '-' + '00001'
		END
	ELSE
		BEGIN
			-- ARMA EL CODIGO RECUPERANDO EL ULTIMO CONTADOR Y SUMANDOLE 1
			SET @contador = convert(int,right(@codigo_cur,5))
			SET @contador = @contador + 1
			SET @codigo_cur = @codigo_patron + '-' + right('0000'+ convert(varchar(5),@contador),5)
		END
		
	RETURN (@codigo_cur)
END

GO

