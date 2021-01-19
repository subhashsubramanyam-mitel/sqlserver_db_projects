
CREATE VIEW [dbo].[V_SC_PartnerNPS]
AS

SELECT     
		t.SE_ID, 
CAST(100 * (CAST(ISNULL(np.NP, 0) AS decimal(16, 2)) / CAST(t.TOTAL AS decimal(16, 2))) AS decimal(16, 0)) AS Promotors, 
        CAST(100 * (CAST(ISNULL(np.NP,0) AS decimal(16, 2)) / CAST(isnull(t.TOTAL,0) AS decimal(16, 2)) - CAST(ISNULL(d.DET, 0) AS decimal(16, 2)) 
                      / CAST(isnull(t.TOTAL,0) AS decimal(16, 2))) AS decimal(16, 0)) AS SCORE, 
								CAST(100 * (CAST(ISNULL(e.PAS, 0) AS decimal(16, 2)) / CAST(t.TOTAL AS decimal(16, 2))) AS decimal(16, 0))
					  as Passive, 
	
				CAST(100 * (CAST(ISNULL(d.DET, 0) AS decimal(16, 2)) / CAST(t.TOTAL AS decimal(16, 2))) AS decimal(16, 0))
					  as Detractors, 				  
--					 isnull( d.DET,0) as DET, 
					  t.TOTAL as SVY_COUNT
FROM         (SELECT     SE_ID, COUNT(*) AS TOTAL
                       FROM          V_PartnerSvyNPS
                       WHERE      SE_ID is not NULL
						AND SvyDate between convert(char(10), '10-01-2016',101) and convert(char(10), '10-01-2017',101)
                       GROUP BY SE_ID) t LEFT OUTER JOIN
                          (SELECT     SE_ID, COUNT(*) AS NP
                            FROM          V_PartnerSvyNPS
                            WHERE      Score >= 9
							and SvyDate between convert(char(10), '10-01-2016',101) and convert(char(10), '10-01-2017',101)
                            GROUP BY SE_ID) np ON t.SE_ID = np.SE_ID LEFT OUTER JOIN
                          (SELECT     SE_ID, COUNT(*) AS DET
                            FROM          V_PartnerSvyNPS
                            WHERE      Score < 7
							and SvyDate between convert(char(10), '10-01-2016',101) and convert(char(10), '10-01-2017',101)
                            GROUP BY SE_ID) d ON t.SE_ID = d.SE_ID  LEFT OUTER JOIN
							--passive
							 (SELECT     SE_ID, COUNT(*) AS PAS
                            FROM          V_PartnerSvyNPS
                            WHERE      Score in (7,8)
							and SvyDate between convert(char(10), '10-01-2016',101) and convert(char(10), '10-01-2017',101)
                            GROUP BY SE_ID) e ON t.SE_ID = e.SE_ID