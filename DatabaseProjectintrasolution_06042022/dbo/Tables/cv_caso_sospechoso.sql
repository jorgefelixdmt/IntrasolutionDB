CREATE TABLE [dbo].[cv_caso_sospechoso] (
    [cv_caso_sospechoso_id]       NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [numero_caso]                 VARCHAR (50)    NULL,
    [fecha_registro]              DATETIME        NULL,
    [g_rol_empresa_id]            NUMERIC (10)    NULL,
    [fb_empresa_especializada_id] NUMERIC (10)    NULL,
    [codigo_tributario]           VARCHAR (50)    NULL,
    [fb_uea_pe_id]                NUMERIC (10)    NULL,
    [fb_empleado_id]              NUMERIC (10)    NULL,
    [empleado_codigo]             VARCHAR (50)    NULL,
    [nombre_completo]             VARCHAR (200)   NULL,
    [documento_entidad]           VARCHAR (50)    NULL,
    [sexo]                        VARCHAR (5)     NULL,
    [fecha_nacimiento]            DATETIME        NULL,
    [edad]                        NUMERIC (10)    NULL,
    [talla]                       NUMERIC (10, 2) NULL,
    [peso]                        NUMERIC (10, 2) NULL,
    [imc]                         NUMERIC (10, 2) NULL,
    [exa_clasificacion_imc_id]    NUMERIC (10)    NULL,
    [temperatura]                 VARCHAR (50)    NULL,
    [pulsioximetria]              VARCHAR (50)    NULL,
    [presion]                     VARCHAR (50)    NULL,
    [cv_tipo_prueba_id]           NUMERIC (10)    NULL,
    [fecha_resultado]             DATETIME        NULL,
    [cv_tipo_resultado_id]        NUMERIC (10)    NULL,
    [hospitalizacion]             VARCHAR (50)    NULL,
    [fecha_hospitalizacion]       DATETIME        NULL,
    [cv_tipo_alta_id]             NUMERIC (10)    NULL,
    [fecha_inicio_aislamiento]    DATETIME        NULL,
    [fecha_fin_aislamiento]       DATETIME        NULL,
    [created]                     DATETIME        NULL,
    [created_by]                  NUMERIC (10)    NULL,
    [updated]                     DATETIME        NULL,
    [updated_by]                  NUMERIC (10)    NULL,
    [owner_id]                    NUMERIC (10)    NULL,
    [is_deleted]                  NUMERIC (1)     NULL,
    CONSTRAINT [PK_cv_caso_sospechoso] PRIMARY KEY CLUSTERED ([cv_caso_sospechoso_id] ASC)
);


GO


CREATE trigger [dbo].[tr_cv_genera_nro_caso]   
on [dbo].[cv_caso_sospechoso]    
after insert    
as    
begin    
declare @nro_caso_sos varchar(50)    
declare @fb_uea_pe_id numeric(10,0)    
 declare @cv_caso_sospechoso_id numeric(10,0)   
 declare @numero_caso_temp varchar(50)    
     
 set @fb_uea_pe_id = (select fb_uea_pe_id from inserted)    
 set @cv_caso_sospechoso_id = (select cv_caso_sospechoso_id  from inserted)    
 set @numero_caso_temp = (select numero_caso  from inserted)    
  
    

		 set @nro_caso_sos = [dbo].[uf_cv_nro_caso_sospechoso](@cv_caso_sospechoso_id,@fb_uea_pe_id)    
    	 update [cv_caso_sospechoso] set numero_caso = @nro_caso_sos where cv_caso_sospechoso_id = @cv_caso_sospechoso_id  
 
  
end

GO

