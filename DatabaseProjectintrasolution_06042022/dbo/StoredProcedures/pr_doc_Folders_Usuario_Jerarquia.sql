



/*  

pr_doc_Folders_Usuario_Jerarquia 5,2,72,'OPERACIONES'  

*/  

  

CREATE PROCEDURE [dbo].[pr_doc_Folders_Usuario_Jerarquia]  
 @fb_uea_pe_Id numeric(10,0),  
 @Rol  numeric(10,0),  
 @fb_empleado_Id numeric(10,0),  
 @folder_Categoria varchar(50)  
AS  
 declare @nivel int, @current int, @wcount int  
 declare @users varchar(200)  
 declare @id_usu int  

 Set Nocount on    

   Create table #pila   
  (   
    nivel_profundidad int,   
    id_folder int  
   )  

Create table #resumen   

  ( nroseq int identity,   

    nivel int NOT NULL,   

    id_folder int NOT NULL ,  

    users varchar(512)  /* MPE */  

  )  

 Declare  @fb_cargo_id numeric(10,0)

 Select @fb_cargo_id = fb_cargo_id from fb_empleado where fb_empleado_id = @fb_empleado_id   

 Select  f.doc_folder_id, f.nombre, f.doc_folder_padre_id, space(512) as usuarios  
  into #folder  
  from doc_folder f   
   where (f.fb_uea_pe_id = @fb_uea_pe_Id or f.fb_uea_pe_id = 0 )  
	   and (f.doc_folder_id in (Select doc_folder_id from doc_folder_empleado where fb_empleado_id = @fb_empleado_Id) or -- MPE  
	   f.doc_folder_id not in (Select doc_folder_id from doc_folder_empleado) 
	   or f.doc_folder_id in (Select doc_folder_id from doc_folder_permiso_cargo where fb_cargo_id = @fb_cargo_id) or -- MPE  
	   f.doc_folder_id not in (Select doc_folder_id from doc_folder_permiso_cargo) 
	   or @Rol = 3)  -- MPE  
       and (f.folder_categoria = @folder_Categoria)     
  order by f.nombre  

  set @nivel = 1  
  set @current = 1  

/* Considera que la RAIZ cada categoria tiene el campo doc_folder_padre_id = null */   

  Select top 1 @current = doc_folder_id from #folder where doc_folder_padre_id = 0   

  --push  
  insert into #pila ( nivel_profundidad, id_folder ) values ( @nivel, @current)  

  While ( @nivel > 0 )  
   begin  
	   if exists(select * from #pila where nivel_profundidad = @nivel)  
			begin  
				 select top 1 @current = id_folder from #pila where nivel_profundidad = @nivel  
				 set rowcount 0  
				 insert into #resumen( nivel , id_folder ) values (@nivel, @current)  
				 -- pop   
				 delete from #pila where nivel_profundidad=@nivel and id_folder = @current  
				 -- push     
				 insert into #pila   

				 select @nivel + 1, doc_folder_id   
					  from #folder   
					  where doc_folder_padre_id = @current  
					   and doc_folder_padre_id <> doc_folder_id  

				 if @@rowcount > 0   
					select @nivel = @nivel + 1  
				 else  
					insert into #pila values ( 0, @current)  
			end   
		else  
			select @nivel = @nivel - 1  
    end  

  create table #resultado  
  (  
  seq int identity,  
  folder varchar(512),  

  id_folder int,  

  nivel int,     

  Flag int,     

  users varchar(512)  

  )  

   

  insert into #resultado (folder, id_folder,nivel )  

   select REPLICATE('.',(isnull(r.nivel,1) - 1)  * 3 ) + f.nombre,  
	   f.doc_folder_id,  
	   r.nivel  
    from #folder f, #resumen r   
	where  f.doc_folder_id = r.id_folder  
    order by r.nroseq  

  Select * from #resultado  

  drop table #pila  
  drop table #folder   
  drop table #resumen  
  drop table #resultado

GO

