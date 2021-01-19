Create procedure POS_ASSET_DEPUPE as 
-- automation proc for deduping assets MW03082016
DROP Table TmpSSCDupAssets
select 
a.CreatedDate,
a.SfdcId,
a.ShipDate,
a.SKU +'_' + convert(varchar(15),a.ShipQty)  +'_' + a.PONum +'_' +  convert(char(10),a.ShipDate,101) +'_' + CustomerId
+'_' + isnull(SerialNumber, '') 
 as KeyField 
--,Row_Number() over (partition by (convert(varchar(15),a.ShipQty)  +'_' + a.PONum +'_' +  convert(char(10),a.ShipDate,101))
--					Order by CreatedDate desc) as rn
 INTO TmpSSCDupAssets 
from CUSTOMER_ASSETS a inner join
(
select SfdcId
from CUSTOMERS
where PartnerId in(
select ImpactNumber from CUSTOMERS Where PartnerId = '51746'
)
) b on a.CustomerId = b.SfdcId
and a.ShipDate >= convert(char(10),'01/01/2016',101)
and PONum like '%-  From POS%'
--and SerialNumber is   null
--order by 4,5
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[POS_ASSET_DEPUPE] TO [CRAdmin]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[POS_ASSET_DEPUPE] TO [ITApps]
    AS [dbo];

