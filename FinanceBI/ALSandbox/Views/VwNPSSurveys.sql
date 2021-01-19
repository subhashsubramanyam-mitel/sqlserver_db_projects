--DROP VIEW ALSandbox.VwNPSSurveys

CREATE VIEW  ALSandbox.VwNPSSurveys AS

SELECT [ID]
      ,S.[AccountID]
      ,Map.M5dbAccountId
      ,S.[ContactID]
      ,[CreatedDate]
      ,[OrigAccountId]
      ,[PrimaryComment]
      ,[PrimaryScore]
      ,[ResponseReceivedDate]
      ,[Status]
      ,[StatusDesc]
	  ,FName
	  ,LName
	  ,BOSSContactRole
  FROM [sfdc].[VwSurveys] S
  INNER JOIN FinanceBI.sfdc.VwAccountMap Map
	ON S.AccountID COLLATE SQL_Latin1_General_CP1_CS_AS = Map.SfdcId COLLATE SQL_Latin1_General_CP1_CS_AS
  LEFT JOIN [$(MiBI)].[dbo].[CONTACTS] C
	ON C.SfdcId COLLATE SQL_Latin1_General_CP1_CS_AS = S.ContactID COLLATE SQL_Latin1_General_CP1_CS_AS
  WHERE Year(CreatedDate) >= 2015
	AND S.AccountID IS NOT NULL
	AND lower(DataCollectionName) LIKE '%nps%'
	AND [Status] NOT IN ('Skipped', 'Failure', 'Bounced', 'Invitation Not Sent')

