CREATE TABLE [dbo].[inc_prueba] (
    [inc_prueba_id]                 NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [inc_incidencia_id]             NUMERIC (10)  NULL,
    [numero_ticket]                 VARCHAR (100) NULL,
    [codigo_jira]                   VARCHAR (100) NULL,
    [inc_tipo_prueba_id]            NUMERIC (10)  NULL,
    [inc_clase_prueba_id]           NUMERIC (10)  NULL,
    [descripcion]                   VARCHAR (MAX) NULL,
    [fb_elaborada_por_id]           NUMERIC (10)  NULL,
    [elaborada_por_texto]           VARCHAR (200) NULL,
    [archivo]                       VARCHAR (200) NULL,
    [precondiciones]                VARCHAR (400) NULL,
    [postcondiciones]               VARCHAR (400) NULL,
    [resultado_esperado]            VARCHAR (400) NULL,
    [pa_entrega_objetos_id]         NUMERIC (10)  NULL,
    [pa_pase_id]                    NUMERIC (10)  NULL,
    [created]                       DATETIME      NULL,
    [created_by]                    NUMERIC (10)  NULL,
    [updated]                       DATETIME      NULL,
    [updated_by]                    NUMERIC (10)  NULL,
    [owner_id]                      NUMERIC (10)  NULL,
    [is_deleted]                    NUMERIC (1)   NULL,
    [inc_incidencia_codigo_jira_id] NUMERIC (10)  NULL,
    [inc_incidencia_ticket_id]      NUMERIC (10)  NULL,
    [codigo]                        VARCHAR (50)  NULL,
    [sac_accion_correctiva_id]      NUMERIC (10)  NULL,
    [otros_origen]                  VARCHAR (200) NULL,
    CONSTRAINT [inc__pk_prueba_id] PRIMARY KEY CLUSTERED ([inc_prueba_id] ASC)
);


GO




/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_inc_prueba_INSERT]
Fecha Creacion: 08/03/2022
Autor: Mauro Roque
Descripcion: Trigger que genera codigo correlativo de la tabla inc_prueba
Llamado por: Java
Usado por: Modulo: Plan de Pruebas
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
create TRIGGER [dbo].[tr_inc_prueba_INSERT]  
on [dbo].inc_prueba  
after insert  
as  
BEGIN  
DECLARE @codigo_prueba VARCHAR(50) , @anno varchar(4)
DECLARE @inc_prueba_id NUMERIC(10,0), @codigo varchar(50)
    
	 SET @inc_prueba_id = (SELECT inc_prueba_id FROM inserted)  
	 SET @codigo = (SELECT codigo FROM inserted)  
	 SET @anno = (SELECT YEAR(GETDATE()))

	 SET @codigo_prueba = [dbo].[uf_inc_codigo_prueba](@anno)  
	 
	   IF (@codigo ='')
		  BEGIN
			 UPDATE inc_prueba 
			 SET codigo = @codigo_prueba 
			 WHERE inc_prueba_id = @inc_prueba_id
		  END

 
	END

GO

