CREATE TABLE [dbo].[inc_incidencia_seguimiento] (
    [inc_incidencia_seguimiento_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [inc_incidencia_id]             NUMERIC (10)  NULL,
    [fecha]                         DATETIME      NULL,
    [hora]                          VARCHAR (50)  NULL,
    [fb_verificador_id]             NUMERIC (10)  NULL,
    [flag_conforme]                 VARCHAR (10)  NULL,
    [observacion]                   VARCHAR (MAX) NULL,
    [archivo]                       VARCHAR (200) NULL,
    [inc_estado_incidencia_id]      NUMERIC (10)  NULL,
    [created]                       DATETIME      NULL,
    [created_by]                    NUMERIC (10)  NULL,
    [updated]                       DATETIME      NULL,
    [updated_by]                    NUMERIC (10)  NULL,
    [owner_id]                      NUMERIC (10)  NULL,
    [is_deleted]                    NUMERIC (10)  NULL,
    CONSTRAINT [PK_inc_incidencia_seguimiento] PRIMARY KEY CLUSTERED ([inc_incidencia_seguimiento_id] ASC)
);


GO

/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_inc_incidencia_seguimiento_update]
Fecha Creacion: 30/06/2020
Autor: Mauro Roque
Descripcion: trigger que actualiza Incidencias , estado y fecha de un seguimiento de una Incidencia
Usado por: Modulo: Mesa de Ayuda
tablas que afecta - inc_incidencia ACTUALIZA
Uso: 
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
11/11/2021              Valky Salinas          Se limitó el trigger a solo after insert.
18/02/2021				Mauro Roque			   Se agrego opcion,after update en el trigger para que actualice 
											   el estado del incidente , ya sea anterior o posterior
***************************************************************************************************************************************
*/
CREATE TRIGGER [dbo].[tr_inc_incidencia_seguimiento_update]
   ON  [dbo].[inc_incidencia_seguimiento]
   AFTER INSERT,UPDATE
AS 
 BEGIN
	SET NOCOUNT ON;

	DECLARE @inc_estado_incidencia_id numeric(10,0),@fecha_estado datetime
	declare @inc_incidencia_seguimiento_id numeric(10,0),@inc_incidencia_id int
 
    set @inc_incidencia_seguimiento_id = (select inc_incidencia_seguimiento_id from inserted)
	set @inc_incidencia_id = (select inc_incidencia_id from inserted)

	set @inc_estado_incidencia_id = (select inc_estado_incidencia_id from inserted)   
	set @fecha_estado = (select fecha from inserted)   

	 
		update inc_incidencia
		set inc_estado_incidencia_id= @inc_estado_incidencia_id --, fecha = @fecha_estado
		where inc_incidencia_id = @inc_incidencia_id


 END

GO

