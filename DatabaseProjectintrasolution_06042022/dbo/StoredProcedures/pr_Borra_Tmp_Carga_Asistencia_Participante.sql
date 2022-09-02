
create proc [dbo].[pr_Borra_Tmp_Carga_Asistencia_Participante]
@Id_Unidad int
as

delete cap_asistencia_temporal where fb_uea_pe_id=@Id_Unidad and tipo_carga=2
--tipo_carga=1	  cargar de asistencia
--tipo_carga=2    cargas de inscripcion

GO

