CREATE TABLE [dbo].[doc_folder] (
    [doc_folder_id]       NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [nombre]              VARCHAR (500) NULL,
    [doc_folder_padre_id] NUMERIC (10)  NULL,
    [folder_categoria]    VARCHAR (50)  NULL,
    [fb_uea_pe_id]        NUMERIC (10)  NULL,
    [created]             DATETIME      NULL,
    [created_by]          NUMERIC (10)  NULL,
    [updated]             DATETIME      NULL,
    [updated_by]          NUMERIC (10)  NULL,
    [owner_id]            NUMERIC (10)  NULL,
    [is_deleted]          NUMERIC (1)   NULL,
    CONSTRAINT [PK_doc_Folder] PRIMARY KEY CLUSTERED ([doc_folder_id] ASC)
);


GO

