### creating a new database

CREATE DATABASE human_resoruces_data;

# ********* CLEANING  ********* # 
SELECT count(*) FROM human_resoruces_data.hr_analysis;

## creating a staging table to work on the changes 
## avoid working on the main table 
CREATE TABLE hr_analysis_staging LIKE hr_analysis;

## inserting the row values from main table
insert hr_analysis_staging 
select * from 
hr_analysis;

select count(*) from hr_analysis_staging;

# checking if there is any duplicate 
with duplicate_cte as (
select * , 
row_number() over (partition by EMPID) as row_num 
from hr_analysis_staging )

select * from duplicate_cte where row_num > 1;   ## returned 0 means no duplicate 

select * from hr_analysis_staging;

## EMployee_Name column has some special chars that need to renamed   (ï»¿Employee_Name)
Alter table hr_analysis_staging
rename  column ï»¿Employee_Name to  Employee_Name;

##  Renaming EngagementSurvey cloumn name to EngagementSurveyScore
Alter table hr_analysis_staging
rename  column EngagementSurvey to  EngagementSurveyScore;

## EmploymentStatus should 2 ; either Active or Terminated , we don't need the cause for it in this analysis 
select  EmploymentStatus,
Case 
 When EmploymentStatus = 'Active' Then 'Active'
 Else  'Terminated'
 End 
from hr_analysis_staging;

Update hr_analysis_staging
Set EmploymentStatus =  
Case 
 When EmploymentStatus = 'Active' Then 'Active'
 Else  'Terminated'
 End ;
 
select * from hr_analysis_staging;





## the values in Employee_name isnot formatted correctly 
## so we need ti change it (Adinolfi, Wilson  K ----> Wilson K Adinolfi) (firstname + ' ' + lastname )

Select 
concat(
TRIM(SUBSTRING_INDEX(Employee_Name, ',', -1)) , 
' ', 
TRIM(SUBSTRING_INDEX(Employee_Name, ',', 1))
) as 'New_Employee_Name'
  from hr_analysis_staging;

## updating the colum Name 
UPDATE hr_analysis_staging 
Set  Employee_Name = concat(
TRIM(SUBSTRING_INDEX(Employee_Name, ',', -1)) , 
' ', 
TRIM(SUBSTRING_INDEX(Employee_Name, ',', 1))
);

## Triming some extra space 
update  hr_analysis_staging 
set Employee_Name = Trim(Employee_Name);

select * from hr_analysis_staging;


# ********* ANALYSIS ********* #

## basic facts 

-- Total Salary bugdet

select sum(Salary) from hr_analysis_staging;

-- Avegrage Performance Score across company (out of 4)
select AVG(PerfScoreID) from hr_analysis_staging;

-- Average Staisfaction Score across company  (out of 5)
select AVG(EmpSatisfaction) from hr_analysis_staging;

-- Avegrage EngagementSurvey Score across company (out of 5)
select AVG(EngagementSurveyScore) from hr_analysis_staging;





#  1. Top 3 best performing Department 

--  Performance Index Calcuation 
  --  if PerfScoreID  == 1 then PIP, 2 then need Improvement , 3 then Fully meets and 4 then exceeds 
  
select  Department, AVG(PerfScoreID) as average_Performance_Score from hr_analysis_staging  
group by Department 
order by average_Performance_Score desc 
limit  3;

#2. #  1. Top 3 best most statisfied  Department 

select  Department, AVG(EmpSatisfaction) as average_EmpSatisfaction_Score from hr_analysis_staging  
group by Department 
order by average_EmpSatisfaction_Score desc 
limit  3;

#3. best place to recruit new hires  

select RecruitmentSource, count( RecruitmentSource) as new_hire_count_per_source from hr_analysis_staging 
group by RecruitmentSource 
order by new_hire_count_per_source desc ;

# 4 best overall  manager 
-- I do the average of both (PerfScoreID and EmpSatisfaction) to calculate the top 5 best overall manager

select  ManagerName, ((AVG(PerfScoreID ) + AVG (EmpSatisfaction)) / 2) overall_score from hr_analysis_staging  
group by ManagerName 
order by overall_score desc 
limit 5;


# 5 calcualting the average satisfaction score between active and terminated employee 
-- analyzing the employee who are active and terminated across 3 different metrics

select  EmploymentStatus, AVG(EmpSatisfaction) as average_EmpSatisfaction_Score , 
	AVG(PerfScoreID) as average_performance_score ,
    AVG(EngagementSurveyScore)  as average_engagement_score from hr_analysis_staging 
group by EmploymentStatus 
order by average_EmpSatisfaction_Score, average_performance_score desc ;


