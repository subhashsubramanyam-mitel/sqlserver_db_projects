

Create view V_MCSS_ACTIVATION_SURVEY as
-- for Tableau MCSS DSx MW 12102019
select *
FROM
	Surveys
where DataCollectionName = 'Activation Self Service – Account Survey'