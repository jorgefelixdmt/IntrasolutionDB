CREATE TABLE [dbo].[doc_folder_permiso_cargo] (
    [doc_folder_permiso_cargo_id] NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [doc_folder_id]               NUMERIC (10) NULL,
    [fb_area_id]                  NUMERIC (10) NULL,
    [fb_cargo_id]                 NUMERIC (10) NULL,
    [tipo_permiso]                VARCHAR (50) NULL,
    [created]                     DATETIME     NULL,
    [created_by]                  NUMERIC (10) NULL,
    [updated]                     DATETIME     NULL,
    [updated_by]                  NUMERIC (10) NULL,
    [owner_id]                    NUMERIC (10) NULL,
    [is_deleted]                  NUMERIC (1)  NULL,
    CONSTRAINT [PK_doc_folder_permiso_cargo] PRIMARY KEY CLUSTERED ([doc_folder_permiso_cargo_id] ASC)
);


GO

CREATE NONCLUSTERED INDEX [IX_doc_folder_permiso_cargo_1]
    ON [dbo].[doc_folder_permiso_cargo]([doc_folder_id] ASC, [fb_cargo_id] ASC);


GO

CREATE NONCLUSTERED INDEX [IX_doc_folder_permiso_cargo]
    ON [dbo].[doc_folder_permiso_cargo]([doc_folder_id] ASC);


GO

