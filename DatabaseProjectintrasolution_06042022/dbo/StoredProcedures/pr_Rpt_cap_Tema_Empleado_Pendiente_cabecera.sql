

/*
exec pr_Rpt_cap_Tema_Empleado_Pendiente_cabecera 2,2015,27
*/

CREATE PROCEDURE [dbo].[pr_Rpt_cap_Tema_Empleado_Pendiente_cabecera]
 (@fb_uea_pe_id int,  
  @Anno     int,  
  @tema_id int)
AS
BEGIN

Select 
    distinct tema.cap_tema_id,
	tema.codigo, tema.nombre as Tema,
    uea.nombre as Unidad 
   From cap_tema tema
            inner join cap_tema_rol tr on tr.cap_tema_id=tema.cap_tema_id
            inner join cap_rol_capacitacion rc on rc.cap_rol_capacitacion_id=tr.cap_rol_capacitacion_id
            inner join fb_uea_pe uea on uea.fb_uea_pe_id=rc.fb_uea_pe_id    
where     
       rc.fb_uea_pe_id = @fb_uea_pe_id and
      tema.estado = 1 and
    (@tema_id is null or tema.cap_tema_id = @tema_id)

END

GO

