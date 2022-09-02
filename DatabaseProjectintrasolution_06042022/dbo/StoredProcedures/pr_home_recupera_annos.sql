
/*
Creado Por : Valky Salinas
Fecha Creacion : 22/05/2020
Descripcion :	Retorna los años de todos los modulos
Llamado por : los home para mostrar los años

[pr_home_recupera_annos] 0

Usado por : Aplicacion web
****************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(aaaa-mm-dd)       Autor                  Comentarios
------------------      -----------------      --------------------------------------------------------

**************************************************************************************************************************************
*/
   

CREATE PROCEDURE [dbo].[pr_home_recupera_annos] @fb_uea numeric(10,0) 
AS 
begin
  set nocount on
	declare @corp numeric(10,0)
	set @corp = 0
	select @corp = 1 from fb_uea_pe where codigo = 'CORP' and fb_uea_pe_id = @fb_uea
	if @corp = 1
	begin 
		set @fb_uea = 0
	end


Select distinct year(fecha_resultado) as anno

from cv_examen_covid

where (fb_uea_Pe_id = @fb_uea or @fb_uea = 0) and year(fecha_resultado) is not null

union

Select distinct year(fecha_registro) 

from cv_declaracion

where (fb_uea_Pe_id = @fb_uea or @fb_uea = 0) and  year(fecha_registro) is not null



Order by 1 desc

end

GO

