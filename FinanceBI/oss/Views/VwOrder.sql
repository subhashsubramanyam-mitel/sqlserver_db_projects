










CREATE view [oss].[VwOrder]
as select 
	O.Id OrderId,
	ORS.Name OrderRequestSource,
	O.Name OrderName, 
	CASE 
		 WHEN O.OrderTypeId = 2 and Lo.Id is not null THEN 9 -- Linked Add
		 WHEN O.Id is null THEN -1 -- Unspecified
		 ELSE O.OrderTypeId
	END as OrderTypeId,
	O.LinkedOrderId,
	O.MasterOrderId ,
	OS.Name OrderStatus,
	O.AccountId,
	O.LocationId,
	O.DateLiveScheduledOriginal,
	O.DateLiveScheduled,
	O.DateBillingStart,
	O.DateBillingStopped,
	O.OrderedById,
	coalesce(O.ProjectManagerId, O.CreatedByPersonId )ProjectManagerId,
	O.SalesPersonId,
	CASE WHEN coalesce(O.ContractNumber, LO.ContractNumber) = '' THEN NULL ELSE coalesce(O.ContractNumber, LO.ContractNumber) END ContractNumber,
	O.LichenQuoteId,
	O.LichenOrderId,
	O.IsAutoCommit,
	O.IsWebOrder,
	OC.Name OrderCloseReason,
	O.SalesForceId,
	O.CaseNumber, 
	O.OrderSubtypeId,
	Case when coalesce(O.ClientProgrammerId,0) = 0 THEN LO.ClientProgrammerId ELSE O.ClientProgrammerId END ClientProgrammerId,
	Case when coalesce(O.DataEngineerId,0) = 0 THEN LO.DataEngineerId ELSE O.DataEngineerId END DataEngineerId,
	dbo.UfnTruncateDay(Case when O.DateCreatedOriginal is null then O.DateCreated 
					Else O.DateCreatedOriginal end) DateCreated,
	O.CreatedByPersonId,
	O.DateModifiedOriginal,
	dbo.UfnTruncateDay(O.DateModified)DateModified,
	O.ModifiedByPersonId,
	Case when O.DateCreatedOriginal is null then O.DateCreated Else O.DateCreatedOriginal end 
		DateTimeCreated,
	ost.Name OrderSubType,
	CP.FirstName + ' ' + CP.LastName ClientProgrammer,
	DE.FirstName + ' ' + DE.LastName DataEngineer ,
	O.InFirstContract,
	CD.SalesContractId,
	O.IsEnforcementBypassed,
	O.MasterOrderTypeId,
	CASE WHEN O.MasterOrderTypeId = 6 and O.OrderSubtypeId in (7,8) then O.DateLiveScheduled else null end MigrationDate

from oss.[Order] O
left join enum.OrderType OT on OT.Id = O.OrderTypeId
left join enum.OrderCloseReason OC on OC.Id = O.CloseReasonId
left join enum.OrderRequestSource ORS on ORS.Id = O.OrderRequestSourceId
left join enum.OrderStatus OS on OS.Id = O.OrderStatusId
left join oss.[Order] LO on LO.Id = O.LinkedOrderId
left join enum.OrderSubtype OST on OST.Id = O.OrderSubtypeId
left join people.Person CP on CP.Id = O.ClientProgrammerId
left join people.Person DE on DE.Id = O.DataEngineerId
left join company.VwContractDetail CD on CD.SalesContractId = coalesce(O.SalesContractId, LO.SalesContractId)










