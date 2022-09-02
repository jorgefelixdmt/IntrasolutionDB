CREATE TABLE [dbo].[cv_declaracion_sintomas] (
    [cv_declaracion_sintomas_id] NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [cv_declaracion_id]          NUMERIC (10) NULL,
    [cv_sintoma_covid_id]        NUMERIC (10) NULL,
    [fecha_inicio]               DATETIME     NULL,
    [numero_dias]                NUMERIC (10) NULL,
    [fecha_fin]                  DATETIME     NULL,
    [created]                    DATETIME     NULL,
    [created_by]                 NUMERIC (10) NULL,
    [updated]                    DATETIME     NULL,
    [updated_by]                 NUMERIC (10) NULL,
    [owner_id]                   NUMERIC (10) NULL,
    [is_deleted]                 NUMERIC (1)  NULL,
    CONSTRAINT [PK_cv_declaracion_sintomas] PRIMARY KEY CLUSTERED ([cv_declaracion_sintomas_id] ASC)
);


GO


CREATE TRIGGER [dbo].[tr_cv_declaracion_nuevo_sintoma]
   ON  [dbo].[cv_declaracion_sintomas]
   AFTER INSERT
AS 
 BEGIN
	SET NOCOUNT ON;

	DECLARE @cv_declaracion_sintomas_id numeric(10,0)

    set @cv_declaracion_sintomas_id = (select cv_declaracion_sintomas_id from inserted)

	exec pr_cv_aviso_caso_sospechoso @cv_declaracion_sintomas_id

 END

GO

