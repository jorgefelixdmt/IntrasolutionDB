/*  
 *** Recupera la lista de Folders a los que tiene acceso el usuario  
  
 Tipo_Permiso_Modulo = 1: Sin Acceso, 2:Solo Lectura, 3:Acceso Total  
   
 pr_doc_Folders_Usuario 156,25,3,'OPERACIONES'  

 El folder debera mostrarse :
 - Si no existen permisos se le muestra a todos los usuarios
 - Si solo tiene un publicadcor se le muestra a todos los usuarios
 - Si tiene al menos un lector solo se le muestra a los publicadores y lectores definidos explicitamente

 -- 19/11/2021  MPE		Controla los accesos para los folders que solo tienen a publicador 

*/




CREATE PROCEDURE [dbo].[pr_doc_Folders_Usuario]   
 @Usuario_Id  numeric(10,0),  
 @fb_uea_pe_Id     numeric(10,0),  
 @Tipo_Permiso_Modulo numeric(10,0), --1: Sin Acceso , 2:Solo Lectura, 3:Acceso Total  
 @folder_Categoria varchar(50)  
As  
  
Set Nocount on  
  
Declare @Tipo_Permiso_Folder varchar(1), @fb_empleado_id numeric(10,0), @fb_cargo_id numeric(10,0)

Select @fb_empleado_id = fb_empleado_id from sc_user where SC_USER_ID = @Usuario_Id   
Select @fb_cargo_id = fb_cargo_id from fb_empleado where fb_empleado_id = @fb_empleado_id   

  
-- Recupera la lista de folders de la Unidad   
Select f.doc_folder_id, f.nombre, f.doc_folder_padre_id, 0 nro_docs, 0 nro_folders,' ' as Tipo_Permiso_Folder   
 into #temp_folder  
 from doc_folder f   
 WHERE    
--  (f.fb_uea_pe_id = @fb_uea_pe_Id OR f.doc_folder_padre_id = 0) -- OR f.fb_uea_pe_id = 0)  
  (f.fb_uea_pe_id = @fb_uea_pe_Id  OR f.fb_uea_pe_id = 0 OR f.doc_folder_padre_id = 0)  
  AND (f.folder_categoria = @folder_Categoria)  and f.is_deleted=0 
  
  
-- Recupera la cantidad de documentos en cada folder   
Select doc_folder_id, count(*) nro_docs  
 into #temp  
 from doc_Documento   
 where doc_folder_id In (Select doc_folder_id from #temp_Folder)   
 group by doc_folder_id  
  
-- Actualiza el campo nro_docs de la tabla #temp_Folder  
Update #temp_Folder  
 Set nro_docs = t.nro_docs  
 from #temp t  
 Where #temp_folder.doc_folder_id = t.doc_folder_id  
  
--   
  
Declare @id_folder numeric(10,0) , @out_nro_child numeric(10,0)  
Declare @Flag varchar(1)  , @FlagE varchar(1), @FlagC varchar(1)    
  
Declare mycur Cursor For   
 Select f.doc_folder_id From doc_Folder f   
  Where  (f.fb_uea_pe_id = @fb_uea_pe_Id OR f.fb_uea_pe_id = 0)  
  AND (f.folder_categoria = @folder_Categoria)   
  Order by 1  
 
Set @Flag = ''
  
Open mycur   
 Fetch From mycur Into @id_folder  
  
WHILE @@FETCH_STATUS = 0  
 BEGIN  
      
    select @out_nro_child = count(*) from doc_folder where doc_folder_padre_id = @id_folder  
     
    if  @out_nro_child <> 0  
	   BEGIN   
		update #temp_folder  
			set nro_folders = @out_nro_child  
			where doc_folder_id = @id_folder  
       END  
         
	  if(@Tipo_Permiso_Modulo = 3) -- ACCESO TOTAL EN EL MODULO  
		 Set @Flag = 'P'  
	  else 
		BEGIN
		
		--********* VERIFICACION POR EMPLEADO 
		 /*  Verifica si la carpeta no tiene permisos */  
		 if (not Exists(select 1 from doc_Folder_Empleado where doc_folder_id = @id_folder and is_deleted = 0))
				
			set @FlagE = 'S' -- Visualiza con el rol  de lector  
		 else  
		
		 /* Tiene que verificarse la siguiente condiction
		 
		 La carpeta tiene permisos y debe mostrarse al usuario si tiene acceso Flag
		 
		 
		 */  
			if exists(Select 1 from doc_Folder_Empleado where doc_folder_id = @id_folder and  fb_empleado_id= @fb_empleado_id and tipo_permiso='P' and is_deleted=0)  
				Set @FlagE = 'P'  
			else
			
					if exists(Select 1 from doc_Folder_Empleado where doc_folder_id = @id_folder and  fb_empleado_id = @fb_empleado_id and tipo_permiso='L' and is_deleted=0)
						Set @FlagE = 'L'  
					else	
						if not exists(Select 1 from doc_Folder_Empleado where doc_folder_id = @id_folder and tipo_permiso='L' and is_deleted=0)  -- MPE  19/11/2021
							Set @FlagE = 'L'  
						else
							Set @FlagE = 'X'  

		--********* VERIFICACION POR CARGO 
		 /*  Verifica si la carpeta no tiene permisos POR CARGO*/  
		 if ( not Exists(select 1 from doc_folder_permiso_cargo where doc_folder_id = @id_folder and is_deleted = 0 )  )
			set @FlagC = 'S' -- Visualiza con el rol  de lector  
		 else  
		
		 /* La carpeta tiene permisos y debe mostrarse al usuario si tiene acceso Flag*/  
			if exists(Select 1 from doc_folder_permiso_cargo where doc_folder_id = @id_folder and  fb_cargo_id= @fb_cargo_id and tipo_permiso='P' and is_deleted=0)  
				Set @FlagC = 'P'  
			else
			
					if exists(Select 1 from doc_folder_permiso_cargo where doc_folder_id = @id_folder and  fb_cargo_id = @fb_cargo_id and tipo_permiso='L' and is_deleted=0)
						Set @FlagC = 'L'  
					else			  
						Set @FlagC = 'X'  



			IF (@FlagE = 'S' AND @FlagC='S')
				 SET @Flag = 'L'
			ELSE
				IF((@FlagE = 'X' AND @FlagC='S') OR (@FlagE='S' AND @FlagC='X') )
					SET @Flag = 'X'
				ELSE
					 IF (@FlagE='P' OR @FlagC='P')
						SET @Flag='P' 
					ELSE
						IF(@FlagE='L' OR @FlagC='L')
							SET @Flag='L'
						ELSE
							SET @Flag = 'X'


        END   
	
	UPDATE #temp_folder  
		set Tipo_Permiso_Folder = @Flag      
		where doc_folder_id = @id_folder   
    
	Fetch From mycur Into @id_folder  
 end  
CLOSE mycur  
DEALLOCATE mycur  

Select * From #temp_folder   
   Where Tipo_Permiso_Folder <> 'X'  
   Order By nombre, doc_folder_padre_id

GO

