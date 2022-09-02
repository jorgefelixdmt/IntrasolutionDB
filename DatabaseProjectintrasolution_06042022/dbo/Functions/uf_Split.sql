

/*
procedure: dbo.uf_Split
create date (YYYY-MM-DD): 2020-07-13
Autor: Mauro Roque
description: funcion que permite separar cadena con un delimitador caracter
affected table(s): no afecta ninguna tabla
Used By: Esta función es generica y es usado por varios módulos
Parameter(s): @sInputList - nombre de la cadena
				@sDelimiter - caracter separador.
*/
create FUNCTION [dbo].[uf_Split](
    @sInputList VARCHAR(8000) -- List of delimited items
  , @sDelimiter VARCHAR(8000) = ',' -- delimiter that separates items
) RETURNS @List TABLE (item VARCHAR(8000))

BEGIN
DECLARE @sItem VARCHAR(8000)
WHILE CHARINDEX(@sDelimiter,@sInputList,0) <> 0
 BEGIN
 SELECT
  @sItem=RTRIM(LTRIM(SUBSTRING(@sInputList,1,CHARINDEX(@sDelimiter,@sInputList,0)-1))),
  @sInputList=RTRIM(LTRIM(SUBSTRING(@sInputList,CHARINDEX(@sDelimiter,@sInputList,0)+LEN(@sDelimiter),LEN(@sInputList))))
 
 IF LEN(@sItem) > 0
  INSERT INTO @List SELECT @sItem
 END

IF LEN(@sInputList) > 0
 INSERT INTO @List SELECT @sInputList -- Put the last item in
RETURN
END

GO

