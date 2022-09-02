CREATE TABLE [dbo].[sol_solicitud] (
    [sol_solicitud_id]        NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [sol_categoria_id]        NUMERIC (10)  NULL,
    [fb_solicitante_id]       NUMERIC (10)  NULL,
    [fecha_solicitud]         DATETIME      NULL,
    [descripcion]             VARCHAR (MAX) NULL,
    [observacion_registro]    VARCHAR (MAX) NULL,
    [observacion_aprobacion]  VARCHAR (MAX) NULL,
    [observacion_atencion]    VARCHAR (MAX) NULL,
    [fb_aprobador_id]         NUMERIC (10)  NULL,
    [fecha_aprobacion]        DATETIME      NULL,
    [fb_ejecutor_id]          NUMERIC (10)  NULL,
    [fecha_ejecucion]         DATETIME      NULL,
    [sol_solicitud_estado_id] NUMERIC (10)  NULL,
    [created]                 DATETIME      NULL,
    [created_by]              NUMERIC (10)  NULL,
    [updated]                 DATETIME      NULL,
    [updated_by]              NUMERIC (10)  NULL,
    [owner_id]                NUMERIC (10)  NULL,
    [is_deleted]              NUMERIC (1)   NULL,
    [fb_uea_pe_id]            NUMERIC (10)  NULL,
    [codigo]                  VARCHAR (200) NULL,
    [fb_destinatario_id]      NUMERIC (10)  NULL,
    CONSTRAINT [sol_solicitud_id] PRIMARY KEY CLUSTERED ([sol_solicitud_id] ASC)
);


GO

/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_INSERT_sol_planes_accion]
Fecha Creacion: 10/06/2021
Autor: Mauro Roque
Descripcion: trigger que inserta data en SAC al crear una solicitud
Usado por: Modulo: Registro Solicitue
Tablas Afectadas : sac_accion_correctiva INSERTA
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE trigger [dbo].[tr_INSERT_sol_planes_accion]  
on [dbo].[sol_solicitud]  
after insert  
as  
begin  

declare @sol_solicitud numeric(10,0) , @codigo varchar(200)
declare @sol_categoria_id numeric(10,0)  
   
 set @sol_solicitud = (select sol_solicitud_id from inserted)  
 set @sol_categoria_id = (select sol_categoria_id  from inserted)  
 
set @codigo = (select codigo  from inserted)    

   
  if (@codigo ='')
  begin
	set @codigo = [dbo].[uf_sol_codigo_solicitud] (@sol_solicitud)    
  end


	 update [sol_solicitud] 
	 set codigo = @codigo
	 where sol_solicitud_id = @sol_solicitud


	 insert into sac_accion_correctiva
			 (
			 g_tipo_origen_id,
			 origen_id,
			 sub_origen_id,
			 codigo_registro_origen,
			 fecha_origen,
			 codigo_accion_correctiva,
			 g_tipo_accion_correctiva_id,
			 accion_correctiva_detalle,
			 g_estado_jerarquia_id,
			 g_nivel_riesgo_id,
			 g_tipo_accion_id,
			 sac_estado_accion_correctiva_id,
			 fb_empleado_id_correcion,
			 nombre_responsable_correccion,
			 observaciones_responsable_correccion,
			 fecha_acordada_ejecucion,
			 fecha_implementada,
			 fb_uea_pe_id,
			 created,
			 created_by,
			 updated,
			 updated_by,
			 owner_id,
			 is_deleted
			 )
	 select 
			  23, --solicitud
			 sol.sol_solicitud_id,
			 it.sol_item_id,
			 sol.codigo,
			 sol.fecha_solicitud,
			 '', --codigo_Accion_corectiva
			 19,-- g_tipo_accion_correctiva_id -- Actualizar/Aplicar
			 it.nombre,
			 null, -- g_estado_jerarquia_id
			 null, --nivel riesl
			 1, --tipo accion -- Correctiva
			 1, -- estado_sac
			 it.fb_responsable_principal_id ,
			 null, -- nombre_responsable_correccion
			 null, -- observaciones_responsable_correccion
			 sol.fecha_solicitud, -- fecha_acordada_ejecucion
			 null, --- fecha_implementada
			 sol.fb_uea_pe_id ,
			 getdate(),
			 1,
			 getdate(),
			 1,
			 1,
			 0
	 from sol_item it 
		inner join sol_categoria cat on it.sol_categoria_id = cat.sol_categoria_id
		inner join sol_solicitud sol on sol.sol_categoria_id = cat.sol_categoria_id
	 where sol.sol_categoria_id = @sol_categoria_id
	 order by it.orden desc

end

GO

