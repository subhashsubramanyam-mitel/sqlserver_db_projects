-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-03-27
-- Description:	generate forecast SP items and then final SP items
-- =============================================
create PROCEDURE invoice.UspForecast
	@numMonths int
AS
BEGIN
	set @numMonths = CASE WHEN @numMonths is null THEN 2 ELSE @numMonths END;

	DECLARE @LastBilledMonth DateTime = dbo.UfnLastBilledMonth();
	--exec invoice.UspGenerateForecastItems @LastBilledMonth, @NumMonths;  
	truncate table invoice.ForecastSPItem;

	truncate table invoice.FinalSPItem;
	exec invoice.UspGenerateFinalSpItem null; 

	EXEC dbo.UspScrubDataForCube;


END
