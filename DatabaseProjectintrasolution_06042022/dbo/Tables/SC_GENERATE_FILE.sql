CREATE TABLE [dbo].[SC_GENERATE_FILE] (
    [SC_GENERATE_FILE_ID] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [code]                VARCHAR (50)  NULL,
    [document_name]       VARCHAR (200) NULL,
    [document_type]       VARCHAR (50)  NULL,
    [origen]              VARCHAR (50)  NULL,
    [datetime]            DATETIME      CONSTRAINT [DF_SC_GENERATE_FILE_datetime] DEFAULT (getdate()) NULL,
    [created]             DATETIME      CONSTRAINT [DF_SC_GENERATE_FILE_created] DEFAULT (getdate()) NULL,
    [created_by]          NUMERIC (10)  NULL,
    [updated]             DATETIME      NULL,
    [updated_by]          NUMERIC (10)  NULL,
    [owner_id]            NUMERIC (10)  NULL,
    [is_deleted]          NUMERIC (1)   CONSTRAINT [DF_SC_GENERATE_FILE_is_deleted] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SC_GENERATE_FILE] PRIMARY KEY CLUSTERED ([SC_GENERATE_FILE_ID] ASC)
);


GO

