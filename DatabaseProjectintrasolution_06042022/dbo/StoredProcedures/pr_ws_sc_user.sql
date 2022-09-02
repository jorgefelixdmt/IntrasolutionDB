/*******************************************************************
creado por: Jorge Felix
Descripcion: Para el logueo de los usuarios a la aplicacion movil
Fecha: 18/02/2022
*******************************************************************/
CREATE PROCEDURE [dbo].[pr_ws_sc_user]
(@user_login varchar(50),
@password varchar(50)
)
AS
BEGIN
	select
		top 1
		SC_USER_ID
		,USER_LOGIN
		,DNI
		,usuario.fb_empleado_id
		,empleado.nombreCompleto as nombre_empleado,
		(select VALUE from PM_PARAMETER WHERE CODE = 'URL_EXT') as URL_EXT,
		empleado.email as email,
		usuario.USER_LOGIN as usuario,
		usuario.PASSWORD password,
		usuario.session_string as token
	from
		SC_USER usuario
		left join fb_empleado empleado on empleado.fb_empleado_id = usuario.fb_empleado_id
	where
		(usuario.IS_DELETED is null or usuario.IS_DELETED = 0)
		and
		usuario.USER_LOGIN = @user_login and
		usuario.PASSWORD = @password

END

GO

