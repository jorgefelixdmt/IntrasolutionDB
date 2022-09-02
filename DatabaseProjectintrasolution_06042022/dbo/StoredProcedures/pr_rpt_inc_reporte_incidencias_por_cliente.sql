/*      
****************************************************************************************************************************************
Nombre: dbo.pr_rpt_inc_reporte_incidencias_por_cliente
Fecha Creacion: 23/02/2021
Autor: Mauro Roque
Descripcion: SP reporte de incidencias por cliente
Llamado por: Clase java
Usado por: Modulo: mesa de Ayuda / Reporte Cliente por Incidente
Uso: pr_rpt_inc_reporte_incidencias_por_cliente 2,0,10,2020,1,0,0
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
02/03/2022				Mauro Roque			   se agrego parametros al reporte "semaforos"
**********************************************************************************************************
*/
CREATE proc pr_rpt_inc_reporte_incidencias_por_cliente
@id_cliente int,
@id_proyecto int,
@id_mes int,
@anno int,
@semaforo_rojo int,
@semaforo_naranja int,
@semaforo_verde int
as

select 
convert(int,year(fecha)) as anno, 

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
END))				 as nombre_mes,
month(fecha) as id_mes,
inc.codigo_ticket +' - '+ inc.codigo_jira AS ticket_jira,
tipo_contacto.nombre as tipo_contacto,
(SELECT (CASE DATENAME(dw,fecha)
     when 'Monday' then 'Lunes'
     when 'Tuesday' then 'Martes'
     when 'Wednesday' then 'Miercoles'
     when 'Thursday' then 'Jueves'
     when 'Friday' then 'Viernes'
     when 'Saturday' then 'Sabado'
     when 'Sunday' then 'Domingo'
END)) as dia_recepcion,
convert(varchar(10),inc.fecha,103) + ' - ' + inc.hora as fecha_hora_recepcion,
contacto.nombres as reportado_por,
inc.descripcion_incidente as descripcion,
cat_causa.nombre as categoria_causa,
tip_causa.nombre as tipo_causa,
dbo.uf_inc_total_hh_incidencia(inc.inc_incidencia_id) as hh_solucion,
tipo_incidencia.nombre as tipo_incidencia,
estado_incidencia.nombre as estado_incidencia,
convert(varchar(10),inc.fecha_solucion,103) as fecha_solucion,
inc.hora_solucion as hora_solucion,

dbo.uf_inc_concatena_codigo_pase_jira(inc.inc_incidencia_id) as codigo_pase,

(select  top 1 esta_pa.nombre from pa_pase pa 
					inner join pa_pase_asociado aso on pa.pa_pase_id = aso.pa_pase_id 
					inner join  pa_pase_estado esta_pa on esta_pa.pa_pase_estado_id=pa.pa_pase_estado_id 
					left join inc_incidencia incidencia on incidencia.inc_incidencia_id = aso.inc_incidencia_id 
					where pa.is_deleted=0 and aso.is_deleted=0 and incidencia.inc_incidencia_id = inc.inc_incidencia_id )
					as nombre_estado_pase,

dbo.uf_inc_total_hh_pase(inc.inc_incidencia_id) as hh_pase,

( select top 1 co.titulo  from inc_incidencia_comentario co 
					inner join inc_incidencia incidencia on incidencia.inc_incidencia_id = co.inc_incidencia_id 
					where co.is_deleted=0 and incidencia.inc_incidencia_id = inc.inc_incidencia_id )
					as observaciones_incidente
from inc_incidencia inc 
left join inc_tipo_contacto tipo_contacto on tipo_contacto.inc_tipo_contacto_id = inc.inc_tipo_contacto_id
left join fb_contacto contacto on contacto.fb_contacto_id = inc.fb_contacto_id
left join inc_categoria_causa cat_causa on cat_causa.inc_categoria_causa_id = inc.inc_categoria_causa_id
left join inc_tipo_causa tip_causa on tip_causa.inc_tipo_causa_id = inc.inc_tipo_causa_id
left join inc_tipo_incidencia tipo_incidencia on tipo_incidencia.inc_tipo_incidencia_id = inc.inc_tipo_incidencia_id
left join inc_estado_incidencia estado_incidencia on estado_incidencia.inc_estado_incidencia_id = inc.inc_estado_incidencia_id
left join pa_pase_asociado aso on inc.inc_incidencia_id = aso.inc_incidencia_id
left join pa_pase pase on pase.pa_pase_id = aso.pa_pase_id
left join pa_pase_estado esta_pa on esta_pa.pa_pase_estado_id=pase.pa_pase_estado_id 

where 
	inc.is_deleted=0 and
	inc.fb_cliente_id = @id_cliente and
	(inc.pry_proyecto_id = @id_proyecto or @id_proyecto = 0) and
	(year(inc.fecha) = @anno or @anno = 0 ) and

	-- SI LOS SEMAFOROS ESTAN INACTIVOS 

	((month(inc.fecha) = @id_mes  or @id_mes=0) and @semaforo_rojo = 0 and @semaforo_naranja = 0  and @semaforo_verde = 0) or

--SI SEMAFORO ROJO ESTA ACTIVO ENTONCES FILTRA INCIDENCIAS CON ESTADO  
--10. SOLICIT
--20. EN_PROC
--24. EN ESPERA DE AUTORIZACION DE GERENCIA
--30. INFO_CLI
--40. SOLUC_COMPL
--45. INST_QA_DTECH
--46. APROB_QA_DTECH

((inc.inc_estado_incidencia_id in (1,2,20003,3,4,10003,10004) and @semaforo_rojo = 1 and @semaforo_naranja = 0  and @semaforo_verde = 0
and
	(inc.is_deleted=0) and
	(inc.fb_cliente_id = @id_cliente) and
	(inc.pry_proyecto_id = @id_proyecto or @id_proyecto = 0) and
	(month(inc.fecha) = @id_mes  or @id_mes=0) and
	(year(inc.fecha) = @anno or @anno = 0 ) 
) or

--SI SEMAFORO ROJO Y NARANJA ESTA ACTIVO ENTONCES FILTRA INCIDENCIAS CON ESTADO  
--1	10. SOLICIT
--2	20. EN_PROC
--20003	24. EN ESPERA DE AUTORIZACION DE GERENCIA
--3	30. INFO_CLI
--4	40. SOLUC_COMPL
--10003	45. INST_QA_DTECH
--10004	46. APROB_QA_DTECH
--10005	47. ENV_CLI_S_PASE
--5	50. PASE_ENV_O_INST_QA_CLI
--6	60. APROB_QA_CLI
--7	70. PASE_PROD_ENV
--8	80. PASE_PROD_EJEC

(inc.inc_estado_incidencia_id in (1,2,20003,3,4,10003,10004,10005,5,6,7,8) and @semaforo_rojo = 1 and @semaforo_naranja = 1  and @semaforo_verde = 0
and
	(inc.is_deleted=0) and
	(inc.fb_cliente_id = @id_cliente) and
	(inc.pry_proyecto_id = @id_proyecto or @id_proyecto = 0) and
	(month(inc.fecha) = @id_mes  or @id_mes=0) and
	(year(inc.fecha) = @anno or @anno = 0 ) 

) or

--SI SEMAFORO ROJO NARANJA Y VERDE ESTAN ACTIVOS ENTONCES FILTRA INCIDENCIAS CON TODOS LOS ESTADOS  
--1	10. SOLICIT
--2	20. EN_PROC
--20003	24. EN ESPERA DE AUTORIZACION DE GERENCIA
--3	30. INFO_CLI
--4	40. SOLUC_COMPL
--10003	45. INST_QA_DTECH
--10004	46. APROB_QA_DTECH
--10005	47. ENV_CLI_S_PASE
--5	50. PASE_ENV_O_INST_QA_CLI
--6	60. APROB_QA_CLI
--7	70. PASE_PROD_ENV
--8	80. PASE_PROD_EJEC
--10002	90. CULM_CLI
--9	99. ANUL_CLI_DT

(inc.inc_estado_incidencia_id in (1,2,20003,3,4,10003,10004,10005,5,6,7,8,10002,9) and @semaforo_rojo = 1 and @semaforo_naranja = 1  and @semaforo_verde = 1
and
	(inc.is_deleted=0) and
	(inc.fb_cliente_id = @id_cliente) and
	(inc.pry_proyecto_id = @id_proyecto or @id_proyecto = 0) and
	(month(inc.fecha) = @id_mes  or @id_mes=0) and
	(year(inc.fecha) = @anno or @anno = 0 ) 

) or


--SI SOLO EL SEMAFORO NARANJA ESTA ACTIVO ENTONCES FILTRA INCIDENCIAS CON ESTADO  
--10005	47. ENV_CLI_S_PASE
--5	50. PASE_ENV_O_INST_QA_CLI
--6	60. APROB_QA_CLI
--7	70. PASE_PROD_ENV
--8	80. PASE_PROD_EJEC

(inc.inc_estado_incidencia_id in (10005,5,6,7,8) and @semaforo_rojo = 0 and @semaforo_naranja = 1  and @semaforo_verde = 0
and
	(inc.is_deleted=0) and
	(inc.fb_cliente_id = @id_cliente) and
	(inc.pry_proyecto_id = @id_proyecto or @id_proyecto = 0) and
	(month(inc.fecha) = @id_mes  or @id_mes=0) and
	(year(inc.fecha) = @anno or @anno = 0 ) 

) or

--SI SOLO EL SEMAFORO NARANJA Y VERDE ESTA ACTIVO ENTONCES FILTRA INCIDENCIAS CON ESTADO  
--10005	47. ENV_CLI_S_PASE
--5	50. PASE_ENV_O_INST_QA_CLI
--6	60. APROB_QA_CLI
--7	70. PASE_PROD_ENV
--8	80. PASE_PROD_EJEC
--10002	90. CULM_CLI
--9	99. ANUL_CLI_DT


(inc.inc_estado_incidencia_id in (10005,5,6,7,8,10002,9) and @semaforo_rojo = 0 and @semaforo_naranja = 1  and @semaforo_verde = 1
and
	(inc.is_deleted=0) and
	(inc.fb_cliente_id = @id_cliente) and
	(inc.pry_proyecto_id = @id_proyecto or @id_proyecto = 0) and
	(month(inc.fecha) = @id_mes  or @id_mes=0) and
	(year(inc.fecha) = @anno or @anno = 0 ) 

) or

--SI SOLO EL SEMAFORO ROJO Y VERDE ESTA ACTIVO ENTONCES FILTRA INCIDENCIAS CON ESTADO  
--1	10. SOLICIT
--2	20. EN_PROC
--20003	24. EN ESPERA DE AUTORIZACION DE GERENCIA
--3	30. INFO_CLI
--4	40. SOLUC_COMPL
--10003	45. INST_QA_DTECH
--10004	46. APROB_QA_DTECH

--10002	90. CULM_CLI
--9	99. ANUL_CLI_DT



(inc.inc_estado_incidencia_id in (1,2,3,4,20003,10003,10004,10002,9) and @semaforo_rojo = 1 and @semaforo_naranja = 0  and @semaforo_verde = 1
and
	(inc.is_deleted=0) and
	(inc.fb_cliente_id = @id_cliente) and
	(inc.pry_proyecto_id = @id_proyecto or @id_proyecto = 0) and
	(month(inc.fecha) = @id_mes  or @id_mes=0) and
	(year(inc.fecha) = @anno or @anno = 0 ) 

) or

--SI SOLO EL SEMAFOROVERDE ESTA ACTIVO ENTONCES FILTRA INCIDENCIAS CON ESTADO  


--10002	90. CULM_CLI
--9	99. ANUL_CLI_DT



(inc.inc_estado_incidencia_id in (10002,9) and @semaforo_rojo = 0 and @semaforo_naranja = 0  and @semaforo_verde = 1
and
	(inc.is_deleted=0) and
	(inc.fb_cliente_id = @id_cliente) and
	(inc.pry_proyecto_id = @id_proyecto or @id_proyecto = 0) and
	(month(inc.fecha) = @id_mes  or @id_mes=0) and
	(year(inc.fecha) = @anno or @anno = 0 ) 

))

GO

