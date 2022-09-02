CREATE TABLE [dbo].[fnz_venta] (
    [fnz_venta_id]                  NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [fecha_factura]                 DATETIME        NULL,
    [numero_factura]                VARCHAR (50)    NULL,
    [pry_proyecto_id]               NUMERIC (10)    NULL,
    [concepto_factura]              VARCHAR (MAX)   NULL,
    [moneda]                        VARCHAR (10)    NULL,
    [fecha_tipo_cambio]             DATETIME        NULL,
    [monto_tipo_cambio]             NUMERIC (15, 2) NULL,
    [monto_soles]                   NUMERIC (15, 2) NULL,
    [monto_dolares]                 NUMERIC (15, 2) NULL,
    [monto_impuesto_soles]          NUMERIC (15, 2) NULL,
    [monto_impuesto_dolares]        NUMERIC (15, 2) NULL,
    [monto_total_soles]             NUMERIC (15, 2) NULL,
    [monto_total_venta_dolares]     NUMERIC (15, 2) NULL,
    [fb_empresa_cuenta_bancaria_id] NUMERIC (10)    NULL,
    [fnz_movimiento_bancario_id]    NUMERIC (10)    NULL,
    [fnz_voucher_id]                NUMERIC (10)    NULL,
    [fb_empresa_id]                 NUMERIC (10)    NULL,
    [flag_retencion]                NUMERIC (1)     NULL,
    [fnz_estado_venta_id]           NUMERIC (10)    NULL,
    [created]                       DATETIME        NULL,
    [created_by]                    NUMERIC (10)    NULL,
    [updated]                       DATETIME        NULL,
    [updated_by]                    NUMERIC (10)    NULL,
    [owner_id]                      NUMERIC (10)    NULL,
    [is_deleted]                    NUMERIC (1)     NULL,
    [archivo]                       VARCHAR (200)   NULL,
    [fb_cliente_id]                 NUMERIC (10)    NULL,
    [hes]                           VARCHAR (400)   NULL,
    [archivo_hes]                   VARCHAR (200)   NULL,
    [observacion]                   VARCHAR (MAX)   NULL,
    [fecha_pago_estimado]           DATETIME        NULL,
    [fecha_pago_real]               DATETIME        NULL,
    CONSTRAINT [PK_fnz_venta] PRIMARY KEY CLUSTERED ([fnz_venta_id] ASC)
);


GO



-- =============================================
-- Author:		Mauro Roque
-- Create date: 06/11/2020
-- Description: Un proyecto puede colocarse como INACTIVO cuando se ha facturado el total del monto del proyecto
-- =============================================
create TRIGGER tr_venta_update
   ON  fnz_venta
   AFTER insert,update 
AS 
BEGIN
declare @id_proyecto int
declare @total_mont_s numeric(15,3),@total_mont_d numeric(15,3)
declare @total_mont_s_pro numeric(15,3),@total_mont_d_pro numeric(15,3)

set @id_proyecto = (select pry_proyecto_id from inserted)

set @total_mont_s = ( select sum (monto_soles) from fnz_venta where pry_proyecto_id =@id_proyecto )
set @total_mont_d = ( select sum (monto_dolares) from fnz_venta where pry_proyecto_id =@id_proyecto )

set @total_mont_s_pro = ( select monto_soles from pry_proyecto where pry_proyecto_id =@id_proyecto )	
set @total_mont_d_pro = ( select monto_dolares from pry_proyecto where pry_proyecto_id =@id_proyecto )	

if  (@total_mont_s>=@total_mont_s_pro)
begin
	update pry_proyecto
	set estado=0 -- inactivo
	where pry_proyecto_id = @id_proyecto
end
if  (@total_mont_d>=@total_mont_d_pro)
begin
	update pry_proyecto
	set estado=0 -- inactivo
	where pry_proyecto_id = @id_proyecto
end

END

GO

