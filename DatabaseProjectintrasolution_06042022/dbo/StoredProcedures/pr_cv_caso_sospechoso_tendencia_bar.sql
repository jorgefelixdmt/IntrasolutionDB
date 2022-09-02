
/*
Creado por: Valky Salinas
Fecha Creacion: 14/05/2020
Descripcion: Retorna tabla de la cantidad de control COVID por acceso y tipo de empresa
[pr_cv_caso_sospechoso_tendencia_bar] 76,2020,0

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/
CREATE PROCEDURE [dbo].[pr_cv_caso_sospechoso_tendencia_bar] 
  @fb_uea_pe_id numeric(10,0),
  @anho int,
  @consulta int
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


	IF @consulta = 0 --Total registros
	 BEGIN
		SELECT
			COUNT(*) total
		FROM cv_caso_sospechoso cs
			INNER JOIN cv_tipo_resultado tr ON tr.cv_tipo_resultado_id = cs.cv_tipo_resultado_id
		WHERE
			cs.is_deleted = 0 AND
			cs.is_deleted = 0 AND
			tr.is_deleted = 0 AND
			YEAR(cs.fecha_registro) = @anho AND
			(cs.fb_uea_pe_id = @fb_uea_pe_id OR @fb_uea_pe_id = 0)
	 END
	ELSE
	 BEGIN
		IF @consulta = 1 --Datos Gráfico
		 BEGIN
			SELECT
				CONVERT(VARCHAR, cs.fecha_registro, 103) fecha,
				SUM(CASE WHEN tr.codigo = 'PO' THEN 1 ELSE 0 END) positivos,
				COUNT(*) cantidad
			FROM cv_caso_sospechoso cs 
				INNER JOIN fb_empresa_especializada ee ON ee.fb_empresa_especializada_id = cs.fb_empresa_especializada_id
				INNER JOIN g_rol_empresa re ON re.g_rol_empresa_id = cs.g_rol_empresa_id
				INNER JOIN cv_tipo_resultado tr ON tr.cv_tipo_resultado_id = cs.cv_tipo_resultado_id
			WHERE
				cs.is_deleted = 0 AND
				ee.is_deleted = 0 AND
				re.is_deleted = 0 AND
				tr.is_deleted = 0 AND
				YEAR(cs.fecha_registro) = @anho AND
				(cs.fb_uea_pe_id = @fb_uea_pe_id OR @fb_uea_pe_id = 0)
			GROUP BY cs.fecha_registro
		 END
	 END

end

GO

