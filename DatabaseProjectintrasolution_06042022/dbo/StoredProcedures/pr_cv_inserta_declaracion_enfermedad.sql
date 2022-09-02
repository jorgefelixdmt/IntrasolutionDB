
/*      
****************************************************************************************************************************************
Nombre: dbo.pr_cv_inserta_declaracion_enfermedad
Fecha Creacion: 13/05/2020
Autor: Mauro Roque
Descripcion: inserta datos en declaracion enfermedad
Llamado por: javasdcript
Usado por: Modulo: Declaracion - Pestana Enfermedad
Parametros: @id_empleado - ID de empleado , @id_declaracion id declaracion
Uso: pr_cv_inserta_declaracion_enfermedad 52,1
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE proc pr_cv_inserta_declaracion_enfermedad
@id_empleado int,
@id_declaracion int
as
begin

if exists (select * from cv_declaracion_enfermedades where is_deleted=0 and cv_declaracion_id = @id_declaracion )
begin

 return

end

DECLARE @ID_EM_CURSOR INT, @exa_enfermedad_patologica_id int , @detalle_patalogico varchar(500)

		 DECLARE Cur_Cov_Declara_Enferme CURSOR FOR      
			 SELECT        
				med.fb_empleado_id,
				exa_enfermedad_patologica_id,
				detalle_patalogico
					from exa_datos_medico_detalle det inner join exa_datos_medico med
					on det.exa_datos_medico_id=med.exa_datos_medico_id
					where med.fb_empleado_id=@id_empleado

				  OPEN Cur_Cov_Declara_Enferme      
		  FETCH NEXT FROM Cur_Cov_Declara_Enferme INTO @ID_EM_CURSOR, @exa_enfermedad_patologica_id , @detalle_patalogico
      
		  WHILE @@FETCH_STATUS = 0      
			BEGIN   

	
					insert into cv_declaracion_enfermedades
					(
					cv_declaracion_id,
					exa_enfermedad_patologica_id,
					detalle,
					created,
					created_by,
					updated,
					updated_by,
					owner_id,
					is_deleted
					)
					values(
					@id_declaracion,
					@exa_enfermedad_patologica_id,
					@detalle_patalogico,
					getdate(),
					1,
					getdate(),
					1,
					1,
					0)


				FETCH NEXT FROM Cur_Cov_Declara_Enferme INTO  @ID_EM_CURSOR, @exa_enfermedad_patologica_id , @detalle_patalogico  
	 
			END	 

			  CLOSE Cur_Cov_Declara_Enferme      
		  DEALLOCATE Cur_Cov_Declara_Enferme      


end

GO

