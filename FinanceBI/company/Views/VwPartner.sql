create view company.VwPartner
as select A.Name Parnter, P.* from company.Partner P
inner join company.Account A on A.Id = P.AccountId
