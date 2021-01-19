
-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2012-04-16
-- Description: returns the MRR Category based on parameters
-- =============================================
CREATE FUNCTION [enum].[UfnMRRCategory]
(
    @IACPCategory nvarchar(50),
    @OrderTypeId int, 
	@MasterOrderTypeId int,
	@MonthMRRFirstInvoiced date,
	@NumMRRItemsBilled int,
	@InvoiceMonth date
)
RETURNS nvarchar(50)
AS
BEGIN
	
	RETURN CASE 
	-- Migration dominates starting Q4 FY 2017
			WHEN @InvoiceMonth >= '2017-05-01' and @IACPCategory in ('Install', 'Anomaly') and @MasterOrderTypeId = 6 
				THEN 'Migrate In'
			WHEN @InvoiceMonth >= '2017-05-01' and @IACPCategory  = 'Close' and @MasterOrderTypeId = 6 
				THEN 'Migrate Out'
			WHEN @IACPCategory = 'Install' and @OrderTypeId = 2 
				THEN 'Add' 
			WHEN @IACPCategory = 'Anomaly' and @MonthMRRFirstInvoiced is null and @OrderTypeId = 2 
				THEN 'Add' 
			WHEN @IACPCategory = 'Anomaly' and @MonthMRRFirstInvoiced is null and @OrderTypeId <> 2 
				THEN 'Install' 
			WHEN @IACPCategory = 'Anomaly' and @MonthMRRFirstInvoiced is not null  
				THEN 'Reinstated' 
			WHEN @IACPCategory = 'Close' and @NumMRRItemsBilled = 0
				THEN 'Cancel - Ac Close' 
			WHEN @IACPCategory = 'Close' and @NumMRRItemsBilled > 0
				THEN 'Cancel - Downsize'
			ELSE @IACPCategory 
		END;	

END

