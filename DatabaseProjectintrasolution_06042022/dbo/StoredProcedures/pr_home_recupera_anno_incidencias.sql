/*
Creado Por : Valky Salinas
Fecha Creacion : 05/02/2021
Descripcion : Retorna los años de incidencias
Llamado por : lHome de Incidencias

[pr_home_recupera_anno_incidencias] 0

Usado por : Aplicacion web
****************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(aaaa-mm-dd)       Autor                  Comentarios
------------------      -----------------      --------------------------------------------------------

**************************************************************************************************************************************
*/
   

CREATE PROCEDURE [dbo].[pr_home_recupera_anno_incidencias] @fb_uea numeric(10,0) 
AS 
begin
  
  SET NOCOUNT ON;

  SELECT DISTINCT YEAR(fecha) as Anno
  FROM inc_incidencia
  WHERE is_deleted = 0
  ORDER BY 1 DESC

end

GO

