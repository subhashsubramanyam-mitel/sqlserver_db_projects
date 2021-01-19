
create view [cdr].[VwSpecialCalls] as
select * from cdr.SpecialCalls
where CdrCallTypeid  <> 5;

