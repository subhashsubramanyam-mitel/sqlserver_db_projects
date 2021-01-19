-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-01-13
-- Description:	Sync Invoice Group
-- Change Log: 2012-09-25, tarak, Added LichenInvoiceGroupId
-- Change Log: 2014-08-29, tarak, Added AXAccountNum
-- Change Log: 2016-02-24, tarak, Added CurrencyId

-- =============================================
CREATE PROCEDURE [company].[UspSyncInvoiceGroup] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Invoice Group data';

	MERGE company.InvoiceGroup as target
	USING (
		SELECT 
			IG.Id, 
			CASE WHEN IG.Name is null or IG.Name = '' THEN 'Unspecified' ELSE IG.Name END Name,
			IG.AccountId,
			coalesce(IG.Balance,0.0) Balance,
			dbo.UfnUTCTimeToLocalDate(IG.DateBalanceSet) as DateBalanceSet_Local,
			IG.IsActive,
			IG.NeedPaperInvoice,
			IG.PayByCreditCard,
			IG.LichenInvoiceGroupId,
			IG.BillingContactid
			,IG.CurrencyId
		FROM 
			M5DB.M5DB.dbo.billing_InvoiceGroup IG with(nolock)
		WHERE
			( IG.DateModified >= @lastSync )
	) AS source
	ON target.Id = source.Id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.Name = source.Name,
			target.AccountId = source.AccountId,
			target.Balance = source.Balance,
			target.DateBalanceSet_Local = source.DateBalanceSet_Local,
			target.IsActive = source.IsActive,
			target.NeedPaperInvoice = source.NeedPaperInvoice,
			target.PayByCreditCard = source.PayByCreditCard,
			target.LichenInvoiceGroupId = source.LichenInvoiceGroupId,
			target.BillingContactid = source.BillingContactId,
			target.CurrencyId = source.CurrencyId
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( Id, Name, AccountId, Balance, DateBalanceSet_Local, 
			IsActive, NeedPaperInvoice, PayByCreditCard, LichenInvoiceGroupId, BillingContactId, CurrencyId  ) 
		VALUES ( Id, Name, AccountId, Balance, DateBalanceSet_Local, 
			IsActive, NeedPaperInvoice, PayByCreditCard, LichenInvoiceGroupId, BillingContactId, CurrencyId  )   
	OUTPUT 'Company.InvoiceGroup', $action INTO SyncChanges;

	Update IG
		set AxAccountNum = CT.ACCOUNTNUM
	from company.InvoiceGroup IG
	inner join ax.CustTable CT on ISNUMERIC(CT.STCLOUDINVOICEID)=1 and CT.STCLOUDINVOICEID = IG.Id
	;
	
	PRINT convert(varchar,getdate(),14) + N': End syncing Invoice Group data';

END
