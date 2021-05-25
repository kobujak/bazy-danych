
CREATE FUNCTION fibonacci (@liczba int)
RETURNS @tab TABLE(liczba int, nr int)

AS

BEGIN
	declare @a int
	declare @b int
	declare @c int
	declare @i int

	set @a=0
	set @b=1
	set @i=0
	set @c=0
		insert into @tab values(@a,@i-2)
		while @i<@liczba
			Begin
				set @c=@a+@b
				
				set @i=@i+1
				set @a=@b
				set @b=@c
				insert into @tab values(@a,@i-2)
		end
		return
end;

CREATE OR ALTER PROCEDURE fib(@n INT)
AS
BEGIN
SELECT * FROM dbo.fibonacci(@liczba)
END;
EXEC fibonacci 20
