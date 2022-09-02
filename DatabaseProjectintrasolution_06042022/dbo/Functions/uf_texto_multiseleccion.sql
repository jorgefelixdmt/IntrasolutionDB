


/*
procedure: dbo.uf_texto_multiseleccion
create date (YYYY-MM-DD): 2020-04-18
Autor: dominiotech
description: esta función devuelve una cadena separados por coma. 
Call by: esta función como es genérica es llamado desde varios objetos:
			vistas
			código java (clases bean)
affected table(s): no afecta ninguna tabla
Used By: Esta función es parte del framework por lo tanto es usado por varios módulos
Parameter(s): @cadena_ids - cadenas de ids separados por coma
				@codigo_filtro - nombre de la tabla que se desea consultar para armar la cadena de nombres.

*/
CREATE function [dbo].[uf_texto_multiseleccion] (@cadena_ids varchar(50), @codigo_filtro varchar(100)) 
returns varchar(1000)  
  
As  
Begin  
 Declare   
 @cadena_nombres varchar(1000)  


 set @cadena_nombres = NULL
 /*ejemplo para tabla normal*/
 if(@codigo_filtro = 'nl_norma_legal_estado' AND @cadena_ids <> '') 
 BEGIN  
   
   select @cadena_nombres = coalesce(@cadena_nombres + ',', '') +  convert(varchar(100),nombre) 
   from nl_norma_legal_estado 
   where
   is_deleted <> 1 AND 
   nl_norma_legal_estado_id in (select item from dbo.uf_Split( @cadena_ids,',' ))
   order by orden ASC
 END
 
 /*ejemplo para tabla maestra*/
  if(@codigo_filtro = 'tabla_maestra' AND @cadena_ids <> '') 
 BEGIN  
   
   select @cadena_nombres = coalesce(@cadena_nombres + ',', '') +  convert(varchar(100),maestra.name) 
   from SC_MASTER_TABLE maestra
   inner join SC_DOMAIN_TABLE domain on domain.SC_DOMAIN_TABLE_ID = maestra.SC_DOMAIN_TABLE_ID
   where
   maestra.is_deleted <> 1 AND 
   domain.NAME = 'TIPO_RESIDUO' AND
   maestra.code in (select item from dbo.uf_Split( @cadena_ids,',' ))
   order by maestra.order_by ASC
 END  
   
 return (@cadena_nombres)  
End

GO

