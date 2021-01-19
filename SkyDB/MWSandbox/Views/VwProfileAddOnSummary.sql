

create view MWSandbox.VwProfileAddOnSummary as
-- MW 12142017 show add ons for quote
select aa.Id as AccountId,
isnull(a.Fax, '-') + ', ' + isnull(b.SCRIBE, '-')   + ', ' + isnull(c.CR, '-')   + ', ' + isnull(d.CONF, '-')  as Options 
from
[$(FinanceBI)].company.Account aa left outer join
(
select AccountId, 'FAX: ' + COnvert(varchar(50), count(*)) as Fax
from MWSandbox.VwSkyCustomerService
where ProductId IN
--
(18,
359)
Group By AccountId
) a on aa.Id = a.AccountId left outer join
(
select AccountId, 'SCRIBE: ' + COnvert(varchar(50), count(*)) as SCRIBE
from MWSandbox.VwSkyCustomerService
where ProductId IN
--Scribe
(116,
131)
Group By AccountId
) b on aa.Id = b.AccountId left outer join
(
select AccountId, 'CALL RECORDING: ' + COnvert(varchar(50), count(*)) as CR
from MWSandbox.VwSkyCustomerService
where ProductId IN (
-- call Recording
127,
191,
192)
Group By AccountId
) c  on aa.Id = c.AccountId left outer join

(
select AccountId, 'CONF: ' + COnvert(varchar(50), count(*)) as CONF
from MWSandbox.VwSkyCustomerService
where ProductId IN(
-- conferencing
82,
167,
168,
169,
170,
171,
172,
173,
174,
175,
176,
177,
180,
181)
Group By AccountId
) d   on aa.Id = d.AccountId  

