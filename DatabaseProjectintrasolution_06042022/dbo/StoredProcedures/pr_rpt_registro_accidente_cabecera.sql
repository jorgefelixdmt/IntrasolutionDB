 
/*
exec [pr_rpt_registro_accidente_cabecera] 1780
este SP apunta al Reporte de MINTRA Accidente de Trabajo
*/
create PROCEDURE [dbo].[pr_rpt_registro_accidente_cabecera]
(@ifi_id int)
AS
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
ifi.num_trab_afectado,
acc.diagnostico,
ee.razon_social,
ee.ruc_empresa,
ee.direccion,
ciiu.descripcion_CIIU as Actividad_Economia,
acc.num_trab_centro_lab as N_trabj,
rol.nombre as rol_empresa,
acc.num_trab_afil_sctr,
acc.num_trab_no_afil_sctr,
acc.aseguradora_nombre,
acc.inc_tipo_incapacidad_id,
incap.nombre as incapacidad,

(select case trep.codigo when 'AL' then 'X' when '' then '' end )as Leve,
(select case trep.codigo when 'AI' then 'X' when '' then '' end )as Incapacitante,
(select case trep.codigo when 'AF' then 'X' when '' then '' end )as Mortal,

(select case incap.codigo when 'INC_TO_TEM' then 'X' when '' then '' end )as Total_Temporal,
(select case incap.codigo when 'INC_PAR_PER' then 'X' when '' then '' end )as Parcial_Permanente,
(select case incap.codigo when 'INC_TO_PER' then 'X' when '' then '' end )as Total_Permanente,
(select case incap.codigo when 'INC_PAR_TEM' then 'X' when '' then '' end )as Parcial_Temporal

--ifi.inc_tipo_reporte_mintra_id,
--reg.nombre as tipo_reporte_nombre
From inc_informe_final ifi
    inner join inc_informe_final_accidentado acc on ifi.inc_informe_final_id=acc.inc_informe_final_id
    inner join fb_empresa_especializada ee on ee.fb_empresa_especializada_id=acc.fb_empresa_especializada_id
    inner join g_rol_empresa rol on rol.g_rol_empresa_id=ee.g_rol_empresa_id
    left join g_actividad_economica_ciiu ciiu on ciiu.g_actividad_economica_ciiu_id=ee.g_actividad_economica_ciiu_id
    left join fb_empleado emp on acc.fb_empleado_id=emp.fb_empleado_id
    left join fb_Area area on area.fb_area_id=ifi.fb_area_id
    inner join inc_tipo_reporte trep on trep.inc_tipo_reporte_id=ifi.inc_tipo_reporte_id
    inner join inc_tipo_reporte_mintra mintra on mintra.inc_tipo_reporte_mintra_id=ifi.inc_tipo_reporte_mintra_id
   inner join inc_tipo_registro tr on tr.inc_tipo_registro_id=mintra.inc_tipo_registro_id
   left join inc_tipo_incapacidad incap on incap.inc_tipo_incapacidad_id=acc.inc_tipo_incapacidad_id

    
WHERE 
 ifi.is_deleted =0
  and (@ifi_id is null or ifi.inc_informe_final_id = @ifi_id)
 
END

GO

