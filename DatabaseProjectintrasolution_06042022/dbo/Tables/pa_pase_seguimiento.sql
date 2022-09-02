CREATE TABLE [dbo].[pa_pase_seguimiento] (
    [pa_pase_seguimiento_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [pa_pase_id]             NUMERIC (10)  NULL,
    [fecha]                  DATETIME      NULL,
    [fb_verificador_id]      NUMERIC (10)  NULL,
    [flag_conforme]          VARCHAR (10)  NULL,
    [observacion]            VARCHAR (MAX) NULL,
    [archivo]                VARCHAR (200) NULL,
    [pa_pase_estado_id]      NUMERIC (10)  NULL,
    [pa_pase_siguiente_id]   NUMERIC (10)  NULL,
    [created]                DATETIME      NULL,
    [created_by]             NUMERIC (10)  NULL,
    [updated]                DATETIME      NULL,
    [updated_by]             NUMERIC (10)  NULL,
    [owner_id]               NUMERIC (10)  NULL,
    [is_deleted]             NUMERIC (10)  NULL,
    CONSTRAINT [PK_pa_pase_seguimiento] PRIMARY KEY CLUSTERED ([pa_pase_seguimiento_id] ASC)
);


GO




 
/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_pa_pase_seguimiento_update]
Fecha Creacion: 25/05/2020
Autor: Mauro Roque
Descripcion: trigger que actualiza pase de software , estado y fecha de un seguimiento de pase
Usado por: Modulo: pases de Software
tablas que afecta - pa_pase ACTUALIZA
Uso: 
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
15/11/2021              Valky Salinas          Se limitó a un trigger after insert.

****************************************************************************************************************************************
*/
CREATE TRIGGER [dbo].[tr_pa_pase_seguimiento_update]
   ON  [dbo].[pa_pase_seguimiento]
   AFTER INSERT
AS 
 BEGIN
	SET NOCOUNT ON;

	DECLARE @pa_pase_estado_id numeric(10,0),@fecha_estado datetime
	declare @pa_pase_seguimiento_id numeric(10,0),@pa_pase_id int
 
    set @pa_pase_seguimiento_id = (select pa_pase_seguimiento_id from inserted)
	set @pa_pase_id = (select pa_pase_id from inserted)

	set @pa_pase_estado_id = (select pa_pase_estado_id from inserted)   
	set @fecha_estado = (select fecha from inserted)   

	 
		update pa_pase
		set pa_pase_estado_id= @pa_pase_estado_id , fecha_estado = @fecha_estado
		where pa_pase_id = @pa_pase_id


 END

GO

