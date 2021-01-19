


CREATE VIEW [dbo].[V_TAC_SLA]
AS
 


SELECT InSLA,SR_NUM,LastSLAActivity,End_User,Status,Severity,Feature,SubFeatComp,Owner,Priority,Date_Open,SR_TITLE,Sub_Status,SR_AREA,Partner,SR_Version,Support_Prog_for_SR,subquery.ContactId,DSLT,"Days Open","SR Work Group",Employees.Team,Employees.JobTitle,Employees.EmpGroup,CONTACTS.WorkPhone AS SR_Contact_Phone, CONTACTS.FName AS SR_Contact_FName, CONTACTS.LName AS SR_Contact_LName, CONTACTS.Email AS SR_Contact_Email 
,AdvQCall
FROM (SELECT CASE WHEN DATEDIFF(hour,(CASE WHEN LEFT(DATENAME(WEEKDAY,b.Date_Open),3) ='Sat' 
    THEN DATEADD(DAY,2,b.Date_Open) 
WHEN LEFT(DATENAME(WEEKDAY,b.Date_Open),3) ='Sun' 
    THEN DATEADD(DAY,1,b.Date_Open) 
ELSE b.Date_Open END),GETDATE()) <= 24 THEN 'Yes' ELSE (CASE WHEN b.Severity IN('High','Critical') AND (DATEDIFF(hour,(CASE WHEN LEFT(DATENAME(WEEKDAY,a.LastAct),3) ='Sat' 
    THEN DATEADD(DAY,2,a.LastAct) 
WHEN LEFT(DATENAME(WEEKDAY,a.LastAct),3) ='Sun' 
    THEN DATEADD(DAY,1,a.LastAct) 
ELSE a.LastAct END),GETDATE()) <=24) THEN 'Yes' ELSE CASE WHEN b.Severity='Medium' AND (DATEDIFF(hour,(CASE WHEN LEFT(DATENAME(WEEKDAY,a.LastAct),3) ='Sat' 
    THEN DATEADD(DAY,2,a.LastAct) 
WHEN LEFT(DATENAME(WEEKDAY,a.LastAct),3) ='Sun' 
    THEN DATEADD(DAY,1,a.LastAct) 
ELSE a.LastAct END),GETDATE()) <=3*24) THEN 'Yes' ELSE CASE WHEN b.Severity='Low' AND (DATEDIFF(hour,(CASE WHEN LEFT(DATENAME(WEEKDAY,a.LastAct),3) ='Sat' 
    THEN DATEADD(DAY,2,a.LastAct) 
WHEN LEFT(DATENAME(WEEKDAY,a.LastAct),3) ='Sun' 
    THEN DATEADD(DAY,1,a.LastAct) 
ELSE a.LastAct END),GETDATE()) <=7*24) THEN 'Yes' ELSE 'No' END END END) END AS 'InSLA',b.SR_NUM,(CASE WHEN LEFT(DATENAME(WEEKDAY,a.LastAct),3) ='Sat' 
    THEN DATEADD(DAY,2,a.LastAct) 
WHEN LEFT(DATENAME(WEEKDAY,a.LastAct),3) ='Sun' 
    THEN DATEADD(DAY,1,a.LastAct) 
ELSE a.LastAct END) AS LastSLAActivity, b.End_User,b.Status,
b.Severity,b.Feature,b.SubFeatComp,b.Owner,b.Priority,b.Date_Open,
b.SR_TITLE,b.Sub_Status,b.SR_AREA,b.Partner,b.SR_Version, 
b.Support_Prog_for_SR, b.ContactId,DATEDIFF(day,convert(varchar(10),a.LastAct,101),convert(varchar(10),GETDATE(),101)) AS 'DSLT', DATEDIFF(day,convert(varchar(10),Date_Open,101),convert(varchar(10),GETDATE(),101)) AS 'Days Open', CASE WHEN Sub_Status LIKE ('%[Ww]aiting%') THEN 'Customer_Partner' ELSE CASE WHEN Sub_Status LIKE ('%OEM%') THEN 'OEM Engineering' ELSE CASE WHEN (Status NOT IN ('Closed','Engineering Help')) OR Sub_Status IN ('Support Help','Support Help Pending','Pending Recreation') THEN 'TAC' ELSE 'Engineering' END END END AS 'SR Work Group'
 ,b.AdvQCall
 FROM 
 (SELECT V_ECC_INFO.SR_NUM,V_ECC_INFO.Status,V_ECC_INFO.Feature,V_ECC_INFO.SubFeatComp,V_ECC_INFO.Owner,
 V_ECC_INFO.Priority,V_ECC_INFO.Date_Open,V_ECC_INFO.Severity,V_ECC_INFO.SR_TITLE,V_ECC_INFO.Sub_Status,
 V_ECC_INFO.SR_AREA, Partner, End_User, SR_Version, Support_Prog_for_SR, ContactId ,  SR_HEADER.AdvQCall
 FROM V_ECC_INFO INNER JOIN SR_HEADER ON V_ECC_INFO.SR_NUM=SR_HEADER.SR_NUM) AS b 
 LEFT JOIN (SELECT SR_NUM, MAX(CREATED) AS LastAct FROM 
 dbo.SR_ACTIVITY WHERE (Internal NOT IN('Internal') OR Internal IS NULL) AND Type NOT IN  ('Web Update') GROUP BY SR_NUM) AS a ON a.SR_NUM=b.SR_NUM 
 WHERE b.Status <> ('Closed') AND b.SR_AREA NOT LIKE ('%Enhancement%') )AS subquery LEFT JOIN Employees ON subquery.Owner=Employees.Login
JOIN CONTACTS ON subquery.ContactId=CONTACTS.ContactId




GO
GRANT SELECT
    ON OBJECT::[dbo].[V_TAC_SLA] TO [CANDY\MEdwards]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_TAC_SLA] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_TAC_SLA] TO [CANDY\CStewart]
    AS [dbo];

