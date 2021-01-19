




CREATE view [dbo].[V_ECC_PHONE_LOOKUP] as 
-- called from Igor's partner pin DB to be used by ECC to determine Customer Type for routing
-- MW 11062019
select
		 PhoneNumber	
		,CustomerType	
		,Platform
		,Instance
from
(
select
		 FormattedPhone as PhoneNumber
		--,WorkPhone
		,CustomerType
		,[Platform]
		,Instance
		,row_number() over (partition by  FormattedPhone order by FormattedPhone    ) rn
from		
(
SELECT 
		 substring( dbo.fnRemoveNonNumericCharacters(   WorkPhone) , 1 ,11 ) as FormattedPhone
		--,WorkPhone
		,a.CustomerType
		,a.[Platform]
		,a.Instance
		--,row_number() over (partition by  substring( dbo.fnRemoveNonNumericCharacters(   WorkPhone) , 1 ,11 ) order by WorkPhone ) rn
--into  #BizPhones
  FROM 
   CUSTOMERS a (nolock) inner join
   CONTACTS b  (nolock) on a.SfdcId = b.SfdcAccountId and WorkPhone is not null
where (a.[Platform] like '%Business' or a.CustomerType = 'MiCloud Flex')
UNION ALL
SELECT 
		 substring( dbo.fnRemoveNonNumericCharacters(   MobilePhone) , 1 ,11 ) as FormattedPhone
		--,WorkPhone
		,a.CustomerType
		,a.[Platform]
		,a.Instance
		--,row_number() over (partition by  substring( dbo.fnRemoveNonNumericCharacters(   WorkPhone) , 1 ,11 ) order by WorkPhone ) rn
--into  #BizPhones
  FROM 
   CUSTOMERS a (nolock) inner join
   CONTACTS b  (nolock) on a.SfdcId = b.SfdcAccountId and MobilePhone is not null
 where a.[Platform] in  (
							'MiCloud Business',
							'MiCloud Connect',
							'SKY'
						)
-- WorkPhone
UNION ALL
SELECT 
		 substring( dbo.fnRemoveNonNumericCharacters(   WorkPhone) , 1 ,11 ) as FormattedPhone
		--,WorkPhone
		,a.CustomerType
		,a.[Platform]
		,a.Instance
		--,row_number() over (partition by  substring( dbo.fnRemoveNonNumericCharacters(   WorkPhone) , 1 ,11 ) order by WorkPhone ) rn
--into  #BizPhones
  FROM 
   CUSTOMERS a (nolock) inner join
   CONTACTS b  (nolock) on a.SfdcId = b.SfdcAccountId and WorkPhone is not null
 where a.[Platform] in  (
							'MiCloud Business',
							'MiCloud Connect',
							'SKY'
						)
UNION ALL
SELECT 
		 --b.BOSSPhone as FormattedPhone
		 substring( dbo.fnRemoveNonNumericCharacters(   b.BOSSPhone) , 1 ,11 )  as FormattedPhone
		--,WorkPhone
		,a.CustomerType
		,a.[Platform]
		,a.Instance
		--,row_number() over (partition by  b.BossPhone order by SfdcCreateDateUTC desc  ) rn
--into  #BizPhones
  FROM 
   CUSTOMERS a (nolock) inner join
   CONTACTS b  (nolock) on a.SfdcId = b.SfdcAccountId and b.BOSSPhone is not null
where a.M5DBAccountID is not null
) a
	) b 
	where rn = 1
	and LTRIM(RTRIM(PhoneNumber)) != ''


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_ECC_PHONE_LOOKUP] TO [TACECC]
    AS [dbo];

