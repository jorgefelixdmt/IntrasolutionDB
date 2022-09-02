CREATE TABLE [dbo].[SC_GROUP] (
    [SC_GROUP_ID]     NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [CODE]            NVARCHAR (50)  NULL,
    [NAME]            NVARCHAR (100) NULL,
    [DESCRIPTION]     NVARCHAR (200) NULL,
    [VERSION]         NVARCHAR (20)  NULL,
    [CREATED]         DATETIME       NULL,
    [UPDATED]         DATETIME       NULL,
    [IS_DELETED]      NUMERIC (1)    NULL,
    [PARENT_GROUP_ID] NUMERIC (10)   NULL,
    [CREATED_BY]      NUMERIC (10)   NULL,
    [UPDATED_BY]      NUMERIC (10)   NULL,
    [OWNER_ID]        NUMERIC (10)   NULL,
    CONSTRAINT [PK_SC_GROUP] PRIMARY KEY CLUSTERED ([SC_GROUP_ID] ASC)
);


GO

