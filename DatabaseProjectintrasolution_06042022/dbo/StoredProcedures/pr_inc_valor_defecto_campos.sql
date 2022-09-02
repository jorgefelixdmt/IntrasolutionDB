


/*      
****************************************************************************************************************************************
Nombre: dbo.pr_inc_valor_defecto_campos
Fecha Creacion: 15/06/2020
Autor: Mauro Roque
Descripcion: store que obtine el nombre del proyecto por defecto si solo tiene un cliente.
Llamado por: js
Usado por: Modulo:Incidencias , Incidencias del Cliente
Parametros: @id_parametro - ID del Cliente
Uso:  pr_inc_valor_defecto_campos 2
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
06/01/2021				mauro roque			 se agrego variable nivel incidencia_id para mostrar por defecto el valor en formulario
**********************************************************************************************************
*/
CREATE proc pr_inc_valor_defecto_campos
@id_parametro int
as

begin

declare @id_proyecto int ,@total_proyecto int,@codigo_proyecto varchar(400),@nombre_cliente varchar(400)
declare @id_producto int, @nombre_usuario varchar(200), @name_proyecto varchar(200),@id_nivel_incidencia int
declare @id_usuario_inc int,@nombre_usuario_inc varchar(200),@fecha_creado_inc varchar(10),@hora_creado_inc varchar(10)


set @codigo_proyecto = ( select top 1 codigo 
									from pry_proyecto
									 where is_deleted=0 and estado=1 and fb_cliente_id=@id_parametro
								   )

set @name_proyecto = ( select top 1 nombre 
									from pry_proyecto
									 where is_deleted=0 and estado=1 and fb_cliente_id=@id_parametro
								   )

set @id_proyecto = ( select top 1 pry_proyecto_id 
									from pry_proyecto
									 where is_deleted=0 and estado=1 and fb_cliente_id=@id_parametro
								   )

set @total_proyecto = ( select COUNT(*) 
									from pry_proyecto
									 where is_deleted=0 and estado=1 and fb_cliente_id=@id_parametro
								   )


set @id_producto = ( select top 1 prd_producto_id 
									from pry_proyecto
									 where is_deleted=0 and estado=1 and pry_proyecto_id=@id_proyecto
								   )

set @nombre_cliente = ( select top 1 nombre 
									from fb_cliente
									 where is_deleted=0 and estado=1 and fb_cliente_id=@id_parametro
								   )


set @nombre_usuario = ( select top 1 name 
									from sc_user
									 where is_deleted=0 and sc_user_id=@id_parametro
								   )

set @id_usuario_inc = ( select created_by 
									from inc_incidencia
									 where is_deleted=0 and inc_incidencia_id=@id_parametro
								   )

set @nombre_usuario_inc = ( select name 
									from sc_user
									 where is_deleted=0 and sc_user_id=@id_usuario_inc
								   )

set @fecha_creado_inc = ( select convert(varchar(10),created,103) 
									from inc_incidencia
									 where is_deleted=0 and inc_incidencia_id=@id_parametro
								   )

set @hora_creado_inc = ( select convert(char(5), created, 108)      
									from inc_incidencia
									 where is_deleted=0 and inc_incidencia_id=@id_parametro
								   )

set @id_nivel_incidencia = ( select top 1 inc_nivel_incidencia_id 
									from inc_nivel_incidencia
									 where is_deleted=0 and fb_cliente_id=@id_parametro
									 order by 1 desc -- POR DEFECTO VALOR = NO CRITICO
								   )
select @id_proyecto as id_proyecto,
	   @codigo_proyecto as codigo_proyecto,
	   @total_proyecto as total_proyecto,
	   @nombre_cliente as nombre_cliente,
	   @id_producto as id_producto,
	   @nombre_usuario as nombre_usuario,
	   @name_proyecto as nombre_proyecto,
	   @id_usuario_inc as id_usuario_inc,
	   @nombre_usuario_inc as nombre_usuario_inc,
	   @fecha_creado_inc as fecha_creado_inc,
	   @hora_creado_inc as hora_creado_inc,
	   @id_nivel_incidencia as id_nivel_incidencia
end

GO

