

/*      
****************************************************************************************************************************************
Nombre: dbo.[vista_rol_capacitacion_puesto_trabajo]
Fecha Creacion: 20/08/2014
Autor: Mauro Roque
Descripcion: vista que relaciona los cargos asociados a un rol capacitacion 
Llamado por: techbuilder
Usado por: Modulo: Cursos - Pestana participantes
Parametros: ---
Uso: --
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
19/12/2019              Mauro Roque				se agrego is_deleted=0 y se cambio tabla fb_puesto_trabajo por fb_cargo

**********************************************************************************************************
*/
CREATE VIEW [dbo].[vista_rol_capacitacion_puesto_trabajo]    
as Select      
/*el campo cap_rol_capacitacion_id se repite varias veces y en java        
es la clave principal y por lo cual agregamos ROW_NUMBER  */        
ROW_NUMBER() OVER(ORDER BY rc.cap_rol_capacitacion_id asc)as vista_cap_rol_capacitacion_id ,      
  rc.cap_rol_capacitacion_id,    
  rc.codigo as 'codigo',    
  rc.nombre as 'nombre',    
  rc.hora_anual_ley as 'hora_anual_ley',    
  rc.hora_anual_corp as 'hora_anual_corp',    
  rc.estado as 'estado',    
  pt.fb_cargo_id,   
 -- c.nombre as 'cargo_nombre' ,  
  NULL AS CREATED,    
  NULL AS CREATED_BY,    
  NULL AS OWNER_ID,    
  NULL AS UPDATED,    
  NULL AS UPDATED_BY, 0 AS IS_DELETED     
FROM             
cap_rol_capacitacion AS rc LEFT JOIN cap_rol_capacitacion_cargo AS rcp    
ON rc.cap_rol_capacitacion_id = rcp.cap_rol_capacitacion_id LEFT JOIN fb_cargo AS pt     
ON rcp.fb_cargo_id = pt.fb_cargo_id
where rcp.is_deleted=0 and rc.is_deleted=0

GO

