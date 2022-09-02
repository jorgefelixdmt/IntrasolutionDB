-- =============================================
-- Author:		<Author,,Carlos Cubas>
-- Create date: <Create 03/11/2015,,
-- Description:	<Description,copia el modulo desde el formulario>
-- =============================================
CREATE procedure [dbo].[pr_copia_modulo_desde_grilla]
@module_id numeric(10,0)
,@module_id_padre numeric(10,0)
,@nombre_modulo varchar(200)
AS
BEGIN

declare 
			@SC_MODULE_ID numeric(10,0)
           ,@SC_MODULE_TYPE_ID numeric(10,0)
           ,@SC_TABLE_ID numeric(10,0)
           ,@CODE nvarchar(1000)
           ,@NAME nvarchar(1000)
           ,@DESCRIPTION nvarchar(200)
           ,@ITEM_ORDER numeric(3,0)
           ,@MODULE_CALL numeric(10,0)
           ,@MODULE_ICON nvarchar(200)
           ,@URL nvarchar(400)
           ,@IS_LEAF numeric(1,0)
           ,@CREATED datetime
           ,@CREATED_BY numeric(10,0)
           ,@UPDATED datetime
           ,@UPDATED_BY numeric(10,0)
           ,@OWNER_ID numeric(10,0)
           ,@INCLUDING_PAGE nvarchar(200)
           ,@SC_SUPER_MODULE_ID numeric(10,0)
           ,@GENERIC_TYPE numeric(1,0)
           ,@IS_DELETED numeric(1,0)
           ,@JSON_CONFIG nvarchar(500)
           ,@IS_ENABLED numeric(1,0)
           ,@IS_VISIBLE numeric(1,0)
           ,@numero_ramdon_entero integer
           ,@numero_ramdon_cadena varchar(2)
           
           
           
           
           	,@SC_MODULE_ID_2 numeric(10,0)
           ,@SC_MODULE_TYPE_ID_2 numeric(10,0)
           ,@SC_TABLE_ID_2 numeric(10,0)
           ,@CODE_2 nvarchar(1000)
           ,@NAME_2 nvarchar(1000)
           ,@DESCRIPTION_2 nvarchar(200)
           ,@ITEM_ORDER_2 numeric(3,0)
           ,@MODULE_CALL_2 numeric(10,0)
           ,@MODULE_ICON_2 nvarchar(200)
           ,@URL_2 nvarchar(400)
           ,@IS_LEAF_2 numeric(1,0)
           ,@CREATED_2 datetime
           ,@CREATED_BY_2 numeric(10,0)
           ,@UPDATED_2 datetime
           ,@UPDATED_BY_2 numeric(10,0)
           ,@OWNER_ID_2 numeric(10,0)
           ,@INCLUDING_PAGE_2 nvarchar(200)
           ,@SC_SUPER_MODULE_ID_2 numeric(10,0)
           ,@GENERIC_TYPE_2 numeric(1,0)
           ,@IS_DELETED_2 numeric(1,0)
           ,@JSON_CONFIG_2 nvarchar(500)
           ,@IS_ENABLED_2 numeric(1,0)
           ,@IS_VISIBLE_2 numeric(1,0)
           ,@numero_ramdon_entero_2 integer
           ,@numero_ramdon_cadena_2 varchar(2)
           
           ,@tiene_hijos numeric(10)
           
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


			
			
			IF(@module_id_padre=0)
				BEGIN
					SET @module_id_padre = NULL
				END

	/*
	obtiene modulo a copiar
	*/
    SELECT
			@SC_MODULE_TYPE_ID	=	SC_MODULE_TYPE_ID
           ,@SC_TABLE_ID		=	SC_TABLE_ID
           ,@CODE				=	CODE	
           ,@NAME				=	NAME
           ,@DESCRIPTION		=	DESCRIPTION
           ,@ITEM_ORDER			=	ITEM_ORDER
           ,@MODULE_CALL		=	MODULE_CALL
           ,@MODULE_ICON		=	MODULE_ICON
           ,@URL				=	URL 
           ,@IS_LEAF			=	IS_LEAF
           ,@CREATED			=	CREATED 
           ,@CREATED_BY			=	CREATED_BY 
           ,@UPDATED			=	UPDATED 
           ,@UPDATED_BY			=	UPDATED_BY
           ,@OWNER_ID			=	OWNER_ID 
           ,@INCLUDING_PAGE		=	INCLUDING_PAGE 
           ,@SC_SUPER_MODULE_ID =	SC_SUPER_MODULE_ID 
           ,@GENERIC_TYPE		=	GENERIC_TYPE 
           ,@IS_DELETED			=	IS_DELETED 
           ,@JSON_CONFIG		=	JSON_CONFIG 
           ,@IS_ENABLED			=	IS_ENABLED 
           ,@IS_VISIBLE			=	IS_VISIBLE 
    
    FROM
		SC_MODULE
    WHERE
		SC_MODULE_ID = @module_id
		
		/*
			PRINT @SC_MODULE_ID
			PRINT @SC_MODULE_TYPE_ID 
			PRINT @CODE+@CONCATENADO 
			PRINT @NAME+@CONCATENADO	 
			PRINT @DESCRIPTION 
			PRINT @module_id_padre 
			PRINT @MODULE_ICON 
			PRINT @URL 
			PRINT @IS_LEAF 
			PRINT @CREATED 
			PRINT @CREATED_BY 
			PRINT @UPDATED 
			PRINT @UPDATED_BY 
			PRINT @OWNER_ID 
			PRINT @INCLUDING_PAGE 
			PRINT @SC_SUPER_MODULE_ID
			PRINT @GENERIC_TYPE 
			PRINT @IS_DELETED 
			PRINT @JSON_CONFIG 
			PRINT @IS_ENABLED 
			PRINT @IS_VISIBLE
		*/
	
	/*
	obtiene id a usar para insertar
	*/
	SELECT
		@SC_MODULE_ID = NEXT_SEQUENCE_ID +1
	FROM
		PM_SEQUENCE_TABLE
	WHERE
		SEQUENCE_NAME = 'seq_sc_module'
	
	
	PRINT '@SC_MODULE_ID ' + CONVERT(varchar(10),@SC_MODULE_ID)
	
	/*
	inserta el nuevo modulo
	*/
	INSERT INTO [dbo].[SC_MODULE]
           ([SC_MODULE_ID]
           ,[SC_MODULE_TYPE_ID]
           ,[SC_TABLE_ID]
           ,[CODE]
           ,[NAME]
           ,[DESCRIPTION]
           ,[ITEM_ORDER]
           ,[MODULE_CALL]
           ,[MODULE_ICON]
           ,[URL]
           ,[IS_LEAF]
           ,[CREATED]
           ,[CREATED_BY]
           ,[UPDATED]
           ,[UPDATED_BY]
           ,[OWNER_ID]
           ,[INCLUDING_PAGE]
           ,[SC_SUPER_MODULE_ID]
           ,[GENERIC_TYPE]
           ,[IS_DELETED]
           ,[JSON_CONFIG]
           ,[IS_ENABLED]
           ,[IS_VISIBLE])
     VALUES
     (
			@SC_MODULE_ID
			,@SC_MODULE_TYPE_ID
			,@SC_TABLE_ID
           ,@CODE+@CONCATENADO
           ,@NAME+@CONCATENADO		
           ,@DESCRIPTION		
           ,99		
           ,@module_id_padre	
           ,@MODULE_ICON	
           ,@URL			
           ,@IS_LEAF		
           ,@CREATED		
           ,@CREATED_BY		 
           ,@UPDATED			
           ,@UPDATED_BY		
           ,@OWNER_ID			
           ,@INCLUDING_PAGE		
           ,@SC_SUPER_MODULE_ID
           ,@GENERIC_TYPE		
           ,@IS_DELETED			
           ,@JSON_CONFIG		
           ,@IS_ENABLED			
           ,@IS_VISIBLE		

	)
	
	
	
	
	
	PRINT 'inserto padre'
	/*
	actualiza tabla de secuenciales luego de usar el ID
	*/
	UPDATE PM_SEQUENCE_TABLE SET NEXT_SEQUENCE_ID = @SC_MODULE_ID+1 WHERE SEQUENCE_NAME = 'seq_sc_module'
	
	/*
	almaneca los id de las pestanas
	*/
	DECLARE cursor_pestana cursor local for
				SELECT
					SC_MODULE_ID
					,SC_MODULE_TYPE_ID
					,SC_TABLE_ID
					,CODE	
					,NAME
					,DESCRIPTION
					,ITEM_ORDER
					,MODULE_CALL
					,MODULE_ICON
					,URL 
					,IS_LEAF
					,CREATED 
					,CREATED_BY 
					,UPDATED 
					,UPDATED_BY
					,OWNER_ID 
					,INCLUDING_PAGE 
					,SC_SUPER_MODULE_ID 
					,GENERIC_TYPE 
					,IS_DELETED 
					,JSON_CONFIG 
					,IS_ENABLED 
					,IS_VISIBLE 
		    
				FROM
					SC_MODULE
				WHERE
					MODULE_CALL = @module_id
				AND
					is_deleted = 0
	
	open cursor_pestana
	
	fetch next from cursor_pestana into
			@SC_MODULE_ID_2
			,@SC_MODULE_TYPE_ID_2
			,@SC_TABLE_ID_2
           ,@CODE_2
           ,@NAME_2			
           ,@DESCRIPTION_2		
           ,@ITEM_ORDER_2		
           ,@MODULE_CALL_2	
           ,@MODULE_ICON_2	
           ,@URL_2			
           ,@IS_LEAF_2		
           ,@CREATED_2		
           ,@CREATED_BY_2		 
           ,@UPDATED_2			
           ,@UPDATED_BY_2		
           ,@OWNER_ID_2			
           ,@INCLUDING_PAGE_2		
           ,@SC_SUPER_MODULE_ID_2
           ,@GENERIC_TYPE_2		
           ,@IS_DELETED_2			
           ,@JSON_CONFIG_2		
           ,@IS_ENABLED_2			
           ,@IS_VISIBLE_2		
	
	
	WHILE @@fetch_status = 0 
	BEGIN
			
			select 
				@tiene_hijos = COUNT(*) 
			FROM 
				SC_MODULE 
			WHERE
				MODULE_CALL =  @SC_MODULE_ID_2
			AND
				IS_DELETED = 0
				
			
			IF(@tiene_hijos<>0)
				BEGIN
					exec pr_copia_modulo_desde_grilla @SC_MODULE_ID_2, @SC_MODULE_ID, @nombre_modulo
				END
			ELSE
				BEGIN
				
						/*
						obtiene id a usar para insertar
						*/
						SELECT
							@SC_MODULE_ID_2 = NEXT_SEQUENCE_ID +1
						FROM
							PM_SEQUENCE_TABLE
						WHERE
							SEQUENCE_NAME = 'seq_sc_module'
							
							
					
						/*
						inserta el nuevo modulo
						*/
						INSERT INTO [dbo].[SC_MODULE]
							   ([SC_MODULE_ID]
							   ,[SC_MODULE_TYPE_ID]
							   ,[SC_TABLE_ID]
							   ,[CODE]
							   ,[NAME]
							   ,[DESCRIPTION]
							   ,[ITEM_ORDER]
							   ,[MODULE_CALL]
							   ,[MODULE_ICON]
							   ,[URL]
							   ,[IS_LEAF]
							   ,[CREATED]
							   ,[CREATED_BY]
							   ,[UPDATED]
							   ,[UPDATED_BY]
							   ,[OWNER_ID]
							   ,[INCLUDING_PAGE]
							   ,[SC_SUPER_MODULE_ID]
							   ,[GENERIC_TYPE]
							   ,[IS_DELETED]
							   ,[JSON_CONFIG]
							   ,[IS_ENABLED]
							   ,[IS_VISIBLE])
						 VALUES
						 (
								@SC_MODULE_ID_2
								,@SC_MODULE_TYPE_ID_2
								,@SC_TABLE_ID_2
							   ,@CODE_2+@CONCATENADO
							   ,@NAME_2+@CONCATENADO		
							   ,@DESCRIPTION_2		
							   ,@ITEM_ORDER_2		
							   ,@SC_MODULE_ID
							   ,@MODULE_ICON_2	
							   ,@URL_2			
							   ,@IS_LEAF_2		
							   ,@CREATED_2		
							   ,@CREATED_BY_2		 
							   ,@UPDATED_2			
							   ,@UPDATED_BY_2		
							   ,@OWNER_ID_2			
							   ,@INCLUDING_PAGE_2		
							   ,@SC_SUPER_MODULE_ID_2
							   ,@GENERIC_TYPE_2		
							   ,@IS_DELETED_2			
							   ,@JSON_CONFIG_2		
							   ,@IS_ENABLED_2			
							   ,@IS_VISIBLE_2		

						)
						
						PRINT 'inserto hijo'
						/*
						actualiza tabla de secuenciales luego de usar el ID
						*/
						UPDATE 
							PM_SEQUENCE_TABLE 
						SET 
							NEXT_SEQUENCE_ID = @SC_MODULE_ID_2+1 
						WHERE 
							SEQUENCE_NAME = 'seq_sc_module'
				
				END
							
				
			fetch next from cursor_pestana into 
								@SC_MODULE_ID_2
								,@SC_MODULE_TYPE_ID_2
								,@SC_TABLE_ID_2
							   ,@CODE_2
							   ,@NAME_2			
							   ,@DESCRIPTION_2		
							   ,@ITEM_ORDER_2		
							   ,@MODULE_CALL_2	
							   ,@MODULE_ICON_2	
							   ,@URL_2			
							   ,@IS_LEAF_2		
							   ,@CREATED_2		
							   ,@CREATED_BY_2		 
							   ,@UPDATED_2			
							   ,@UPDATED_BY_2		
							   ,@OWNER_ID_2			
							   ,@INCLUDING_PAGE_2		
							   ,@SC_SUPER_MODULE_ID_2
							   ,@GENERIC_TYPE_2		
							   ,@IS_DELETED_2			
							   ,@JSON_CONFIG_2		
							   ,@IS_ENABLED_2			
							   ,@IS_VISIBLE_2	
				
				
	END
	
		
	CLOSE cursor_pestana 
	DEALLOCATE cursor_pestana
		
	select @nombre_modulo+@CONCATENADO as nuevo_codigo
	
	
	
END

GO

