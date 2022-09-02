CREATE TABLE [dbo].[doc_documento_distribucion] (
    [doc_documento_distribucion_id] NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [doc_documento_id]              NUMERIC (10) NULL,
    [fb_area_id]                    NUMERIC (10) NULL,
    [fb_cargo_id]                   NUMERIC (10) NULL,
    [fb_uea_pe_id]                  NUMERIC (10) NULL,
    [created]                       DATETIME     NULL,
    [created_by]                    NUMERIC (10) NULL,
    [updated]                       DATETIME     NULL,
    [updated_by]                    NUMERIC (10) NULL,
    [owner_id]                      NUMERIC (10) NULL,
    [is_deleted]                    NUMERIC (1)  NULL,
    CONSTRAINT [PK_doc_documento_distribucion] PRIMARY KEY CLUSTERED ([doc_documento_distribucion_id] ASC)
);


GO

