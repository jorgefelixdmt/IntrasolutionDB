CREATE TABLE [dbo].[pro_propuesta] (
    [pro_propuesta_id]         NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [codigo]                   VARCHAR (100)   NULL,
    [titulo]                   VARCHAR (512)   NULL,
    [descripcion]              VARCHAR (2048)  NULL,
    [moneda]                   VARCHAR (20)    NULL,
    [monto]                    NUMERIC (10, 2) NULL,
    [pro_propuesta_cliente_id] NUMERIC (10)    NULL,
    [prd_producto_id]          NUMERIC (10)    NULL,
    [fb_uea_pe_id]             NUMERIC (10)    NULL,
    [pro_estado_propuesta_id]  NUMERIC (10)    NULL,
    [pro_motivo_rechazo_id]    NUMERIC (10)    NULL,
    [rechazo_descripcion]      VARCHAR (1024)  NULL,
    [fecha_solicitante]        DATETIME        NULL,
    [fecha_propuesta_inicial]  DATETIME        NULL,
    [solicitante]              VARCHAR (200)   NULL,
    [archivo_propuesta]        VARCHAR (550)   NULL,
    [fecha_documento]          DATETIME        NULL,
    [version]                  VARCHAR (50)    NULL,
    [observacion]              VARCHAR (MAX)   NULL,
    [created]                  DATETIME        NULL,
    [created_by]               NUMERIC (10)    NULL,
    [updated]                  DATETIME        NULL,
    [updated_by]               NUMERIC (10)    NULL,
    [owner_id]                 NUMERIC (10)    NULL,
    [is_deleted]               NUMERIC (1)     NULL,
    [fb_contacto_id]           NUMERIC (10)    NULL,
    [fb_cliente_id]            NUMERIC (10)    NULL,
    [archivo_propuesta_size]   NUMERIC (10)    NULL,
    CONSTRAINT [PK_pro_propuesta] PRIMARY KEY CLUSTERED ([pro_propuesta_id] ASC)
);


GO

/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_pro_propuesta_genera_codigo]
Fecha Creacion: 27/02/2020
Autor: Mauro Roque
Descripcion: trigger que genera codigo correlativo del modulo propuesta evento despues de grabar
Usado por: Modulo: Propuesta
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
21/05/2021				MAURO ROQUE				se agrego nueva funcion que genera correlativo [uf_pro_codigo_propuesta_v2]
15/09/2021				MAURO ROQUE				se REMPLAZO LA FUNCION ANTERIOR [uf_pro_codigo_propuesta]
15/11/2021				MAURO ROQUE				se remplazo el campo "propuesta_cliente_id" por "fb_cliente_id"
03/12/2021				MAURO ROQUE				se agrego Sp "pr_aviso_propuesta_cliente_proyecto" que envia correo de Aviso 
**********************************************************************************************************
*/
CREATE trigger [dbo].[tr_pro_propuesta_genera_codigo]    
on [dbo].[pro_propuesta]    
after insert    
as    
begin    
declare @codigo varchar(50)   , @fb_cliente_id int    
declare @pro_propuesta_id numeric(10,0), @codigo_cliente varchar(100)   
    
 
set @pro_propuesta_id = (select pro_propuesta_id  from inserted)    
set @codigo = (select codigo  from inserted)    
set @fb_cliente_id = (select fb_cliente_id from inserted)  
   
  if (@codigo ='')
  begin
	-- set @codigo = [dbo].[uf_pro_codigo_propuesta_v2](@pro_propuesta_id)   
	  set @codigo = [dbo].[uf_pro_codigo_propuesta](@pro_propuesta_id)   
	 
  end


	 update pro_propuesta 
	 set codigo = @codigo 
	 where pro_propuesta_id = @pro_propuesta_id

	EXEC pr_aviso_propuesta_cliente_proyecto @pro_propuesta_id , 'PROPUESTA'
	


end

GO

/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_pro_propuesta_UPDATE]
Fecha Creacion: 03/12/2020
Autor: Mauro Roque
Descripcion: trigger que envia correo de aviso despues de cambiar estado de la propuesta 
Usado por: Modulo: Propuesta
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
 
**********************************************************************************************************
*/
create trigger [dbo].[tr_pro_propuesta_UPDATE]    
on [dbo].[pro_propuesta]    
after update    
as    
begin     
declare @pro_propuesta_id numeric(10,0), @estado_pro numeric(10,0)   
    
 
set @pro_propuesta_id = (select pro_propuesta_id  from inserted)    
   
   if update (pro_estado_propuesta_id)
	   begin 

   		EXEC pr_aviso_propuesta_cliente_proyecto @pro_propuesta_id , 'PROPUESTA'
  
	   end
   
end

GO

