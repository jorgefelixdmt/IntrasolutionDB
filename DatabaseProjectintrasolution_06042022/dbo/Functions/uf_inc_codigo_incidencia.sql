

/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_inc_codigo_incidencia]
Fecha Creacion: 15/06/2020
Autor: Mauro Roque
Descripcion: funcion que genera codigo corelativo de la incidencia por cliente
Llamado por: javascript
Usado por: Incidencias, Incidencias del Cliente
Parametros: @id_cliente Id del cliente
Uso: select dbo.[uf_inc_codigo_incidencia] (2)
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE function [dbo].[uf_inc_codigo_incidencia] (@id_cliente numeric(10,0))              
returns varchar(150)              
AS              
BEGIN              
    DECLARE @codigo_cliente varchar(50)              
    DECLARE @anno varchar(50)              
    DECLARE @codigo_patron varchar(50)              
    DECLARE @codigo_inc varchar(50)              
 DECLARE @contador int              

 set @codigo_cliente = (select UPPER(codigo) from fb_cliente where fb_cliente_id=@id_cliente)              
 set @anno = YEAR(getdate())              

 -- DEFINE PATRON DEL CODIGO --              

 set  @codigo_patron = @anno + '-' + @codigo_cliente        

 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --              

 SET @codigo_inc  = (Select MAX(codigo_ticket) from inc_incidencia  where is_deleted=0 and codigo_ticket like @codigo_patron + '%'  and fb_cliente_id = @id_cliente )               
 --SET @codigo_pas  = (Select MAX(codigo) from pas_registro  where is_deleted=0 and codigo like @codigo_patron + '%' and fb_uea_pe_id = @fb_uea_pe_id )
    
 -- SI NO EXISTE UN CODIGO CON EL PATRON DEFINIDO              
  IF (@codigo_inc is Null)              
    BEGIN              
	   -- CREA EL CODIGO CON 0001              
	      set  @codigo_inc = @codigo_patron + '-' + '00001'          
		    END              
 ELSE              
  BEGIN              
   -- ARMA EL CODIGO RECUPERANDO EL ULTIMO CONTADOR Y SUMANDOLE 1              

   SET @contador = convert(int,right(@codigo_inc,5))        
   SET @contador = @contador + 1              
   SET @codigo_inc = @codigo_patron + '-' + right('0000'+ convert(varchar(5),@contador),5)             
  END              
 RETURN (@codigo_inc)              
END

GO

