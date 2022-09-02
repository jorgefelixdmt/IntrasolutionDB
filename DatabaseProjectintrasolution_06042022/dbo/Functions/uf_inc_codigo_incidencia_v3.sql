/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_inc_codigo_incidencia_v3]
Fecha Creacion: 20/10/2021
Autor: Mauro Roque
Descripcion: funcion que genera codigo correlativo del campo codigo_ticket de la incidencia
Llamado por: Trigger [tr_inc_incidencia_genera_cod]
Usado por: Modulo Mesa de Ayuda
Parametros: @anno Id del iNCIDENTE
Uso: SELECT dbo.[uf_inc_codigo_incidencia_v3] (2021)
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
02/12/2021              Valky Salinas          Se agregó ID de incidencia. Ahora obtiene último registro que no sea el ID actual.
											   Se dejó el correlativo en 5 dígitos.

**********************************************************************************************************
*/

CREATE function [dbo].[uf_inc_codigo_incidencia_v3]
( @anno VARCHAR(4), @inc_incidencia_id NUMERIC(10,0) )

RETURNS VARCHAR(100)
as
BEGIN

	DECLARE @Reg int
	DECLARE @CODIGO_TICKET VARCHAR(20)

	SET @Reg = (SELECT COUNT (*) FROM inc_incidencia WHERE is_deleted=0)
	IF @Reg = 0
		BEGIN
			SET @CODIGO_TICKET = @anno + '-' + '0001'
		END

	ELSE
		BEGIN
			DECLARE @ANNO_INCIDENCIA VARCHAR(4)
			DECLARE @COD_TICKET INT
			
			SET @ANNO_INCIDENCIA = (SELECT top 1 substring(codigo_ticket,1,4) FROM inc_incidencia WHERE is_deleted=0 AND inc_incidencia_id <> @inc_incidencia_id  ORDER BY inc_incidencia_id DESC)
			SET @COD_TICKET = (SELECT top 1 substring(codigo_ticket,6,5) FROM inc_incidencia WHERE is_deleted=0 AND inc_incidencia_id <> @inc_incidencia_id ORDER BY inc_incidencia_id DESC)
			
			IF @anno = @ANNO_INCIDENCIA
				BEGIN
					SET @COD_TICKET =  @COD_TICKET + 1
					SET @CODIGO_TICKET = @anno + '-' + RIGHT('00000' + Ltrim(Rtrim(@COD_TICKET)),5)
				END
			ELSE
				BEGIN
					SET @CODIGO_TICKET = @anno +'-' + '00001'
				END			
		END

	RETURN @CODIGO_TICKET


	
	END

GO

