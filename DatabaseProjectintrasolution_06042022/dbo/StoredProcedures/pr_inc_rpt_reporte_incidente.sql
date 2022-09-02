

/*      
****************************************************************************************************************************************
Nombre: dbo.pr_inc_rpt_reporte_incidente
Fecha Creacion: 24/02/2021
Autor: Mauro Roque
Descripcion: SP que lista las incidencias por Cliente y proyecto
Llamado por: JasperStudio
Usado por: Modulo: Mesa Ayuda / Reporte Incidentes
Parametros: @id_cliente - ID de Cliente
			@id_proyecto - Id Proyecto
			@ambito - Ambito (Interno o Externo)
			@fecha_inicio - Fecha inicio de Incidencia
			@fecha_fin - Fecha Fin de Incidencia
			@id_estado_incidencia - Estado Incidencia
Uso: pr_inc_rpt_reporte_incidente 1,0,'Ext','01/01/2020','24/02/2021',1,0,0,0
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
03/03/2021				MAURO ROQUE				SE AGREGARON PARAMETROS DE SEMAFORO
21/04/2021				MAURO ROQUE				SE AGREGO CODIGO TICKET DE INCIDENCIA CONCATENANDO CAMPO CODIGO JIRA
**********************************************************************************************************
*/
CREATE proc [dbo].[pr_inc_rpt_reporte_incidente]
@id_cliente int,
@id_proyecto int,
@ambito varchar(5),
@fecha_inicio varchar(10),
@fecha_fin varchar(10),
@id_estado_incidencia int,
@semaforo_rojo int,
@semaforo_naranja int,
@semaforo_verde int
as
begin

declare @fecha_desde varchar(10) , @fecha1 date
declare @fecha_hasta varchar(10) , @fecha2 date
set @fecha_desde = CONVERT(date, @fecha_inicio,103)         
set @fecha_hasta = CONVERT(date, @fecha_fin ,103)  

select
inc.inc_incidencia_id ,
cli.nombre as Cliente,
pro.pry_proyecto_id as pry_proyecto_id,
pro.nombre as Proyecto,
convert(varchar,inc.fecha,103) + ' - '+ inc.hora as fecha,
inc.codigo_ticket + ' - '+ inc.codigo_jira as codigo_jira,
inc.descripcion_incidente as Descripcion_incidente,
tip.nombre as Tipo_Incidente,
inc.ambito as Ambito,
emp.codigo as Responsable,
est.nombre as EstadoIncidente
from inc_incidencia inc 
left join fb_cliente cli on cli.fb_cliente_id = inc.fb_cliente_id
left join pry_proyecto pro on pro.pry_proyecto_id = inc.pry_proyecto_id
left join fb_empleado emp on emp.fb_empleado_id = inc.fb_empleado_id
left join inc_estado_incidencia est on est.inc_estado_incidencia_id = inc.inc_estado_incidencia_id
left join inc_tipo_incidencia tip on tip.inc_tipo_incidencia_id = inc.inc_tipo_incidencia_id
where 
inc.is_deleted=0 and cli.is_deleted=0 and pro.is_deleted=0 and

(inc.ambito = @ambito or @ambito = '0' ) and 
(inc.fecha between @fecha_desde and @fecha_hasta) and
(inc.fb_cliente_id = @id_cliente or @id_cliente = 0) and
(inc.pry_proyecto_id = @id_proyecto  or @id_proyecto = 0) and

-- SI LOS SEMAFOROS ESTAN INACTIVOS Y ESTADO INCIDENCIA VALOR "0" LISTA TODAS LAS INCIDENCIAS DE DIFERENTES ESTADOS..

((inc.inc_estado_incidencia_id = @id_estado_incidencia  or @id_estado_incidencia = '0' )and @semaforo_rojo = 0 and @semaforo_naranja = 0  and @semaforo_verde = 0 ) or

--SI SEMAFORO ROJO ESTA ACTIVO ENTONCES FILTRA INCIDENCIAS CON ESTADO  
--10. Solicitado 
--20. En Proceso de Atencion
--30. En espera de Informacion del Cliente
--40. Solucion Completada)

((inc.inc_estado_incidencia_id in (1,2,3,4) and @semaforo_rojo = 1 and @semaforo_naranja = 0  and @semaforo_verde = 0
and
(inc.is_deleted=0) AND
(inc.ambito = @ambito or @ambito = '0' ) and 
(inc.fecha between @fecha_desde and @fecha_hasta) and
(inc.fb_cliente_id = @id_cliente or @id_cliente = 0) and
(inc.pry_proyecto_id = @id_proyecto  or @id_proyecto = 0)

) or

--SI SEMAFORO NARANJA ESTA ACTIVO ENTONCES FILTRA INCIDENCIAS CON ESTADO  
--50. Instalado en Ambiente QA del Cliente
--60. Aprobado en QA del Cliente
--70. Pase a Ambiente Producción del Cliente Enviado

(inc.inc_estado_incidencia_id in (5,6,7) and @semaforo_rojo = 0 and @semaforo_naranja = 1  and @semaforo_verde = 0
and
(inc.is_deleted=0) AND
(inc.ambito = @ambito or @ambito = '0' ) and 
(inc.fecha between @fecha_desde and @fecha_hasta) and
(inc.fb_cliente_id = @id_cliente or @id_cliente = 0) and
(inc.pry_proyecto_id = @id_proyecto  or @id_proyecto = 0)

) or


--SI SEMAFORO VERDE ESTA ACTIVO ENTONCES FILTRA INCIDENCIAS CON ESTADO  
--80. Pase a Ambiente Produccion Confirmado
--90. Culminada por el Usuario
--99. Anulado por el Cliente

(inc.inc_estado_incidencia_id in (8,10002,9) and @semaforo_rojo = 0 and @semaforo_naranja = 0  and @semaforo_verde = 1
and
(inc.is_deleted=0) AND
(inc.ambito = @ambito or @ambito = '0' ) and 
(inc.fecha between @fecha_desde and @fecha_hasta) and
(inc.fb_cliente_id = @id_cliente or @id_cliente = 0) and
(inc.pry_proyecto_id = @id_proyecto  or @id_proyecto = 0)

) or


--SI SEMAFORO ROJO Y NARANJA ESTA ACTIVO ENTONCES FILTRA INCIDENCIAS CON ESTADO  
--10. Solicitado 
--20. En Proceso de Atencion
--30. En espera de Informacion del Cliente
--40. Solucion Completada)
--50. Instalado en Ambiente QA del Cliente
--60. Aprobado en QA del Cliente
--70. Pase a Ambiente Producción del Cliente Enviado

(inc.inc_estado_incidencia_id in (1,2,3,4,5,6,7) and @semaforo_rojo = 1 and @semaforo_naranja = 1  and @semaforo_verde = 0
and
(inc.is_deleted=0) AND
(inc.ambito = @ambito or @ambito = '0' ) and 
(inc.fecha between @fecha_desde and @fecha_hasta) and
(inc.fb_cliente_id = @id_cliente or @id_cliente = 0) and
(inc.pry_proyecto_id = @id_proyecto  or @id_proyecto = 0)

) or

--SI SEMAFORO ROJO NARANJA Y VERDE ESTAN ACTIVOS ENTONCES FILTRA INCIDENCIAS CON TODOS LOS ESTADOS  
--10. Solicitado 
--20. En Proceso de Atencion
--30. En espera de Informacion del Cliente
--40. Solucion Completada)
--50. Instalado en Ambiente QA del Cliente
--60. Aprobado en QA del Cliente
--70. Pase a Ambiente Producción del Cliente Enviado
--80. Pase a Ambiente Produccion Confirmado
--90. Culminada por el Usuario
--99. Anulado por el Cliente

(inc.inc_estado_incidencia_id in (1,2,3,4,5,6,7,8,10002,9) and @semaforo_rojo = 1 and @semaforo_naranja = 1  and @semaforo_verde = 1
and
(inc.is_deleted=0) AND
(inc.ambito = @ambito or @ambito = '0' ) and 
(inc.fecha between @fecha_desde and @fecha_hasta) and
(inc.fb_cliente_id = @id_cliente or @id_cliente = 0) and
(inc.pry_proyecto_id = @id_proyecto  or @id_proyecto = 0)
) or


--SI SEMAFORO NARANJA Y VERDE ESTAN ACTIVOS ENTONCES FILTRA INCIDENCIAS CON TODOS LOS ESTADOS  
--50. Instalado en Ambiente QA del Cliente
--60. Aprobado en QA del Cliente
--70. Pase a Ambiente Producción del Cliente Enviado
--80. Pase a Ambiente Produccion Confirmado
--90. Culminada por el Usuario
--99. Anulado por el Cliente

(inc.inc_estado_incidencia_id in (5,6,7,8,10002,9) and @semaforo_rojo = 0 and @semaforo_naranja = 1  and @semaforo_verde = 1
and
(inc.is_deleted=0) AND
(inc.ambito = @ambito or @ambito = '0' ) and 
(inc.fecha between @fecha_desde and @fecha_hasta) and
(inc.fb_cliente_id = @id_cliente or @id_cliente = 0) and
(inc.pry_proyecto_id = @id_proyecto  or @id_proyecto = 0)


--SI SEMAFORO ROJO Y VERDE ESTAN ACTIVOS ENTONCES FILTRA INCIDENCIAS CON TODOS LOS ESTADOS  
--10. Solicitado 
--20. En Proceso de Atencion
--30. En espera de Informacion del Cliente
--40. Solucion Completada)
--80. Pase a Ambiente Produccion Confirmado
--90. Culminada por el Usuario
--99. Anulado por el Cliente
) or
(inc.inc_estado_incidencia_id in (1,2,3,4,8,10002,9) and @semaforo_rojo = 1 and @semaforo_naranja = 0  and @semaforo_verde = 1
and
(inc.is_deleted=0) AND
(inc.ambito = @ambito or @ambito = '0' ) and 
(inc.fecha between @fecha_desde and @fecha_hasta) and
(inc.fb_cliente_id = @id_cliente or @id_cliente = 0) and
(inc.pry_proyecto_id = @id_proyecto  or @id_proyecto = 0)


))
	
end

GO

