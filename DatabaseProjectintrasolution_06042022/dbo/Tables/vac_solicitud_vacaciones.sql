CREATE TABLE [dbo].[vac_solicitud_vacaciones] (
    [vac_solicitud_vacaciones_id]  NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                       VARCHAR (50)  NULL,
    [fb_empleado_id]               NUMERIC (10)  NULL,
    [anno]                         NUMERIC (10)  NULL,
    [vac_tipo_vacaciones_id]       NUMERIC (10)  NULL,
    [fecha_inicio]                 DATETIME      NULL,
    [fecha_fin]                    DATETIME      NULL,
    [dias_vacaciones]              NUMERIC (10)  NULL,
    [saldo]                        NUMERIC (10)  NULL,
    [descripcion]                  VARCHAR (MAX) NULL,
    [fb_responsable_aprobacion_id] NUMERIC (10)  NULL,
    [vac_estado_vacaciones_id]     NUMERIC (10)  NULL,
    [estado]                       NUMERIC (1)   NULL,
    [created]                      DATETIME      NULL,
    [created_by]                   NUMERIC (10)  NULL,
    [updated]                      DATETIME      NULL,
    [updated_by]                   NUMERIC (10)  NULL,
    [owner_id]                     NUMERIC (10)  NULL,
    [is_deleted]                   NUMERIC (1)   NULL,
    CONSTRAINT [PK_vac_solicitud_vacaciones] PRIMARY KEY CLUSTERED ([vac_solicitud_vacaciones_id] ASC)
);


GO





/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_vac_vacaciones_genera_codigo]
Fecha Creacion: 02/03/2020
Autor: Mauro Roque
Descripcion: trigger que genera codigo correlativo del modulo Solicitud de vacaciones
Usado por: Modulo: Solicitud de Vacaciones
**************************************************************************************************************************************
RESUMEN DE CAMBIOS	
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE trigger [dbo].[tr_vac_vacaciones_genera_codigo]    
on [dbo].[vac_solicitud_vacaciones]    
after insert    
as    
begin    
declare @codigo varchar(50)    
declare @vac_solicitud_vacaciones_id numeric(10,0)   

 
set @vac_solicitud_vacaciones_id = (select vac_solicitud_vacaciones_id  from inserted)    
set @codigo = (select codigo  from inserted)    
 
   
  if (@codigo ='')
  begin
	set @codigo = [dbo].[uf_vac_codigo_vacaciones](@vac_solicitud_vacaciones_id)    
   	update vac_solicitud_vacaciones set codigo = @codigo where vac_solicitud_vacaciones_id = @vac_solicitud_vacaciones_id  

  end
   
end

GO

