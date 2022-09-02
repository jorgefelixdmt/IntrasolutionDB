CREATE TABLE [dbo].[cap_curso] (
    [cap_curso_id]              NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                    VARCHAR (50)  NULL,
    [nombre]                    VARCHAR (100) NULL,
    [institucion]               VARCHAR (100) NULL,
    [expositor]                 VARCHAR (200) NULL,
    [fecha_inicio]              DATETIME      NULL,
    [fecha_final]               DATETIME      NULL,
    [puntaje_curso]             NUMERIC (10)  NULL,
    [puntaje_aprobatorio]       NUMERIC (10)  NULL,
    [costo]                     NUMERIC (10)  NULL,
    [horas]                     NUMERIC (10)  NULL,
    [cap_curso_estado_id]       NUMERIC (10)  NULL,
    [tipo_curso]                VARCHAR (2)   NULL,
    [cap_curso_modalidad_id]    NUMERIC (10)  NULL,
    [observacion_anulado]       VARCHAR (500) NULL,
    [pre_registro_participante] NUMERIC (10)  NULL,
    [fb_uea_pe_id]              NUMERIC (10)  NULL,
    [estado]                    NUMERIC (1)   NULL,
    [created]                   DATETIME      NULL,
    [created_by]                NUMERIC (10)  NULL,
    [updated]                   DATETIME      NULL,
    [updated_by]                NUMERIC (10)  NULL,
    [owner_id]                  NUMERIC (10)  NULL,
    [is_deleted]                NUMERIC (1)   NULL,
    [id_Carga]                  NUMERIC (10)  NULL,
    CONSTRAINT [cap_curso_id] PRIMARY KEY CLUSTERED ([cap_curso_id] ASC)
);


GO

create trigger [dbo].[tr_cap_curso]
on [dbo].[cap_curso]
after insert
as
begin
declare @codigo varchar(50)
declare @fecha_curso datetime
declare @fb_uea_pe_id numeric(10,0)
declare @cap_curso_id numeric(10,0)
	
	set @fb_uea_pe_id = (select fb_uea_pe_id from inserted)
	set @cap_curso_id = (select cap_curso_id  from inserted)
	set @fecha_curso = (select fecha_inicio  from inserted)

	set @codigo = [dbo].[uf_codigo_curso](@fb_uea_pe_id,@fecha_curso)

	update cap_curso set codigo = @codigo where cap_curso_id = @cap_curso_id
end

GO

