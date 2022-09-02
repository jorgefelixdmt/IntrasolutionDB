
--Creación de la función que usa la vista vw_Lista_Modulo_Rol
create FUNCTION [dbo].[uf_Ruta_Modulo] (@SC_MODULE_id int)
RETURNS nvarchar(500)
AS
BEGIN
	
DECLARE 
	@ruta  nvarchar(500),
	@concatenado  nvarchar(500),
	@contador numeric(10,0),
	@super_modulo_id numeric(10,0),
	@modulo_id numeric(10,0),
	@super_modulo varchar(100),
	@modulo varchar(100),
	@objeto_llamado numeric(10,0)

    Select @modulo = NAME from  SC_MODULE  where SC_MODULE_id =@SC_MODULE_id
	
	if (select MODULE_CALL from SC_MODULE  where SC_MODULE_id = @SC_MODULE_id) is null 
		Begin
			Select @super_modulo_id = SC_SUPER_MODULE_id, @modulo = NAME from  SC_MODULE  where SC_MODULE_id =@SC_MODULE_id 
			Set @ruta = (select NAME from SC_SUPER_MODULE  where SC_SUPER_MODULE_id = @super_modulo_id) + ' / ' + @modulo
		End
	else
		Begin
			Set @ruta = ''
			WHILE (select MODULE_CALL from  SC_MODULE  where SC_MODULE_id =@SC_MODULE_id  ) is  not null
				begin
					       
					Set @ruta =  (select NAME from  SC_MODULE  where SC_MODULE_id =
								(select MODULE_CALL from  SC_MODULE  where SC_MODULE_id =@SC_MODULE_id  )) +' / ' + @ruta
				
					set @SC_MODULE_id = (select MODULE_CALL from  SC_MODULE  where SC_MODULE_id =@SC_MODULE_id);                    
				End

			 Select @super_modulo_id = SC_SUPER_MODULE_id from  SC_MODULE  where SC_MODULE_id = @SC_MODULE_id
			 Set @ruta = (select NAME from SC_SUPER_MODULE   where SC_SUPER_MODULE_id = @super_modulo_id) + ' / '+ @ruta +  @modulo

		End

 RETURN(@ruta);
END;

GO

