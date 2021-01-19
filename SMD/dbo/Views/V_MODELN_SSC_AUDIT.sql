

CREATE View [dbo].[V_MODELN_SSC_AUDIT] as 
--MW 02232017 try to find missing days based on data in Raw file
select 
	a.theDate,
	a.Day,
	b.PosLines_RawFile,
	c.PosLines_ModelN
	from
		(
		select datename(weekday,theDate)+'-'+convert(varchar(5),datepart(month,theDate))+'-'+convert(varchar(5),datepart(day,theDate)) as Day,theDate
		from TimeLookup
		where theDate >getdate()-14
	 
		) a inner join
		(
		select 
		datename(weekday,InvoiceDate)+'-'+convert(varchar(5),datepart(month,InvoiceDate))+'-'+convert(varchar(5),datepart(day,InvoiceDate)) as Day ,
		count(*) as PosLines_RawFile
		from POS_RAW_SSC_IMPORT
		where InvoiceDate >=getdate()-14
		group by datename(weekday,InvoiceDate)+'-'+convert(varchar(5),datepart(month,InvoiceDate))+'-'+convert(varchar(5),datepart(day,InvoiceDate)) , InvoiceDate
	 
		) b on a.Day = b.Day left outer join
		(
		SELECT  
			   datename(weekday,VAD_Ship_Date)+'-'+convert(varchar(5),datepart(month,VAD_Ship_Date))+'-'+convert(varchar(5),datepart(day,VAD_Ship_Date)) as Day , 
			   count(*) as PosLines_ModelN
		  FROM CORPDB.STDW.dbo.POS_TXN
		  where VAD_ID = '51746'
		  and VAD_Ship_Date >=getdate()-14
		  group by datename(weekday,VAD_Ship_Date)+'-'+convert(varchar(5),datepart(month,VAD_Ship_Date))+'-'+convert(varchar(5),datepart(day,VAD_Ship_Date)),VAD_Ship_Date

		  ) c on a.Day = c.Day

