-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 7/15/11
-- Description: the number of months (full and partial) within a period
-- CAUTION: this function RoundsUp both dates as in Lichen Billing Engine before
--          using them in computation
-- =============================================
create FUNCTION invoice.UfnFractionalMonthsInPeriod
(
	@fromDate datetime,
	@toDate datetime
)
RETURNS float
AS
BEGIN
	DECLARE @months float;
	DECLARE @firstPartialMonth float;
	DECLARE @lastPartialMonth float;
		 
	SET @FromDate = dbo.UfnRoundUpDay(@fromDate);
	SET @toDate = dbo.UfnRoundUpDay(@toDate);
	SET @months =  
		DATEDIFF(month, 
				 CASE WHEN @fromDate > dbo.UfnFirstofMonth(@fromDate) 
				          THEN dbo.UfnFirstofMonth(Dateadd(month, 1, @fromDate))
				      ELSE @fromDate
				 END,
				 @toDate);
	SET @firstPartialMonth = 
		CASE WHEN @fromDate > dbo.UfnFirstOfMonth(@fromDate) THEN
		(CAST(DATEDIFF(DAY, 
				  @fromDate, 
				  dbo.UfnFirstofMonth(Dateadd(month, 1, @fromDate))
				  )
			   as float)
				/ CAST(DATEDIFF(DAY, 
						dbo.UfnFirstofMonth(@fromDate),
						dbo.UfnFirstofMonth(Dateadd(month, 1, @fromDate))
				  )
			   as float ))
		  ELSE 0.0
		  END;
	SET @lastPartialMonth =  
			case WHEN @toDate > dbo.UfnFirstOfMonth(@toDate) THEN
			(CAST(DATEDIFF(DAY, 
					  dbo.UfnFirstOfMonth(@toDate),
					  @toDate) 
		              
				   as float)
			 / CAST(DATEDIFF(DAY, 
					  dbo.UfnFirstofMonth(@toDate),
					  dbo.UfnFirstofMonth(Dateadd(month, 1, @toDate))
					  )
				   as float ))
			  ELSE 0.0 
			  END;
	-- Return the result of the function
	RETURN @months + @firstPartialMonth + @lastPartialMonth;
END
