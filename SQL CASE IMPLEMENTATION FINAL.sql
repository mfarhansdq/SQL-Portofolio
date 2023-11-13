-- Dataset: MySkill SQL for Data Analysis Project 
-- Link Dataset: https://drive.google.com/file/d/1ln9B8f2ryOWUK73eCipoGMKDE5lVTw50/view?usp=drive_link
-- Query used: MySQL Workbench, postgreSQL

select * from ds_salaries;

-- CEK APAKAH ADA DATA YANG NULL
select * from ds_salaries
where myunknowncolumn is null
or work_year is null
or experience_level is null
or job_title is null
or salary is null
or salary_currency is null
or salary_in_usd is null
or employee_residence is null
or remote_ratio is null
or company_location is null
or company_size is null;

-- CEK ADA JOB TITLE APA SAJA
select distinct(job_title) from ds_salaries;

-- JOB TITLE APA SAJA YANG BERKAITAN DENGAN DATA ANALYST
select distinct job_title from ds_salaries
where job_title like '%Data Analyst%';

-- RATA-RATA GAJI DATA ANALYST BERDASARKAN LEVELNYA DAN EMPLOYMENT TYPE
select experience_level,
employment_type, 
round(avg(salary_in_usd),2) as avg_salary_usd_per_year, 
round(avg(salary_in_usd) / 12, 2) as avg_salary_usd_per_month,
round((avg(salary_in_usd) * 15841) / 12, 2) as avg_salary_idr_per_month_2023 from ds_salaries
where job_title = 'data analyst'
group by experience_level, employment_type;

-- NEGARA DENGAN GAJI TERBESAR UNTUK FULL TIME DATA ANALYST DENGAN PENGALAMAN ENTRY LEVEL DAN MENENGAH (MID LEVEL)
-- MINIMAL SALARY 3,000 USD
select company_location,
	job_title,
	employment_type,
	experience_level,
	round(avg(salary_in_usd) / 12 ,2) as salary_usd_monthly
from ds_salaries
where 
	job_title = 'Data Analyst' and 
    employment_type = 'FT' and 
    experience_level in ('EN','MI')
group by company_location, experience_level
having salary_usd_monthly >= 3000
order by salary_usd_monthly desc;

-- PADA TAHUN BERAPA KENAIKAN GAJI DARI MID KE SENIOR MEMILIKI KENAIKAN TERTINGGI?
-- (UNTUK PEKERJAAN YANG BERKAITAN DENGAN DATA ANALYST, DENGAN EMPLOYMENT FULL TIME)
with ds_1 as (
	select 
		work_year, 
        round(avg(salary_in_usd) / 12, 2) as middle_salary_usd_monthly, 
        job_title
    from ds_salaries
    where 
		job_title like '%Data Analyst%' and 
        experience_level = 'MI' and 
        employment_type = 'FT'
    group by work_year, job_title
), 
ds_2 as (
	select 
		work_year, 
        round(avg(salary_in_usd) / 12, 2) as senior_salary_usd_monthly, 
        job_title
    from ds_salaries
    where 
		job_title like '%Data Analyst%' and 
        experience_level = 'EX' and 
        employment_type = 'FT'
    group by work_year, job_title
), 
t_year as (
	select distinct work_year from ds_salaries
)
select 
	t_year.work_year, 
    ds_1.job_title, 
	ds_1.middle_salary_usd_monthly, 
    ds_2.senior_salary_usd_monthly,
	(ds_2.senior_salary_usd_monthly - ds_1.middle_salary_usd_monthly) as difference_salary
from t_year
left join ds_1 on ds_1.work_year = t_year.work_year
left join ds_2 on ds_2.work_year = t_year.work_year
order by difference_salary desc;