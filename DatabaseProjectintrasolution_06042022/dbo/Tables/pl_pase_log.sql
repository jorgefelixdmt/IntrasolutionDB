CREATE TABLE [dbo].[pl_pase_log] (
    [pl_pase_log_id]                NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [pa_pase_id]                    NUMERIC (10)  NULL,
    [version]                       VARCHAR (50)  NULL,
    [descripcion_pase]              VARCHAR (MAX) NULL,
    [fecha_pase]                    DATETIME      NULL,
    [codigo_pase]                   VARCHAR (50)  NULL,
    [codigo_jira_pase]              VARCHAR (50)  NULL,
    [fecha_entrega]                 DATETIME      NULL,
    [fecha_ejecucion]               DATETIME      NULL,
    [flag_control_version_ante]     NUMERIC (1)   NULL,
    [version_anterior]              VARCHAR (50)  NULL,
    [flag_control_version_frw_ante] NUMERIC (10)  NULL,
    [version_anterior_frw]          VARCHAR (50)  NULL,
    [flag_control_version_std_ante] NUMERIC (10)  NULL,
    [version_anterior_std]          VARCHAR (50)  NULL,
    [pl_tipo_pase_id]               NUMERIC (10)  NULL,
    [pl_estado_pase_id]             NUMERIC (10)  NULL,
    [observacion]                   VARCHAR (MAX) NULL,
    [created]                       DATETIME      NULL,
    [created_by]                    NUMERIC (10)  NULL,
    [updated]                       DATETIME      NULL,
    [updated_by]                    NUMERIC (10)  NULL,
    [owner_id]                      NUMERIC (10)  NULL,
    [is_deleted]                    NUMERIC (10)  NULL,
    CONSTRAINT [PK_pl_pase_log] PRIMARY KEY CLUSTERED ([pl_pase_log_id] ASC)
);


GO

