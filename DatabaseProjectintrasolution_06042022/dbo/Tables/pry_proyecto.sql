CREATE TABLE [dbo].[pry_proyecto] (
    [pry_proyecto_id]                    NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [codigo]                             VARCHAR (100)   NULL,
    [nombre]                             VARCHAR (500)   NULL,
    [descripcion]                        VARCHAR (MAX)   NULL,
    [fb_cliente_id]                      NUMERIC (10)    NULL,
    [prd_producto_id]                    NUMERIC (10)    NULL,
    [fecha_inicio_estimada]              DATETIME        NULL,
    [fecha_fin_estimada]                 DATETIME        NULL,
    [fecha_inicio_real]                  DATETIME        NULL,
    [fecha_fin_real]                     DATETIME        NULL,
    [pro_propuesta_id]                   NUMERIC (10)    NULL,
    [archivo_propuesta]                  VARCHAR (500)   NULL,
    [archivo_orden_compra]               VARCHAR (500)   NULL,
    [archivo_inicio_proyecto]            VARCHAR (500)   NULL,
    [archivo_cierre_proyecto]            VARCHAR (500)   NULL,
    [pry_estado_proyecto_id]             NUMERIC (10)    NULL,
    [moneda]                             VARCHAR (50)    NULL,
    [monto_proyecto]                     NUMERIC (19, 4) NULL,
    [estado]                             NUMERIC (1)     NULL,
    [created]                            DATETIME        NULL,
    [created_by]                         NUMERIC (10)    NULL,
    [updated]                            DATETIME        NULL,
    [updated_by]                         NUMERIC (10)    NULL,
    [owner_id]                           NUMERIC (10)    NULL,
    [is_deleted]                         NUMERIC (1)     NULL,
    [monto_soles]                        NUMERIC (15, 2) NULL,
    [monto_dolares]                      NUMERIC (15, 2) NULL,
    [codigo_jira]                        VARCHAR (50)    NULL,
    [renovable]                          NUMERIC (1)     NULL,
    [email_cliente_incidente]            VARCHAR (520)   NULL,
    [fb_responsable_id]                  NUMERIC (10)    NULL,
    [fb_responsable_ti_cliente_id]       NUMERIC (10)    NULL,
    [fb_analista_dtech_id]               NUMERIC (10)    NULL,
    [fb_responsable_proyecto_cliente_id] NUMERIC (10)    NULL,
    [nro_orden_compra]                   VARCHAR (200)   NULL,
    CONSTRAINT [PK_pry_proyecto] PRIMARY KEY CLUSTERED ([pry_proyecto_id] ASC)
);


GO

/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_pry_proyecto_genera_codigo]
Fecha Creacion: 27/02/2020
Autor: Mauro Roque
Descripcion: trigger que genera codigo correlativo del modulo proyecto evento despues de grabar
Usado por: Modulo: proyecto
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
03/12/2021				MAURO ROQUE				se agrego Sp "pr_aviso_propuesta_cliente_proyecto" que envia correo de Aviso 
**********************************************************************************************************
*/
CREATE trigger [dbo].[tr_pry_proyecto_genera_codigo]    
on [dbo].[pry_proyecto]    
after insert    
as    
begin    
declare @codigo varchar(50)    
declare @pry_proyecto_id numeric(10,0)   

 
set @pry_proyecto_id = (select pry_proyecto_id  from inserted)    
set @codigo = (select codigo  from inserted)    
 
   
  if (@codigo ='')
  begin
	set @codigo = [dbo].[uf_pry_codigo_proyecto](@pry_proyecto_id)    
   	update pry_proyecto set codigo = @codigo where pry_proyecto_id = @pry_proyecto_id  

  end
   

      EXEC pr_aviso_propuesta_cliente_proyecto @pry_proyecto_id , 'PROYECTO'

end

GO

/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_pry_proyecto_UPDATE]
Fecha Creacion: 03/12/2020
Autor: Mauro Roque
Descripcion: trigger que envia correo de aviso despues de cambiar estado del proyecto 
Usado por: Modulo: Proyecto
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
 
**********************************************************************************************************
*/
create trigger [dbo].[tr_pry_proyecto_UPDATE]    
on [dbo].[pry_proyecto]    
after update    
as    
begin     
declare @pry_proyecto_id numeric(10,0)
    
 
set @pry_proyecto_id = (select pry_proyecto_id  from inserted)    
   
   if update (pry_estado_proyecto_id)
	   begin 

   		EXEC pr_aviso_propuesta_cliente_proyecto @pry_proyecto_id , 'PROYECTO'
  
	   end
   
end

GO

