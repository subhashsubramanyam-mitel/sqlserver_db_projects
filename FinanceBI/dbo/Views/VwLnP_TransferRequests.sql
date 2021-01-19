

create VIEW [dbo].[VwLnP_TransferRequests]
AS
SELECT
s.Name As [Current Status],
COUNT(r.Id) AS [Number of Requests]
FROM [M5DB].[m5db].[dbo].[lnp_TransferRequestStatus] s
LEFT JOIN [M5DB].[m5db].[dbo].[lnp_TransferRequest] r ON s.Id = r.RequestStatusId
GROUP BY s.Id, s.Name


