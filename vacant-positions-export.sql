select 
	DistrictID,
	rtrim(DistrictAbbrev) as DistrictAbbrev,
	DistrictTitle
from tblDistrict

select 
	(select DistrictID from	tblDistrict) as DistrictID,
	(select DistrictAbbrev from	tblDistrict) as DistrictAbbrev,
	cl.ClassDescription,
	subc.SubClassDesc,
	pcd.SlotNum,
	jt.JobTitle,
	worksite.SiteCode,
	worksite.SiteName,
	pcd.FTE,
	acc.AccountString,
	fund.[Percent],
	CONVERT(VARCHAR(10), pcd.EffectiveDate, 110) as EffectiveDate
from tblPositionControlDetails pcd
inner join
	tblJobTitles jt
	on pcd.pcJobTitleID = jt.JobTitleID
	and pcd.InactiveDate is null
	and pcd.EmployeeID is null
inner join
	tblSubClassifications subc
	on subc.SubClassificationID = jt.SubClassificationID
inner join
	tblClassifications cl
	on cl.ClassificationID = subc.scClassificationID
inner join
	tblSite worksite
	on pcd.SiteID = worksite.SiteID
inner join
	tblFundingSlotDetails fund
	on fund.fPositionControlID = pcd.PositionControlID
	and fund.Inactive = 0
	and fund.InactivePayrollId is null
inner join
	tblAccount acc
	on acc.AccountID = fund.fsAccountID
order by
	pcd.SlotNum asc

