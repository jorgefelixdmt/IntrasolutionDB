CREATE TABLE [dbo].[dc_documento] (
    [dc_documento_id]             NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fb_uea_pe_id]                NUMERIC (10)  NULL,
    [codigo]                      VARCHAR (50)  NULL,
    [fecha_registro]              DATETIME      NULL,
    [hora_registro]               VARCHAR (10)  NULL,
    [fecha_documento]             DATETIME      NULL,
    [categoria]                   VARCHAR (5)   NULL,
    [fb_cliente_id]               NUMERIC (10)  NULL,
    [fb_empresa_especializada_id] NUMERIC (10)  NULL,
    [otro_rd]                     VARCHAR (200) NULL,
    [requiere_respuesta]          VARCHAR (50)  NULL,
    [fecha_maxima_respuesta]      DATETIME      NULL,
    [dc_tipo_documento_id]        NUMERIC (10)  NULL,
    [titulo_documento]            VARCHAR (200) NULL,
    [descripcion_documento]       VARCHAR (MAX) NULL,
    [archivo_fisico_doc]          VARCHAR (200) NULL,
    [cod_origen]                  VARCHAR (50)  NULL,
    [pry_proyecto_id]             NUMERIC (10)  NULL,
    [dc_estado_documento_id]      NUMERIC (10)  NULL,
    [created]                     DATETIME      NULL,
    [created_by]                  NUMERIC (10)  NULL,
    [updated]                     DATETIME      NULL,
    [updated_by]                  NUMERIC (10)  NULL,
    [owner_id]                    NUMERIC (10)  NULL,
    [is_deleted]                  NUMERIC (1)   NULL,
    CONSTRAINT [PK_dc_documento] PRIMARY KEY CLUSTERED ([dc_documento_id] ASC)
);


GO




/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_dc_documentario_genera_codigo]
Fecha Creacion: 18/50/2020
Autor: Mauro Roque
Descripcion: trigger que genera codigo correlativo para el modulo documentario despues de grabar
Usado por: Modulo: Control Documenratio
tablas que afecta : dc_documento actualiza
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
create trigger [dbo].[tr_dc_documentario_genera_codigoo]    
on [dbo].[dc_documento]    
after insert    
as    
begin    
declare @codigo varchar(50)    
declare @dc_documento_id numeric(10,0)   

 
set @dc_documento_id = (select dc_documento_id  from inserted)    
set @codigo = (select codigo  from inserted)    
 
   
  if (@codigo ='')
  begin
	set @codigo = [dbo].[uf_dc_codigo_documentario](@dc_documento_id)    
   	update dc_documento set codigo = @codigo where dc_documento_id = @dc_documento_id  

  end
   
end

GO

