CREATE TABLE [dbo].[cv_examen_covid] (
    [cv_examen_covid_id]          NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [g_rol_empresa_id]            NUMERIC (10)  NULL,
    [fb_empresa_especializada_id] NUMERIC (10)  NULL,
    [codigo_tributario]           VARCHAR (50)  NULL,
    [fb_uea_pe_id]                NUMERIC (10)  NULL,
    [fb_empleado_id]              NUMERIC (10)  NULL,
    [nombre_completo]             VARCHAR (200) NULL,
    [documento_entidad]           VARCHAR (50)  NULL,
    [sexo]                        VARCHAR (5)   NULL,
    [fecha_nacimiento]            DATETIME      NULL,
    [edad]                        NUMERIC (10)  NULL,
    [cv_tipo_origen_id]           NUMERIC (10)  NULL,
    [cv_caso_sospechoso_id]       NUMERIC (10)  NULL,
    [fecha_muestra]               DATETIME      NULL,
    [cv_tipo_prueba_id]           NUMERIC (10)  NULL,
    [g_centro_medico_id]          NUMERIC (10)  NULL,
    [medico_responsable]          VARCHAR (200) NULL,
    [cv_tipo_resultado_id]        NUMERIC (10)  NULL,
    [fecha_resultado]             DATETIME      NULL,
    [created]                     DATETIME      NULL,
    [created_by]                  NUMERIC (10)  NULL,
    [updated]                     DATETIME      NULL,
    [updated_by]                  NUMERIC (10)  NULL,
    [owner_id]                    NUMERIC (10)  NULL,
    [is_deleted]                  NUMERIC (1)   NULL,
    CONSTRAINT [PK_cv_examen_covid] PRIMARY KEY CLUSTERED ([cv_examen_covid_id] ASC)
);


GO


CREATE TRIGGER [dbo].[tr_cv_examen_covid_resultado]
   ON  [dbo].[cv_examen_covid]
   AFTER insert, UPDATE
AS 
 BEGIN
	SET NOCOUNT ON;

	DECLARE @fecha_resultado datetime
	declare @cv_tipo_resultado_id int , @cv_caso_sospechoso_id int

	set @cv_tipo_resultado_id = (select cv_tipo_resultado_id from inserted)
	set @fecha_resultado = (select fecha_resultado from inserted)
	
	set @cv_caso_sospechoso_id = (select cv_caso_sospechoso_id from inserted)
	
	update cv_caso_sospechoso
	set cv_tipo_resultado_id = @cv_tipo_resultado_id, fecha_resultado=@fecha_resultado
	where cv_caso_sospechoso_id = @cv_caso_sospechoso_id


 END

GO

