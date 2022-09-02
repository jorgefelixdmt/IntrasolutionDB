/*      
****************************************************************************************************************************************
Nombre: dbo.[pr_Ejecucion_Procesos]
Fecha Creacion: ---
Autor: Valky Salinas
Descripcion: SP que ejecuta los procesos del sistema.
Parametros: ---
Uso: [pr_Ejecucion_Procesos]

**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**************************************************************************************************************************************
*/
CREATE PROCEDURE [dbo].[pr_Ejecucion_Procesos]
AS
BEGIN

	DECLARE @fb_proceso_id numeric(10,0), @sp_proceso varchar(300), @codigo_proceso varchar(300)
	DECLARE @tipo_frecuencia varchar(200), @recurrencia_diario int
	DECLARE @periodo_desde DATETIME, @periodo_hasta_opc_si int, @periodo_hasta_opc_no int, @periodo_hasta DATETIME
	DECLARE @recurrencia_semanal int, @lunes int, @martes int, @miercoles int, @jueves int, @viernes int, @sabado int, @domingo int
	DECLARE @frec_men_opc_dia int, @frec_men_opc_dia_conf_dia int, @frec_men_opc_dia_conf_mes int, @frec_men_opc_esp int
	DECLARE @frec_men_opc_esp_conf_ord_dia varchar(200), @frec_men_opc_esp_conf_dia_sem varchar(200), @frec_men_opc_esp_conf_mes int

	DECLARE CURSOR_PROC CURSOR FOR 
		SELECT 
			fb_proceso_id,
			sp_proceso,
			codigo,
			tipo_frecuencia,
			recurrencia_diario,
			periodo_desde,
			periodo_hasta_opc_si,
			periodo_hasta_opc_no,
			periodo_hasta_opc_si_conf_dia,
			recurrencia_semanal,
			lunes, 
			martes,
			miercoles,
			jueves,
			viernes,
			sabado,
			domingo,
			frec_men_opc_dia,
			frec_men_opc_dia_conf_dia,
			frec_men_opc_dia_conf_mes,
			frec_men_opc_esp,
			frec_men_opc_esp_conf_mes,
			frec_men_opc_esp_conf_ord_dia,
			frec_men_opc_esp_conf_dia_sem
		FROM fb_proceso
		WHERE 
			is_deleted = 0 AND 
			Flag_Estado=1

	OPEN CURSOR_PROC  
	FETCH NEXT FROM CURSOR_PROC INTO 
		@fb_proceso_id,
		@sp_proceso,
		@codigo_proceso,
		@tipo_frecuencia,
		@recurrencia_diario,
		@periodo_desde,
		@periodo_hasta_opc_si,
		@periodo_hasta_opc_no,
		@periodo_hasta, 
		@recurrencia_semanal,
		@lunes, 
		@martes,
		@miercoles,
		@jueves,
		@viernes,
		@sabado,
		@domingo,
		@frec_men_opc_dia,
		@frec_men_opc_dia_conf_dia,
		@frec_men_opc_dia_conf_mes,
		@frec_men_opc_esp,
		@frec_men_opc_esp_conf_mes,
		@frec_men_opc_esp_conf_ord_dia,
		@frec_men_opc_esp_conf_dia_sem
	WHILE @@FETCH_STATUS = 0  
	 BEGIN 
		IF @periodo_hasta_opc_no = 1 SET @periodo_hasta = GETDATE() + 1

		IF GETDATE() BETWEEN @periodo_desde AND @periodo_hasta
		 BEGIN
			IF @tipo_frecuencia = 'DIA'
			 BEGIN
				IF (DATEDIFF(DAY,GETDATE(),@periodo_desde) % @recurrencia_diario = 0)
				 BEGIN
					exec(@sp_proceso)
				 END
			 END

			IF @tipo_frecuencia = 'SEM'
			 BEGIN
				IF (DATEDIFF(WEEK,GETDATE(),@periodo_desde) % @recurrencia_semanal = 0)
				 BEGIN
					IF DATEPART(dw,GETDATE()) = 1 AND @domingo = 1
					 BEGIN
						exec(@sp_proceso)
					 END
					IF DATEPART(dw,GETDATE()) = 2 AND @lunes = 1
					 BEGIN
						exec(@sp_proceso)
					 END
					IF DATEPART(dw,GETDATE()) = 3 AND @martes = 1
					 BEGIN
						exec(@sp_proceso)
					 END
					IF DATEPART(dw,GETDATE()) = 4 AND @miercoles = 1
					 BEGIN
						exec(@sp_proceso)
					 END
					IF DATEPART(dw,GETDATE()) = 5 AND @jueves = 1
					 BEGIN
						exec(@sp_proceso)
					 END
					IF DATEPART(dw,GETDATE()) = 6 AND @viernes = 1
					 BEGIN
						exec(@sp_proceso)
					 END
					IF DATEPART(dw,GETDATE()) = 7 AND @sabado = 1
					 BEGIN
						exec(@sp_proceso)
					 END
				 END
			 END
	   
			IF @tipo_frecuencia = 'MEN'
			 BEGIN
				IF @frec_men_opc_dia = 1
				 BEGIN
					IF (DATEDIFF(MONTH,GETDATE(),@periodo_desde) % @frec_men_opc_dia_conf_mes = 0)
					 BEGIN
						IF DAY(GETDATE()) = @frec_men_opc_dia_conf_dia
						 BEGIN
							exec(@sp_proceso)
						 END
					 END
				 END
				ELSE
				 BEGIN
					IF @frec_men_opc_esp = 1
					 BEGIN
						IF (DATEDIFF(MONTH,GETDATE(),@periodo_desde) % @frec_men_opc_esp_conf_mes = 0)
						 BEGIN
							IF @frec_men_opc_esp_conf_dia_sem = 'SUN' AND DATEPART(dw,GETDATE()) = 1
							 BEGIN
								IF @frec_men_opc_esp_conf_ord_dia = 'FST'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -7, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'SND'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -7, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -14, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'TRD'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -14, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -21, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'FRTH'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -21, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -28, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'LST'
								 BEGIN
									IF DATEPART(month, DATEADD(day, 7, GETDATE())) = DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
							 END
							IF @frec_men_opc_esp_conf_dia_sem = 'MON' AND DATEPART(dw,GETDATE()) = 2
							 BEGIN
								IF @frec_men_opc_esp_conf_ord_dia = 'FST'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -7, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'SND'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -7, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -14, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'TRD'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -14, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -21, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'FRTH'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -21, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -28, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'LST'
								 BEGIN
									IF DATEPART(month, DATEADD(day, 7, GETDATE())) = DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
							 END
							IF @frec_men_opc_esp_conf_dia_sem = 'TUE' AND DATEPART(dw,GETDATE()) = 3
							 BEGIN
								IF @frec_men_opc_esp_conf_ord_dia = 'FST'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -7, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'SND'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -7, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -14, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'TRD'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -14, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -21, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'FRTH'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -21, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -28, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'LST'
								 BEGIN
									IF DATEPART(month, DATEADD(day, 7, GETDATE())) = DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
							 END
							IF @frec_men_opc_esp_conf_dia_sem = 'WED' AND DATEPART(dw,GETDATE()) = 4
							 BEGIN
								IF @frec_men_opc_esp_conf_ord_dia = 'FST'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -7, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'SND'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -7, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -14, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'TRD'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -14, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -21, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'FRTH'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -21, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -28, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'LST'
								 BEGIN
									IF DATEPART(month, DATEADD(day, 7, GETDATE())) = DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
							 END
							IF @frec_men_opc_esp_conf_dia_sem = 'THU' AND DATEPART(dw,GETDATE()) = 5
							 BEGIN
								IF @frec_men_opc_esp_conf_ord_dia = 'FST'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -7, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'SND'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -7, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -14, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'TRD'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -14, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -21, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'FRTH'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -21, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -28, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'LST'
								 BEGIN
									IF DATEPART(month, DATEADD(day, 7, GETDATE())) = DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
							 END
							IF @frec_men_opc_esp_conf_dia_sem = 'FRI' AND DATEPART(dw,GETDATE()) = 6
							 BEGIN
								IF @frec_men_opc_esp_conf_ord_dia = 'FST'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -7, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'SND'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -7, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -14, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'TRD'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -14, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -21, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'FRTH'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -21, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -28, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'LST'
								 BEGIN
									IF DATEPART(month, DATEADD(day, 7, GETDATE())) = DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
							 END
							IF @frec_men_opc_esp_conf_dia_sem = 'SAT' AND DATEPART(dw,GETDATE()) = 7
							 BEGIN
								IF @frec_men_opc_esp_conf_ord_dia = 'FST'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -7, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'SND'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -7, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -14, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'TRD'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -14, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -21, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'FRTH'
								 BEGIN
									IF DATEPART(month, DATEADD(day, -21, GETDATE())) = DATEPART(month, GETDATE()) AND DATEPART(month, DATEADD(day, -28, GETDATE())) <> DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
								IF @frec_men_opc_esp_conf_ord_dia = 'LST'
								 BEGIN
									IF DATEPART(month, DATEADD(day, 7, GETDATE())) = DATEPART(month, GETDATE())
									 BEGIN
										exec(@sp_proceso)
									 END
								 END
							 END
						 END
					 END
				 END
			 END
		 END

		-- Inserción log procesos
		INSERT INTO fb_procesos_log (codigo_proceso,fechahora,CREATED,CREATED_BY,UPDATED,UPDATED_BY,owner_id,is_deleted,ejecutado)
		VALUES (@codigo_proceso,GETDATE(),GETDATE(),1,GETDATE(),1,1,0,1)
		
		FETCH NEXT FROM CURSOR_PROC INTO 
			@fb_proceso_id,
			@sp_proceso,
			@codigo_proceso,
			@tipo_frecuencia,
			@recurrencia_diario,
			@periodo_desde,
			@periodo_hasta_opc_si,
			@periodo_hasta_opc_no,
			@periodo_hasta, 
			@recurrencia_semanal,
			@lunes, 
			@martes,
			@miercoles,
			@jueves,
			@viernes,
			@sabado,
			@domingo,
			@frec_men_opc_dia,
			@frec_men_opc_dia_conf_dia,
			@frec_men_opc_dia_conf_mes,
			@frec_men_opc_esp,
			@frec_men_opc_esp_conf_mes,
			@frec_men_opc_esp_conf_ord_dia,
			@frec_men_opc_esp_conf_dia_sem
	 END 

	CLOSE CURSOR_PROC  
	DEALLOCATE CURSOR_PROC 

END

GO

