


/*      
****************************************************************************************************************************************
Nombre: dbo.pr_pa_genera_version_log_pase
Fecha Creacion: 26/03/2020
Autor: Mauro Roque
Descripcion: Store que obtiene una nueva version de log por cada cliente.
Llamado por: js
Usado por: Modulo: Pases de Software
Parametros: @id_cliente - ID de Cliente
			@id_tipo_pase - Id Tipo Pase
Uso: pr_pa_genera_version_log_pase 1,2
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/

CREATE proc pr_pa_genera_version_log_pase
@id_cliente int,
@id_tipo_pase int
as
begin
	IF @id_tipo_pase = 3 -- SI ES APP CLIENTE
	begin
		

		DECLARE @codigo_cliente varchar(50)              
			DECLARE @anno varchar(50)              
			DECLARE @codigo_patron varchar(50)              
			DECLARE @codigo_version_log_siguiente varchar(50)              
		 DECLARE @contador int , @codigo_version_log_anterior varchar(100)
              

		 set @codigo_cliente = (select UPPER(codigo) from fb_cliente where fb_cliente_id=@id_cliente)  
 
		 if (@id_cliente =3 or @id_cliente=4 or @id_cliente=5 or @id_cliente=10002)   
			 begin
				set @codigo_cliente = 'FTN'
			 end
          
		 set @anno = YEAR(getdate())              

		 -- DEFINE PATRON DEL CODIGO --              

		 set  @codigo_patron = @codigo_cliente + '.' +  @anno      

		 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --              

		 SET @codigo_version_log_siguiente  = (Select MAX(version) from pa_pase  where is_deleted=0 and version like @codigo_patron + '%' )               
 
		 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO OBTIENE VERSION LOG ANTERIOR--  

		 SET @codigo_version_log_anterior  = (Select MAX(version) from pa_pase  where is_deleted=0 and version like @codigo_patron + '%' )               

		 -- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO              
		  IF (@codigo_version_log_siguiente is Null)              
			BEGIN              
			   -- CREA EL CODIGO CON 0001              
				  set  @codigo_version_log_siguiente = @codigo_patron + '.' + '001'          
					END              
		 ELSE              
		  BEGIN              
		   -- ARMA EL CODIGO RECUPERANDO EL ULTIMO CONTADOR Y SUMANDOLE 1              

		   SET @contador = convert(int,right(@codigo_version_log_siguiente,3))        
		   SET @contador = @contador + 1              
		   SET @codigo_version_log_siguiente = @codigo_patron + '.' + right('00'+ convert(varchar(3),@contador),3)             
		  END          

		  select @codigo_version_log_siguiente as codigo_version_log_siguiente, 
				@codigo_version_log_anterior as codigo_version_log_anterior
	END

	IF @id_tipo_pase = 1 -- SI ES FRAMEWORK
	BEGIN
                
				DECLARE @codigo_patron_fram varchar(50)              
				DECLARE @codigo_version_log_siguiente_fra varchar(50)              
			    DECLARE @contador_fram int , @codigo_version_log_anterior_fra varchar(100)
              
			 -- DEFINE PATRON DEL CODIGO --              

			 set  @codigo_patron_fram = '2.4'      

			 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --              

			 SET @codigo_version_log_siguiente_fra  = (Select MAX(version) from pa_pase  where fb_cliente_id= @id_cliente and is_deleted=0 and version like @codigo_patron_fram + '%' )               
 
			 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO OBTIENE VERSION LOG ANTERIOR--  

			 SET @codigo_version_log_anterior_fra  = (Select MAX(version) from pa_pase  where  fb_cliente_id= @id_cliente and is_deleted=0 and version like @codigo_patron_fram + '%' )               

			 -- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO              
			  IF (@codigo_version_log_siguiente_fra is Null)              
				BEGIN              
				   -- CREA EL CODIGO CON 0001              
					  set  @codigo_version_log_siguiente_fra = @codigo_patron + '.' + '1'          
						END              
			 ELSE              
			  BEGIN              
			   -- ARMA EL CODIGO RECUPERANDO EL ULTIMO CONTADOR Y SUMANDOLE 1              

			   SET @contador_fram = convert(int,right(@codigo_version_log_siguiente_fra,1))        
			   SET @contador_fram = @contador_fram + 1              
			   SET @codigo_version_log_siguiente_fra = @codigo_patron_fram + '.' + right(convert(varchar(1),@contador_fram),1)             
			  END          

			  select @codigo_version_log_siguiente_fra as codigo_version_log_siguiente_fra, 
					@codigo_version_log_anterior_fra as codigo_version_log_anterior_fram

	END


	IF @id_tipo_pase = 2 -- SI ES APP STANDAR
	BEGIN
                
				DECLARE @codigo_cliente_stn varchar(50)              
			DECLARE @anno_stn varchar(50)              
			DECLARE @codigo_patron_stn varchar(50)              
			DECLARE @codigo_version_log_siguiente_stn varchar(50)              
		 DECLARE @contador_stn int , @codigo_version_log_anterior_stn varchar(100)
              

		 set @codigo_cliente_stn = (select UPPER(codigo) from fb_cliente where fb_cliente_id=@id_cliente)  
 
		 if (@id_cliente =3 or @id_cliente=4 or @id_cliente=5 or @id_cliente=10002)   
			 begin
				set @codigo_cliente_stn = 'FTN'
			 end
          
		 set @anno_stn = YEAR(getdate())              

		 -- DEFINE PATRON DEL CODIGO --              

		 set  @codigo_patron_stn = @codigo_cliente_stn + '.' + 'STANDAR' + '.'  +  @anno_stn      

		 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --              

		 SET @codigo_version_log_siguiente_stn  = (Select MAX(version) from pa_pase  where is_deleted=0 and version like @codigo_patron_stn + '%' )               
 
		 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO OBTIENE VERSION LOG ANTERIOR--  

		 SET @codigo_version_log_anterior_stn  = (Select MAX(version) from pa_pase  where is_deleted=0 and version like @codigo_patron_stn + '%' )               

		 -- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO              
		  IF (@codigo_version_log_siguiente_stn is Null)              
			BEGIN              
			   -- CREA EL CODIGO CON 0001              
				  set  @codigo_version_log_siguiente_stn = @codigo_patron_stn + '.' + '001'          
					END              
		 ELSE              
		  BEGIN              
		   -- ARMA EL CODIGO RECUPERANDO EL ULTIMO CONTADOR Y SUMANDOLE 1              

		   SET @contador_stn = convert(int,right(@codigo_version_log_siguiente_stn,3))        
		   SET @contador_stn = @contador_stn + 1              
		   SET @codigo_version_log_siguiente_stn = @codigo_patron_stn + '.' + right('00'+ convert(varchar(3),@contador_stn),3)             
		  END          

		  select @codigo_version_log_siguiente_stn as codigo_version_log_siguiente_stn, 
				@codigo_version_log_anterior_stn as codigo_version_log_anterior_stn
	END

END

GO

