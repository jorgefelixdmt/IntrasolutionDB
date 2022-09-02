/*      
<StoreProcedure>      
 <Name>      
    pr_eliminar_modulos_desuso    
 </Name>      
 <Description>      
	 Elimina modules, tables, tables_field, domain_table, master_table, se debe enviar al store el ID del rol que tiene todo configurado lo que debe quedar.
 </Description>      
 <Parameters>      
 @id id de sc_role_id  
 </Parameters>      
 <Author>      
    Carlos Cubas Landa       
 </Author>      
 <Date>      
    10-09-2019    
 </Date>      
</StoreProcedure>
pr_eliminar_modulos_desuso 1
*/

CREATE PROCEDURE [dbo].[pr_eliminar_modulos_desuso]
	@id int
As

DECLARE @module_correctos_final table (sc_module_id int)

DECLARE @module_correctos table (sc_module_id int)

DECLARE @module_eliminar table (sc_module_id int)

DECLARE @table_correctos table (sc_table_id int)

declare @table_eliminar table (sc_table_id int)

declare @domain_correctos table (sc_domain_table_id int)

declare @domain_eliminar table (sc_domain_table_id int)

declare @master_correctos table (sc_master_table_id int)

declare @master_eliminar table (sc_master_table_id int)

declare @module_correctos_temporal table (sc_module_id int)

declare @table_correctos_temporal table (sc_table_id int)

declare @table_correctos_final table (sc_table_id int)


insert into @module_correctos select sc_module_id from (

	select sc_module_id from SC_ACCESS where sc_role_id = @id

	union

	select SC_MODULE_id from SC_MODULE where MODULE_CALL in (select sc_module_id from SC_ACCESS where sc_role_id = @id)

	union

	select SC_MODULE_id from SC_MODULE where module_call in (select SC_MODULE_id from SC_MODULE where MODULE_CALL in (select sc_module_id from SC_ACCESS where sc_role_id = @id))

	union

	select SC_module_id from sc_module where module_call in (select SC_MODULE_id from SC_MODULE where module_call in (select SC_MODULE_id from SC_MODULE where MODULE_CALL in (select sc_module_id from SC_ACCESS where sc_role_id = @id)))

	union

	select sc_module_id from sc_module where module_call in (select SC_module_id from sc_module where module_call in (select SC_MODULE_id from SC_MODULE where module_call in (select SC_MODULE_id from SC_MODULE where MODULE_CALL in (select sc_module_id from SC_ACCESS where sc_role_id = @id))))


) a 


insert into @table_correctos select  sc_table_id
from SC_MODULE
where 
sc_module_id in (select sc_module_id as module_correctos from @module_correctos) and IS_DELETED <> 1 and SC_TABLE_ID is not null

select sc_table_id as table_correctos from @table_correctos

insert into @module_correctos_temporal select SUBSTRING( SUBSTRING(a.json_config, (CHARINDEX('"module_id"',a.json_config)+13),40),0,CHARINDEX('"',SUBSTRING(a.json_config, (CHARINDEX('"module_id"',a.json_config)+13),40))) as sc_module_id 
from 
SC_TABLE_FIELD a
where 
ASCii(SUBSTRING(a.json_config, (CHARINDEX('"module_id"',a.json_config)+13),1)) between 48 and 57 and a.IS_DELETED <> 1 
and a.SC_TABLE_ID in (select SC_TABLE_ID from @table_correctos)

select sc_module_id as module_correctos_temporal from @module_correctos_temporal

insert into @module_correctos_final 
select sc_module_id from @module_correctos
union
select sc_module_id from @module_correctos_temporal

select sc_module_id  as module_correctos_final from @module_correctos_final

insert into @table_correctos_temporal select  sc_table_id
from SC_MODULE
where 
sc_module_id in (select sc_module_id as module_correctos from @module_correctos_final) and sc_table_id is not null

select sc_table_id as table_correctos_temporal from @table_correctos_temporal

insert into @table_correctos_final
select sc_table_id from @table_correctos
union
select sc_table_id from @table_correctos_temporal

select sc_table_id as table_correctos_final from @table_correctos_final

insert into @domain_correctos select sc_domain_table_id
from SC_DOMAIN_TABLE
where 
(SC_TABLE_ID in (select sc_table_id from @table_correctos_final) OR SC_TABLE_ID is NULL) and IS_DELETED <> 1

insert into @master_correctos select sc_master_table_id
from SC_MASTER_TABLE
where
SC_DOMAIN_TABLE_ID in (select SC_DOMAIN_TABLE_ID from @domain_correctos)

-------------------------------------------------------almacenar eliminados---------------------------------------
insert into @module_eliminar select sc_module_id
from sc_module
where
sc_module_id not in (select sc_module_id as module_correctos from @module_correctos_final) and IS_LEAF = 1

insert into @table_eliminar select sc_table_id
from sc_table
where
sc_table_id not in (select sc_table_id from @table_correctos_final)

select sc_table_id as table_eliminar from @table_eliminar

insert into @domain_eliminar select SC_DOMAIN_TABLE_id
from SC_DOMAIN_TABLE
where
SC_DOMAIN_TABLE_ID not in (select SC_DOMAIN_TABLE_ID from @domain_correctos)

insert into @master_eliminar select SC_MASTER_TABLE_id
from SC_MASTER_TABLE
where
SC_MASTER_TABLE_ID not in (select SC_MASTER_TABLE_ID from @master_correctos)


select count(*) as table_field_antes from SC_TABLE_FIELD
delete from SC_TABLE_FIELD where SC_TABLE_ID in (select sc_table_id from @table_eliminar)
select count(*) as table_field_despues from SC_TABLE_FIELD

select count(*) as master_antes from SC_MASTER_TABLE
delete from SC_MASTER_TABLE where SC_MASTER_TABLE_ID in (select SC_MASTER_TABLE_ID from @master_eliminar)
select count(*) as master_despues from SC_MASTER_TABLE

select count(*) as domain_antes from SC_DOMAIN_TABLE
delete from SC_DOMAIN_TABLE where SC_DOMAIN_TABLE_ID in (select SC_DOMAIN_TABLE_ID from @domain_eliminar)
select count(*) as domain_despues from SC_DOMAIN_TABLE

select count(*) as module_antes from SC_MODULE
delete from SC_MODULE where SC_MODULE_ID in (select SC_MODULE_ID from @module_eliminar)
select count(*) as module_despues from SC_MODULE

select count(*) as table_antes from SC_TABLE
delete from SC_TABLE where SC_TABLE_ID in (select SC_TABLE_ID from @table_eliminar)
select count(*) as table_despues from SC_TABLE

GO

