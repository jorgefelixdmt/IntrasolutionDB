

/*
--exec pr_envia_contrasena '1-1'  
-- =============================================  
-- Author:  <Carlos Cubas>  
-- Create date: <25/01/2017>  
-- Description: <envia contraseña a usuario>  
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
16-01-2020			Mauro Roque      se agrego variable @excluye_ad que envia datos del usuario con @empresa o solo el nombre usuario
16-01-2020			Mauro Roque      se agreg el store pr_g_CadenaAleatoria para obtener cadena aleatoria para 
									 la contraseña de un usuario

-- =============================================  
*/
CREATE PROCEDURE [dbo].[pr_envia_contrasena]  
@cadena varchar(1000)  
AS  
BEGIN  
  
DECLARE   
@SC_USER_ID int  
,@id_parametro varchar(20)  
,@PASS_ENCRIPTADO varchar(10)  
,@TIPO_ENCRIPTACION varchar(50)  
,@ARROBA varchar(200)  
,@cuerpo_email     nvarchar(1000)  
,@asunto_email     nvarchar(1000)  
,@EXCLUYE_AD int  -- agregado por mauro 16-01-2020
  
DECLARE @Random INT  
DECLARE @Upper INT  
DECLARE @Lower INT  
DECLARE @contrasena varchar(200)  
DECLARE @PERFIL_NOMBRE_SQL varchar(50)  
DECLARE @SYSTEM_NAME_APP_EMAIL varchar(200)  
DECLARE @URL_APP varchar(200)  
DECLARE @USER_LOGIN varchar(200)  
DECLARE @USER_EMAIL varchar(200)  
DECLARE @CODIGO_EMAIL varchar(200)  
  
  
  
  select  TOP 1 @PASS_ENCRIPTADO = value from PM_PARAMETER where code = 'PASS_ENCRIPTADO'  
  select  TOP 1 @TIPO_ENCRIPTACION = value from PM_PARAMETER where code = 'TIPO_ENCRIPTACION'  
  select  TOP 1 @PERFIL_NOMBRE_SQL = value from PM_PARAMETER where code = 'PERFIL_SQL_MAIL'  
  select  TOP 1 @URL_APP = value from PM_PARAMETER where code = 'URL_APP'--{1}  
  select  TOP 1 @SYSTEM_NAME_APP_EMAIL = value from PM_PARAMETER where code = 'SYSTEM_NAME_APP_EMAIL'--{0}  
  select  TOP 1 @ARROBA = value from PM_PARAMETER where code = 'ARROBA'  
  
  --SET @cadena = SUBSTRING(@cadena,1,LEN(@cadena)-1)  
  
  WHILE LEN(@cadena) > 0  
  begin  
   IF PATINDEX('%-%',@cadena) > 0  
   BEGIN  
    SET @id_parametro = SUBSTRING(@cadena, 0, PATINDEX('%-%',@cadena))  
    SET @cadena = SUBSTRING(@cadena, LEN(@id_parametro + '-') + 1,LEN(@cadena))  
      
   END  
   ELSE  
   BEGIN  
    SET @id_parametro = @cadena  
    SET @cadena = NULL  
  
   END  
        
   SET @SC_USER_ID = CONVERT(numeric(10,0),@id_parametro)  
     
 
  
    ---- This will create a random number between 1 and 999  
    SET @Lower = 1 ---- The lowest random number  
    SET @Upper = 999999 ---- The highest random number  
    SELECT @Random = ROUND(((@Upper - @Lower -1) * RAND() + @Lower), 0)  
  --  SET @contrasena = @Random--{3}  
  
  -- INICIO : AGREGADO 16-01-2020
  declare @newpwd varchar(20)

	-- all values between ASCII code 48 - 122 excluding defaults
	exec [dbo].pr_g_CadenaAleatoria @len=6, @output=@newpwd out
	SET @contrasena = @newpwd

    -- FIN : AGREGADO 16-01-2020
   
     select TOP 1   
     @USER_LOGIN = USER_LOGIN--{2}  
     ,@USER_EMAIL = EMAIL 
	 ,@EXCLUYE_AD = excluye_ad  -- AGREGADO 16-01-2020
     FROM SC_USER WHERE SC_USER_ID = @SC_USER_ID  
  
     IF(@PASS_ENCRIPTADO IS NULL)  
     BEGIN  
      SET @PASS_ENCRIPTADO = '0'  
     END  
  
     IF(@TIPO_ENCRIPTACION IS NULL)  
     BEGIN  
      SET @TIPO_ENCRIPTACION = 'MD5'  
     END  
       
     IF(@PASS_ENCRIPTADO = '0')  
     BEGIN  
        
      UPDATE SC_USER set "PASSWORD" = @contrasena WHERE SC_USER_ID = @SC_USER_ID  
        
     END  
     ELSE  
     BEGIN  
      update SC_USER set "PASSWORD" = CONVERT(VARCHAR(50), HashBytes(@TIPO_ENCRIPTACION, convert(varchar(50),@contrasena)), 1)  
       
     END  
       
     SET @CODIGO_EMAIL = 'ENVIA_PASSWORD'  
       
	 if (@EXCLUYE_AD=1) -- SE AGREGO 16-01-2020
	 begin
		 SET @USER_LOGIN = @USER_LOGIN+'@'+@ARROBA 
	 end
	 else 
	 begin 
	     SET @USER_LOGIN = @USER_LOGIN
	 end

 
       
       
     IF(@USER_EMAIL IS NOT NULL AND @USER_EMAIL <> '')  
     BEGIN  
       -- se trae de DB el cuerpo y asunto de email  
       set @cuerpo_email = (select cuerpo from SC_MESSAGE_EMAIL where codigo=@CODIGO_EMAIL )  
       set @asunto_email = (select asunto from SC_MESSAGE_EMAIL where codigo=@CODIGO_EMAIL )  
       -- Se arma el asunto  
       set @asunto_email = (SELECT REPLACE(@asunto_email,'{0}',@SYSTEM_NAME_APP_EMAIL))  
         
       -- se Arma el cuerpo del email  
       set @cuerpo_email = (SELECT REPLACE(@cuerpo_email,'{0}',@SYSTEM_NAME_APP_EMAIL))  
       set @cuerpo_email = (SELECT REPLACE(@cuerpo_email,'{1}',@URL_APP))  
       set @cuerpo_email = (SELECT REPLACE(@cuerpo_email,'{2}',@USER_LOGIN))  
       set @cuerpo_email = (SELECT REPLACE(@cuerpo_email,'{3}',@contrasena))  
  
       -- se envia el email   
       EXEC  msdb.dbo.sp_send_dbmail   
       @profile_name =@PERFIL_NOMBRE_SQL ,  
       @recipients  =@USER_EMAIL,  
       @subject  =@asunto_email,  
       @body   =@cuerpo_email,  
       @body_format ='HTML';  
     END  
       
  END  
   
  
END

GO

