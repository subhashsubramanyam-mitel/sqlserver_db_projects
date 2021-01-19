

CREATE VIEW [dbo].[V_PARTNER_NPS_SFDC]
AS
--JO 08192015 now pull NPS data from SFDC/Surveys

select
	t.PartnerSTID,
	CAST(100 * (CAST(ISNULL(np.NP, 0) AS decimal(16, 2)) / CAST(t.TOTAL AS decimal(16, 2))) AS decimal(16, 0)) AS Promotors,
	CAST(100 * (CAST(ISNULL(np.NP,0) AS decimal(16, 2)) / CAST(isnull(t.TOTAL,0) AS decimal(16, 2)) - CAST(ISNULL(d.DET, 0) AS decimal(16, 2)) 
                      / CAST(isnull(t.TOTAL,0) AS decimal(16, 2))) AS decimal(16, 0)) AS SCORE, 
	CAST(100 * (CAST(ISNULL(e.PAS, 0) AS decimal(16, 2)) / CAST(t.TOTAL AS decimal(16, 2))) AS decimal(16, 0))  as Passive,
	CAST(100 * (CAST(ISNULL(d.DET, 0) AS decimal(16, 2)) / CAST(t.TOTAL AS decimal(16, 2))) AS decimal(16, 0))
					  as Detractors,
					  t.TOTAL as SVY_COUNT
FROM         (SELECT     PartnerSTID, COUNT(*) AS TOTAL
                       FROM          Surveys
                       WHERE      DataCollectionName like '%NPS%' and PartnerSTID is not NULL
					   and ResponseReceivedDate between convert(char(10), '10-01-2014',101) and convert(char(10), '10-01-2015',101)
                       GROUP BY PartnerSTID) t LEFT OUTER JOIN
                          (SELECT     PartnerSTID, COUNT(*) AS NP
                            FROM          Surveys
                            WHERE      DataCollectionName like '%NPS%' and PartnerScore >= 9
							and ResponseReceivedDate between convert(char(10), '10-01-2014',101) and convert(char(10), '10-01-2015',101)
                            GROUP BY PartnerSTID) np ON t.PartnerSTID = np.PartnerSTID LEFT OUTER JOIN
                          (SELECT     PartnerSTID, COUNT(*) AS DET
                            FROM          Surveys
                            WHERE     DataCollectionName like '%NPS%' and PartnerScore < 7
							and ResponseReceivedDate between convert(char(10), '10-01-2014',101) and convert(char(10), '10-01-2015',101)
                            GROUP BY PartnerSTID) d ON t.PartnerSTID = d.PartnerSTID  LEFT OUTER JOIN
							--passive
							 (SELECT     PartnerSTID, COUNT(*) AS PAS
                            FROM          Surveys
                            WHERE       DataCollectionName like '%NPS%' and PartnerScore in (7,8)
							and ResponseReceivedDate between convert(char(10), '10-01-2014',101) and convert(char(10), '10-01-2015',101)
                            GROUP BY PartnerSTID) e ON t.PartnerSTID = e.PartnerSTID
--Where t.PartnerSTID='50914'

