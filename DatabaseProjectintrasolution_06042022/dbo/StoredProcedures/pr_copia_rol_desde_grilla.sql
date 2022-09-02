
-- =============================================
-- Author:		<Author,,Carlos Cubas>
-- Create date: <Create 05/11/2015,,
-- Description:	<Description,copia rol>
-- =============================================
CREATE procedure [dbo].[pr_copia_rol_desde_grilla]
@rol_id numeric(10,0)
AS
BEGIN

declare 

			@SC_ROLE_ID numeric(10,0)
			,@CODE varchar(200)
			,@NAME varchar (200)
			, @DESCRIPTION varchar(200)
           
           ,@SC_ACCESS_ID_2 numeric(10,0)
           ,@SC_MODULE_ID_2 numeric(10,0)
           ,@VERSION_2 varchar(50)
           ,@SC_ACCESS_TYPE_ID_2 numeric(10,0)
           

           
           ,@ANO varchar(4)
           ,@MES varchar(2)
           ,@DIA varchar(2)
           ,@HORA varchar(2)
           ,@MINUTO varchar(2)
           ,@CONCATENADO varchar(50)
           
           
           
           
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

				
			
			
			SET @ANO	=	CONVERT(varchar(4),DATEPART(YEAR, GETDATE()))
			SET @MES	=	CONVERT(varchar(2),DATEPART(MONTH, GETDATE()))
			SET @DIA	=	CONVERT(varchar(2),DATEPART(DAY, GETDATE()))
			SET @HORA	=	CONVERT(varchar(2),DATEPART(HOUR, GETDATE()))
			SET @MINUTO	=	CONVERT(varchar(2),DATEPART(MINUTE, GETDATE()))
						
			SET @CONCATENADO = '_'+@ANO+'-'+@MES+'-'+@DIA+'-'+@HORA+'-'+@MINUTO



	/*
	obtiene rol a copiar
	*/
	
	SELECT
			@SC_ROLE_ID		=	SC_ROLE_ID
			,@CODE			=	CODE
			,@NAME			=	NAME 
			,@DESCRIPTION	=	DESCRIPTION
	FROM
		SC_ROLE
	WHERE
		SC_ROLE_ID = @rol_id
	
	/*
	obtiene id a usar para insertar
	*/
	SELECT
		@SC_ROLE_ID = NEXT_SEQUENCE_ID +1
	FROM
		PM_SEQUENCE_TABLE
	WHERE
		SEQUENCE_NAME = 'seq_sc_role'
	
	
	/*
	inserta el nuevo rol
	*/
		INSERT INTO [dbo].[SC_ROLE]
		(
		[SC_ROLE_ID]
		, [CODE]
		, [NAME]
		, [DESCRIPTION]
		, [IS_DELETED]
		, [CREATED]
		, [UPDATED]
		, [CREATED_BY]
		, [UPDATED_BY]
		, [OWNER_ID]
		) 
	VALUES(
		@SC_ROLE_ID
		,@CODE+@CONCATENADO
		,@NAME+@CONCATENADO
		,@DESCRIPTION
		,0
		,GETDATE()
		,NULL
		,1
		,1
		,1
		)

	
	/*
	actualiza tabla de secuenciales luego de usar el ID
	*/
	UPDATE PM_SEQUENCE_TABLE SET NEXT_SEQUENCE_ID = @SC_ROLE_ID+1 WHERE SEQUENCE_NAME = 'seq_sc_role'
	
	/*
	almaneca los accesos
	*/
	DECLARE cursor_access cursor local for
				SELECT
					SC_ACCESS_ID
					,SC_MODULE_ID
					,VERSION
					,SC_ACCESS_TYPE_ID
				FROM
					SC_ACCESS
				WHERE
					SC_ROLE_ID = @rol_id
					AND
					IS_DELETED = 0
	
	open cursor_access
	
	fetch next from cursor_access into
					@SC_ACCESS_ID_2
					,@SC_MODULE_ID_2
					,@VERSION_2
					,@SC_ACCESS_TYPE_ID_2
	
	
	WHILE @@fetch_status = 0 
	BEGIN
			
				
						/*
						obtiene id a usar para insertar
						*/
						SELECT
							@SC_ACCESS_ID_2 = NEXT_SEQUENCE_ID +1
						FROM
							PM_SEQUENCE_TABLE
						WHERE
							SEQUENCE_NAME = 'seq_sc_access'
							
							
					
						/*
						inserta el nuevo modulo
						*/
						INSERT INTO [dbo].[SC_ACCESS](
						[SC_ACCESS_ID]
						, [SC_MODULE_ID]
						, [VERSION]
						, [CREATED]
						, [CREATED_BY]
						, [UPDATED]
						, [UPDATED_BY]
						, [OWNER_ID]
						, [SC_ROLE_ID]
						, [SC_ACCESS_TYPE_ID]
						, [IS_DELETED]
						, [CODE]
						, [NAME]
						) 
						VALUES(
						@SC_ACCESS_ID_2
						,@SC_MODULE_ID_2
						,@VERSION_2
						,GETDATE()
						,1
						,NULL
						,1
						,1
						,@SC_ROLE_ID
						,@SC_ACCESS_TYPE_ID_2
						,0
						,NULL
						,NULL
						)

						
						/*
						actualiza tabla de secuenciales luego de usar el ID
						*/
						UPDATE 
							PM_SEQUENCE_TABLE 
						SET 
							NEXT_SEQUENCE_ID = @SC_ACCESS_ID_2+1 
						WHERE 
							SEQUENCE_NAME = 'seq_sc_access'
				
			fetch next from cursor_access into 
							@SC_ACCESS_ID_2
							,@SC_MODULE_ID_2
							,@VERSION_2
							,@SC_ACCESS_TYPE_ID_2	
				
				
	END
	
		
	CLOSE cursor_access 
	DEALLOCATE cursor_access
		
	select @NAME+@CONCATENADO as nuevo_codigo
	
	
	
END

GO

