


/*
exec [pr_rpt_registro_inc_cabecera] 1780
este SP apunta al Reporte de MINTRA Incidente Peligro o Incidente
*/
create PROCEDURE [dbo].[pr_rpt_registro_inc_cabecera]
(@ifi_id int)
AS

----
declare @conteo_accidentado numeric(10,0)
select @conteo_accidentado = count( inc_informe_final_accidentado_id) from inc_informe_final_accidentado where inc_informe_final_id=@ifi_id
IF(@conteo_accidentado    >0)
----
BEGIN
Select 
ifi.inc_informe_final_id,
acc.inc_informe_final_accidentado_id,
ifi.codigo,
ifi.hora_formateada,
ifi.lugar_evento,
day(ifi.fecha_evento)as dia,month(ifi.fecha_evento)as mes,Year(ifi.fecha_evento)as anno,
day(ifi.fecha_investigacion)as diaI,month(ifi.fecha_investigacion)as mesI,Year(ifi.fecha_investigacion)as annoI,
acc.nombreCompleto,
acc.dni,
acc.edad,
acc.area_nombre,
acc.puesto_trabajo_nombre,
acc.experiencia_uea_formateada as antiguedad_empleo,
emp.sexo,
 (select case 
        when (ifi.hora_evento >= 7 AND ifi.hora_evento<=14) then 'D' 
        when (ifi.hora_evento > 14 AND ifi.hora_evento<=23) then 'T' 
        Else 'N'
  End )as Turno, 
acc.tipo_contrato_nombre,
acc.experiencia_ocupacion_formateada antiguedad_puesto,
acc.horas_jornada_laboral,
acc.descanso_medico_real,
ee.razon_social,
ee.ruc_empresa,
ee.direccion,
ciiu.descripcion_CIIU as Actividad_Economia,
acc.num_trab_centro_lab as N_trabj,
rol.nombre as rol_empresa,
tr.nombre as tipo_Registro,
(select case tr.codigo when 'IP' then 'X' when '' then '' end )as Incidente_Peligroso,
(select case tr.codigo when 'I' then 'X' when '' then '' end )as Incidente,
ifi.num_pobladores_potencial,
ifi.num_trabajadores_potencial,
ifi.atencion_primeros_aux


From inc_informe_final ifi
    LEFT join inc_informe_final_accidentado acc on ifi.inc_informe_final_id=acc.inc_informe_final_id
    LEFT join fb_empresa_especializada ee on ee.fb_empresa_especializada_id=acc.fb_empresa_especializada_id
    LEFT join g_rol_empresa rol on rol.g_rol_empresa_id=ee.g_rol_empresa_id
    left join g_actividad_economica_ciiu ciiu on ciiu.g_actividad_economica_ciiu_id=ee.g_actividad_economica_ciiu_id
    left join fb_empleado emp on acc.fb_empleado_id=emp.fb_empleado_id
    left join fb_Area area on area.fb_area_id=ifi.fb_area_id
    inner join inc_tipo_reporte trep on trep.inc_tipo_reporte_id=ifi.inc_tipo_reporte_id
    inner join inc_tipo_reporte_mintra mintra on mintra.inc_tipo_reporte_mintra_id=ifi.inc_tipo_reporte_mintra_id
   inner join inc_tipo_registro tr on tr.inc_tipo_registro_id=mintra.inc_tipo_registro_id
   left join inc_tipo_incapacidad incap on incap.inc_tipo_incapacidad_id=acc.inc_tipo_incapacidad_id
   inner join fb_uea_pe uea on uea.fb_uea_pe_id = ifi.fb_uea_pe_id
   left join fb_empresa empresa on empresa.fb_empresa_id = uea.fb_empresa_id
WHERE 
 ifi.is_deleted =0
  and (@ifi_id is null or ifi.inc_informe_final_id = @ifi_id)
END





ELSE
BEGIN
Select 
ifi.inc_informe_final_id,
acc.inc_informe_final_accidentado_id,
ifi.codigo,
ifi.hora_formateada,
ifi.lugar_evento,
day(ifi.fecha_evento)as dia,month(ifi.fecha_evento)as mes,Year(ifi.fecha_evento)as anno,
day(ifi.fecha_investigacion)as diaI,month(ifi.fecha_investigacion)as mesI,Year(ifi.fecha_investigacion)as annoI,
acc.nombreCompleto,
acc.dni,
acc.edad,
acc.area_nombre,
acc.puesto_trabajo_nombre,
acc.experiencia_uea_formateada as antiguedad_empleo,
emp.sexo,
 (select case 
        when (ifi.hora_evento >= 7 AND ifi.hora_evento<=14) then 'D' 
        when (ifi.hora_evento > 14 AND ifi.hora_evento<=23) then 'T' 
        Else 'N'
  End )as Turno, 
acc.tipo_contrato_nombre,
acc.experiencia_ocupacion_formateada antiguedad_puesto,
acc.horas_jornada_laboral,
acc.descanso_medico_real,
empresa.razon_social,
empresa.ruc as ruc_empresa,
empresa.direccion,
ciiu.descripcion_CIIU as Actividad_Economia,
acc.num_trab_centro_lab as N_trabj,
CASE rol.nombre  WHEN NULL THEN 'Titular' ELSE 'Titular' END as rol_empresa,


tr.nombre as tipo_Registro,
(select case tr.codigo when 'IP' then 'X' when '' then '' end )as Incidente_Peligroso,
(select case tr.codigo when 'I' then 'X' when '' then '' end )as Incidente,
ifi.num_pobladores_potencial,
ifi.num_trabajadores_potencial,
ifi.atencion_primeros_aux


From inc_informe_final ifi
    LEFT join inc_informe_final_accidentado acc on ifi.inc_informe_final_id=acc.inc_informe_final_id
    LEFT join fb_empresa_especializada ee on ee.fb_empresa_especializada_id=acc.fb_empresa_especializada_id
    LEFT join g_rol_empresa rol on rol.g_rol_empresa_id=ee.g_rol_empresa_id
    left join g_actividad_economica_ciiu ciiu on ciiu.g_actividad_economica_ciiu_id=ee.g_actividad_economica_ciiu_id
    left join fb_empleado emp on acc.fb_empleado_id=emp.fb_empleado_id
    left join fb_Area area on area.fb_area_id=ifi.fb_area_id
    inner join inc_tipo_reporte trep on trep.inc_tipo_reporte_id=ifi.inc_tipo_reporte_id
    inner join inc_tipo_reporte_mintra mintra on mintra.inc_tipo_reporte_mintra_id=ifi.inc_tipo_reporte_mintra_id
   inner join inc_tipo_registro tr on tr.inc_tipo_registro_id=mintra.inc_tipo_registro_id
   left join inc_tipo_incapacidad incap on incap.inc_tipo_incapacidad_id=acc.inc_tipo_incapacidad_id
   inner join fb_uea_pe uea on uea.fb_uea_pe_id = ifi.fb_uea_pe_id
   left join fb_empresa empresa on empresa.fb_empresa_id = uea.fb_empresa_id
WHERE 
 ifi.is_deleted =0
  and (@ifi_id is null or ifi.inc_informe_final_id = @ifi_id)
END

GO

