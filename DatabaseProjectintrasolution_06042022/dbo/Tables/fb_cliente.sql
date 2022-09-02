CREATE TABLE [dbo].[fb_cliente] (
    [fb_cliente_id]            NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]                   VARCHAR (20)   NULL,
    [nombre]                   VARCHAR (100)  NULL,
    [descripcion]              VARCHAR (1024) NULL,
    [observaciones]            VARCHAR (2048) NULL,
    [ruc]                      VARCHAR (40)   NULL,
    [telefono]                 VARCHAR (100)  NULL,
    [direccion]                VARCHAR (512)  NULL,
    [pagina_web]               VARCHAR (512)  NULL,
    [pagina_proveedores]       VARCHAR (512)  NULL,
    [datos_pagina_proveedores] VARCHAR (200)  NULL,
    [fb_pais]                  NUMERIC (10)   NULL,
    [fb_empresa_id]            NUMERIC (10)   NULL,
    [estado]                   INT            NULL,
    [created]                  DATETIME       NULL,
    [created_by]               NUMERIC (10)   NULL,
    [updated]                  DATETIME       NULL,
    [updated_by]               NUMERIC (10)   NULL,
    [owner_id]                 NUMERIC (10)   NULL,
    [is_deleted]               NUMERIC (1)    NULL,
    [fb_pais_id]               NUMERIC (10)   NULL,
    [pro_propuesta_cliente_id] NUMERIC (10)   NULL,
    [prospecto]                NUMERIC (1)    NULL,
    CONSTRAINT [PK_fb_cliente] PRIMARY KEY CLUSTERED ([fb_cliente_id] ASC)
);


GO

/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_fb_cliente_insert_and_update]
Fecha Creacion: 03/12/2020
Autor: Mauro Roque
Descripcion: trigger que envia correo de aviso despues de registrar nuevo cliente 
Usado por: Modulo: Cliente
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
 
**********************************************************************************************************
*/
create trigger [dbo].[tr_fb_cliente_insert]    
on [dbo].[fb_cliente]    
after insert    
as    
begin     
declare @id_cliente numeric(10,0)
    
 	set @id_cliente = (select fb_cliente_id  from inserted)    
   
   EXEC pr_aviso_propuesta_cliente_proyecto @id_cliente , 'CLIENTE'
  
   
end

GO

