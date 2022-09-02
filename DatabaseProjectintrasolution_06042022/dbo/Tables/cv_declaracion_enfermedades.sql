CREATE TABLE [dbo].[cv_declaracion_enfermedades] (
    [cv_declaracion_enfermedades_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [cv_declaracion_id]              NUMERIC (10)  NULL,
    [exa_enfermedad_patologica_id]   NUMERIC (10)  NULL,
    [detalle]                        VARCHAR (MAX) NULL,
    [created]                        DATETIME      NULL,
    [created_by]                     NUMERIC (10)  NULL,
    [updated]                        DATETIME      NULL,
    [updated_by]                     NUMERIC (10)  NULL,
    [owner_id]                       NUMERIC (10)  NULL,
    [is_deleted]                     NUMERIC (1)   NULL,
    CONSTRAINT [PK_cv_declaracion_enfermedades] PRIMARY KEY CLUSTERED ([cv_declaracion_enfermedades_id] ASC)
);


GO


CREATE TRIGGER [dbo].[tr_cv_declaracion_nueva_enfermedad]
   ON  [dbo].[cv_declaracion_enfermedades]
   AFTER INSERT
AS 
 BEGIN
	SET NOCOUNT ON;

	DECLARE @cv_declaracion_enfermedades_id numeric(10,0)

    set @cv_declaracion_enfermedades_id = (select cv_declaracion_enfermedades_id from inserted)

	exec pr_cv_aviso_enfermedad_riesgo @cv_declaracion_enfermedades_id

 END

GO

