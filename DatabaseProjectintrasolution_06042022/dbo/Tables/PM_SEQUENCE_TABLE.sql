CREATE TABLE [dbo].[PM_SEQUENCE_TABLE] (
    [NEXT_SEQUENCE_ID]     NUMERIC (10)   NULL,
    [id]                   NUMERIC (18)   NULL,
    [SEQUENCE_NAME]        NVARCHAR (100) NULL,
    [PM_SEQUENCE_TABLE_ID] NUMERIC (10)   NOT NULL,
    [TABLE_NAME]           VARCHAR (50)   NULL,
    [TABLE_TIPO]           VARCHAR (5)    NULL,
    [IS_DELETED]           NUMERIC (1)    NULL,
    [CREATED]              DATETIME       NULL,
    [UPDATED]              DATETIME       NULL,
    [CREATED_BY]           NUMERIC (10)   NULL,
    [UPDATED_BY]           NUMERIC (10)   NULL,
    [OWNER_ID]             NUMERIC (10)   NULL,
    [CODE]                 NVARCHAR (100) NULL,
    [NAME]                 NVARCHAR (100) NULL,
    CONSTRAINT [PK_PM_SEQUENCE_TABLE] PRIMARY KEY CLUSTERED ([PM_SEQUENCE_TABLE_ID] ASC)
);


GO

