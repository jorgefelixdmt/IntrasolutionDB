/*  
<StoreProcedure>  
 <Name>  
         pr_ws_tareas_vigencia
   </Name>  
    <Description>  
	Cumple con listar las tareas de los responsables por tiempo de vigencia y color
  La informacion a enviar es :  
   - Correlativo  
   - Codigo 
   - accion_correctiva_detalle    
   - FechaVencimiento  
   - DiasParaVencimiento
   - color
	-- pr_alerta_sam_por_vencer   
 </Description>  
 <Parameters>  
 </Parameters>  
    <Author>  
          Jorge Felix
    </Author>  
    <Date>  
         23/02/2022  
    </Date>  
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
*/

CREATE procedure [dbo].[pr_ws_tareas_vigencia]
@dato numeric(10,0)
As
Set nocount on 

SELECT DISTINCT
		tor.nombre as TipoOrigen,
		saa.codigo_accion_correctiva as Codigo,
		saa.accion_correctiva_detalle,
		empleado.nombreCompleto as Responsable,
		emp2.nombreCompleto as ResponsableAlterno,
		isnull(CONVERT(VARCHAR(10), saa.fecha_acordada_ejecucion,103),'') as FechaAcordadaEjecucion,
		isnull(DATEDIFF(DAY,GETDATE(),saa.fecha_acordada_ejecucion),'') as DiasVigencia,
		uea.codigo,
		empleado.fb_empleado_id,
		saa.fb_uea_pe_id,
		color = Case  
					when isnull(DATEDIFF(DAY,GETDATE(),saa.fecha_acordada_ejecucion),'') <=1 then 'Rojo'
					when isnull(DATEDIFF(DAY,GETDATE(),saa.fecha_acordada_ejecucion),'') = 1 then 'Naranja'
					when 1 < isnull(DATEDIFF(DAY,GETDATE(),saa.fecha_acordada_ejecucion),'') and isnull(DATEDIFF(DAY,GETDATE(),saa.fecha_acordada_ejecucion),'') < 8 then 'Celeste'
					when isnull(DATEDIFF(DAY,GETDATE(),saa.fecha_acordada_ejecucion),'') > 7 then 'Verde'
				End

FROM
		sac_accion_correctiva saa
		inner join fb_empleado empleado on empleado.fb_empleado_id = saa.fb_empleado_id_correcion
		left join fb_empleado emp2 on emp2.fb_empleado_id = saa.fb_responsable_alterno_id
		inner join fb_uea_pe uea on uea.fb_uea_pe_id = saa.fb_uea_pe_id
		inner join g_tipo_origen tor on tor.g_tipo_origen_id = saa.g_tipo_origen_id
WHERE
		saa.is_deleted = 0
		and saa.fecha_acordada_ejecucion > GETDATE()

GO

