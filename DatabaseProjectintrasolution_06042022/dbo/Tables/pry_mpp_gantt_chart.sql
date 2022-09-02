CREATE TABLE [dbo].[pry_mpp_gantt_chart] (
    [pry_mpp_gantt_chart_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [titulo]                 VARCHAR (200)  NULL,
    [json]                   NVARCHAR (MAX) NULL,
    [fb_uea_pe_id]           NUMERIC (10)   NULL,
    [created]                DATETIME       NULL,
    [created_by]             NUMERIC (10)   NULL,
    [updated]                DATETIME       NULL,
    [updated_by]             NUMERIC (10)   NULL,
    [owner_id]               NUMERIC (10)   NULL,
    [is_deleted]             NUMERIC (1)    NULL,
    CONSTRAINT [pry_mpp_gantt_chart_id] PRIMARY KEY CLUSTERED ([pry_mpp_gantt_chart_id] ASC)
);


GO

