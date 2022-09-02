CREATE TABLE [dbo].[cap_curso_costo] (
    [cap_curso_costo_id]   NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [cap_curso_id]         NUMERIC (10)    NULL,
    [g_categoria_costo_id] NUMERIC (10)    NULL,
    [g_tipo_costo_id]      NUMERIC (10)    NULL,
    [observacion]          VARCHAR (4000)  NULL,
    [archivo]              VARCHAR (400)   NULL,
    [cantidad]             NUMERIC (15, 3) NULL,
    [costo_unitario]       NUMERIC (15, 3) NULL,
    [sub_total]            NUMERIC (15, 3) NULL,
    [estado]               NUMERIC (1)     NULL,
    [created]              DATETIME        NULL,
    [created_by]           NUMERIC (10)    NULL,
    [updated]              DATETIME        NULL,
    [updated_by]           NUMERIC (10)    NULL,
    [owner_id]             NUMERIC (10)    NULL,
    [is_deleted]           NUMERIC (1)     NULL,
    CONSTRAINT [PK_cap_curso_costo] PRIMARY KEY CLUSTERED ([cap_curso_costo_id] ASC)
);


GO

