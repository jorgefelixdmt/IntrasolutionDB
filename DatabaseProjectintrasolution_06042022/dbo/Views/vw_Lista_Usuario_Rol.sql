
--Creación de la vista para el reporte SC_UEA_Usuario_ROL
create view vw_Lista_Usuario_Rol
As
	select	
			UEA.fb_uea_pe_id,
			UEA.nombre as UEA, 
			U.SC_USER_ID,
			U.USER_LOGIN AS USUARIO,
			UPPER(U.NAME) AS NOMBRE_USUARIO,
			R.SC_ROLE_ID, 
			R.NAME AS ROL
	from SC_USER_ROLE UR
		INNER JOIN fb_uea_pe UEA ON UR.fb_uea_pe_id=UEA.fb_uea_pe_id
		inner join SC_USER U on UR.SC_USER_ID = U.SC_USER_ID
		INNER JOIN SC_ROLE R ON UR.SC_ROLE_ID = R.SC_ROLE_ID
	WHERE 
		U.is_deleted=0 AND 
		R.is_deleted=0

GO

