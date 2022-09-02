CREATE TABLE [dbo].[SC_DOMAIN_TABLE] (
    [SC_DOMAIN_TABLE_ID] NUMERIC (10)   NOT NULL,
    [CODE]               NVARCHAR (50)  NULL,
    [NAME]               NVARCHAR (100) NULL,
    [DATA_TYPE]          NVARCHAR (20)  NULL,
    [CREATED]            DATETIME       NULL,
    [CREATED_BY]         NUMERIC (10)   NULL,
    [UPDATED]            DATETIME       NULL,
    [UPDATED_BY]         NUMERIC (10)   NULL,
    [OWNER_ID]           NUMERIC (10)   NULL,
    [SC_TABLE_ID]        NUMERIC (10)   NULL,
    [IS_DELETED]         NUMERIC (1)    NULL,
    CONSTRAINT [PK_SC_DOMAIN_TABLE] PRIMARY KEY CLUSTERED ([SC_DOMAIN_TABLE_ID] ASC)
);


GO
