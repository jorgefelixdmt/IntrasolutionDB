  
/*        
        
<StoreProcedure>        
 <Name>        
         pr_aviso_documento_distribucion      
   </Name>        
    <Description>        
  Alerta a los responsables que el documento se ha actualizado        
          
  La informacion a enviar es :        
   - Correlativo        
   - Codigo       
   - Titulo        
   - Ruta        
   - FechaActualizacion        
         
 -- pr_aviso_documento_distribucion         
 </Description>        
 <Parameters>        
 </Parameters>        
    <Author>        
          Daniel Restrepo         
    </Author>        
    <Date>        
         27/02/2017        
    </Date>        
</StoreProcedure>          
*/        
--exec pr_aviso_documento_distribucion         
CREATE proc [dbo].[pr_pry_gantt_inserta_mpp]         
@titulo varchar(200), @json nvarchar(max)    
          
AS          
        
BEGIN          
        
	INSERT INTO pry_mpp_gantt_chart (titulo,json,fb_uea_pe_id,created,created_by,updated,updated_by,owner_id,is_deleted)
	VALUES (@titulo,@json,1,GETDATE(),1,GETDATE(),1,1,0)     
        
       
END

GO

