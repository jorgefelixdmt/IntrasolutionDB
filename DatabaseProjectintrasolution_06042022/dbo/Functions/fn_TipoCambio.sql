CREATE function [dbo].[fn_TipoCambio] (@moneda date)
returns numeric(15,3)
as
begin
declare @cambiom numeric(15,3)
set @cambiom = 3.3
return (@cambiom)
end

GO

