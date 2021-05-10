
CREATE OR ALTER PROCEDURE fibonacci (@liczba int)

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
		Print 'Ci¹g fibonacciego'
	print @a
	print @b
		while @i<@liczba
			Begin
				set @c=@a+@b
				print @c
				set @i=@i+1
				set @a=@b
				set @b=@c
		end
end;

EXEC fibonacci 20
