CREATE TABLE [dbo].[pa_pase_envio] (
    [pa_pase_envio_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fecha]            DATETIME      NULL,
    [hora]             VARCHAR (200) NULL,
    [fb_empleado_id]   NUMERIC (10)  NULL,
    [descripcion]      VARCHAR (500) NULL,
    [instrucciones]    VARCHAR (500) NULL,
    [observaciones]    VARCHAR (500) NULL,
    [adjunto]          VARCHAR (200) NULL,
    [created]          DATETIME      NULL,
    [created_by]       NUMERIC (18)  NULL,
    [updated]          DATETIME      NULL,
    [updated_by]       NUMERIC (10)  NULL,
    [owner_id]         NUMERIC (10)  NULL,
    [is_deleted]       NUMERIC (10)  NULL,
    [pa_pase_id]       NUMERIC (10)  NULL
);


GO

