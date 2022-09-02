CREATE proc [dbo].[pr_doc_codigo_generado_documento]
    @doc_documento_id numeric(10,0)
    as
    SELECT
    codigo
    FROM
    doc_documento
    WHERE
    is_deleted=0 and doc_Documento_id=@doc_documento_id

GO

