CREATE TABLE [dbo].[pa_pase_asociado] (
    [pa_pase_asociado_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [pa_pase_id]          NUMERIC (10)  NULL,
    [codigo_jira]         VARCHAR (150) NULL,
    [descripcion]         VARCHAR (MAX) NULL,
    [fecha_incidencia]    DATETIME      NULL,
    [fb_responsable_id]   NUMERIC (10)  NULL,
    [created]             DATETIME      NULL,
    [created_by]          NUMERIC (10)  NULL,
    [updated]             DATETIME      NULL,
    [updated_by]          NUMERIC (10)  NULL,
    [owner_id]            NUMERIC (10)  NULL,
    [is_deleted]          NUMERIC (10)  NULL,
    [url_jira]            VARCHAR (500) NULL,
    [horas]               VARCHAR (50)  NULL,
    [inc_incidencia_id]   NUMERIC (10)  NULL,
    [numero_ticket]       VARCHAR (200) NULL,
    CONSTRAINT [PK_pa_pase_asociado] PRIMARY KEY CLUSTERED ([pa_pase_asociado_id] ASC)
);


GO



/*      
**********************************************
Nombre: dbo.[tr_pa_pase_asociado_relaciona_incidencia]
Fecha Creacion: 29/12/2020
Autor: Mauro Roque
Descripcion: trigger que relaciona el pase asociado con la incidencia, mediante codigo jira
Usado por: Modulo: pases de Software / Pases Asociados
tablas que afecta - pa_pase_asociado actualiza
Uso: 
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

************************************
*/

create TRIGGER [dbo].[tr_pa_pase_asociado_relaciona_incidencia]
   ON  [dbo].[pa_pase_asociado]
   AFTER INSERT,UPDATE
AS 
 BEGIN
	SET NOCOUNT ON;

	DECLARE @codigo_jira varchar(50), @pa_pase_asociado_id numeric(10,0)
 
    set @pa_pase_asociado_id = (select pa_pase_asociado_id from inserted)
	set @codigo_jira = (select codigo_jira from inserted)   
	 
			update pa
			set pa.inc_incidencia_id= iii.inc_incidencia_id
			from  pa_pase_asociado pa inner join inc_incidencia iii
			on pa.codigo_jira=iii.codigo_jira
			where pa.pa_pase_asociado_id = @pa_pase_asociado_id

 END

GO

