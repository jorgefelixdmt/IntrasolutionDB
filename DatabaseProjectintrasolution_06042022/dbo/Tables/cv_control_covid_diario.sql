CREATE TABLE [dbo].[cv_control_covid_diario] (
    [cv_control_covid_diario_id]  NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [fecha_registro]              DATETIME        NULL,
    [codigo]                      VARCHAR (50)    NULL,
    [g_rol_empresa_id]            NUMERIC (10)    NULL,
    [fb_empresa_especializada_id] NUMERIC (10)    NULL,
    [fb_uea_pe_id]                NUMERIC (10)    NULL,
    [fb_empleado_id]              NUMERIC (10)    NULL,
    [nombre_completo]             VARCHAR (200)   NULL,
    [documento_entidad]           VARCHAR (50)    NULL,
    [sexo]                        VARCHAR (5)     NULL,
    [fecha_nacimiento]            DATETIME        NULL,
    [edad]                        NUMERIC (10)    NULL,
    [temperatura]                 NUMERIC (10, 2) NULL,
    [pulsioximetria]              NUMERIC (10, 2) NULL,
    [presion]                     NUMERIC (10, 2) NULL,
    [cv_tipo_acceso_id]           NUMERIC (10)    NULL,
    [created]                     DATETIME        NULL,
    [created_by]                  NUMERIC (10)    NULL,
    [updated]                     DATETIME        NULL,
    [updated_by]                  NUMERIC (10)    NULL,
    [owner_id]                    NUMERIC (10)    NULL,
    [is_deleted]                  NUMERIC (1)     NULL,
    CONSTRAINT [PK_cv_control_covid_diario] PRIMARY KEY CLUSTERED ([cv_control_covid_diario_id] ASC)
);


GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[tr_cv_genera_cod_control_diario]
   ON  [dbo].[cv_control_covid_diario]
   AFTER INSERT
AS 
 BEGIN
	SET NOCOUNT ON;

	DECLARE @cv_control_covid_diario_id numeric(10,0)
	declare @codigo varchar(50)    
	declare @fb_uea_pe_id numeric(10,0)	, @cv_tipo_acceso_id int   
 
    set @cv_control_covid_diario_id = (select cv_control_covid_diario_id from inserted)
	set @fb_uea_pe_id = (select fb_uea_pe_id from inserted)    
 
		 set @codigo = [dbo].[uf_cv_codigo_control_covid](@cv_control_covid_diario_id,@fb_uea_pe_id)    
    	 update cv_control_covid_diario set codigo = @codigo where cv_control_covid_diario_id = @cv_control_covid_diario_id  

		set @cv_tipo_acceso_id = (select cv_tipo_acceso_id from inserted)    

		if (@cv_tipo_acceso_id = 2) -- Restringir Acceso

		begin
			insert into cv_caso_sospechoso
			(
			--numero_caso,
			fecha_registro,
			g_rol_empresa_id,
			fb_empresa_especializada_id,
			codigo_tributario,
			fb_uea_pe_id,
			fb_empleado_id,
			empleado_codigo,
			nombre_completo,
			documento_entidad,
			sexo,
			fecha_nacimiento,
			edad,
			talla,
			peso,
			imc,
			exa_clasificacion_imc_id,
			temperatura,
			pulsioximetria,
			presion,
			
			cv_tipo_prueba_id,
			fecha_resultado,
			cv_tipo_resultado_id,
			hospitalizacion,
			fecha_hospitalizacion,
			cv_tipo_alta_id,
			fecha_inicio_aislamiento,
			fecha_fin_aislamiento,
			created,
			created_by,
			updated,
			updated_by,
			owner_id,
			is_deleted

			)
			select
			ccd.fecha_registro,
			med.g_rol_empresa_id,
			ccd.fb_empresa_especializada_id,
			med.codigo_tributario,
			ccd.fb_uea_pe_id,
			ccd.fb_empleado_id,
			med.documento_entidad,
			ccd.nombre_completo,
			ccd.documento_entidad,
			ccd.sexo,
			ccd.fecha_nacimiento,
			ccd.edad,
			med.talla,
			med.peso,
			med.imc,
			med.exa_clasificacion_imc_id,
			ccd.temperatura,
			ccd.pulsioximetria,
			ccd.presion,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			GETDATE(),
			1,
			GETDATE(),
			1,
			1,
			0
			from [cv_control_covid_diario] ccd LEFT join exa_datos_medico med
			on ccd.fb_empleado_id = med.fb_empleado_id
			where ccd.cv_control_covid_diario_id = @cv_control_covid_diario_id

		end



 END

GO

CREATE TRIGGER [dbo].[tr_cv_revision_control_diario]
   ON  [dbo].[cv_control_covid_diario]
   AFTER INSERT, UPDATE
AS 
 BEGIN
	SET NOCOUNT ON;

	DECLARE @cv_control_covid_diario_id numeric(10,0)

    set @cv_control_covid_diario_id = (select cv_control_covid_diario_id from inserted)
	

		exec pr_cv_aviso_control_diario_excede @cv_control_covid_diario_id



 END

GO

