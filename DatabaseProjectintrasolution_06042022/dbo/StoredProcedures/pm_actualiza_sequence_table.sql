--Esto es para probar modificaciones
create proc pm_actualiza_sequence_table  
@PM_SEQUENCE_TABLE_ID numeric(10,0),  
@valor_netx  numeric(10,0)  
as  
UPDATE PM_SEQUENCE_TABLE  
SET NEXT_SEQUENCE_ID=@valor_netx  
WHERE PM_SEQUENCE_TABLE_ID=@PM_SEQUENCE_TABLE_ID

GO

