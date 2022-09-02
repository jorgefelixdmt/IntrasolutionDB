CREATE TABLE [dbo].[inc_informe_final_evidencia] (
    [inc_informe_final_evidencia_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [inc_informe_final_id]           NUMERIC (10)  NULL,
    [tipo_documento]                 VARCHAR (50)  NULL,
    [archivo]                        VARCHAR (200) NULL,
    [detalle_documento]              VARCHAR (400) NULL,
    [created]                        DATETIME      NULL,
    [created_by]                     NUMERIC (10)  NULL,
    [updated]                        DATETIME      NULL,
    [updated_by]                     NUMERIC (10)  NULL,
    [owner_id]                       NUMERIC (10)  NULL,
    [is_deleted]                     NUMERIC (1)   NULL,
    CONSTRAINT [PK_inc_informe_final_evidencia] PRIMARY KEY CLUSTERED ([inc_informe_final_evidencia_id] ASC)
);


GO

