  /*
exec [pr_rpt_registro_accidente_accion] 350
*/
create PROCEDURE [dbo].[pr_rpt_registro_accidente_accion]
(@ifi_id int)
AS
BEGIN

Select 
ifi.inc_informe_final_id,
sac.accion_correctiva_detalle,
emp.nombreCompleto,
Convert(varchar(10),sac.fecha_acordada_ejecucion, 103) as fecha_acordada_ejecucion,
est.nombre as Estado
From inc_informe_final ifi
    inner join sac_accion_correctiva sac on sac.inc_informe_final_id=ifi.inc_informe_final_id
    inner join fb_empleado emp on emp.fb_empleado_id=sac.fb_empleado_id_correcion
    inner join sac_estado_accion_correctiva est on est.sac_estado_accion_correctiva_id=sac.sac_estado_accion_correctiva_id
WHERE 
 ifi.is_deleted =0
  and sac.is_deleted =0
  and (@ifi_id is null or ifi.inc_informe_final_id = @ifi_id)
 
END

GO

