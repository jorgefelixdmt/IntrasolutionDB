CREATE TABLE [dbo].[inc_accidentado_anatomica] (
    [inc_accidentado_anatomica_id]     NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [inc_informe_final_accidentado_id] NUMERIC (10) NULL,
    [inc_tipo_lesion_anatomica_id]     NUMERIC (10) NULL,
    [tipo_lesion_anatomica_codigo]     VARCHAR (50) NULL,
    [created]                          DATETIME     NULL,
    [created_by]                       NUMERIC (10) NULL,
    [updated]                          DATETIME     NULL,
    [updated_by]                       NUMERIC (10) NULL,
    [owner_id]                         NUMERIC (10) NULL,
    [is_deleted]                       NUMERIC (1)  NULL,
    CONSTRAINT [PK_inc_accidentado_anatomica] PRIMARY KEY CLUSTERED ([inc_accidentado_anatomica_id] ASC)
);


GO

