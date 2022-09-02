-- =============================================
-- Author:		<Carlos Cubas>
-- Create date: <03/01/2017>
-- Description:	<Modifica contraseña según tipo de encriptación>
-- =============================================
--exec pr_encripta_contrasena
CREATE PROCEDURE pr_encripta_contrasena 

AS
BEGIN

	DECLARE 
	@encripta varchar(10)
	,@contrasena_ramdon varchar(100)
	,@tipo_encriptado varchar(10)


	
	select top 1 @encripta = value from PM_PARAMETER where code = 'PASS_ENCRIPTADO'
	select top 1 @tipo_encriptado = value from PM_PARAMETER where code = 'TIPO_ENCRIPTACION'
	
	--set @contrasena_ramdon = convert(numeric(6,0),rand() * 899999) + 100000
	
	--select @contrasena_guardada = "PASSWORD" from sc_user where sc_user_id = convert(int,@usuario_id)
	
	IF(@encripta = '1')
	BEGIN
		update SC_USER set "PASSWORD" = CONVERT(VARCHAR(50), HashBytes(@tipo_encriptado, convert(varchar(50),"PASSWORD")), 1)
	END
	
END

GO

