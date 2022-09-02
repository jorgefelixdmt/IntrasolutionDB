   /*
exec [pr_rpt_registro_accidente_descripcion] 350
*/
create PROCEDURE [dbo].[pr_rpt_registro_accidente_descripcion]
(@ifi_id int)
AS
BEGIN

Select 
ifi.inc_informe_final_id,
ifi.descripcion_evento
From inc_informe_final ifi
WHERE 
 ifi.is_deleted =0
  and (@ifi_id is null or ifi.inc_informe_final_id = @ifi_id)
 
END

GO

