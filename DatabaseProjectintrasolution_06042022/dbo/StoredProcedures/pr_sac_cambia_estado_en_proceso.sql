
CREATE proc pr_sac_cambia_estado_en_proceso
@sac_accion_correctiva_id numeric(10,0)

as

update sac_accion_correctiva
set sac_estado_accion_correctiva_id=2
where sac_accion_correctiva_id= @sac_accion_correctiva_id

GO

