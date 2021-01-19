


-- EXEC [support].[UspLoadMiCustomerSentiment]
CREATE PROCEDURE [support].[UspLoadMiCustomerSentiment]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT cu.[SfdcId] AS AccountId
		,cu.[NAME] AS AccountName
		,cu.[Platform]
		,cu.[AccountTeam]
		,cu.[CustomerType]
		,cu.Theater
		,cu.Region
		,cu.Instance
		,cu.DiscountType
		,cu.Cust_Disc
		,cu.AtRiskNow
		,cu.ActiveMRR_Boss
		,cu.CSM
		,cu.Created AS 'AccountCreationDate'
		,l.ActivationDate
		,c.ID AS CaseID
		,c.CaseNumber
		,c.CreatedDate
		,c.ClosedDate
		,c.FCR
		,c.[Status]
		,c.AtRisk
		,c.CaseOrigin
		,c.CaseOwnerRole
		,c.CaseOwner
		,c.ATEscalation
		,c.CaseReason
	INTO #MiCustomer
	FROM dbo.CUSTOMERS cu(NOLOCK)
	LEFT OUTER JOIN (
		SELECT Account__c
			,MIN(boss_Location_Live__c) AS ActivationDate
		FROM dbo.Location(NOLOCK)
		GROUP BY Account__c
		) l ON l.Account__c = cu.SfdcId
	INNER JOIN dbo.Cases c(NOLOCK) ON c.AccountID = cu.SfdcId
	WHERE cu.CustomerType in ('CLOUD','Legacy Cloud','HYBRID Sites')
		AND cu.[Status] = 'Active'
		AND c.CreatedDate >= '2020-01-01';

	TRUNCATE TABLE [support].[MiCustomerSentiment];

	INSERT INTO [support].[MiCustomerSentiment] (
		[AccountId]
		,[AccountName]
		,[Platform]
		,[AccountTeam]
		,[CustomerType]
		,[Theater]
		,[Region]
		,[Instance]
		,[DiscountType]
		,[Cust_Disc]
		,[AtRiskNow]
		,[ActiveMRR_Boss]
		,[CSM]
		,[AccountCreationDate]
		,[ActivationDate]
		,[CaseId]
		,[CaseNumber]
		,[CreatedDate]
		,[ClosedDate]
		,[FCR]
		,[Status]
		,[AtRisk]
		,[CaseOrigin]
		,[CaseOwnerRole]
		,[CaseOwner]
		,[ATEscalation]
		,[CaseReason]
		,[TransactionId]
		,[TransactionBy]
		,[TransactionEmail]
		,[Transaction Date]
		,[MicsPositive]
		,[MicsNegative]
		,[MicsNeutral]
		,[MicsMax]
		,[MicsEmotion]
		,[FinalScore]
		,[TransactionType]
		)
	SELECT m.AccountId
		,m.AccountName
		,m.[Platform]
		,m.[AccountTeam]
		,m.[CustomerType]
		,m.Theater
		,m.Region
		,m.Instance
		,m.DiscountType
		,m.Cust_Disc
		,m.AtRiskNow
		,m.ActiveMRR_Boss
		,m.CSM
		,m.AccountCreationDate
		,m.ActivationDate
		,m.CaseID
		,m.CaseNumber
		,m.CreatedDate
		,m.ClosedDate
		,m.FCR
		,m.[Status]
		,m.AtRisk
		,m.CaseOrigin
		,m.CaseOwnerRole
		,m.CaseOwner
		,m.ATEscalation
		,m.CaseReason
		,cc.CaseCommentId
		,uc.Name
		,uc.Email
		,cc.CreatedDate AS 'Comment Date'
		,cc.MicsPositive AS 'CaseComment_MicsPositive'
		,cc.MicsNegative AS 'CaseComment_MicsNegative'
		,cc.MicsNeutral AS 'CaseComment_MicsNeutral'
		,cc.MicsMax AS 'CaseComment_MicsMax'
		,cc.MicsEmotion AS 'CaseComment_MicsEmotion'
		,DIFFERENCE(cc.MicsPositive, cc.MicsNegative) AS 'FinalCommentScore'
		,'CaseComment' AS TransactionType
	FROM #MiCustomer m
	INNER JOIN dbo.CaseComment cc(NOLOCK) ON cc.CaseId = m.CaseID
	INNER JOIN dbo.Users uc(NOLOCK) ON uc.ID = cc.CreatedById
	WHERE cc.IsPublished = 1
		AND cc.CreatedDate >= '2020-01-01';
		

	INSERT INTO [support].[MiCustomerSentiment] (
		[AccountId]
		,[AccountName]
		,[Platform]
		,[AccountTeam]
		,[CustomerType]
		,[Theater]
		,[Region]
		,[Instance]
		,[DiscountType]
		,[Cust_Disc]
		,[AtRiskNow]
		,[ActiveMRR_Boss]
		,[CSM]
		,[AccountCreationDate]
		,[ActivationDate]
		,[CaseId]
		,[CaseNumber]
		,[CreatedDate]
		,[ClosedDate]
		,[FCR]
		,[Status]
		,[AtRisk]
		,[CaseOrigin]
		,[CaseOwnerRole]
		,[CaseOwner]
		,[ATEscalation]
		,[CaseReason]
		,[TransactionId]
		,[TransactionBy]
		,[TransactionEmail]
		,[Transaction Date]
		,[MicsPositive]
		,[MicsNegative]
		,[MicsNeutral]
		,[MicsMax]
		,[MicsEmotion]
		,[FinalScore]
		,[TransactionType]
		)
	SELECT m.AccountId
		,m.AccountName
		,m.[Platform]
		,m.[AccountTeam]
		,m.[CustomerType]
		,m.Theater
		,m.Region
		,m.Instance
		,m.DiscountType
		,m.Cust_Disc
		,m.AtRiskNow
		,m.ActiveMRR_Boss
		,m.CSM
		,m.AccountCreationDate
		,m.ActivationDate
		,m.CaseID
		,m.CaseNumber
		,m.CreatedDate
		,m.ClosedDate
		,m.FCR
		,m.[Status]
		,m.AtRisk
		,m.CaseOrigin
		,m.CaseOwnerRole
		,m.CaseOwner
		,m.ATEscalation
		,m.CaseReason
		,l.LiveChatTranscriptId
		,ul.Name
		,ul.Email
		,l.CreatedDate AS 'Chat Date'
		,l.MicsPositive AS 'Chat_MicsPositive'
		,l.MicsNegative AS 'Chat_MicsNegative'
		,l.MicsNeutral AS 'Chat_MicsNeutral'
		,l.MicsMax AS 'Chat_MicsMax'
		,l.MicsEmotion AS 'Chat_MicsEmotion'
		,DIFFERENCE(l.MicsPositive, l.MicsNegative) AS 'FinalChatScore'
		,'Chat' AS TransactionType
	FROM #MiCustomer m
	INNER JOIN dbo.LiveChatTranscript l(NOLOCK) ON l.CaseId = m.CaseID
	INNER JOIN dbo.Users ul(NOLOCK) ON ul.ID = l.CreatedById
	WHERE l.CreatedDate >= '2020-01-01';

	INSERT INTO [support].[MiCustomerSentiment] (
		[AccountId]
		,[AccountName]
		,[Platform]
		,[AccountTeam]
		,[CustomerType]
		,[Theater]
		,[Region]
		,[Instance]
		,[DiscountType]
		,[Cust_Disc]
		,[AtRiskNow]
		,[ActiveMRR_Boss]
		,[CSM]
		,[AccountCreationDate]
		,[ActivationDate]
		,[CaseId]
		,[CaseNumber]
		,[CreatedDate]
		,[ClosedDate]
		,[FCR]
		,[Status]
		,[AtRisk]
		,[CaseOrigin]
		,[CaseOwnerRole]
		,[CaseOwner]
		,[ATEscalation]
		,[CaseReason]
		,[TransactionId]
		,[TransactionBy]
		,[TransactionEmail]
		,[Transaction Date]
		,[MicsPositive]
		,[MicsNegative]
		,[MicsNeutral]
		,[MicsMax]
		,[MicsEmotion]
		,[FinalScore]
		,[TransactionType]
		)
	SELECT m.AccountId
		,m.AccountName
		,m.[Platform]
		,m.[AccountTeam]
		,m.[CustomerType]
		,m.Theater
		,m.Region
		,m.Instance
		,m.DiscountType
		,m.Cust_Disc
		,m.AtRiskNow
		,m.ActiveMRR_Boss
		,m.CSM
		,m.AccountCreationDate
		,m.ActivationDate
		,m.CaseID
		,m.CaseNumber
		,m.CreatedDate
		,m.ClosedDate
		,m.FCR
		,m.[Status]
		,m.AtRisk
		,m.CaseOrigin
		,m.CaseOwnerRole
		,m.CaseOwner
		,m.ATEscalation
		,m.CaseReason
		,em.EmailMessageId
		,em.[FromName] AS 'Email_CreatedBy'
		,em.FromAddress
		,em.MessageDate AS 'Email_Date'
		,em.MicsPositive AS 'Email_MicsPositive'
		,em.MicsNegative AS 'Email_MicsNegative'
		,em.MicsNeutral AS 'Email_MicsNeutral'
		,em.MicsMax AS 'Email_MicsMax'
		,em.MicsEmotion AS 'Email_MicsEmotion'
		,DIFFERENCE(em.MicsPositive, em.MicsNegative) AS 'FinalEmailScore'
		,'Email' AS 'TransactionType'
	--into support.EmailSentiment
	FROM #MiCustomer m
	INNER JOIN dbo.EmailMessage em(NOLOCK) ON em.CaseId = m.CaseID
	--INNER JOIN dbo.Users uem(NOLOCK) ON uem.ID = em.CreatedById
	WHERE em.CreatedDate >= '2020-01-01'
		AND em.IsIncoming = 1;

	DROP TABLE #MiCustomer;

END
