/*
procedure: dbo.pr_ldap_sql_validate
create date (YYYY-MM-DD): 2019-08-01
Autor: dominiotech
description: store procedure que autentica contra el servidor LDAP de la compañia. se deben hacer configuraciones previas. 
			recupera la cadena de conexion ldap de la tabla pm_parameter
Call by: este store es invocado en el proceso de autenticación del framework:
			código java (clases bean)
affected table(s): PM_PARAMETER
Used By: la clase java
Parameter(s): @user_connection - lo que el usuario coloca en la pantalla de autenticación, ejemplo: peru\carlos.cubas
				@password - el password del usuario
				@user - continuando con el ejemplo sería: carlos.cubas

*/
CREATE procedure [dbo].[pr_ldap_sql_validate]
@user_connection varchar(100),
@password varchar(200),
@user varchar(100)
as
begin
declare @ldap_cadena_peru varchar(400)
declare @ldap_cadena_argentina varchar(400)
declare @ldap_cadena_mexico varchar(400)
Declare @sql nvarchar(max)


select @ldap_cadena_peru		=value from PM_PARAMETER where code = 'ADCADENA_PERU'
select @ldap_cadena_argentina	=value from PM_PARAMETER where code = 'ADCADENA_ARGENTINA' 
select @ldap_cadena_mexico		=value from PM_PARAMETER where code = 'ADCADENA_MEXICO' 

if CHARINDEX('PERU',@user_connection)>0
	begin

		Set @sql='SELECT  Name, displayName,givenname,distinguishedName, SAMAccountName
		FROM OPENROWSET(''ADSDSOObject'',''adsdatasource''; '''+@user_connection+''';'''+@password+''',
		''SELECT   Name, displayName,givenname,distinguishedName, SAMAccountName
			FROM '''''+@ldap_cadena_peru+''''' WHERE SAMAccountName =  '''''+@user+''''' '')'

	end

else if CHARINDEX('ARGENTINA',@user_connection)>0
	begin

		Set @sql='SELECT  Name, displayName,givenname,distinguishedName, SAMAccountName
		FROM OPENROWSET(''ADSDSOObject'',''adsdatasource''; '''+@user_connection+''';'''+@password+''',
		''SELECT   Name, displayName,givenname,distinguishedName, SAMAccountName
			FROM '''''+@ldap_cadena_argentina+''''' WHERE SAMAccountName =  '''''+@user+''''' '')'

	end

else if CHARINDEX('MEXICO',@user_connection)>0
	begin

		Set @sql='SELECT  Name, displayName,givenname,distinguishedName, SAMAccountName
		FROM OPENROWSET(''ADSDSOObject'',''adsdatasource''; '''+@user_connection+''';'''+@password+''',
		''SELECT   Name, displayName,givenname,distinguishedName, SAMAccountName
			FROM '''''+@ldap_cadena_mexico+''''' WHERE SAMAccountName =  '''''+@user+''''' '')'

	end
else
begin
		Set @sql='SELECT  Name, displayName,givenname,distinguishedName, SAMAccountName
		FROM OPENROWSET(''ADSDSOObject'',''adsdatasource''; '''+@user_connection+''';'''+@password+''',
		''SELECT   Name, displayName,givenname,distinguishedName, SAMAccountName
			FROM '''''+@ldap_cadena_mexico+''''' WHERE SAMAccountName =  '''''+@user+''''' '')'
end

Exec(@sql)


end

GO

