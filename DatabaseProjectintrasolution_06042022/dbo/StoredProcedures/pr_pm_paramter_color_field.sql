create proc [dbo].[pr_pm_paramter_color_field]
@parametro int
as
select
value
from pm_parameter
where code='CAMPOS_LECTURA_COLOR' and @parametro=1

GO

