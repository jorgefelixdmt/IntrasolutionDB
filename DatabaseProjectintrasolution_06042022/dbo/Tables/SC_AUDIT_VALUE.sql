CREATE TABLE [dbo].[SC_AUDIT_VALUE] (
    [sc_audit_value_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [module_name]       VARCHAR (200)  NULL,
    [table_name]        VARCHAR (200)  NULL,
    [user_name]         VARCHAR (200)  NULL,
    [module_id]         NUMERIC (10)   NULL,
    [table_id]          NUMERIC (10)   NULL,
    [date_action]       DATETIME       NULL,
    [value_old]         VARCHAR (4000) NULL,
    [value_new]         VARCHAR (4000) NULL,
    [action_name]       VARCHAR (50)   NULL,
    [created]           DATETIME       NULL,
    [created_by]        NUMERIC (10)   NULL,
    [updated]           DATETIME       NULL,
    [updated_by]        NUMERIC (10)   NULL,
    [owner_id]          NUMERIC (10)   NULL,
    [user_id]           NUMERIC (10)   NULL,
    [is_deleted]        NUMERIC (1)    NULL,
    [value_id]          VARCHAR (100)  NULL,
    CONSTRAINT [PK_SC_AUDIT_VALUE] PRIMARY KEY CLUSTERED ([sc_audit_value_id] ASC)
);


GO

