CREATE TABLE [dbo].[pa_entrega_objetos] (
    [pa_entrega_objetos_id]        NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                       VARCHAR (200) NULL,
    [fecha]                        DATETIME      NULL,
    [hora]                         VARCHAR (25)  NULL,
    [adjunto]                      VARCHAR (200) NULL,
    [pa_entrega_objetos_estado_id] NUMERIC (10)  NULL,
    [pa_carga_lista_objetos_id]    NUMERIC (10)  NULL,
    [created]                      DATETIME      NULL,
    [created_by]                   NUMERIC (10)  NULL,
    [updated]                      DATETIME      NULL,
    [updated_by]                   NUMERIC (10)  NULL,
    [owner_id]                     NUMERIC (10)  NULL,
    [is_deleted]                   NUMERIC (1)   NULL,
    [comentarios]                  VARCHAR (MAX) NULL,
    [adjunto_v2]                   VARCHAR (200) NULL,
    [adjunto_v3]                   VARCHAR (200) NULL,
    [adjunto_v4]                   VARCHAR (200) NULL,
    [fb_empleado_id]               NUMERIC (10)  NULL,
    [titulo]                       VARCHAR (500) NULL,
    [fb_cliente_id]                NUMERIC (10)  NULL,
    [prd_producto_id]              NUMERIC (10)  NULL,
    [estado_ok]                    NUMERIC (1)   NULL
);


GO

CREATE TRIGGER [dbo].[tr_genera_codigo]
ON [dbo].[pa_entrega_objetos]
AFTER INSERT
AS
BEGIN

DECLARE @carga_id numeric(10,0), @entrega_id numeric(10,0), @correlativo int
DECLARE @ult_cod varchar(200), @codigo varchar(200)

SET @entrega_id = (SELECT pa_entrega_objetos_id FROM inserted)
SET @carga_id = (SELECT pa_carga_lista_objetos_id FROM inserted)

SET @ult_cod = NULL

IF @carga_id IS NULL
 BEGIN
	SELECT TOP 1 @ult_cod = codigo
	FROM pa_entrega_objetos
	WHERE
		is_deleted = 0 AND
		pa_carga_lista_objetos_id IS NULL AND
		(codigo IS NOT NULL AND codigo <> '')
	ORDER BY created DESC

	IF @ult_cod IS NULL
	 BEGIN
		SET @codigo = 'MN-0001'
	 END
	ELSE
	 BEGIN
		SET @correlativo = CAST(SUBSTRING(@ult_cod, 4, 4) AS int)
		SET @correlativo = @correlativo + 1
		SET @codigo = 'MN-' + right('000'+ convert(varchar(4),@correlativo),4) 
	 END
 END
ELSE
 BEGIN
	SELECT TOP 1 @ult_cod = codigo
	FROM pa_entrega_objetos
	WHERE
		is_deleted = 0 AND
		pa_carga_lista_objetos_id IS NOT NULL AND
		(codigo IS NOT NULL AND codigo <> '')
	ORDER BY created DESC

	IF @ult_cod IS NULL
	 BEGIN
		SET @codigo = 'CM-0001'
	 END
	ELSE
	 BEGIN
		SET @correlativo = CAST(SUBSTRING(@ult_cod, 4, 4) AS int)
		SET @correlativo = @correlativo + 1
		SET @codigo = 'CM-' + right('000'+ convert(varchar(4),@correlativo),4) 
	 END
 END

UPDATE pa_entrega_objetos
SET codigo = @codigo
WHERE pa_entrega_objetos_id = @entrega_id

END

GO


/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_pa_entrega_objetos_update]
Fecha Creacion: ---
Autor: Valky Salinas
Descripcion: Trigger que actualiza estados de incidencias de una entrega y manda correos
Usado por: Modulo: pases de Software
tablas que afecta - pa_entrega_objetos
Uso: 
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
16/03/2022              Valky Salinas          Actualiza estados de incidencias de una entrega.

**********************************************************************************************************
*/

CREATE TRIGGER [dbo].[tr_pa_entrega_objetos_update]
   ON  [dbo].[pa_entrega_objetos]
   AFTER UPDATE
AS 
 BEGIN
	SET NOCOUNT ON;

	DECLARE @pa_entrega_objetos_id NUMERIC(10,0)
	DECLARE @estado_antes numeric(10,0), @estado_despues numeric(10,0)

	DECLARE @estado_ok_before numeric(1,0), @estado_ok_after numeric(1,0)

	DECLARE @incidencia_id numeric(10,0), @entrega_incidencia_id numeric(10,0)
    
	SET @pa_entrega_objetos_id = (SELECT pa_entrega_objetos_id FROM inserted)  
	SET @estado_antes = (SELECT pa_entrega_objetos_estado_id FROM deleted) 
	SET @estado_despues = (SELECT pa_entrega_objetos_estado_id FROM inserted) 

	SET @estado_ok_before = (select estado_ok from deleted)
    SET @estado_ok_after = (select estado_ok from inserted)
	
	IF @estado_ok_before <> @estado_ok_after
	 BEGIN
		IF @estado_ok_after = 1 -- Entrega OK
		 BEGIN
			DECLARE CURSOR_INC CURSOR FOR 
				SELECT 
					i.inc_incidencia_id,
					ei.pa_entrega_incidentes_id
				FROM inc_incidencia i
					INNER JOIN pa_entrega_incidentes ei ON ei.inc_incidencia_id = i.inc_incidencia_id
				WHERE
					ei.pa_entrega_objetos_id = @pa_entrega_objetos_id AND
					ei.is_deleted = 0

			OPEN CURSOR_INC  
			FETCH NEXT FROM CURSOR_INC INTO @incidencia_id, @entrega_incidencia_id 

			WHILE @@FETCH_STATUS = 0  
			 BEGIN  
				UPDATE inc_incidencia
				SET inc_estado_incidencia_id = 10004 -- Aprobado en QA DTECH
				WHERE inc_incidencia_id = @incidencia_id

				FETCH NEXT FROM CURSOR_INC INTO @incidencia_id , @entrega_incidencia_id 
			 END 

			CLOSE CURSOR_INC  
			DEALLOCATE CURSOR_INC 
		 END
	 END

	IF update(pa_entrega_objetos_estado_id)
	 BEGIN
		IF @estado_despues = 2 -- Completo
		 BEGIN
			exec pr_pa_aviso_entrega_completa @pa_entrega_objetos_id
		 END
	 END

 END

GO

