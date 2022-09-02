CREATE TABLE [dbo].[SC_DOCUMENT] (
    [SC_DOCUMENT_ID]      NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [sc_document_type_id] NUMERIC (10)  NULL,
    [name]                VARCHAR (200) NULL,
    [description]         VARCHAR (200) NULL,
    [keys]                VARCHAR (200) NULL,
    [document]            VARCHAR (200) NULL,
    [url]                 VARCHAR (200) NULL,
    [document_name]       VARCHAR (200) NULL,
    [document_code]       VARCHAR (200) NULL,
    [sc_table_id]         NUMERIC (10)  NULL,
    [created]             DATETIME      NULL,
    [created_by]          NUMERIC (10)  NULL,
    [updated]             DATETIME      NULL,
    [updated_by]          NUMERIC (10)  NULL,
    [owner_id]            NUMERIC (10)  NULL,
    [is_deleted]          NUMERIC (10)  NULL,
    CONSTRAINT [PK_SC_DOCUMENT] PRIMARY KEY CLUSTERED ([SC_DOCUMENT_ID] ASC)
);


GO

