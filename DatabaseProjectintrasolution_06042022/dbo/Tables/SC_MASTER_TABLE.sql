CREATE TABLE [dbo].[SC_MASTER_TABLE] (
    [SC_MASTER_TABLE_ID] NUMERIC (10)   NOT NULL,
    [CODE]               NVARCHAR (50)  NULL,
    [NAME]               NVARCHAR (100) NULL,
    [SC_DOMAIN_TABLE_ID] NUMERIC (10)   NULL,
    [ORDER_BY]           NUMERIC (5)    NULL,
    [IS_DEFAULT]         NUMERIC (1)    NULL,
    [IS_ACTIVE]          NUMERIC (1)    NULL,
    [VERSION]            NVARCHAR (20)  NULL,
    [CREATED]            DATETIME       NULL,
    [CREATED_BY]         NUMERIC (10)   NULL,
    [UPDATED]            DATETIME       NULL,
    [UPDATED_BY]         NUMERIC (10)   NULL,
    [OWNER_ID]           NUMERIC (10)   NULL,
    [IS_DELETED]         NUMERIC (1)    NULL,
    CONSTRAINT [PK_SC_MASTER_TABLE] PRIMARY KEY CLUSTERED ([SC_MASTER_TABLE_ID] ASC)
);


GO

