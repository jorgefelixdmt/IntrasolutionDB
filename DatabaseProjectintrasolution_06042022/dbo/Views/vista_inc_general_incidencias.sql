

/*      
****************************************************************************************************************************************
Nombre: dbo.vista_inc_general_incidencias
Fecha Creacion: 23/02/2021
Autor: Mauro Roque
Descripcion: vista general de mesa de ayuda solo para consulta
Llamado por: Clase java
Usado por: Modulo: mesa de Ayuda 
Uso: select * from vista_inc_general_incidencias
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
25/02/2022				Mauro Roque			  se agrego campo "id_mes"
**********************************************************************************************************
*/
CREATE view vista_inc_general_incidencias
as

select convert(int,year(fecha)) as anno, 
	(SELECT (CASE month(fecha)
     when 1 then 'Enero'
     when 2 then 'Febrero'
     when 3 then 'Marzo'
     when 4 then 'Abril'
     when 5 then 'Mayo'
     when 6 then 'Junio'
     when 7 then 'Julio'
	 when 8 then 'Agosto'
     when 9 then 'Setiembre'
     when 10 then 'Octubre'
     when 11 then 'Noviembre'
     when 12 then 'Diciembre'
END)) as nombre_mes,

	(SELECT (CASE DATENAME(dw,fecha)
     when 'Monday' then 'Lunes'
     when 'Tuesday' then 'Martes'
     when 'Wednesday' then 'Miercoles'
     when 'Thursday' then 'Jueves'
     when 'Friday' then 'Viernes'
     when 'Saturday' then 'Sabado'
     when 'Sunday' then 'Domingo'
END)) as dia_mes,
month(fecha) as id_mes,
 * 

from inc_incidencia
where is_deleted=0

GO

