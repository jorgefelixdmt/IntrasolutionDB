

--select [dbo].[uf_inc_informe_final] (14,'2016-04-01')  
CREATE function [dbo].[uf_inc_informe_final] (@fb_uea_pe_id numeric(10,0))  
  
returns varchar(150)  
  
AS  
  
BEGIN  
    DECLARE @modulo varchar(50)  
    DECLARE @codigo_uea varchar(50)  

    DECLARE @codigo_patron varchar(50)  
    DECLARE @codigo_inc varchar(50)  
 DECLARE @contador int  
   
 --SET  @i=(select COUNT(*) codigo from cap_curso where fb_uea_pe_id=@fb_uea_pe_id )  
   
 set @modulo = 'ACC'  
 set @codigo_uea = (select UPPER(codigo) from fb_uea_pe where fb_uea_pe_id=@fb_uea_pe_id)  
 
   
 -- DEFINE PATRON DEL CODIGO --  
 set  @codigo_patron = @modulo + '-' + @codigo_uea    
   
 -- BUSCA EL ULTIMO REGISTRO CON PATRON DEL CODIGO --  
 SET @codigo_inc  = (Select MAX(codigo) from inc_informe_final  where codigo like @codigo_patron + '%')   
   
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

