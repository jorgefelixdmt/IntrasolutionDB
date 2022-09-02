CREATE TABLE [dbo].[pa_pase_entregas] (
    [pa_pase_entregas_id]   NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [pa_pase_id]            NUMERIC (10) NULL,
    [pa_entrega_objetos_id] NUMERIC (10) NULL,
    [created]               DATETIME     NULL,
    [created_by]            NUMERIC (10) NULL,
    [updated]               DATETIME     NULL,
    [updated_by]            NUMERIC (10) NULL,
    [owner_id]              NUMERIC (10) NULL,
    [is_deleted]            NUMERIC (1)  NULL
);


GO

/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_pa_pase_entrega_insert_incidente]
Fecha Creacion: 16/03/2022
Autor: Valky Salinas
Descripcion: Trigger que inserta incidencias al pase
Usado por: Modulo: pases de Software
tablas que afecta - pa_pase_asociado
Uso: 
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/

CREATE TRIGGER [dbo].[tr_pa_pase_entrega_insert_incidente]
   ON  [dbo].[pa_pase_entregas]
   AFTER INSERT
AS 
 BEGIN
	SET NOCOUNT ON;

	DECLARE @pa_pase_entregas_id numeric(10,0)
	DECLARE @pa_pase_id numeric(10,0), @pa_entrega_objetos_id numeric(10,0)
 
    SET @pa_pase_entregas_id = (select pa_pase_entregas_id from inserted)
    SET @pa_pase_id = (select pa_pase_id from inserted)
    SET @pa_entrega_objetos_id = (select pa_entrega_objetos_id from inserted)
	

	INSERT INTO pa_pase_asociado
		(
		pa_pase_id,
		codigo_jira,
		descripcion,
		fecha_incidencia,
		fb_responsable_id,
		url_jira,
		inc_incidencia_id,
		numero_ticket,
		created,
		created_by,
		updated,
		updated_by,
		owner_id,
		is_deleted
		)
	SELECT
		@pa_pase_id,
		ei.codigo_jira,
		i.titulo_incidencia,
		i.fecha,
		i.fb_empleado_id,
		ei.link_jira,
		i.inc_incidencia_id,
		i.codigo_ticket,
		GETDATE(),
		1,
		GETDATE(),
		1,
		1,
		0
	FROM pa_entrega_incidentes ei
		LEFT JOIN inc_incidencia i ON i.inc_incidencia_id = ei.inc_incidencia_id
	WHERE 
		ei.pa_entrega_objetos_id = @pa_entrega_objetos_id AND
		ei.is_deleted = 0 


 END

GO

