
-- =============================================
-- JO 01132015 Cleans up bad date for ArenaItemTrk table
-- ============================================= 

CREATE PROCEDURE   [dbo].[CleanArenaItemTrk] AS


update ArenaItemTrk set EffectiveDateActual=r.EffectiveDateActual
from
(
select 
number,
CASE WHEN LEN(parsename(replace(EffectiveDate,'/','.'),1)) <>4 then NULL
	ELSE EffectiveDate END as EffectiveDateActual
from ArenaItemTrk
) r
Where ArenaItemTrk.number=r.number



