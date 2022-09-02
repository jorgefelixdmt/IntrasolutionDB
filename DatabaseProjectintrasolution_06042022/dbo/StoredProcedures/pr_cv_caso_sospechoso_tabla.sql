
/*
Creado por: Valky Salinas
Fecha Creacion: 14/05/2020
Descripcion: Retorna tabla de la cantidad de control COVID por resultado y tipo de empresa
[pr_cv_caso_sospechoso_tabla] 76,2020

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/
CREATE PROCEDURE [dbo].[pr_cv_caso_sospechoso_tabla] 
  @fb_uea_pe_id numeric(10,0),
  @anho int
 as	
 begin
    SET NOCOUNT ON;

	DECLARE @id_corp numeric(10,0)

	SELECT
		@id_corp = fb_uea_pe_id
	FROM fb_uea_pe
	WHERE
		codigo = (SELECT VALUE FROM PM_PARAMETER WHERE CODE = 'CODIGO_CORP')

	IF @id_corp = @fb_uea_pe_id
	 BEGIN
		SET @fb_uea_pe_id = 0
	 END

	DECLARE @columns NVARCHAR(MAX) = '';
 
	SET @columns = STUFF((
						SELECT ',' + QUOTENAME(nombre) 
						FROM cv_tipo_resultado
						WHERE is_deleted = 0
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')


	DECLARE @sql NVARCHAR(MAX)

	SET @sql ='
	SELECT * FROM   
	(
		SELECT
			re.nombre rol,
			tr.nombre resultado,
			1 cant
       FROM cv_caso_sospechoso cs
			INNER JOIN fb_empresa_especializada ee ON ee.fb_empresa_especializada_id = cs.fb_empresa_especializada_id
			INNER JOIN g_rol_empresa re ON re.g_rol_empresa_id = cs.g_rol_empresa_id
			INNER JOIN cv_tipo_resultado tr ON tr.cv_tipo_resultado_id = cs.cv_tipo_resultado_id
		WHERE
			cs.is_deleted = 0 AND
			ee.is_deleted = 0 AND
			re.is_deleted = 0 AND
			tr.is_deleted = 0 AND
			YEAR(cs.fecha_registro) = ' + CAST(@anho AS VARCHAR(10)) + ' AND
			(cs.fb_uea_pe_id = ' + CAST(@fb_uea_pe_id AS VARCHAR(10)) + ' OR ' + CAST(@fb_uea_pe_id AS VARCHAR(10)) + ' = 0)
	) t 
	PIVOT(
		SUM(cant) 
		FOR resultado IN ('+ @columns +')
	) AS pivot_table;';

	EXECUTE sp_executesql @sql;

end

GO

