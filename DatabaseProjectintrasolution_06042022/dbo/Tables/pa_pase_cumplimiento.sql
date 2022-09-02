CREATE TABLE [dbo].[pa_pase_cumplimiento] (
    [pa_pase_cumplimiento_id]      NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [pa_pase_id]                   NUMERIC (10)  NULL,
    [descripcion_verificacion]     VARCHAR (MAX) NULL,
    [check_constructor_pase]       NUMERIC (1)   NULL,
    [check_qa_empresa]             NUMERIC (1)   NULL,
    [observacion_constructor_pase] VARCHAR (MAX) NULL,
    [observacion_qa_empresa]       VARCHAR (MAX) NULL,
    [created]                      DATETIME      NULL,
    [created_by]                   NUMERIC (10)  NULL,
    [updated]                      DATETIME      NULL,
    [updated_by]                   NUMERIC (10)  NULL,
    [owner_id]                     NUMERIC (10)  NULL,
    [is_deleted]                   NUMERIC (10)  NULL,
    CONSTRAINT [PK_pa_pase_cumplimiento] PRIMARY KEY CLUSTERED ([pa_pase_cumplimiento_id] ASC)
);


GO

