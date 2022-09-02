CREATE TABLE [dbo].[pa_pase_hh] (
    [pa_pase_hh_id] NUMERIC (10)     IDENTITY (1, 1) NOT NULL,
    [pa_pase_id]    NUMERIC (10)     NULL,
    [codigo]        VARCHAR (50)     NULL,
    [codigo_jira]   VARCHAR (200)    NULL,
    [url_jira]      VARCHAR (500)    NULL,
    [concepto]      VARCHAR (MAX)    NULL,
    [numero_hh]     NUMERIC (23, 10) NULL,
    [created]       DATETIME         NULL,
    [created_by]    NUMERIC (10)     NULL,
    [updated]       DATETIME         NULL,
    [updated_by]    NUMERIC (10)     NULL,
    [owner_id]      NUMERIC (10)     NULL,
    [is_deleted]    NUMERIC (10)     NULL,
    CONSTRAINT [PK_pa_pase_hh_id] PRIMARY KEY CLUSTERED ([pa_pase_hh_id] ASC)
);


GO

