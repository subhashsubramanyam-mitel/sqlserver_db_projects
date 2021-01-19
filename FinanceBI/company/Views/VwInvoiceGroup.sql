create VIEW company.VwInvoiceGroup
AS
SELECT     PayByCreditCard, NeedPaperInvoice, IsActive, DateBalanceSet_Local, COALESCE (Balance, 0.0) AS Balance, Id, AccountId, COALESCE (Name, '') 
                      AS Name, LichenInvoiceGroupId, AxAccountNum
FROM         company.InvoiceGroup
