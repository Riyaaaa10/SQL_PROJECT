/* ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
Database Load Issues (follow if receiving permission denied when running SQL code below)

Possible Errors: 
- ERROR >>  duplicate key value violates unique constraint "company_dim_pkey"
- ERROR >> could not open file "C:\Users\...\company_dim.csv" for reading: Permission denied

1. Drop the Database 
            DROP DATABASE IF EXISTS sql_course;
2. Repeat steps to create database and load table schemas
            - 1_create_database.sql
            - 2_create_tables.sql
3. Open pgAdmin
4. In Object Explorer (left-hand pane), navigate to `sql_course` database
5. Right-click `sql_course` and select `PSQL Tool`
            - This opens a terminal window to write the following code
6. Get the absolute file path of your csv files
            1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
7. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy company_dim FROM 'C:\Users\hp\Downloads\csv_files-20260218T064202Z-1-001\csv_files\company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM 'C:\Users\hp\Downloads\csv_files-20260218T064202Z-1-001\csv_files\skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM 'C:\Users\hp\Downloads\csv_files-20260218T064202Z-1-001\csv_files\job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM 'C:\Users\hp\Downloads\csv_files-20260218T064202Z-1-001\csv_files\skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/

-- NOTE: This has been updated from the video to fix issues with encoding
COPY company_dim
FROM 'C:\Users\hp\Downloads\csv_files-20260218T064202Z-1-001\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'C:\Users\hp\Downloads\csv_files-20260218T064202Z-1-001\csv_files\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM 'C:\Users\hp\Downloads\csv_files-20260218T064202Z-1-001\csv_files\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM 'C:\Users\hp\Downloads\csv_files-20260218T064202Z-1-001\csv_files\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


-- select * from company_dim limit 100
-- select count (*) FROM job_postings_fact;
-- select count (*) FROM skills_dim;
-- select count (*) FROM skills_job_dim;

select job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST'
FROM job_postings_fact
limit 10;


create table february as
    Select * from job_postings_fact limit 10
    ORDER BY salary_year_avg ASC
    limit 10
    where EXTRACT (MONTH from job_posted_date) = 2

    select job_title_short, job_location
    from job_postings_fact
    where job_location like '%New%York%'
    
    select count (job_id)  as total_jobs,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
      end as JLO
    from job_postings_fact
    --where job_title_short in ('Data Analyst', 'Data Scientist')
    GROUP BY JLO


select COUNT (salary_year_avg) ,
CASE 
WHEN salary_year_avg > 100000 THEN 'High'
WHEN salary_year_avg between 30000 AND 100000 THEN 'Standard'
ELSE 'Low Salary'
END AS Sal_Range
from job_postings_fact
where job_title_short = 'Data Analyst' and salary_year_avg IS NOT NULL
GROUP BY Sal_Range
ORDER BY Sal_Range ASC;

SELECT * from company_dim

select name as company_name
from company_dim
where company_id IN (
    SELECT company_id
    FROM job_postings_fact
    WHERE job_no_degree_mention is TRUE
)

with job_openings as (
select company_id, count(*) as job_count
    from job_postings_fact
    group by company_id
)
select job_openings.job_count, cd.name from company_dim as cd 
left join job_openings on  cd.company_id = job_openings.company_id


select * from skills_dim

select * from job_postings_fact

select count(skill_id) AS COUNT_OF_POSTINGS , skills from skills_dim
group by skills
ORDER by ASC
LIMIT 5

