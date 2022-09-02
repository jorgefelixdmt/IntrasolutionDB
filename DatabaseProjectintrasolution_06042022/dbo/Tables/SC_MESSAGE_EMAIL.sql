CREATE TABLE [dbo].[SC_MESSAGE_EMAIL] (
    [sc_message_email_id] NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [codigo]              NVARCHAR (50)   NULL,
    [descripcion]         NVARCHAR (200)  NULL,
    [leyenda]             NVARCHAR (400)  NULL,
    [asunto]              NVARCHAR (400)  NULL,
    [cuerpo]              NVARCHAR (1024) NULL,
    [observaciones]       NVARCHAR (200)  NULL,
    [CREATED]             DATETIME        NULL,
    [UPDATED]             DATETIME        NULL,
    [IS_DELETED]          NUMERIC (1)     NULL,
    [CREATED_BY]          NUMERIC (10)    NULL,
    [UPDATED_BY]          NUMERIC (10)    NULL,
    [OWNER_ID]            NUMERIC (10)    NULL,
    CONSTRAINT [PK_sc_message_email] PRIMARY KEY CLUSTERED ([sc_message_email_id] ASC) WITH (FILLFACTOR = 95)
);


GO

