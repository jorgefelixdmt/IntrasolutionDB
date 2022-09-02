  /*
exec [pr_rpt_registro_accidente_causa] 350
*/
create PROCEDURE [dbo].[pr_rpt_registro_accidente_causa]
(@ifi_id int)
AS
BEGIN

Select 
ifi.inc_informe_final_id,
causa.codigo_tipo_causa as Codigo_Causa,
causa.descripcion_tipo_causa as Tipo_Causa,
causa.comentario
From inc_informe_final ifi
    inner join inc_informe_final_causa causa on causa.inc_informe_final_id=ifi.inc_informe_final_id
WHERE 
 ifi.is_deleted =0
and causa.is_deleted=0
  and (@ifi_id is null or ifi.inc_informe_final_id = @ifi_id)
 
END

GO

