

CREATE PROCEDURE [dbo].[SetAcademyAttribs] AS

-- Called from LMS Loader.  Updates Mob and CC Sell/Support Attributes based on LMS and other data.

--SSCA
update LMS_ACADEMY set SSCA = '1' where Email IN
(
select Email from LMS_ACADEMY
	where 
(		        --BR001 > 0 AND
                --CS100 > 0  AND
				SSCA000 > 0
)
)

--SSCE
update LMS_ACADEMY set SSCE = '1' where Email IN
(
select Email from LMS_ACADEMY
	where 
(		        --BR001 > 0 AND
                --BR002 > 0 AND
                --BR002e > 0 AND
                --CS100 > 0 AND
				--CS103 > 0 AND 
                --BR004 > 0 AND
				--BR201 > 0 AND
				--BR008 > 0 AND
				--BR800c > 0 AND
				--CS109 > 0 AND
				SSCE000 > 0
)
)

--SSO
update LMS_ACADEMY set SSO = '1' where Email IN
(
select Email from LMS_ACADEMY
	where 
(		        --BR001 > 0 AND
                --BR002 > 0 AND
                --OS100 > 0 AND
                --OS105 > 0 AND
                --BR004 > 0 AND
                --OS107 > 0 AND
                --OS102 > 0 AND
                --BR201 > 0 AND
                --BR008 > 0 AND
				--BR800c > 0 AND
                SSO000 > 0 
)
)

--SSA
update LMS_ACADEMY set SSA = '1' where Email IN
(
select Email from LMS_ACADEMY
	where 
(		        --BR001 > 0 AND
                --BR002 > 0 AND
                --CS100 > 0 AND  --SSA (US only requirement)
                --OS100 > 0 AND
                --OS105 > 0 AND
                --BR004 > 0 AND
				--BR006 > 0 AND	--SSA
                --OS107 > 0 AND
                --OS102 > 0 AND
                --BR201 > 0 AND
				--OS108 > 0 AND	--SSA
                --BR008 > 0 AND
                --BR800c > 0 AND
				SSA000 > 0
)
)


--SESO
update LMS_ACADEMY set SESO = '1' where Email IN
(
select Email from LMS_ACADEMY
	where 
(		        --OS300 > 0 AND
                --OS301 > 0  AND
				SESO000 > 0
)
)

--SESA
update LMS_ACADEMY set SESA = '1' where Email IN
(
select Email from LMS_ACADEMY
	where 
(		        --OS300 > 0 AND
                --CS300 > 0 AND --(US only requirement)
                --OS301 > 0 AND 
                --OS305 > 0 AND
				--OS305e > 0 AND 
                --OT302 > 0 AND
				--OT303 > 0 AND
				--OT304 > 0 AND
				--OT306 > 0 AND
				--OT307 > 0 AND
				SESA000 > 0
)
)

--DemoSkills
update LMS_ACADEMY set DemoSkills = '1' where Email IN
(
select Email from LMS_ACADEMY
	where 
(		        BR008c > 0  
)
)

--UCSI
update LMS_ACADEMY set UCSI = '1' where Email IN
(
select Email from LMS_ACADEMY
	where 
(		        --BR001 > 0 AND
                --BR002 > 0 AND
                --OT101 > 0 AND
				--OT103 > 0 AND
				--OT105 > 0 AND
				--OT106 > 0 AND
				--OT109 > 0 AND
				--OT110 > 0 AND
				UCSI000 > 0
				OR UCSE000 >0  --12092015 JO per Monica
)
)

--UCSP
update LMS_ACADEMY set UCSP = '1' where Email IN
(
select Email from LMS_ACADEMY
	where 
(		        --BR001 > 0 AND
                --BR002 > 0 AND
                --OT101 > 0 AND
				--OT201 > 0 AND
				--OT102 > 0 AND
				--OT104 > 0 AND
				--OT105 > 0 AND
				--OT107 > 0 AND
				--OT108 > 0 AND
				--OT203 > 0 AND
				--OT106 > 0 AND
				--OT109 > 0 AND
				--OT205 > 0 AND
				--OT110 > 0 AND
				UCSP000 > 0
				OR UCSE000 >0 --12092015 JO per Monica
)
)

--UCSE
update LMS_ACADEMY set UCSE = '1' where Email IN
(
select Email from LMS_ACADEMY
	where 
(		        --BR001 > 0 AND
                --BR002 > 0 AND
                --OT101 > 0 AND
				--OT201 > 0 AND
				--OT102 > 0 AND
				--OT103 > 0 AND
				--OT104 > 0 AND
				--OT105 > 0 AND
				--OT108 > 0 AND
				--OT203 > 0 AND
				--OT106 > 0 AND
				--OT109 > 0 AND
				--OT110 > 0 AND
				--OT209 > 0 AND
				--OT202 > 0 AND
				--OT204 > 0 AND
				--OT111 > 0 AND
				--OT211 > 0 AND
				--OT206 > 0 AND
				--OT213 > 0 AND
				--OT212 > 0 AND
				--OT207 > 0 AND
				--OT216 > 0 AND
				--OT208 > 0 AND
				--OT218 > 0 AND
				--OT217 > 0 AND
				--OT250 > 0 AND
				UCSE000 >0
)
)

--CCSI
update LMS_ACADEMY set CCSI = '1' where Email IN
(
select Email from LMS_ACADEMY
	where 
(		        --BR001 > 0 AND
                --BR002 > 0 AND
                --BR002e > 0 AND
                --OT101 > 0 AND
				--OT102 > 0 AND
				--OT103 > 0 AND
				--OT105 > 0 AND
				--OT106 > 0 AND
				--OT109 > 0 AND
				--OT110 > 0 AND
				--OT308 > 0 AND
				CCSI000 > 0
				OR CCSE000 > 0  --12092015 JO per Monica
)
)

--CCSP
update LMS_ACADEMY set CCSP = '1' where Email IN
(
select Email from LMS_ACADEMY
	where 
(		        --BR001 > 0 AND
                --OT101 > 0 AND
                --OT309 > 0 AND
                --OT310 > 0 AND
                --OT304 > 0 AND
                --OT311 > 0 AND
				CCSP000 > 0
				OR CCSE000 > 0  --12092015 JO per Monica
)
)

--CCSE
update LMS_ACADEMY set CCSE = '1' where Email IN
(
select Email from LMS_ACADEMY
	where 
(		        --BR001 > 0 AND
                --BR002 > 0 AND
                --BR002e > 0 AND
                --OT101 > 0 AND
				--OT102 > 0 AND
				--OT103 > 0 AND
				--OT105 > 0 AND
				--OT106 > 0 AND
				--OT109 > 0 AND
				--OT110 > 0 AND
				--OT308 > 0 AND
				--OT309 > 0 AND
				--OT310 > 0 AND
				--OT304 > 0 AND
				--OT311 > 0 AND
				--OT312 > 0 AND
				--OT313 > 0 AND
				--OT314 > 0 AND
				CCSE000 > 0
)
)

--SMSI
update LMS_ACADEMY set SMSI = '1' where Email IN
(
select Email from LMS_ACADEMY
	where 
(		        --BR001 > 0 AND
                --BR002 > 0 AND
                --OT101 > 0 AND
				--OT103 > 0 AND
				--OT105 > 0 AND
				--OT106 > 0 AND
				--OT109 > 0 AND
				--OT110 > 0 AND
				--OT401 > 0 AND
				MSI000 >0
				OR MSE000 >0  --12092015 JO per Monica
)
)

--SMSE
update LMS_ACADEMY set SMSE = '1' where Email IN
(
select Email from LMS_ACADEMY
	where 
(		        --BR001 > 0 AND
                --BR002 > 0 AND
                --OT101 > 0 AND
				--OT103 > 0 AND
				--OT105 > 0 AND
				--OT106 > 0 AND
				--OT109 > 0 AND
				--OT110 > 0 AND
				--OT401 > 0 AND
				--OT402 > 0 AND
				MSE000 >0
)
)




