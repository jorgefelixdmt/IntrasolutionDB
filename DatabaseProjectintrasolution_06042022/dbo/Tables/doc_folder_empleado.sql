CREATE TABLE [dbo].[doc_folder_empleado] (
    [doc_folder_empleado_id] NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [doc_folder_id]          NUMERIC (10) NULL,
    [fb_empleado_id]         NUMERIC (10) NULL,
    [tipo_permiso]           VARCHAR (50) NULL,
    [created]                DATETIME     NULL,
    [created_by]             NUMERIC (10) NULL,
    [updated]                DATETIME     NULL,
    [updated_by]             NUMERIC (10) NULL,
    [owner_id]               NUMERIC (10) NULL,
    [is_deleted]             NUMERIC (1)  NULL,
    CONSTRAINT [PK_doc_folder_empleado] PRIMARY KEY CLUSTERED ([doc_folder_empleado_id] ASC)
);


GO

CREATE NONCLUSTERED INDEX [IX_doc_folder_empleado_1]
    ON [dbo].[doc_folder_empleado]([doc_folder_id] ASC, [fb_empleado_id] ASC);


GO

CREATE NONCLUSTERED INDEX [IX_doc_folder_empleado]
    ON [dbo].[doc_folder_empleado]([fb_empleado_id] ASC);


GO

