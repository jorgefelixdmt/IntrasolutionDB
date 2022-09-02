CREATE TABLE [dbo].[sac_accion_correctiva] (
    [sac_accion_correctiva_id]             NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [g_tipo_origen_id]                     NUMERIC (10)   NULL,
    [eva_hallazgo_id]                      NUMERIC (10)   NULL,
    [eva_hallazgo_causa_basica_id]         NUMERIC (10)   NULL,
    [eva_hallazgo_causa_inmediata_id]      NUMERIC (10)   NULL,
    [inc_informe_final_id]                 NUMERIC (10)   NULL,
    [inc_accidente_causa_basica_id]        NUMERIC (10)   NULL,
    [inc_accidente_causa_inmediata_id]     NUMERIC (10)   NULL,
    [enf_registro_enf_datos_empleador_id]  NUMERIC (10)   NULL,
    [enf_registro_causa_basica_id]         NUMERIC (10)   NULL,
    [enf_registro_causa_inmediata_id]      NUMERIC (10)   NULL,
    [ops_registro_generales_id]            NUMERIC (10)   NULL,
    [origen_id]                            NUMERIC (10)   NULL,
    [sub_origen_id]                        NUMERIC (10)   NULL,
    [codigo_registro_origen]               VARCHAR (50)   NULL,
    [fecha_origen]                         DATETIME       NOT NULL,
    [codigo_accion_correctiva]             VARCHAR (50)   NULL,
    [id_causa_inmediata]                   NUMERIC (10)   NULL,
    [codigo_causa_inmediata]               VARCHAR (50)   NULL,
    [nombre_causa_inmediata]               VARCHAR (200)  NULL,
    [causa_inmediata_detalle]              VARCHAR (4000) NULL,
    [id_causa_basica]                      NUMERIC (10)   NULL,
    [codigo_causa_basica]                  VARCHAR (50)   NULL,
    [nombre_causa_basica]                  VARCHAR (200)  NULL,
    [causa_basica_detalle]                 VARCHAR (4000) NULL,
    [g_tipo_accion_correctiva_id]          NUMERIC (10)   NULL,
    [accion_correctiva_detalle]            VARCHAR (4000) NULL,
    [g_estado_jerarquia_id]                NUMERIC (10)   NULL,
    [g_nivel_riesgo_id]                    NUMERIC (10)   NULL,
    [g_tipo_accion_id]                     NUMERIC (10)   NULL,
    [sac_estado_accion_correctiva_id]      NUMERIC (10)   NULL,
    [fb_empleado_id_correcion]             NUMERIC (10)   NULL,
    [nombre_responsable_correccion]        VARCHAR (200)  NULL,
    [observaciones_responsable_correccion] VARCHAR (4000) NULL,
    [fecha_acordada_ejecucion]             DATETIME       NULL,
    [fecha_implementada]                   DATETIME       NULL,
    [fecha_verificacion]                   DATETIME       NULL,
    [fb_empleado_id_verificador]           NUMERIC (10)   NULL,
    [nombre_verificador]                   VARCHAR (200)  NULL,
    [observaciones_verificador]            VARCHAR (4000) NULL,
    [fb_uea_pe_id]                         NUMERIC (10)   NULL,
    [created]                              DATETIME       NULL,
    [created_by]                           NUMERIC (10)   NULL,
    [updated]                              DATETIME       NULL,
    [updated_by]                           NUMERIC (10)   NULL,
    [owner_id]                             NUMERIC (10)   NULL,
    [is_deleted]                           NUMERIC (1)    NULL,
    [inc_informe_final_icam_id]            NUMERIC (10)   NULL,
    [fb_responsable_alterno_id]            NUMERIC (10)   NULL,
    [codigo_jira]                          VARCHAR (200)  NULL,
    CONSTRAINT [PK_sac_accion_correctivaA] PRIMARY KEY CLUSTERED ([sac_accion_correctiva_id] ASC)
);


GO

CREATE TRIGGER [dbo].[TR_SAC_Actualiza]  
ON [dbo].[sac_accion_correctiva]  
AFTER UPDATE  
AS   
  
BEGIN  
  
  
 IF UPDATE(sac_estado_accion_correctiva_id)   
 BEGIN   
  
  Declare @id_solicitud numeric(10,0)  
  Select @id_solicitud = origen_id from inserted  
  
  			  -- SI LOS PLANES DE ACCION ESTAN CON ESTADO EJECUTADO

			  IF Not Exists(SELECT * FROM sac_accion_correctiva   
			   WHERE sac_estado_accion_correctiva_id <> 6 and    -- EJECUTADO
			  origen_id = @id_solicitud and  
			  g_tipo_origen_id = 23 and -- SOLICITUD
			  is_deleted = 0) -- VERIFICA QUE NO EXISTA ACCIONES NO CERRADAS   
				   BEGIN  
					Update sol_solicitud Set sol_solicitud_estado_id = 5  -- COLOCA ESTADO=EJECUTADO
					Where sol_solicitud_id = @id_solicitud  
				   END  
				   
					   
				  
	END

END

GO


/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_sac_accion_correctiva_genera_cod]
Fecha Creacion: 20/08/2019
Autor: Mauro Roque
Descripcion: trigger que obtiene codigo correlativo de SAC despues de insertar una SAC
Usado por: Modulo: SAC
Tablas afectadas : sac_accion_correctiva ACTUALIZA
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
10/06/2021				Mauro Roque			 se agrego cursor que actializa la fecha ejecucion de la sac del tipo origen Solicitud
**********************************************************************************************************
*/
CREATE trigger [dbo].[tr_sac_accion_correctiva_genera_cod]  
on [dbo].[sac_accion_correctiva]  
after insert  
as  
begin  
declare @codigo varchar(50)  ,@origen_id int , @fecha_final_sac varchar(10) , @FechaInicial varchar(10)
declare @fb_uea_pe_id numeric(10,0) ,@plazo_dias numeric(10,0)
declare @sac_accion_correctiva_id numeric(10,0) , @sub_origen_id int 
   

  DECLARE CursorSAC CURSOR FOR      
			 SELECT  
			 fb_uea_pe_id,      
				sac_accion_correctiva_id,
				sub_origen_id,
				origen_id 
			 FROM inserted 
		   
				  OPEN CursorSAC      
		  FETCH NEXT FROM CursorSAC INTO @fb_uea_pe_id,@sac_accion_correctiva_id ,@sub_origen_id,@origen_id
      
		  WHILE @@FETCH_STATUS = 0      
			BEGIN   

			 set @codigo = [dbo].[uf_sac_codigo_accion_correctiva](@sac_accion_correctiva_id,@fb_uea_pe_id)  
  
			 set @plazo_dias = (select plazo_dias from sol_item where sol_item_id = @sub_origen_id)

			 set @FechaInicial = (select  convert(varchar(10),fecha_solicitud,103) 
									from sol_solicitud where sol_solicitud_id = @origen_id)

			 
			  Set dateformat dmy  
			 Set datefirst 1   -- Considera el dia 1 como LUNES  
			 Set @plazo_dias = @plazo_dias 
  
			 Declare @Fecha as datetime, @ContadorDias int 
    
			 Set @Fecha = @FechaInicial   
 
			 Set @ContadorDias = 0 

			 While @ContadorDias  < @plazo_dias   
			  BEGIN  
				Set @Fecha = DATEADD(DAY,1,@Fecha)
	
						Set @ContadorDias = @ContadorDias + 1
			  END  
			 set @fecha_final_sac = ( Select convert(varchar(10),@Fecha,103) ) --as FechaFinal 
 


			 update sac_accion_correctiva 
			 set codigo_accion_correctiva = @codigo
			 where sac_accion_correctiva_id = @sac_accion_correctiva_id  


			 update sac_accion_correctiva 
			 set fecha_acordada_ejecucion = @fecha_final_sac
			 where sub_origen_id = @sub_origen_id  


  
				FETCH NEXT FROM CursorSAC INTO @fb_uea_pe_id,@sac_accion_correctiva_id ,@sub_origen_id,@origen_id
	 
			END	 

			  CLOSE CursorSAC      
		  DEALLOCATE CursorSAC      

end

GO

