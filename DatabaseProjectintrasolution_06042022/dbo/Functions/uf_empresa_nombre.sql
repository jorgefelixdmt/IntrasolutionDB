
CREATE FUNCTION [dbo].[uf_empresa_nombre](
@tipo_empresa varchar(50),
@id_empresa VARCHAR(50))
RETURNS varchar(200)
AS 
BEGIN

declare @razon_social varchar(200) 

    IF(@tipo_empresa='18')--eps
    BEGIN
        select @razon_social = razon_social from fb_eps_ec where fb_eps_ec_id = @id_empresa

    END

    IF(@tipo_empresa='7')--laboratorio
    BEGIN
        select @razon_social = razon_social from fb_laboratorio where fb_laboratorio_id = @id_empresa

    END

    IF(@tipo_empresa='36')--consultora
    BEGIN
        select @razon_social = razon_social from fb_consultora where fb_consultora_id = @id_empresa

    END

    IF(@tipo_empresa='56')--empresa_especializada
    BEGIN
        select @razon_social = razon_social from fb_empresa_especializada where fb_empresa_especializada_id = @id_empresa

    END

    RETURN @razon_social
END;

GO

