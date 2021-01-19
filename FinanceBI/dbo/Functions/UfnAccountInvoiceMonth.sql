
-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2018-11-16
-- Description: composite bigint key from AccountId and InvoiceMonth
-- =============================================
create FUNCTION [dbo].UfnAccountInvoiceMonth (
 @AccountId    int,
 @InvMonth	date

 )
RETURNS bigint
AS
BEGIN
	DECLARE @RD bigint  = (@AccountId * 10000)+DateDiff(month, '1990-01-01',  @InvMonth)
	
    RETURN @RD;
END

