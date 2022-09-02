

/*      
****************************************************************************************************************************************
Nombre: dbo.pr_pry_valida_ingreso_salida
Fecha Creacion: 21/05/2020
Autor: Mauro Roque
Descripcion: store que valida el ingreso y salida de un trabajador
Llamado por: js
Usado por: Modulo: Asistencia / Registro Ingreso y Salida
Parametros: @id_user - ID de Usuario Session
			@fecha - Fecha de Registro Asistencia
			@tipo_asistencia -- Tipo de Registro Asistencia : si es "1" registro ingreso "2" registro salida
Uso: exec pr_pry_valida_ingreso_salida 3,'21/05/2020',1
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE proc pr_pry_valida_ingreso_salida
@id_user int,
@fecha varchar(10),
@tipo_asistencia int
as
begin
declare @flag_valida_hora_ini int=0,@flag_valida_hora_fin int=0,@mensaje_inicio varchar(200),@mensaje_fin varchar(200)

if @tipo_asistencia = 1  -- si es registro ingreso
begin


		if exists( select * from pry_registro_ingreso_salida 
					where convert(varchar(10),fecha,103)=@fecha
							and hora_ingreso<>''
							and hora_salida<>''
							and created_by=@id_user
							and is_deleted=0)

		begin
			set @flag_valida_hora_ini = 1
			set @mensaje_inicio ='Ya Registro su Asistencia'
		end


		if exists( select * from pry_registro_ingreso_salida 
					where convert(varchar(10),fecha,103)=@fecha
							and hora_ingreso<>''

							and created_by=@id_user
							and is_deleted=0)

		begin
			set @flag_valida_hora_ini = 1
			set @mensaje_inicio ='Ya Registro su Hora Inicio'
		end
end
if @tipo_asistencia = 2  -- si es registro salida
begin


		if exists( select * from pry_registro_ingreso_salida 
					where convert(varchar(10),fecha,103)=@fecha
							and hora_salida<>'' 
							and created_by=@id_user
							and is_deleted=0)

		begin
			set @flag_valida_hora_fin = 1
			set @mensaje_fin ='Ya Registro su hora de salida'
		end

end

select @flag_valida_hora_fin as flag_valida_hora_fin,
	   @flag_valida_hora_ini as flag_valida_hora_ini,
	   @mensaje_inicio as mensaje_inicio,
	   @mensaje_fin as mensaje_fin

end

GO

