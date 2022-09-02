CREATE TABLE [dbo].[FB_HISTORY_FILTERS] (
    [FB_HISTORY_FILTERS_ID] NUMERIC (10)   NOT NULL,
    [SC_TABLE_ID]           NUMERIC (10)   NULL,
    [SC_USER_ID]            NUMERIC (10)   NULL,
    [NAME]                  NVARCHAR (100) NULL,
    [DESCRIPTION]           NVARCHAR (100) NULL,
    [VALUE]                 TEXT           NULL,
    [IS_DELETED]            NUMERIC (1)    NULL,
    [CREATED]               DATETIME       NULL,
    [UPDATED]               DATETIME       NULL,
    [CREATED_BY]            NUMERIC (10)   NULL,
    [UPDATED_BY]            NUMERIC (10)   NULL,
    [OWNER_ID]              NUMERIC (10)   NULL,
    [CODE]                  NVARCHAR (100) NULL,
    [IS_DEFAULT]            NUMERIC (5)    NULL,
    [IS_LAST_ACCESS]        NUMERIC (5)    NULL,
    [SAVE]                  NUMERIC (5)    NULL,
    CONSTRAINT [PK_FB_HISTORY_FILTERS] PRIMARY KEY CLUSTERED ([FB_HISTORY_FILTERS_ID] ASC),
    CONSTRAINT [FK_HISTORY_FILTER_SC_TABLE] FOREIGN KEY ([SC_TABLE_ID]) REFERENCES [dbo].[SC_TABLE] ([SC_TABLE_ID])
);


GO

