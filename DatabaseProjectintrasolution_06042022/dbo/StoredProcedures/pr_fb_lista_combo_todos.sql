


/*

Nombre: dbo.pr_fb_lista_combo_todos
Fecha Creación: ---
Autor: ---
Descripción: Obtiene una lista para todos los combos del sistema.
Llamado por: Módulos de reportes
Usado por: Varios
Parámetro(s):   @param    Parámetros
				@tipo     Tipo de combo
				@uea      UEA
Uso: exec pr_fb_lista_combo_todos 5,'ESTADO_INC',1

***********************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------
24/02/2020			mauro roque			se agrego tipo de estado para incidencias con valor "todos"
21/04/2021			mauro roque			se agrego campo "orden" para el select de "estado incidencia"			
***********************************************************************************************

*/
CREATE proc [dbo].[pr_fb_lista_combo_todos]
@param int,
@tipo varchar(50),
@uea int
as
SET NOCOUNT ON;

if @tipo = 'CAP'
 begin

	select distinct year(fecha_inicio) as anno
	from cap_curso
	where cap_curso_estado_id = 4 and is_deleted = 0 and fb_uea_pe_id = @uea

 end

if @tipo = 'SEDE'
 begin

	select fb_uea_pe_id, nombre
	from fb_uea_pe
	where is_deleted = 0 and fb_uea_pe_id in (1,2,3,4)
	union 
	select 
	0,'TODAS'

 end

 if @tipo = 'ESTADO_INC'
 begin


	select 
	0 as inc_estado_incidencia_id,
	'TODAS' as nombre,
	1 as orden
	union
	select 
	inc_estado_incidencia_id, 
	nombre,
	orden 
	from inc_estado_incidencia 
	WITH (NOLOCK)
		
	ORDER By orden

 end

 if @tipo = 'AMBITO_INC'
 begin

	SELECT CODE as code ,NAME as name FROM  SC_MASTER_TABLE WHERE  
	SC_DOMAIN_TABLE_ID IN (SELECT SC_DOMAIN_TABLE_ID FROM SC_DOMAIN_TABLE
	WHERE CODE='INC_TIPO_INTERNA_EXTERNA')
	union 
	select 
	convert(varchar(10), 0),'TODAS'


 end

GO

