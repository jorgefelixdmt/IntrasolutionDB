CREATE TABLE [dbo].[SC_WEBSERVICE_LOG] (
    [SC_WEBSERVICE_LOG_ID] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [WEBSERVICE_CODE]      VARCHAR (100)  NULL,
    [HEADER]               VARCHAR (100)  NULL,
    [BODY]                 VARCHAR (8000) NULL,
    [STATE]                NUMERIC (1)    NULL,
    [OUT_FORMAT]           VARCHAR (50)   NULL,
    [REMOTE_IP]            VARCHAR (50)   NULL,
    [RESPONSE]             VARCHAR (MAX)  NULL,
    [CREATED]              DATETIME       NULL,
    [CREATED_BY]           NUMERIC (10)   NULL,
    [UPDATED]              DATETIME       NULL,
    [UPDATED_BY]           NUMERIC (10)   NULL,
    [OWNER_ID]             NUMERIC (10)   NULL,
    [IS_DELETED]           NUMERIC (1)    NULL,
    CONSTRAINT [PK_SC_WEBSERVICE_LOG] PRIMARY KEY CLUSTERED ([SC_WEBSERVICE_LOG_ID] ASC)
);


GO

