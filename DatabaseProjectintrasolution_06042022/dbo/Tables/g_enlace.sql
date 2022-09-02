CREATE TABLE [dbo].[g_enlace] (
    [g_enlace_id]  NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [titulo]       NVARCHAR (200) NULL,
    [enlace_drive] NVARCHAR (200) NULL,
    [archivo]      NVARCHAR (200) NULL,
    [archivo_size] NUMERIC (10)   NULL,
    [owner_id]     NUMERIC (10)   NULL,
    [created]      DATETIME       NULL,
    [created_by]   NUMERIC (10)   NULL,
    [updated]      DATETIME       NULL,
    [updated_by]   NUMERIC (10)   NULL,
    [is_deleted]   NUMERIC (1)    NULL,
    [fb_uea_pe_id] NUMERIC (10)   NULL,
    [autor]        VARCHAR (200)  NULL
);


GO

