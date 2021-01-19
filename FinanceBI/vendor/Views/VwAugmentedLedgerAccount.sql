create view vendor.VwAugmentedLedgerAccount as
select [GL AccountNum], [GL Account name],[GL Search name] ,[GL Account type], [GL Account Grouping], [Locked in journal]
from enum.AxLedgerAccount 
union all
select 
	name [GL AccountNum],
	[Description] [GL Account name],
	[Description] [GL Search name],
	'TBD' [GL Account type],
	'TBD' [GL Account Grouping],
	'No' [Locked in journal]
from vendor.AugmentedLedgerAccount ALA
left join enum.AxLedgerAccount LA on LA.[GL AccountNum] = ALA.name 
where LA.[GL Account name] is null
