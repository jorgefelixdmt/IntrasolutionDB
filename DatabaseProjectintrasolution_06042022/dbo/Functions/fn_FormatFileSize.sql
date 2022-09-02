/*
********************************************************************************************
Nombre:[dbo].[fn_FormatFileSize ]
Fecha de creación:09-07-2020
Autor:Flavio Cesar García
Descripción:Esta función se encarga de definir el tamaño de los archivos cargados al modulo enlace documentos
use : select dbo.fn_FormatFileSize (2486423)
********************************************************************************************
Resumen de cambios 
Fecha(aaaa-mm-dd)	Autor			Comentarios
-----------------	-------------	-------------
********************************************************************************************
*/
create Function dbo.fn_FormatFileSize (@Tamano numeric(10,0))
    RETURNS varchar(50)
As
    BEGIN
       DECLARE @TamanoFormateado varchar(50);

       IF (@Tamano < 1024)
           SET @TamanoFormateado =  convert(varchar, convert(int, @Tamano)) + ' B'
       ELSE IF @Tamano <= 1048576 -- KB
         SET @TamanoFormateado = FORMAT(@Tamano/1024,'N0') + ' KB'
        ELSE IF @Tamano >= 1048576 -- MB
             SET @TamanoFormateado = FORMAT(@Tamano/1048576,'N1') + ' MB'
       RETURN (@TamanoFormateado)
    END

GO

