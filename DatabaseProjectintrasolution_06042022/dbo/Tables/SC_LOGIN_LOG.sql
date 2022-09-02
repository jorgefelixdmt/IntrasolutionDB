CREATE TABLE [dbo].[SC_LOGIN_LOG] (
    [sc_login_log_id]     NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [remote_ip]           VARCHAR (50)  NULL,
    [user]                VARCHAR (50)  NULL,
    [user_name]           VARCHAR (50)  NULL,
    [date]                DATETIME      NULL,
    [type]                NUMERIC (1)   NULL,
    [module_id]           NUMERIC (10)  NULL,
    [module_name]         VARCHAR (100) NULL,
    [access_type_id]      NUMERIC (10)  NULL,
    [access_type_name]    VARCHAR (100) NULL,
    [id_uea]              NUMERIC (10)  NULL,
    [authentication_type] VARCHAR (25)  NULL
);


GO

