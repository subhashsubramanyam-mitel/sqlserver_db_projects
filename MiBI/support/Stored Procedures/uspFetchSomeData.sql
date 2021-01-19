create proc support.uspFetchSomeData( @i int )
as
begin
select a from (
select 1 as a
union all
select 2
union all
select 3 
union all
select 1

) x
where a = @i
end
