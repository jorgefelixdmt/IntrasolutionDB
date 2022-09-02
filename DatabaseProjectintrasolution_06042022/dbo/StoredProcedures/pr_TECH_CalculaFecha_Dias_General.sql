	

/*

Nombre: dbo.[pr_TECH_CalculaFecha_Dias_General]
Fecha Creación: 14/06/2020
Autor: Mauro Roque
Descripción: Calcula la fecha en base a dias calendario a partir de una fecha de Inicio 
Llamado por: Javascript Modulo Registro Solicitud
Usado por: Modulo : Registro Solicitud
Parámetro(s):   @FechaInicial  -  Fecha Incial 
				@NumeroDias    -  # días
Uso: [pr_TECH_CalculaFecha_Dias_General] '24/08/2020',270

******************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ----------------------------------------------------------

******************************************************************************************************

*/

CREATE PROCEDURE [dbo].[pr_TECH_CalculaFecha_Dias_General]  
@FechaInicial   varchar(10), -- dd/mm/yyyy  
 @NumeroDias  int  
As  

 Set dateformat dmy  
 Set datefirst 1   -- Considera el dia 1 como LUNES  
 Set @NumeroDias = @NumeroDias + 1
  
 Declare @Fecha as datetime, @ContadorDias int 
    
 Set @Fecha = @FechaInicial   
 
 Set @ContadorDias = 0 

 While @ContadorDias  < @NumeroDias   
  BEGIN  
	Set @Fecha = DATEADD(DAY,1,@Fecha)
	
			Set @ContadorDias = @ContadorDias + 1
  END  
 Select convert(varchar(10),@Fecha,103) as FechaFinal

GO

