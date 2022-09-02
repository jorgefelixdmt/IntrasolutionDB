
create PROCEDURE [dbo].[pr_rpt_registro_accidente_rsp_registro]
(@ifi_id int)
AS
BEGIN

Select 
ifi.inc_informe_final_id,
eq.nombre_apellido as nombreCompleto,
eq.rol_nombre,
eq.cargo_nombre,
Convert(varchar(10),ifi.fecha_evento, 103) as Fecha

From inc_informe_final ifi
    inner join inc_informe_final_equipo eq on eq.inc_informe_final_id=ifi.inc_informe_final_id
    WHERE 
 ifi.is_deleted =0 and
eq.is_deleted =0
  and (@ifi_id is null or ifi.inc_informe_final_id = @ifi_id)
 
END

GO

