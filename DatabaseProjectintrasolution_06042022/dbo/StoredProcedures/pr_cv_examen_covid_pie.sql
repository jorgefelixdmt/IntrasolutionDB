
/*
Creado por: Valky Salinas
Fecha Creacion: 14/05/2020
Descripcion: Retorna tabla de la cantidad de control COVID por resultado y tipo de empresa
[pr_cv_examen_covid_pie] 76,2020

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/
 CREATE procedure [dbo].[pr_cv_examen_covid_pie] 
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
		tr.nombre resultado,
		COUNT(*) cantidad
	FROM cv_examen_covid ec
		INNER JOIN cv_tipo_resultado tr ON tr.cv_tipo_resultado_id = ec.cv_tipo_resultado_id
	WHERE
		ec.is_deleted = 0 AND
		tr.is_deleted = 0 AND
		YEAR(ec.fecha_resultado) = @anho AND
		(ec.fb_uea_pe_id = @fb_uea_pe_id OR @fb_uea_pe_id = 0)
	GROUP BY tr.nombre

end

GO

