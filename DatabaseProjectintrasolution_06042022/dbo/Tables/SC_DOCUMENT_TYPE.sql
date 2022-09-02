CREATE TABLE [dbo].[SC_DOCUMENT_TYPE] (
    [sc_document_type_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [code]                VARCHAR (50)  NULL,
    [name]                VARCHAR (200) NULL,
    [is_shared]           NUMERIC (1)   NULL,
    [is_default]          NUMERIC (1)   NULL,
    [created]             DATETIME      NULL,
    [created_by]          NUMERIC (10)  NULL,
    [updated]             DATETIME      NULL,
    [updated_by]          NUMERIC (10)  NULL,
    [owner_id]            NUMERIC (10)  NULL,
    [is_deleted]          NUMERIC (1)   NULL,
    CONSTRAINT [PK_sc_document_type] PRIMARY KEY CLUSTERED ([sc_document_type_id] ASC)
);


GO

