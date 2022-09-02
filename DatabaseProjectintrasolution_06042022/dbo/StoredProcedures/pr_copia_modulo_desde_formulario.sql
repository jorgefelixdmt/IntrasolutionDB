

-- =============================================
-- Author:		<Author,,Carlos Cubas>
-- Create date: <Create 03/11/2015,,
-- Description:	<Description,copia el modulo desde el formulario>
-- =============================================
CREATE procedure [dbo].[pr_copia_modulo_desde_formulario]
@module_id numeric(10,0)
AS
BEGIN

declare @SC_MODULE_ID numeric(10,0)
           ,@SC_MODULE_TYPE_ID numeric(10,0)
           ,@SC_TABLE_ID numeric(10,0)
           ,@CODE nvarchar(50)
           ,@NAME nvarchar(100)
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
           
           ,@ANO varchar(4)
           ,@MES varchar(2)
           ,@DIA varchar(2)
           ,@HORA varchar(2)
           ,@MINUTO varchar(2)
           ,@CONCATENADO varchar(50)
           
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


			SET @ANO	=	NULL
			SET @MES	=	NULL
			SET @DIA	=	NULL
			SET @HORA	=	NULL
			SET @MINUTO	=	NULL
			SET @CONCATENADO = NULL
			
			
			
			SET @ANO	=	CONVERT(varchar(4),DATEPART(YEAR, GETDATE()))
			SET @MES	=	CONVERT(varchar(2),DATEPART(MONTH, GETDATE()))
			SET @DIA	=	CONVERT(varchar(2),DATEPART(DAY, GETDATE()))
			SET @HORA	=	CONVERT(varchar(2),DATEPART(HOUR, GETDATE()))
			SET @MINUTO	=	CONVERT(varchar(2),DATEPART(MINUTE, GETDATE()))
			
			SET @CONCATENADO = '_'+@ANO+'-'+@MES+'-'+@DIA+'-'+@HORA+'-'+@MINUTO
		
			PRINT 'concatenado ' + @CONCATENADO

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
	Genera numero aleatorio para concatenar al nuevo nombre del modulo
	*/
	set @numero_ramdon_cadena = NULL
	set @numero_ramdon_entero = NULL
		
	set @numero_ramdon_cadena = CONVERT(varchar(2),(select ABS(CHECKSUM(NewId())) % 99))
	set @numero_ramdon_entero = (select ABS(CHECKSUM(NewId())) % 99)
	
	
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
           ,@MODULE_CALL	
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
	/*
	actualiza tabla de secuenciales luego de usar el ID
	*/
	UPDATE PM_SEQUENCE_TABLE SET NEXT_SEQUENCE_ID = @SC_MODULE_ID+1 WHERE SEQUENCE_NAME = 'seq_sc_module'
	
	
	/*
	almaneca los id de las pestanas
	*/
		
	select @NAME+@CONCATENADO as nuevo_codigo
	
	
	
END

GO

