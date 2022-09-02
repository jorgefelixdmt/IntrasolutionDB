
/*
Creado por: Valky Salinas
Fecha Creacion: 14/05/2020
Descripcion: Retorna la cantidad de control COVID divididos por acceso
[pr_cv_control_covid_diario_pie] 76,2020

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/
 CREATE procedure [dbo].[pr_cv_control_covid_diario_pie] 
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

	SELECT
		ta.nombre acceso,
		COUNT(*) cantidad
	FROM cv_control_covid_diario ccd
		INNER JOIN fb_empresa_especializada ee ON ee.fb_empresa_especializada_id = ccd.fb_empresa_especializada_id
		--INNER JOIN g_rol_empresa re ON re.g_rol_empresa_id = ee.g_rol_empresa_id
		INNER JOIN cv_tipo_acceso ta ON ta.cv_tipo_acceso_id = ccd.cv_tipo_acceso_id
	WHERE
		ccd.is_deleted = 0 AND
		ee.is_deleted = 0 AND
		ta.is_deleted = 0 AND
		--re.is_deleted = 0 AND
		YEAR(ccd.fecha_registro) = @anho AND
		(ccd.fb_uea_pe_id = @fb_uea_pe_id OR @fb_uea_pe_id = 0)
	GROUP BY ta.nombre

end

GO

