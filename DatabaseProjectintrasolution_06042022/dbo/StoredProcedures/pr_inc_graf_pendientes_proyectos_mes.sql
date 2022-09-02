/*
Creado por: Jorge Felix
Fecha Creacion: 28/01/2021
Descripcion: SP para gráfico de barras de incidencias pendientes por proyectos por mens
Parametros: @usuario   -    ID Usuario
[dbo].[pr_inc_graf_pendientes_proyectos_mes] 2

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_inc_graf_pendientes_proyectos_mes]
@usuario numeric(10,0),
@tipoinc numeric(10,0),
@ambito varchar(10)

AS

SET NOCOUNT ON;

DECLARE @cliente_id numeric(10,0)

SELECT TOP 1 
	@cliente_id = ISNULL(id_empresa,0) 
FROM SC_USER 
WHERE SC_USER_ID = @usuario

CREATE TABLE #temporal (estado varchar(200), mes varchar(200), num int)
CREATE TABLE #meses (mes varchar(200))

;with months (date)
AS
(
	SELECT DATEADD(DAY,1,EOMONTH(DATEADD(MONTH,-12,GETDATE())))
	UNION ALL
	SELECT DATEADD(month,1,date)
	from months
	where DATEADD(month,1,date) <= GETDATE()
)
insert into #meses
select
	Case month(date)
			when 1 then 'Enero ' + CONVERT(varchar(10), YEAR(date))
			when 2 then 'Febrero ' + CONVERT(varchar(10), YEAR(date))
			when 3 then 'Marzo ' + CONVERT(varchar(10), YEAR(date))
			when 4 then 'Abril ' + CONVERT(varchar(10), YEAR(date))
			when 5 then 'Mayo ' + CONVERT(varchar(10), YEAR(date))
			when 6 then 'Junio ' + CONVERT(varchar(10), YEAR(date))
			when 7 then 'Julio ' + CONVERT(varchar(10), YEAR(date))
			when 8 then 'Agosto ' + CONVERT(varchar(10), YEAR(date))
			when 9 then 'Septiembre ' + CONVERT(varchar(10), YEAR(date))
			when 10 then 'Octubre ' + CONVERT(varchar(10), YEAR(date))
			when 11 then 'Noviembre ' + CONVERT(varchar(10), YEAR(date))
			when 12 then 'Diciembre ' + CONVERT(varchar(10), YEAR(date))
	End as mes
from months

DECLARE @columns NVARCHAR(MAX) = '';


SET @columns = STUFF((
								SELECT ',' + QUOTENAME(mes) 
								FROM #meses
								FOR XML PATH(''), TYPE
								).value('.', 'NVARCHAR(MAX)') 
							,1,1,'')

INSERT INTO #temporal
SELECT 
	ei.nombre,
	Mes = Case month(i.fecha)
					when 1 then 'Enero ' + CONVERT(varchar(10), YEAR(i.fecha))
					when 2 then 'Febrero ' + CONVERT(varchar(10), YEAR(i.fecha))
					when 3 then 'Marzo ' + CONVERT(varchar(10), YEAR(i.fecha))
					when 4 then 'Abril ' + CONVERT(varchar(10), YEAR(i.fecha))
					when 5 then 'Mayo ' + CONVERT(varchar(10), YEAR(i.fecha))
					when 6 then 'Junio ' + CONVERT(varchar(10), YEAR(i.fecha))
					when 7 then 'Julio ' + CONVERT(varchar(10), YEAR(i.fecha))
					when 8 then 'Agosto ' + CONVERT(varchar(10), YEAR(i.fecha))
					when 9 then 'Septiembre ' + CONVERT(varchar(10), YEAR(i.fecha))
					when 10 then 'Octubre ' + CONVERT(varchar(10), YEAR(i.fecha))
					when 11 then 'Noviembre ' + CONVERT(varchar(10), YEAR(i.fecha))
					when 12 then 'Diciembre ' + CONVERT(varchar(10), YEAR(i.fecha))
			End,
	1
FROM inc_incidencia i
	INNER JOIN inc_estado_incidencia ei ON ei.inc_estado_incidencia_id = i.inc_estado_incidencia_id
WHERE
	i.is_deleted = 0 AND
	ei.is_deleted = 0 AND
	ei.inc_estado_incidencia_id NOT IN (9,10002) AND -- 10002:Culminado, 9:Anulado
	(i.inc_tipo_incidencia_id = @tipoinc OR @tipoinc = 0) AND
	(i.ambito = @ambito OR @ambito = 'A') AND
	(i.fb_cliente_id = @cliente_id OR @cliente_id = 0) AND
	i.fecha BETWEEN DATEADD(DAY,1,EOMONTH(DATEADD(MONTH,-12,GETDATE()))) AND GETDATE()

IF EXISTS( SELECT * FROM #temporal) 
 BEGIN
	DECLARE @sql NVARCHAR(MAX)

	SET @sql ='
	SELECT * FROM (
		SELECT 
			estado,
			mes,
			num
		FROM #temporal 
	) p
	PIVOT (
		COUNT(num)
		FOR mes in ('+ @columns +')
	) as pivot_table';

	EXECUTE sp_executesql @sql;
 END
ELSE
 BEGIN
	SELECT *
	FROM #temporal
 END

GO

