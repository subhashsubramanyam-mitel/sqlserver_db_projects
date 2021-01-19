CREATE Function [dbo].[UfnFindStringInObjects] (@string varchar(100))
returns @tbl  Table([Schema] varchar(50), Name varchar(128), [Type/Column] varchar(100))
AS 
BEGIN
insert into @tbl([Schema], Name,[Type/Column]) 
select 
OBJECT_SCHEMA_NAME(id),
name, 
ObjectType = case 
when TYPE='D' then 'Default or DEFAULT constraint' 
when TYPE='FN' then 'Scalar function' 
when TYPE='IF' then 'Inlined table-function' 
when TYPE='P' then 'Stored procedure' 
when TYPE='R' then 'Rule' 
when TYPE='RF' then 'Replication filter stored procedure' 
when TYPE='TF' then 'Table function' 
when TYPE='TR' then 'Trigger' 
when TYPE='U' then 'User table' 
when TYPE='V' then 'View' 
when TYPE='X' then 'Extended stored procedure'
else 'others'
end
 from sysobjects where id in
(select id from syscomments where text like '%'+@string+'%');
insert into @tbl([Schema], Name,[Type/Column]) 
SELECT 
SCHEMA_NAME(schema_id) AS schema_name,
t.name AS table_name,
'col: ' + c.name AS column_name
FROM sys.tables AS t
INNER JOIN sys.columns c ON t.OBJECT_ID = c.OBJECT_ID
WHERE c.name LIKE '%'+@string+'%';
return
END
