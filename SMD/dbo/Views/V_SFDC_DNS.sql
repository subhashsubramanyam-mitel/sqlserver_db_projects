
create view V_SFDC_DNS as 
--MW 11-15-2016  Cast Iron View
select *,
			       CASE
        WHEN MONTH([InvoiceDate] ) BETWEEN 1  AND 3  THEN convert(char(4), YEAR([InvoiceDate]) ) + '-Q3'
        WHEN MONTH([InvoiceDate]) BETWEEN 4  AND 6  THEN convert(char(4), YEAR([InvoiceDate]) ) + '-Q4'
        WHEN MONTH([InvoiceDate]) BETWEEN 7  AND 9  THEN convert(char(4), YEAR([InvoiceDate]) + 1) + '-Q1'
        WHEN MONTH([InvoiceDate]) BETWEEN 10 AND 12 THEN convert(char(4), YEAR([InvoiceDate]) + 1) + '-Q2'
    END As FYear,
convert(varchar(4), YEAR(InvoiceDate))  + '-M' + RIGHT('00' + CONVERT(NVARCHAR(2), DATEPART(MM, InvoiceDate)), 2) as CMonth
 from SFDC_DNS_BILLING_TRK
where Status = 'N'
 
