


/*      
****************************************************************************************************************************************
Nombre: dbo.pr_g_CadenaAleatoria
Fecha Creacion: 16/01/2020
Autor: Mauro Roque
Descripcion: store para generar contraseñas aleatorias para un usuario nuevo
Llamado por: store [pr_envia_contrasena] 
Usado por: Modulo Usuarios
Parametros: 

LEN - especifica la longitud del resultado (obligatorio)
MIN - indica el Código ASCII inicial (opcional: por omisión "48": que es el número cero)
RANGE - determina el rango de cuántos caracteres ASCII se incluirán (opcional: por omisión "74" (48 + 74 = 122) donde 122 es "z" minúscula)
EXCLUDE - un string de caracteres por excluir de la salida final (opcional: por omisión incluye cero, "O" mayúscula, estos signos de puntuación :;<=>?@[]`^\/)

Uso: 
declare @newpwd varchar(20)

-- all values between ASCII code 48 - 122 excluding defaults
exec [dbo].pr_g_CadenaAleatoria @len=8, @output=@newpwd out
select @newpwd

-- all lower case letters excluding o and l
exec [dbo].pr_g_CadenaAleatoria @len=10, @min=97, @range=25, @exclude='ol', @output=@newpwd out
select @newpwd

-- all upper case letters excluding O
exec [dbo].pr_g_CadenaAleatoria @len=12, @min=65, @range=25, @exclude='O', @output=@newpwd out
select @newpwd

-- all numbers between 0 and 9
exec [dbo].pr_g_CadenaAleatoria @len=14, @min=48, @range=9, @exclude='', @output=@newpwd out
select @newpwd

Resultados

2uR37gRq
--------------
qvffsvxzvd
--------------
IRTIFJHFFCKB
--------------
58739441336731


**********************************************************************************************************
*/

CREATE proc [dbo].pr_g_CadenaAleatoria
   @len int,
   @min tinyint = 48,
   @range tinyint = 74,
   @exclude varchar(50) = ':;[]`^',
   @output varchar(50) output
as
   declare @char char
   set @output = ''
   while @len > 0 begin
     select @char = char(round(rand() * @range + @min, 0))
     if charindex(@char, @exclude) = 0 begin
       set @output += @char
       set @len = @len - 1
     end

   end;

GO

