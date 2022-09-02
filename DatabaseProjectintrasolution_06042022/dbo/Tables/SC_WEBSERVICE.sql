CREATE TABLE [dbo].[SC_WEBSERVICE] (
    [SC_WEBSERVICE_ID] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [CODE]             VARCHAR (100)  NULL,
    [NAME]             VARCHAR (100)  NULL,
    [SQL_TEXT]         VARCHAR (1000) NULL,
    [SQL_TYPE]         NUMERIC (1)    NULL,
    [OUT_FORMAT]       NUMERIC (1)    NULL,
    [IS_PROCEDURE]     NUMERIC (1)    NULL,
    [IS_READ_ONLY]     NUMERIC (1)    NULL,
    [CREATED]          DATETIME       NULL,
    [CREATED_BY]       NUMERIC (10)   NULL,
    [UPDATED]          DATETIME       NULL,
    [UPDATED_BY]       NUMERIC (10)   NULL,
    [OWNER_ID]         NUMERIC (10)   NULL,
    [IS_DELETED]       NUMERIC (1)    NULL,
    [is_proccess_java] NUMERIC (1)    NULL,
    [DESCRIPCION]      VARCHAR (MAX)  NULL,
    CONSTRAINT [PK_SC_WEBSERVICE] PRIMARY KEY CLUSTERED ([SC_WEBSERVICE_ID] ASC)
);


GO

