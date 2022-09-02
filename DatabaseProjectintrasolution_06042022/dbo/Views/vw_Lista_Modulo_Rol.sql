
--Creación de la vista para el reporte SC_Modulo_ROL
create View vw_Lista_Modulo_Rol
As
Select 
	sm.ITEM_ORDER as ORDER_SM,
	m.ITEM_ORDER as ORDER_M,
	sm.SC_SUPER_MODULE_ID,
	rol.NAME as ROL,
	m.SC_MODULE_id,
	m.NAME  as MODULO,
	dbo.uf_Ruta_Modulo(m.SC_MODULE_id) as Ruta,
	acc.SC_ACCESS_TYPE_ID,
	Case acc.SC_ACCESS_TYPE_ID
		When '2' then 'L'
		When '3' then 'T'
	End
		As TipoAcceso
from SC_ACCESS acc 
	inner join SC_MODULE m on m.SC_MODULE_ID = acc.SC_MODULE_ID
	inner join SC_ROLE rol on rol.SC_ROLE_ID = acc.SC_ROLE_ID
	left join SC_SUPER_MODULE sm on sm.SC_SUPER_MODULE_id = m.SC_SUPER_MODULE_ID 
Where 
	rol.IS_DELETED = 0 and
	m.IS_DELETED = 0 and  -- NO ESTA BORRADO
	m.IS_VISIBLE = 1 and  -- ES VISIBLE
	m.IS_LEAF = 1 and --- ES MODULO 
	m.SC_MODULE_TYPE_ID = 1 and -- MODULO PRINCIPAL
	(m.SC_MODULE_ID is not null and m.SC_SUPER_MODULE_id is not null)  and
	m.SC_SUPER_MODULE_ID <> 1

GO

